<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    /** Party Wear category id, matching the frontend's existing collection() mapping in src/lib/api.ts. */
    const PARTY_WEAR_CATEGORY_ID = 24;

    private function baseQuery()
    {
        return Product::with('product_images')
            ->where('status', 1)
            ->vendorActive();
    }

    private function applySort($query, ?string $sort)
    {
        return match ($sort) {
            'price-asc' => $query->orderBy('price', 'asc'),
            'price-desc' => $query->orderBy('price', 'desc'),
            'name-asc' => $query->orderBy('title', 'asc'),
            default => $query->orderBy('id', 'desc'),
        };
    }

    public function index(Request $request)
    {
        $query = $this->baseQuery();

        if ($request->filled('collection')) {
            if ($request->collection === 'party-wear') {
                $query->where('category_id', self::PARTY_WEAR_CATEGORY_ID);
            } elseif ($request->collection === 'casual-wear') {
                $query->where('category_id', '!=', self::PARTY_WEAR_CATEGORY_ID);
            }
        }

        if ($request->filled('category_id')) {
            $query->where('category_id', $request->category_id);
        }

        if ($request->filled('keyword')) {
            $query->where('title', 'like', '%' . $request->keyword . '%');
        }

        if ($request->boolean('featured')) {
            $query->where('is_featured', 'Yes');
        }

        $query = $this->applySort($query, $request->get('sort'));

        $products = $query->get();

        return response()->json([
            'data' => [
                'products' => $products,
            ],
        ]);
    }

    public function show(string $slug)
    {
        $product = $this->baseQuery()->where('slug', $slug)->first();

        if (!$product) {
            return response()->json([
                'status' => false,
                'message' => 'Product not found.',
            ], 404);
        }

        $similar = $this->baseQuery()
            ->where('category_id', $product->category_id)
            ->where('id', '!=', $product->id)
            ->take(4)
            ->get();

        return response()->json([
            'data' => [
                'product' => $product,
                'similar' => $similar,
            ],
        ]);
    }

    public function categories()
    {
        $categories = Category::where('status', 1)->orderBy('name', 'asc')->get();

        return response()->json([
            'data' => [
                'categories' => $categories,
            ],
        ]);
    }
}
