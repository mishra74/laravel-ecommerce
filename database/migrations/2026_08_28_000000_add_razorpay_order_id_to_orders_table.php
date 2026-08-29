<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            // Standard Checkout replaces the Payment Links flow — a Razorpay
            // *order* id (not a payment link id) ties our Order row to the
            // Razorpay order created before the customer pays.
            $table->string('razorpay_order_id')->nullable()->after('payment_method');
        });
    }

    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->dropColumn('razorpay_order_id');
        });
    }
};
