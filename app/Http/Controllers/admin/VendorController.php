<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class VendorController extends Controller
{
    public function index(Request $request) {
        $vendors = User::where('role',User::ROLE_VENDOR)->withCount('products')->latest();

        if(!empty($request->get('keyword'))) {
            $vendors = $vendors->where('name','like','%'.$request->get('keyword').'%');
            $vendors = $vendors->orWhere('email','like','%'.$request->get('keyword').'%');
        }

        $vendors = $vendors->paginate(10);

        return view('admin.vendors.list',[
            'vendors' => $vendors
        ]);
    }

    public function create(Request $request) {
        return view('admin.vendors.create',[

        ]);
    }

    public function store(Request $request) {
        $validator = Validator::make($request->all(),[
            'name' => 'required',
            'password' => 'required|min:5',
            'email' => 'required|email|unique:users',
            'phone' => 'required',
        ]);

        if ($validator->passes()) {

            $vendor = new User;
            $vendor->name = $request->name;
            $vendor->email = $request->email;
            $vendor->phone = $request->phone;
            $vendor->status = $request->status;
            $vendor->role = User::ROLE_VENDOR;
            $vendor->password = Hash::make($request->password);
            $vendor->save();

            $message = 'Vendor added successfully.';

            session()->flash('success',$message);

            return response()->json([
                'status' => true,
                'message' => $message
            ]);

        } else {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ]);
        }
    }

    public function edit(Request $request, $id) {
        $vendor = User::where('role',User::ROLE_VENDOR)->find($id);

        if ($vendor == null) {
            $message = 'Vendor not found.';
            session()->flash('error',$message);
            return redirect()->route('admin.vendors.index');
        }

        return view('admin.vendors.edit',[
           'vendor' => $vendor
        ]);
    }

    public function update(Request $request, $id) {

        $vendor = User::where('role',User::ROLE_VENDOR)->find($id);

        if ($vendor == null) {
            $message = 'Vendor not found.';
            session()->flash('error',$message);

            return response()->json([
                'status' => true,
                'message' => $message
            ]);
        }

        $validator = Validator::make($request->all(),[
            'name' => 'required',
            'email' => 'required|email|unique:users,email,'.$id.',id',
            'phone' => 'required',
        ]);

        if ($validator->passes()) {

            $vendor->name = $request->name;
            $vendor->email = $request->email;
            $vendor->phone = $request->phone;
            $vendor->status = $request->status;

            if ($request->password != '') {
                $vendor->password = Hash::make($request->password);
            }

            $vendor->save();

            $message = 'Vendor updated successfully.';

            session()->flash('success',$message);

            return response()->json([
                'status' => true,
                'message' => $message
            ]);

        } else {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ]);
        }
    }

    public function destroy($id) {

        $vendor = User::where('role',User::ROLE_VENDOR)->find($id);

        if ($vendor == null) {
            $message = 'Vendor not found.';
            session()->flash('error',$message);

            return response()->json([
                'status' => true,
                'message' => $message
            ]);
        }

        $vendor->delete();

        $message = 'Vendor deleted successfully.';
        session()->flash('success',$message);

        return response()->json([
            'status' => true,
            'message' => $message
        ]);

    }
}
