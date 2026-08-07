<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Page;

class PageController extends Controller
{
    public function index()
    {
        $pages = Page::orderBy('name', 'asc')->get(['id', 'name', 'slug']);

        return response()->json([
            'status' => true,
            'pages' => $pages,
        ]);
    }

    public function show(string $slug)
    {
        $page = Page::where('slug', $slug)->first();

        if (!$page) {
            return response()->json([
                'status' => false,
                'message' => 'Page not found.',
            ], 404);
        }

        return response()->json([
            'status' => true,
            'page' => $page,
        ]);
    }
}
