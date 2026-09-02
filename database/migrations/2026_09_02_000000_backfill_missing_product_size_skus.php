<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

/**
 * One-time repair for ProductSize rows saved before syncSizes() backfilled
 * sku on every save (it used to only set sku on first creation) — those
 * rows are stuck with sku=null forever otherwise, which blocks checkout
 * with "The items.0.sku field is required." for any customer buying that
 * size. Runs automatically on the next deploy, no manual admin resave needed.
 */
return new class extends Migration
{
    public function up(): void
    {
        $rows = DB::table('product_sizes')
            ->whereNull('sku')
            ->orWhere('sku', '')
            ->get();

        foreach ($rows as $row) {
            $product = DB::table('products')->where('id', $row->product_id)->first();
            if (!$product) {
                continue;
            }

            DB::table('product_sizes')
                ->where('id', $row->id)
                ->update(['sku' => $product->sku . '-' . $row->size]);
        }
    }

    public function down(): void
    {
        // Not reversible — we don't know which rows were null before.
    }
};
