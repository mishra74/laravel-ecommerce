<?php

namespace App\Http\Controllers\Api;

use App\Exceptions\OrderBuildException;
use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Services\OrderBuilder;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class OrderController extends Controller
{
    public function __construct(protected OrderBuilder $orderBuilder)
    {
    }

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
            'items.*.sku' => ['required', $this->orderBuilder->skuExistsRule()],
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
        $user = $this->orderBuilder->resolveUser($request);

        try {
            $built = $this->orderBuilder->build($request, $user);
        } catch (OrderBuildException $e) {
            return response()->json(['status' => false, 'message' => $e->getMessage()], $e->status);
        }

        // COD is the only payment method this endpoint ever creates — online
        // orders are created exclusively by PaymentController once Razorpay
        // confirms payment, so a client can never POST its way to a "paid"
        // order without actually paying.
        $order = $this->orderBuilder->persist($user, $request, $built, [
            'payment_status' => 'not paid',
            'payment_method' => 'cod',
        ], decrementStock: true);

        return response()->json([
            'status' => true,
            'order_id' => $order->id,
            'order_number' => 'WE24-' . str_pad($order->id, 8, '0', STR_PAD_LEFT),
            'grand_total' => $order->grand_total,
        ]);
    }
}
