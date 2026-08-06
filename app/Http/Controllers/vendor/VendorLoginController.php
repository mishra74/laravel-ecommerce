<?php

namespace App\Http\Controllers\vendor;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class VendorLoginController extends Controller
{
    public function index() {
        return view('vendor.login');
    }

    public function authenticate(Request $request){

        $validator = Validator::make($request->all(),[
            'email' => 'required|email',
            'password' => 'required'
        ]);

        if ($validator->passes()) {

            if (Auth::guard('vendor')->attempt(['email' => $request->email,'password'=> $request->password],$request->get('remember'))) {

                $vendor = Auth::guard('vendor')->user();

                if ($vendor->role == User::ROLE_VENDOR && $vendor->status == User::STATUS_ACTIVE) {
                    return redirect()->route('vendor.dashboard');
                } else {

                    Auth::guard('vendor')->logout();

                    if ($vendor->role == User::ROLE_VENDOR) {
                        return redirect()->route('vendor.login')->with('error','Your vendor account has been suspended.');
                    }

                    return redirect()->route('vendor.login')->with('error','You are not authorized to access the vendor panel.');
                }

            } else {
                return redirect()->route('vendor.login')->with('error','Either Email/Password is incorrect');
            }

        } else {
            return redirect()->route('vendor.login')
                ->withErrors($validator)
                ->withInput($request->only('email'));
        }
    }
}
