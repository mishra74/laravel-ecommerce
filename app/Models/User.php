<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    const ROLE_CUSTOMER = 1;
    const ROLE_ADMIN = 2;
    const ROLE_VENDOR = 3;

    const STATUS_ACTIVE = 1;
    const STATUS_SUSPENDED = 0;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'role',
        'status',
        'phone',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function products()
    {
        return $this->hasMany(Product::class, 'vendor_id');
    }

    public function isAdmin(): bool
    {
        return $this->role == self::ROLE_ADMIN;
    }

    public function isVendor(): bool
    {
        return $this->role == self::ROLE_VENDOR;
    }

    public function isCustomer(): bool
    {
        return $this->role == self::ROLE_CUSTOMER;
    }
}
