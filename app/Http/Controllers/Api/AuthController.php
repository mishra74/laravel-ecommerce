<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    public function googleLogin(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id_token' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => false, 'message' => 'Missing Google credential.']);
        }

        // Verifies the ID token's signature/expiry with Google and returns its claims.
        // (tokeninfo is fine at this traffic level; a high-volume app would instead
        // verify the JWT signature locally against Google's published JWKS.)
        $response = Http::get('https://oauth2.googleapis.com/tokeninfo', [
            'id_token' => $request->id_token,
        ]);

        if (!$response->ok()) {
            return response()->json(['status' => false, 'message' => 'Invalid or expired Google sign-in. Please try again.']);
        }

        $claims = $response->json();

        $expectedAudience = config('services.google.client_id');
        if (!$expectedAudience || ($claims['aud'] ?? null) !== $expectedAudience) {
            return response()->json(['status' => false, 'message' => 'Google sign-in could not be verified.']);
        }

        if (($claims['email_verified'] ?? 'false') !== 'true' || empty($claims['email'])) {
            return response()->json(['status' => false, 'message' => 'Your Google account email is not verified.']);
        }

        $user = User::where('email', $claims['email'])->first();

        if (!$user) {
            $user = new User;
            $user->name = $claims['name'] ?? explode('@', $claims['email'])[0];
            $user->email = $claims['email'];
            $user->password = Hash::make(Str::random(32)); // never used to sign in directly
            $user->role = User::ROLE_CUSTOMER;
            $user->status = User::STATUS_ACTIVE;
            $user->save();
        }

        if ($user->status != User::STATUS_ACTIVE) {
            return response()->json(['status' => false, 'message' => 'This account has been suspended.']);
        }

        $token = $user->createToken('we24-frontend')->plainTextToken;

        return response()->json([
            'status' => true,
            'token' => $token,
            'user' => $user->only(['id', 'name', 'email', 'phone']),
        ]);
    }

    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|min:3',
            'email' => 'required|email|unique:users,email',
            'phone' => 'required',
            'password' => 'required|min:5|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ]);
        }

        $user = new User;
        $user->name = $request->name;
        $user->email = $request->email;
        $user->phone = $request->phone;
        $user->password = Hash::make($request->password);
        $user->role = User::ROLE_CUSTOMER;
        $user->status = User::STATUS_ACTIVE;
        $user->save();

        $token = $user->createToken('we24-frontend')->plainTextToken;

        return response()->json([
            'status' => true,
            'token' => $token,
            'user' => $user->only(['id', 'name', 'email', 'phone']),
        ]);
    }

    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'Email and password are required.',
            ]);
        }

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'status' => false,
                'message' => 'Either email/password is incorrect.',
            ]);
        }

        if ($user->status != User::STATUS_ACTIVE) {
            return response()->json([
                'status' => false,
                'message' => 'This account has been suspended.',
            ]);
        }

        $token = $user->createToken('we24-frontend')->plainTextToken;

        return response()->json([
            'status' => true,
            'token' => $token,
            'user' => $user->only(['id', 'name', 'email', 'phone']),
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status' => true,
        ]);
    }

    public function me(Request $request)
    {
        return response()->json([
            'status' => true,
            'user' => $request->user()->only(['id', 'name', 'email', 'phone']),
        ]);
    }

    public function updateProfile(Request $request)
    {
        $userId = $request->user()->id;

        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'email' => 'required|email|unique:users,email,' . $userId . ',id',
            'phone' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ]);
        }

        $user = User::find($userId);
        $user->name = $request->name;
        $user->email = $request->email;
        $user->phone = $request->phone;
        $user->save();

        return response()->json([
            'status' => true,
            'user' => $user->only(['id', 'name', 'email', 'phone']),
        ]);
    }

    public function changePassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'old_password' => 'required',
            'new_password' => 'required|min:5',
            'confirm_password' => 'required|same:new_password',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ]);
        }

        $user = $request->user();

        if (!Hash::check($request->old_password, $user->password)) {
            return response()->json([
                'status' => false,
                'message' => 'Your old password is incorrect.',
            ]);
        }

        $user->password = Hash::make($request->new_password);
        $user->save();

        return response()->json([
            'status' => true,
        ]);
    }
}
