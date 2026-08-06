<?php

namespace App\Http\Controllers\vendor;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class OrderController extends Controller
{
    public function index(Request $request) {

        $vendorId = Auth::guard('vendor')->id();
        $vendorProductIds = Product::where('vendor_id',$vendorId)->pluck('id');

        $orderIds = OrderItem::whereIn('product_id',$vendorProductIds)->pluck('order_id')->unique();

        $orders = Order::select('orders.*','users.name','users.email')
                    ->leftJoin('users','users.id','orders.user_id')
                    ->whereIn('orders.id',$orderIds)
                    ->latest('orders.created_at');

        if ($request->get('keyword') != "") {
            $orders = $orders->where('users.name','like','%'.$request->keyword.'%');
            $orders = $orders->orWhere('users.email','like','%'.$request->keyword.'%');
        }

        $orders = $orders->paginate(10);

        return view('vendor.orders.list',[
            'orders' => $orders
        ]);
    }

    public function detail($orderId) {

        $vendorId = Auth::guard('vendor')->id();
        $vendorProductIds = Product::where('vendor_id',$vendorId)->pluck('id');

        $orderItems = OrderItem::where('order_id',$orderId)->whereIn('product_id',$vendorProductIds)->get();

        if ($orderItems->isEmpty()) {
            abort(403);
        }

        $order = Order::select('orders.*','countries.name as countryName')
                    ->where('orders.id',$orderId)
                    ->leftJoin('countries','countries.id','orders.country_id')
                    ->first();

        return view('vendor.orders.detail',[
            'order' => $order,
            'orderItems' => $orderItems
        ]);
    }
}
