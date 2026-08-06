<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\Wishlist;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class WishlistController extends Controller
{
    public function index(Request $request)
    {
        $items = Wishlist::where('user_id', $request->user()->id)
            ->with('product.product_images')
            ->get()
            ->filter(fn ($w) => $w->product !== null)
            ->values();

        return response()->json([
            'status' => true,
            'items' => $items->map(function ($w) {
                $firstImage = $w->product->product_images->first();
                return [
                    'handle' => $w->product->slug,
                    'title' => $w->product->title,
                    'price' => $w->product->price,
                    'image' => $firstImage ? asset('uploads/product/large/' . $firstImage->image) : null,
                    'imageLabel' => $w->product->title,
                ];
            }),
        ]);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'handle' => 'required|exists:products,slug',
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => false, 'errors' => $validator->errors()]);
        }

        $product = Product::where('slug', $request->handle)->first();
        $userId = $request->user()->id;
        $existing = Wishlist::where('user_id', $userId)->where('product_id', $product->id)->first();

        if ($existing) {
            $existing->delete();
            return response()->json(['status' => true, 'wishlisted' => false]);
        }

        $wishlist = new Wishlist;
        $wishlist->user_id = $userId;
        $wishlist->product_id = $product->id;
        $wishlist->save();

        return response()->json(['status' => true, 'wishlisted' => true]);
    }

    public function destroy(Request $request, string $handle)
    {
        $product = Product::where('slug', $handle)->first();

        if ($product) {
            Wishlist::where('user_id', $request->user()->id)->where('product_id', $product->id)->delete();
        }

        return response()->json(['status' => true]);
    }
}
