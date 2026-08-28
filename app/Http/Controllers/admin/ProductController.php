<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use App\Models\Brand;
use App\Models\Category;
use App\Models\Product;
use App\Models\ProductImage;
use App\Models\ProductSize;
use App\Models\SubCategory;
use App\Models\TempImage;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Validator;
use Image;

class ProductController extends Controller
{

    public function index(Request $request)
    {
        $products = Product::latest('id')->with('product_images','vendor');

        if ($request->get('keyword') != "") {
            $products = $products->where('title','like','%'.$request->keyword.'%');
        }

        if ($request->get('vendor_id') != "") {
            if ($request->get('vendor_id') == '0') {
                $products = $products->whereNull('vendor_id');
            } else {
                $products = $products->where('vendor_id',$request->get('vendor_id'));
            }
        }

        $products = $products->paginate();
        //dd($products);
        $data['products'] = $products;
        $data['vendors'] = User::where('role',User::ROLE_VENDOR)->orderBy('name','ASC')->get();
        return view('admin.products.list',$data);
    }

    public function create() {
        $data = [];
        $categories = Category::orderBy('name','ASC')->get();
        $brands = Brand::orderBy('name','ASC')->get();
        $data['categories'] = $categories;
        $data['brands'] = $brands;
        $data['vendors'] = User::where('role',User::ROLE_VENDOR)->orderBy('name','ASC')->get();
        return view('admin.products.create', $data);
    }

