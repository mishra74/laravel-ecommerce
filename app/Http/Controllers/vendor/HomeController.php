<?php

namespace App\Http\Controllers\vendor;

use App\Http\Controllers\Controller;
use App\Models\OrderItem;
use App\Models\Product;
use Illuminate\Support\Facades\Auth;

class HomeController extends Controller
{
    public function index(){

        $vendorId = Auth::guard('vendor')->id();

        $totalProducts = Product::where('vendor_id',$vendorId)->count();
        $activeProducts = Product::where('vendor_id',$vendorId)->where('status',1)->count();
        $inactiveProducts = Product::where('vendor_id',$vendorId)->where('status','!=',1)->count();

        $vendorProductIds = Product::where('vendor_id',$vendorId)->pluck('id');

        $totalOrders = OrderItem::whereIn('product_id',$vendorProductIds)->distinct('order_id')->count('order_id');

        return view('vendor.dashboard',[
            'totalProducts' => $totalProducts,
            'activeProducts' => $activeProducts,
            'inactiveProducts' => $inactiveProducts,
            'totalOrders' => $totalOrders,
        ]);

    }

    public function logout() {
        Auth::guard('vendor')->logout();
        return redirect()->route('vendor.login');
    }
}
