<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('product_sizes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('product_id')->constrained()->cascadeOnDelete();
            $table->enum('size', ['S', 'M', 'L', 'XL', 'XXL', 'XXXL']);
            // Own SKU per size (e.g. "sku-7-M") so cart/order lines can key
            // on it directly, the same way they already key on a product's
            // plain sku — no schema change needed anywhere else downstream.
            $table->string('sku')->unique();
            $table->unsignedInteger('qty')->default(0);
            $table->timestamps();

            $table->unique(['product_id', 'size']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('product_sizes');
    }
};