    public function store(Request $request) {

        // dd($request->image_array);
        // exit();
        $rules = [
            'title' => 'required',
            'slug' => 'required|unique:products',
            'price' => 'required|numeric',
            'sku' => 'required|unique:products',
            'track_qty' => 'required|in:Yes,No',
            'category' => 'required|numeric',
            'collection' => 'required|in:party-wear,casual-wear',
            'is_featured' => 'required|in:Yes,No',
        ];


        if (!empty($request->track_qty) && $request->track_qty == 'Yes') {
            $rules['qty'] = 'required|numeric';
        }


        $validator = Validator::make($request->all(),$rules);

        if ($validator->passes()) {

            $product = new Product;
            $product->vendor_id = $request->vendor_id ?: null;
            $product->title = $request->title;
            $product->slug = $request->slug;
            $product->description = $request->description;
            $product->price = $request->price;
            $product->compare_price = $request->compare_price;
            $product->sku = $request->sku;
            $product->barcode = $request->barcode;
            $product->track_qty = $request->track_qty;
            $product->qty = $request->qty;
            $product->status = $request->status;
            $product->category_id = $request->category;
            $product->collection = $request->collection;
            $product->sub_category_id = $request->sub_category;
            $product->brand_id = $request->brand;
            $product->is_featured = $request->is_featured;
            $product->shipping_returns = $request->shipping_returns;
            $product->short_description = $request->short_description;
            $product->related_products = (!empty($request->related_products)) ? implode(',',$request->related_products) : '';
            $product->save();

            $this->syncSizes($product, $request);

            // Save Gallery Pics
            if(!empty($request->image_array)) {
                foreach ($request->image_array as $temp_image_id) {

                    $tempImageInfo = TempImage::find($temp_image_id);
                    $extArray = explode('.',$tempImageInfo->name);
                    $ext = last($extArray); // like jpg,gif,png etc

                    $productImage = new ProductImage();
                    $productImage->product_id = $product->id;
                    $productImage->image = 'NULL';
                    $productImage->save();

                    $imageName = $product->id.'-'.$productImage->id.'-'.time().'.'.$ext;
                    $productImage->image = $imageName;
                    $productImage->save();
                    
                    // Generate Product Thumbnails

                    // Large Image
                    $sourcePath = public_path().'/temp/'.$tempImageInfo->name;
                    $destPath = public_path().'/uploads/product/large/'.$imageName;
                    $image = Image::make($sourcePath);
                    $image->resize(1400, null, function ($constraint) {
                        $constraint->aspectRatio();
                    });
                    $image->save($destPath);

                    // Small Image
                    $destPath = public_path().'/uploads/product/small/'.$imageName;
                    $image = Image::make($sourcePath);
                    $image->fit(300,300);
                    $image->save($destPath);


                }
            }


            $request->session()->flash('success','Product added successfully');

            return response()->json([
                'status' => true,
                'message' => 'Product added successfully'
            ]);

        } else {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ]);
        }
    }

    public function edit($id, Request $request)
    {
        $product = Product::find($id);

        if (empty($product)) {
            return redirect()->route('products.index')->with('error','Product not found');
        }

        // Fetch Product Images
        $productImages = ProductImage::where('product_id',$product->id)->get();

        $productSizes = ProductSize::where('product_id',$product->id)->get()->keyBy('size');

        $subCategories = SubCategory::where('category_id',$product->category_id)->get();

        $relatedProducts = [];
        // fetch related products
        if ($product->related_products != '') {
            $productArray = explode(',',$product->related_products);
            $relatedProducts = Product::whereIn('id',$productArray)->with('product_images')->get();
        }

        
        $data = [];
        $categories = Category::orderBy('name','ASC')->get();
        $brands = Brand::orderBy('name','ASC')->get();
        $data['categories'] = $categories;
        $data['brands'] = $brands;
        $data['product'] = $product;
        $data['subCategories'] = $subCategories;
        $data['productImages'] = $productImages;
        $data['productSizes'] = $productSizes;
        $data['relatedProducts'] = $relatedProducts;
        $data['vendors'] = User::where('role',User::ROLE_VENDOR)->orderBy('name','ASC')->get();

        return view('admin.products.edit',$data);
    }

    public function update($id, Request $request){

        $product = Product::find($id);

        $rules = [
            'title' => 'required',
            'slug' => 'required|unique:products,slug,'.$product->id.',id',
            'price' => 'required|numeric',
            'sku' => 'required|unique:products,sku,'.$product->id.',id',
            'track_qty' => 'required|in:Yes,No',
            'category' => 'required|numeric',
            'collection' => 'required|in:party-wear,casual-wear',
            'is_featured' => 'required|in:Yes,No',
        ];


        if (!empty($request->track_qty) && $request->track_qty == 'Yes') {
            $rules['qty'] = 'required|numeric';
        }


        $validator = Validator::make($request->all(),$rules);

        if ($validator->passes()) {

            $product->vendor_id = $request->vendor_id ?: null;
            $product->title = $request->title;
            $product->slug = $request->slug;
            $product->description = $request->description;
            $product->price = $request->price;
            $product->compare_price = $request->compare_price;
            $product->sku = $request->sku;
            $product->barcode = $request->barcode;
            $product->track_qty = $request->track_qty;
            $product->qty = $request->qty;
            $product->status = $request->status;
            $product->category_id = $request->category;
            $product->collection = $request->collection;
            $product->sub_category_id = $request->sub_category;
            $product->brand_id = $request->brand;
            $product->is_featured = $request->is_featured;
            $product->shipping_returns = $request->shipping_returns;
            $product->short_description = $request->short_description;
            $product->related_products = (!empty($request->related_products)) ? implode(',',$request->related_products) : '';
            $product->save();

            $this->syncSizes($product, $request);

            // Save Gallery Pics
            $request->session()->flash('success','Product updated successfully');

            return response()->json([
                'status' => true,
                'message' => 'Product updated successfully'
            ]);

        } else {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ]);
        }
    }

    /**
     * Creates/updates/removes this product's ProductSize rows to match the
     * checked sizes + qty inputs on the form. A product with no sizes
     * checked keeps behaving exactly as before (single "Free Size", stock
     * tracked on the product itself) — sizes are opt-in per product.
     */
    private function syncSizes(Product $product, Request $request): void
    {
        $enabled = $request->input('size_enabled', []);
        $qtyInput = $request->input('size_qty', []);

        $keep = [];

        foreach ($enabled as $size) {
            $qty = (int) ($qtyInput[$size] ?? 0);

            $productSize = ProductSize::firstOrNew([
                'product_id' => $product->id,
                'size' => $size,
            ]);
            $productSize->qty = $qty;
            if (!$productSize->exists) {
                $productSize->sku = $product->sku . '-' . $size;
            }
            $productSize->save();

            $keep[] = $productSize->id;
        }

        ProductSize::where('product_id', $product->id)
            ->whereNotIn('id', $keep)
            ->delete();
    }

    public function destroy($id, Request $request){
        $product = Product::find($id);

        if (empty($product)) {
            $request->session()->flash('error','Product not found');
            return response()->json([
                'status' => false,
                'notFound' => true
            ]);
        }

        $productImages = ProductImage::where('product_id',$id)->get();

        if (!empty($productImages)) {
            foreach ($productImages as $productImage) {
                File::delete(public_path('uploads/product/large/'.$productImage->image));
                File::delete(public_path('uploads/product/small/'.$productImage->image));
            }

            ProductImage::where('product_id',$id)->delete();            
        }

        $product->delete();

        $request->session()->flash('success','Product deleted successfully');

        return response()->json([
            'status' => true,
            'message' => 'Product deleted successfully'
        ]);
      
    }

    public function getProducts(Request $request){

        $tempProduct = [];
        if ($request->term != "") {
            $products = Product::where('title','like','%'.$request->term.'%')->get();


            if ($products != null) {
                foreach ($products as $product) {
                    $tempProduct[] = array('id' => $product->id, 'text' => $product->title);
                }
            }
        }

        return response()->json([
            'tags' => $tempProduct,
            'status' => true
        ]);

    }

}
