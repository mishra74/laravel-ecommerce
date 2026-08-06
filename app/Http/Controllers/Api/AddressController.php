<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CustomerAddress;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class AddressController extends Controller
{
    /** India — this is a single-market (India-only) storefront; the address form has no country field. */
    const DEFAULT_COUNTRY_ID = 100;

    public function index(Request $request)
    {
        $addresses = CustomerAddress::where('user_id', $request->user()->id)
            ->orderBy('is_default', 'desc')
            ->orderBy('id', 'desc')
            ->get();

        return response()->json([
            'status' => true,
            'addresses' => $addresses->map(fn ($a) => $this->present($a)),
        ]);
    }

    public function store(Request $request)
    {
        $validated = $this->validateInput($request);
        if ($validated instanceof \Illuminate\Http\JsonResponse) {
            return $validated;
        }

        $user = $request->user();
        $isFirst = CustomerAddress::where('user_id', $user->id)->count() === 0;

        $address = $this->fillFromInput(new CustomerAddress, $validated, $user);
        $address->is_default = $isFirst || $request->boolean('make_default');
        $address->save();

        if ($address->is_default) {
            $this->clearOtherDefaults($user->id, $address->id);
        }

        return response()->json([
            'status' => true,
            'address' => $this->present($address),
        ]);
    }

    public function update(Request $request, CustomerAddress $address)
    {
        if ($address->user_id !== $request->user()->id) {
            abort(403);
        }

        $validated = $this->validateInput($request);
        if ($validated instanceof \Illuminate\Http\JsonResponse) {
            return $validated;
        }

        $this->fillFromInput($address, $validated, $request->user());
        $address->save();

        return response()->json([
            'status' => true,
            'address' => $this->present($address),
        ]);
    }

    public function destroy(Request $request, CustomerAddress $address)
    {
        if ($address->user_id !== $request->user()->id) {
            abort(403);
        }

        $wasDefault = $address->is_default;
        $userId = $address->user_id;
        $address->delete();

        if ($wasDefault) {
            $next = CustomerAddress::where('user_id', $userId)->orderBy('id', 'asc')->first();
            if ($next) {
                $next->is_default = true;
                $next->save();
            }
        }

        return response()->json(['status' => true]);
    }

    public function setDefault(Request $request, CustomerAddress $address)
    {
        if ($address->user_id !== $request->user()->id) {
            abort(403);
        }

        $this->clearOtherDefaults($request->user()->id, $address->id);
        $address->is_default = true;
        $address->save();

        return response()->json([
            'status' => true,
            'address' => $this->present($address),
        ]);
    }

    private function clearOtherDefaults(int $userId, int $exceptId): void
    {
        CustomerAddress::where('user_id', $userId)
            ->where('id', '!=', $exceptId)
            ->update(['is_default' => false]);
    }

    private function validateInput(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'label' => 'required|in:Home,Work,Other',
            'fullName' => 'required|min:2',
            'phone' => 'required',
            'line1' => 'required',
            'line2' => 'nullable',
            'city' => 'required',
            'state' => 'required',
            'pincode' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ]);
        }

        return $validator->validated();
    }

    /** Translates the frontend's simpler field set onto the real schema's columns. */
    private function fillFromInput(CustomerAddress $address, array $input, $user): CustomerAddress
    {
        [$firstName, $lastName] = $this->splitName($input['fullName']);

        $address->user_id = $user->id;
        $address->label = $input['label'];
        $address->first_name = $firstName;
        $address->last_name = $lastName;
        $address->email = $user->email;
        $address->mobile = $input['phone'];
        $address->country_id = self::DEFAULT_COUNTRY_ID;
        $address->address = $input['line1'];
        $address->apartment = $input['line2'] ?? null;
        $address->city = $input['city'];
        $address->state = $input['state'];
        $address->zip = $input['pincode'];

        return $address;
    }

    private function splitName(string $fullName): array
    {
        $parts = explode(' ', trim($fullName), 2);
        return [$parts[0], $parts[1] ?? ''];
    }

    /** Presents a CustomerAddress back in the frontend's Address shape. */
    private function present(CustomerAddress $address): array
    {
        return [
            'id' => (string) $address->id,
            'label' => $address->label,
            'fullName' => trim($address->first_name . ' ' . $address->last_name),
            'phone' => $address->mobile,
            'line1' => $address->address,
            'line2' => $address->apartment,
            'city' => $address->city,
            'state' => $address->state,
            'pincode' => $address->zip,
            'isDefault' => (bool) $address->is_default,
        ];
    }
}
