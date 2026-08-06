<?php

use App\Http\Controllers\Api\AddressController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ContactController;
use App\Http\Controllers\Api\CouponController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\Api\WishlistController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Frontend-facing JSON API for the WHITE ELEGANCE 24 Next.js app. All
| routes here are automatically prefixed with /api by RouteServiceProvider.
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// ---- Products & Categories (public) ----
Route::get('/products', [ProductController::class, 'index']);
Route::get('/products/{slug}', [ProductController::class, 'show']);
Route::get('/categories', [ProductController::class, 'categories']);

// ---- Auth ----
// Paths match what the frontend (src/lib/api.ts) already calls.
Route::post('/account/login', [AuthController::class, 'login']);
Route::post('/account/process-register', [AuthController::class, 'register']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/account/logout', [AuthController::class, 'logout']);
    Route::get('/account/me', [AuthController::class, 'me']);
    Route::post('/account/update-profile', [AuthController::class, 'updateProfile']);
    Route::post('/account/change-password', [AuthController::class, 'changePassword']);

    // ---- Addresses ----
    Route::get('/addresses', [AddressController::class, 'index']);
    Route::post('/addresses', [AddressController::class, 'store']);
    Route::put('/addresses/{address}', [AddressController::class, 'update']);
    Route::delete('/addresses/{address}', [AddressController::class, 'destroy']);
    Route::post('/addresses/{address}/default', [AddressController::class, 'setDefault']);

    // ---- Wishlist ----
    Route::get('/wishlist', [WishlistController::class, 'index']);
    Route::post('/wishlist', [WishlistController::class, 'store']);
    Route::delete('/wishlist/{handle}', [WishlistController::class, 'destroy']);

    // ---- My Orders ----
    Route::get('/orders', [OrderController::class, 'index']);
    Route::get('/orders/{order}', [OrderController::class, 'show']);
});

// ---- Checkout (public — supports guest checkout; recognizes a logged-in user if a Bearer token is present) ----
Route::post('/orders', [OrderController::class, 'store']);
Route::post('/coupons/apply', [CouponController::class, 'apply']);

// ---- Contact form ----
Route::post('/contact', [ContactController::class, 'store']);
