<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('products', function (Blueprint $table) {
            // Explicit, admin-controlled — the site only has two real
            // collections, and this was previously guessed from category_id
            // (== "Women"), which misclassified any non-party casual item
            // filed under Women. Nullable: existing rows need a one-time
            // backfill; the admin form makes it required going forward.
            $table->enum('collection', ['party-wear', 'casual-wear'])->nullable()->after('category_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('products', function (Blueprint $table) {
            $table->dropColumn('collection');
        });
    }
};
