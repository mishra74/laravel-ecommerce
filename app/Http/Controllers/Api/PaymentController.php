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
    public function __construct(protected OrderBuilder $orderBuilder)
    {
    }

    /**
     * Creates the order (unpaid, stock not yet decremented) and a Razorpay
     * Payment Link for its grand total, then hands back the link URL so the
     * frontend can send the browser there — a real redirect to Razorpay's
     * hosted checkout, not an embedded widget.
     */
    public function checkout(Request $request)
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

        if ($built['grandTotal'] <= 0) {
            return response()->json(['status' => false, 'message' => 'Order total must be greater than zero to pay online.'], 422);
        }

        $order = $this->orderBuilder->persist($user, $request, $built, [
            'payment_status' => 'not paid',
            'payment_method' => 'online',
        ], decrementStock: false);

        $api = new Api(config('services.razorpay.key'), config('services.razorpay.secret'));

        try {
            $paymentLink = $api->paymentLink->create([
                'amount' => (int) round($order->grand_total * 100),
                'currency' => 'INR',
                'accept_partial' => false,
                'description' => "WHITE ELEGANCE 24 — Order #{$order->id}",
                'customer' => [
                    'name' => trim($order->first_name . ' ' . $order->last_name) ?: 'Customer',
                    'email' => $order->email,
                    'contact' => $order->mobile,
                ],
                'notify' => ['sms' => false, 'email' => false],
                'reminder_enable' => false,
                'reference_id' => (string) $order->id,
                'callback_url' => url('/api/payments/razorpay/callback'),
                'callback_method' => 'get',
            ]);
        } catch (\Throwable $e) {
            Log::error('Razorpay payment link creation failed', ['order_id' => $order->id, 'error' => $e->getMessage()]);
            return response()->json(['status' => false, 'message' => 'Unable to start online payment right now. Please try Cash on Delivery.'], 502);
        }

        $order->razorpay_payment_link_id = $paymentLink['id'];
        $order->save();

        return response()->json([
            'status' => true,
            'order_id' => $order->id,
            'redirect_url' => $paymentLink['short_url'],
        ]);
    }

    /**
     * Razorpay redirects the customer's browser here after a Payment Link
     * attempt (success or failure) — this is a GET hit by the browser, not a
     * server-to-server webhook. Verifies the signature before trusting
     * anything in the query string, then bounces to the frontend.
     */
    public function callback(Request $request)
    {
        $frontendUrl = rtrim(config('services.frontend_url'), '/');
        $referenceId = $request->query('razorpay_payment_link_reference_id');
        $order = $referenceId ? Order::find($referenceId) : null;

        if (!$order) {
            return redirect("{$frontendUrl}/checkout?payment=failed");
        }

        // Idempotency guard — Razorpay/the browser can hit this URL more than
        // once (refresh, back button); never re-verify or decrement stock twice.
        if ($order->payment_status === 'paid') {
            return redirect("{$frontendUrl}/order-confirmation?order_id={$order->id}&payment=success");
        }

        $api = new Api(config('services.razorpay.key'), config('services.razorpay.secret'));

        try {
            $api->utility->verifyPaymentLinkSignature($request->only([
                'razorpay_payment_id',
                'razorpay_payment_link_id',
                'razorpay_payment_link_reference_id',
                'razorpay_payment_link_status',
                'razorpay_signature',
            ]));
        } catch (SignatureVerificationError $e) {
            Log::warning('Razorpay callback signature verification failed', ['order_id' => $order->id]);
            return redirect("{$frontendUrl}/checkout?payment=failed&order_id={$order->id}");
        }

        if ($request->query('razorpay_payment_link_status') !== 'paid') {
            return redirect("{$frontendUrl}/checkout?payment=failed&order_id={$order->id}");
        }

        $order->payment_status = 'paid';
        $order->razorpay_payment_id = $request->query('razorpay_payment_id');
        $order->razorpay_signature = $request->query('razorpay_signature');
        $order->save();

        $this->orderBuilder->decrementStockForOrder($order);

        return redirect("{$frontendUrl}/order-confirmation?order_id={$order->id}&payment=success");
    }
}
