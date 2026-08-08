<?php

namespace App\Services;

use App\Exceptions\OrderBuildException;
use App\Models\CustomerAddress;
use App\Models\DiscountCoupon;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use App\Models\ShippingCharge;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

/**
 * Shared order-building logic for both checkout paths (COD via OrderController
 * and online payment via PaymentController). Kept in one place so pricing,
 * stock checks, and coupon/shipping rules can never drift between the two —
 * this codebase has already hit real bugs from that kind of duplication.
 */
class OrderBuilder
{
    const DEFAULT_COUNTRY_ID = 100; // India
    const FREE_SHIPPING_THRESHOLD = 5000;
    const FALLBACK_SHIPPING = 150; // used only if no ShippingCharge row exists for the country

    public function resolveUser(Request $request): User
    {
        $user = $request->user('sanctum');

        if (!$user) {
            $user = User::firstOrCreate(
                ['email' => $request->contact_email],
                [
                    'name' => $request->input('shipping.fullName', 'Guest'),
                    'phone' => $request->contact_phone,
                    'password' => Hash::make(Str::random(32)),
                    'role' => User::ROLE_CUSTOMER,
                    'status' => User::STATUS_ACTIVE,
                ]
            );
        }

        return $user;
    }

    /**
     * @throws OrderBuildException
     */
    public function build(Request $request, User $user): array
    {
        if ($request->filled('address_id')) {
            $saved = CustomerAddress::find($request->address_id);
            if (!$saved || $saved->user_id !== $user->id) {
                throw new OrderBuildException('Address not found.', 404);
            }
            $shipping = [
                'first_name' => $saved->first_name,
                'last_name' => $saved->last_name,
                'address' => $saved->address,
                'apartment' => $saved->apartment,
                'city' => $saved->city,
                'state' => $saved->state,
                'zip' => $saved->zip,
            ];
        } else {
            $parts = explode(' ', trim($request->input('shipping.fullName')), 2);
            $shipping = [
                'first_name' => $parts[0],
                'last_name' => $parts[1] ?? '',
                'address' => $request->input('shipping.line1'),
                'apartment' => $request->input('shipping.line2'),
                'city' => $request->input('shipping.city'),
                'state' => $request->input('shipping.state'),
                'zip' => $request->input('shipping.pincode'),
            ];
        }

        // Price every line server-side from the real product record — never trust client-submitted prices.
        $lineItems = [];
        $subtotal = 0;

        foreach ($request->items as $item) {
            $product = Product::where('sku', $item['sku'])->where('status', 1)->vendorActive()->first();

            if (!$product) {
                throw new OrderBuildException('One of the items in your cart is no longer available.', 422);
            }

            if ($product->track_qty === 'Yes' && $product->qty !== null && $product->qty < $item['qty']) {
                throw new OrderBuildException("\"{$product->title}\" doesn't have enough stock left.", 422);
            }

            $lineTotal = $product->price * $item['qty'];
            $subtotal += $lineTotal;

            $lineItems[] = [
                'product' => $product,
                'qty' => $item['qty'],
                'price' => $product->price,
                'total' => $lineTotal,
            ];
        }

        // Re-validate any coupon server-side rather than trusting a client-computed discount.
        $discount = 0;
        $couponCode = null;
        $couponCodeId = null;

        if ($request->filled('coupon_code')) {
            $coupon = DiscountCoupon::where('code', $request->coupon_code)->where('status', 1)->first();
            if ($coupon && (!$coupon->min_amount || $subtotal >= $coupon->min_amount)) {
                $discount = $coupon->type === 'percent'
                    ? round($subtotal * ($coupon->discount_amount / 100), 2)
                    : $coupon->discount_amount;
                $couponCode = $coupon->code;
                $couponCodeId = $coupon->id;
            }
        }

        $afterDiscount = max(0, $subtotal - $discount);
        $shippingCharge = ShippingCharge::where('country_id', (string) self::DEFAULT_COUNTRY_ID)->first();
        $shippingAmount = $afterDiscount >= self::FREE_SHIPPING_THRESHOLD
            ? 0
            : ($shippingCharge->amount ?? self::FALLBACK_SHIPPING);

        return [
            'shipping' => $shipping,
            'lineItems' => $lineItems,
            'subtotal' => $subtotal,
            'discount' => $discount,
            'couponCode' => $couponCode,
            'couponCodeId' => $couponCodeId,
            'shippingAmount' => $shippingAmount,
            'grandTotal' => $subtotal - $discount + $shippingAmount,
        ];
    }

    /**
     * Persists the order + order items. Stock is only decremented immediately
     * when $decrementStock is true (COD — a firm commitment at order time).
     * For online payments, stock is decremented separately once payment is
     * actually confirmed (see PaymentController::callback), so an abandoned
     * Razorpay checkout never holds stock hostage.
     */
    public function persist(User $user, Request $request, array $built, array $paymentFields, bool $decrementStock): Order
    {
        return DB::transaction(function () use ($user, $request, $built, $paymentFields, $decrementStock) {
            $order = new Order;
            $order->user_id = $user->id;
            $order->subtotal = $built['subtotal'];
            $order->shipping = $built['shippingAmount'];
            $order->coupon_code = $built['couponCode'];
            $order->coupon_code_id = $built['couponCodeId'];
            $order->discount = $built['discount'];
            $order->grand_total = $built['grandTotal'];
            $order->first_name = $built['shipping']['first_name'];
            $order->last_name = $built['shipping']['last_name'];
            $order->email = $request->contact_email;
            $order->mobile = $request->contact_phone;
            $order->country_id = self::DEFAULT_COUNTRY_ID;
            $order->address = $built['shipping']['address'];
            $order->apartment = $built['shipping']['apartment'];
            $order->city = $built['shipping']['city'];
            $order->state = $built['shipping']['state'];
            $order->zip = $built['shipping']['zip'];
            $order->notes = $request->notes;
            $order->status = 'pending';

            foreach ($paymentFields as $key => $value) {
                $order->{$key} = $value;
            }

            $order->save();

            foreach ($built['lineItems'] as $line) {
                $orderItem = new OrderItem;
                $orderItem->order_id = $order->id;
                $orderItem->product_id = $line['product']->id;
                $orderItem->name = $line['product']->title;
                $orderItem->qty = $line['qty'];
                $orderItem->price = $line['price'];
                $orderItem->total = $line['total'];
                $orderItem->save();

                if ($decrementStock && $line['product']->track_qty === 'Yes' && $line['product']->qty !== null) {
                    $line['product']->decrement('qty', $line['qty']);
                }
            }

            return $order;
        });
    }

    /**
     * Decrements stock for a previously-persisted order whose items were not
     * decremented at creation time (the online-payment path). Called once,
     * guarded by the order's payment_status, from PaymentController::callback.
     */
    public function decrementStockForOrder(Order $order): void
    {
        DB::transaction(function () use ($order) {
            foreach ($order->items as $item) {
                $product = Product::find($item->product_id);
                if ($product && $product->track_qty === 'Yes' && $product->qty !== null) {
                    $product->decrement('qty', $item->qty);
                }
            }
        });
    }
}
