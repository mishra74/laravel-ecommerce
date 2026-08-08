<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->enum('payment_method', ['cod', 'online'])->default('cod')->after('payment_status');
            $table->string('razorpay_payment_link_id')->nullable()->after('payment_method');
            $table->string('razorpay_payment_id')->nullable()->after('razorpay_payment_link_id');
            $table->string('razorpay_signature')->nullable()->after('razorpay_payment_id');
        });
    }

    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->dropColumn(['payment_method', 'razorpay_payment_link_id', 'razorpay_payment_id', 'razorpay_signature']);
        });
    }
};
