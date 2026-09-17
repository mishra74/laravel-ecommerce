<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

// No delivery/courier partner integration exists yet to compute a real
// estimate, so the admin sets a plain number of days per product instead —
// nullable, since not every product has one set.
return new class extends Migration
{
    public function up(): void
    {
        Schema::table('products', function (Blueprint $table) {
            $table->unsignedSmallInteger('delivery_days')->nullable()->after('shipping_returns');
        });
    }

    public function down(): void
    {
        Schema::table('products', function (Blueprint $table) {
            $table->dropColumn('delivery_days');
        });
    }
};
