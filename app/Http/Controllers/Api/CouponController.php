<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\DiscountCoupon;
use App\Models\Order;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CouponController extends Controller
{
    public function apply(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'code' => 'required',
            'subtotal' => 'required|numeric',
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => false, 'message' => 'Invalid discount coupon']);
        }

        $coupon = DiscountCoupon::where('code', $request->code)->where('status', 1)->first();

        if (!$coupon) {
            return response()->json(['status' => false, 'message' => 'Invalid discount coupon']);
        }

        $now = Carbon::now();

        if (!empty($coupon->starts_at) && $now->lt(Carbon::parse($coupon->starts_at))) {
            return response()->json(['status' => false, 'message' => 'Invalid discount coupon']);
        }

        if (!empty($coupon->expires_at) && $now->gt(Carbon::parse($coupon->expires_at))) {
            return response()->json(['status' => false, 'message' => 'Invalid discount coupon']);
        }

        if ($coupon->max_uses > 0) {
            $used = Order::where('coupon_code_id', $coupon->id)->count();
            if ($used >= $coupon->max_uses) {
                return response()->json(['status' => false, 'message' => 'Invalid discount coupon']);
            }
        }

        $user = $request->user('sanctum');
        if ($coupon->max_uses_user > 0 && $user) {
            $usedByUser = Order::where('coupon_code_id', $coupon->id)->where('user_id', $user->id)->count();
            if ($usedByUser >= $coupon->max_uses_user) {
                return response()->json(['status' => false, 'message' => 'You already used this coupon.']);
            }
        }

        if ($coupon->min_amount > 0 && $request->subtotal < $coupon->min_amount) {
            return response()->json(['status' => false, 'message' => 'Minimum order amount is ₹' . $coupon->min_amount . '.']);
        }

        $discount = $coupon->type === 'percent'
            ? round($request->subtotal * ($coupon->discount_amount / 100), 2)
            : $coupon->discount_amount;

        return response()->json([
            'status' => true,
            'coupon_id' => $coupon->id,
            'code' => $coupon->code,
            'discount' => $discount,
        ]);
    }
}
