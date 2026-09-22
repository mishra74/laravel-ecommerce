<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

// Deliberately separate from password_reset_otps — a leaked or guessed
// login code should only ever be able to log in as the customer, never
// also be usable to change their password (and vice versa).
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('login_otps', function (Blueprint $table) {
            $table->string('email')->primary();
            $table->string('otp');
            $table->timestamp('expires_at');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('login_otps');
    }
};
