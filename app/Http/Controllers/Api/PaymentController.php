<?php

namespace App\Http\Controllers\Api;

use App\Exceptions\OrderBuildException;
use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Services\OrderBuilder;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Razorpay\Api\Api;
use Razorpay\Api\Errors\SignatureVerificationError;

class PaymentController extends Controller
{
    const MIN_AMOUNT_PAISE = 100; // Razorpay's own minimum order amount (₹1)

    public function __construct(protected OrderBuilder $orderBuilder)
    {
    }

    /**
     * Creates the order (unpaid, stock not yet decremented) and a Razorpay
     * order for its grand total, so the frontend can open the Standard
     * Checkout modal on-page — no redirect away from the site.
     */
    public function order(Request $request)
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
            'items.*.sku' => ['required', $this->orderBuilder->skuExistsRule()],
            'items.*.qty' => 'required|integer|min:1',
            'coupon_code' => 'nullable|string',
            'notes' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => false, 'errors' => $validator->errors()]);
        }

        if (!config('services.razorpay.key') || !config('services.razorpay.secret')) {
            return response()->json(['status' => false, 'message' => 'Online payment is not configured yet. Please choose Cash on Delivery.'], 503);
        }

        $user = $this->orderBuilder->resolveUser($request);

        try {
            $built = $this->orderBuilder->build($request, $user);
        } catch (OrderBuildException $e) {
            return response()->json(['status' => false, 'message' => $e->getMessage()], $e->status);
        }

        $amountPaise = (int) round($built['grandTotal'] * 100);

        if ($amountPaise < self::MIN_AMOUNT_PAISE) {
            return response()->json(['status' => false, 'message' => 'Order total is too small to pay online.'], 422);
        }

        $order = $this->orderBuilder->persist($user, $request, $built, [
            'payment_status' => 'not paid',
            'payment_method' => 'online',
        ], decrementStock: false);

        $api = new Api(config('services.razorpay.key'), config('services.razorpay.secret'));

        try {
            $rzpOrder = $api->order->create([
                'amount' => $amountPaise,
                'currency' => 'INR',
                'receipt' => 'order_' . $order->id,
                'notes' => ['order_id' => (string) $order->id],
            ]);
        } catch (\Throwable $e) {
            Log::error('Razorpay order creation failed', ['order_id' => $order->id, 'error' => $e->getMessage()]);
            return response()->json(['status' => false, 'message' => 'Unable to start online payment right now. Please try Cash on Delivery.'], 502);
        }

        $order->razorpay_order_id = $rzpOrder['id'];
        $order->save();

        return response()->json([
            'status' => true,
            'order_id' => $order->id,
            'razorpay_order_id' => $rzpOrder['id'],
            'razorpay_key' => config('services.razorpay.key'),
            'amount' => $amountPaise,
            'currency' => 'INR',
            'name' => config('app.name'),
            'description' => "Order #{$order->id}",
            'prefill' => [
                'name' => trim($order->first_name . ' ' . $order->last_name),
                'email' => $order->email,
                'contact' => $order->mobile,
            ],
        ]);
    }

    /**
     * Verifies the Standard Checkout signature server-side before an order
     * is ever marked paid. Called by the modal's success handler with the
     * three fields Razorpay hands back to the browser.
     */
    public function verify(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'order_id' => 'required|integer|exists:orders,id',
            'razorpay_order_id' => 'required|string',
            'razorpay_payment_id' => 'required|string',
            'razorpay_signature' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => false, 'errors' => $validator->errors()], 400);
        }

        $order = Order::find($request->order_id);

        if (!$order || $order->razorpay_order_id !== $request->razorpay_order_id) {
            return response()->json(['status' => false, 'message' => 'Order not found.'], 400);
        }

        // Idempotency guard — the modal's handler could theoretically fire
        // more than once; never re-verify or decrement stock twice.
        if ($order->payment_status === 'paid') {
            return response()->json([
                'status' => true,
                'order_id' => $order->id,
                'order_number' => 'WE24-' . str_pad($order->id, 8, '0', STR_PAD_LEFT),
                'grand_total' => $order->grand_total,
            ]);
        }

        $api = new Api(config('services.razorpay.key'), config('services.razorpay.secret'));

        try {
            $api->utility->verifyPaymentSignature([
                'razorpay_order_id' => $request->razorpay_order_id,
                'razorpay_payment_id' => $request->razorpay_payment_id,
                'razorpay_signature' => $request->razorpay_signature,
            ]);
        } catch (SignatureVerificationError $e) {
            Log::warning('Razorpay signature verification failed', ['order_id' => $order->id]);
            return response()->json(['status' => false, 'message' => 'Payment verification failed.'], 400);
        }

        $order->payment_status = 'paid';
        $order->razorpay_payment_id = $request->razorpay_payment_id;
        $order->razorpay_signature = $request->razorpay_signature;
        $order->save();

        $this->orderBuilder->decrementStockForOrder($order);

        return response()->json([
            'status' => true,
            'order_id' => $order->id,
            'order_number' => 'WE24-' . str_pad($order->id, 8, '0', STR_PAD_LEFT),
            'grand_total' => $order->grand_total,
        ]);
    }
}
