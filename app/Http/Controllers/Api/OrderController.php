<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
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
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class OrderController extends Controller
{
    const DEFAULT_COUNTRY_ID = 100; // India
    const FREE_SHIPPING_THRESHOLD = 5000;
    const FALLBACK_SHIPPING = 150; // used only if no ShippingCharge row exists for the country

    public function index(Request $request)
    {
        $orders = Order::where('user_id', $request->user()->id)
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json(['status' => true, 'orders' => $orders]);
    }

    public function show(Request $request, Order $order)
    {
        if ($order->user_id !== $request->user()->id) {
            abort(403);
        }

        return response()->json([
            'status' => true,
            'order' => $order,
            'items' => $order->items,
        ]);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'contact_email' => 'required|email',
            'contact_phone' => 'required',
            'address_id' => 'nullable|exists:customer_addresses,id',
            'shipping.fullName' => 'required_without:address_id',
            'shipping.line1' => 'required_without:address_id',
            'shipping.city' => 'required_without:address_id',
            'shipping.state' => 'required_without:address_id',
            'shipping.pincode' => 'required_without:address_id',
            'items' => 'required|array|min:1',
            'items.*.sku' => 'required|exists:products,sku',
            'items.*.qty' => 'required|integer|min:1',
            'coupon_code' => 'nullable|string',
            'notes' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => false, 'errors' => $validator->errors()]);
        }

        // This route is intentionally public (guest checkout) — explicitly check the
        // sanctum guard so a logged-in user is still recognized when a valid Bearer
        // token is present, since no auth:sanctum middleware runs on this route to
        // populate $request->user() automatically.
        $user = $request->user('sanctum');

        if (!$user) {
            // Guest checkout: find-or-create a customer account by email so the order
            // can attach to a real user_id (the orders table requires one). Matches
            // the site's existing guest-first checkout decision without a schema change.
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

        // Resolve shipping address: either a saved address or the inline fields.
        if ($request->filled('address_id')) {
            $saved = CustomerAddress::find($request->address_id);
            if (!$saved || $saved->user_id !== $user->id) {
                return response()->json(['status' => false, 'message' => 'Address not found.'], 404);
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
                return response()->json(['status' => false, 'message' => 'One of the items in your cart is no longer available.'], 422);
            }

            if ($product->track_qty === 'Yes' && $product->qty !== null && $product->qty < $item['qty']) {
                return response()->json(['status' => false, 'message' => "\"{$product->title}\" doesn't have enough stock left."], 422);
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

        $order = DB::transaction(function () use ($user, $shipping, $request, $subtotal, $shippingAmount, $couponCode, $couponCodeId, $discount, $lineItems) {
            $order = new Order;
            $order->user_id = $user->id;
            $order->subtotal = $subtotal;
            $order->shipping = $shippingAmount;
            $order->coupon_code = $couponCode;
            $order->coupon_code_id = $couponCodeId;
            $order->discount = $discount;
            $order->grand_total = $subtotal - $discount + $shippingAmount;
            $order->first_name = $shipping['first_name'];
            $order->last_name = $shipping['last_name'];
            $order->email = $request->contact_email;
            $order->mobile = $request->contact_phone;
            $order->country_id = self::DEFAULT_COUNTRY_ID;
            $order->address = $shipping['address'];
            $order->apartment = $shipping['apartment'];
            $order->city = $shipping['city'];
            $order->state = $shipping['state'];
            $order->zip = $shipping['zip'];
            $order->notes = $request->notes;
            $order->payment_status = 'not paid';
            $order->status = 'pending';
            $order->save();

            foreach ($lineItems as $line) {
                $orderItem = new OrderItem;
                $orderItem->order_id = $order->id;
                $orderItem->product_id = $line['product']->id;
                $orderItem->name = $line['product']->title;
                $orderItem->qty = $line['qty'];
                $orderItem->price = $line['price'];
                $orderItem->total = $line['total'];
                $orderItem->save();

                if ($line['product']->track_qty === 'Yes' && $line['product']->qty !== null) {
                    $line['product']->decrement('qty', $line['qty']);
                }
            }

            return $order;
        });

        return response()->json([
            'status' => true,
            'order_id' => $order->id,
            'order_number' => 'WE24-' . str_pad($order->id, 8, '0', STR_PAD_LEFT),
            'grand_total' => $order->grand_total,
        ]);
    }
}
