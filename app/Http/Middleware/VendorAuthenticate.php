<?php

namespace App\Http\Middleware;

use App\Models\User;
use Illuminate\Auth\Middleware\Authenticate as Middleware;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class VendorAuthenticate extends Middleware
{
    /**
     * Get the path the user should be redirected to when they are not authenticated.
     */
    protected function redirectTo(Request $request): ?string
    {
        return $request->expectsJson() ? null : route('vendor.login');
    }

    protected function authenticate($request, array $guards)
    {
        if ($this->auth->guard('vendor')->check()) {

            $vendor = $this->auth->guard('vendor')->user();

            if ($vendor->role != User::ROLE_VENDOR || $vendor->status != User::STATUS_ACTIVE) {
                Auth::guard('vendor')->logout();
                $request->session()->flash('error', 'Your vendor account is no longer active.');
                $this->unauthenticated($request, ['vendor']);
            }

            return $this->auth->shouldUse('vendor');
        }

        $this->unauthenticated($request, ['vendor']);
    }
}
