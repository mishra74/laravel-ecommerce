<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Password;
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

    /**
     * Kicks off Laravel's built-in password_reset_tokens flow. Always
     * reports success regardless of whether the email is registered, so
     * this can't be used to check which emails have accounts.
     */
    public function forgotPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ]);
        }

        try {
            Password::sendResetLink($request->only('email'));
        } catch (\Throwable $e) {
            // A mail-transport failure only ever happens on the branch where
            // the account exists (Laravel skips sending entirely for an
            // unregistered email) — letting it propagate as a 500 would leak
            // which emails have accounts purely via the response status.
            // Same generic response either way; the real failure is logged.
            \Illuminate\Support\Facades\Log::error('Password reset email failed to send', [
                'error' => $e->getMessage(),
            ]);
        }

        return response()->json([
            'status' => true,
            'message' => 'If an account exists for that email, a password reset link has been sent.',
        ]);
    }

    public function resetPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'token' => 'required|string',
            'password' => 'required|min:5|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ]);
        }

        $status = Password::reset(
            $request->only('email', 'password', 'password_confirmation', 'token'),
            function ($user, $password) {
                $user->password = Hash::make($password);
                $user->save();
            }
        );

        if ($status !== Password::PASSWORD_RESET) {
            return response()->json([
                'status' => false,
                'message' => 'This password reset link is invalid or has expired. Please request a new one.',
            ]);
        }

        return response()->json([
            'status' => true,
            'message' => 'Your password has been reset. You can now log in.',
        ]);
    }

    /**
     * Second reset path alongside forgotPassword()/resetPassword() above —
     * emails a short numeric code instead of a link, for customers who'd
     * rather type a code than click through email. Same anti-enumeration
     * shape: always a generic success response, and mail failures are
     * swallowed (logged, not surfaced) so they can't be distinguished from
     * "no account" by response status.
     */
    public function forgotPasswordOtp(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ]);
        }

        $user = User::where('email', $request->email)->first();

        if ($user) {
            $otp = (string) random_int(100000, 999999);

            \Illuminate\Support\Facades\DB::table('password_reset_otps')->updateOrInsert(
                ['email' => $user->email],
                [
                    'otp' => Hash::make($otp),
                    'expires_at' => now()->addMinutes(10),
                    'updated_at' => now(),
                    'created_at' => now(),
                ]
            );

            try {
                $user->notify(new \App\Notifications\ResetPasswordOtpNotification($otp));
            } catch (\Throwable $e) {
                \Illuminate\Support\Facades\Log::error('Password reset OTP email failed to send', [
                    'error' => $e->getMessage(),
                ]);
            }
        }

        return response()->json([
            'status' => true,
            'message' => 'If an account exists for that email, a reset code has been sent.',
        ]);
    }

    public function resetPasswordOtp(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'otp' => 'required|string',
            'password' => 'required|min:5|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ]);
        }

        $invalidResponse = response()->json([
            'status' => false,
            'message' => 'That code is invalid or has expired. Please request a new one.',
        ]);

        $record = \Illuminate\Support\Facades\DB::table('password_reset_otps')
            ->where('email', $request->email)
            ->first();

        if (!$record || now()->greaterThan($record->expires_at) || !Hash::check($request->otp, $record->otp)) {
            return $invalidResponse;
        }

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return $invalidResponse;
        }

        $user->password = Hash::make($request->password);
        $user->save();

        \Illuminate\Support\Facades\DB::table('password_reset_otps')->where('email', $request->email)->delete();

        return response()->json([
            'status' => true,
            'message' => 'Your password has been reset. You can now log in.',
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
