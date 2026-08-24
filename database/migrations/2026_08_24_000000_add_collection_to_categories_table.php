<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('categories', function (Blueprint $table) {
            // Admin-organizational only — lets the category list be filtered/
            // identified by collection at a glance. Nullable: a category
            // doesn't have to belong to just one collection (or either).
            $table->enum('collection', ['party-wear', 'casual-wear'])->nullable()->after('slug');
        });
    }

    public function down(): void
    {
        Schema::table('categories', function (Blueprint $table) {
            $table->dropColumn('collection');
        });
    }
};
