@extends('admin.layouts.app')

@section('content')
<!-- Content Header -->
<section class="content-header">					
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="text-primary font-weight-bold">Dashboard</h1>
            </div>
        </div>
    </div>
</section>

<!-- Main content -->
<section class="content">
    <div class="container-fluid">
        <div class="row">
            @php
                $cards = [
                    ['title' => 'Total Orders', 'value' => $totalOrders, 'icon' => 'fas fa-shopping-cart', 'route' => route('orders.index'), 'color' => 'bg-primary'],
                    ['title' => 'Total Products', 'value' => $totalProducts, 'icon' => 'fas fa-box', 'route' => route('products.index'), 'color' => 'bg-success'],
                    ['title' => 'Total Customers', 'value' => $totalCustomers, 'icon' => 'fas fa-users', 'route' => route('users.index'), 'color' => 'bg-warning'],
                    ['title' => 'Total Sales', 'value' => '₹' . number_format($totalRevenue,2), 'icon' => 'fas fa-coins', 'route' => 'javascript:void(0);', 'color' => 'bg-danger'],
                    ['title' => 'Revenue This Month', 'value' => '₹' . number_format($revenueThisMonth,2), 'icon' => 'fas fa-chart-line', 'route' => 'javascript:void(0);', 'color' => 'bg-info'],
                    ['title' => 'Revenue Last Month ('.$lastMonthName.')', 'value' => '₹' . number_format($revenueLastMonth,2), 'icon' => 'fas fa-calendar-alt', 'route' => 'javascript:void(0);', 'color' => 'bg-dark'],
                    ['title' => 'Revenue Last 30 Days', 'value' => '₹' . number_format($revenueLastThirtyDays,2), 'icon' => 'fas fa-chart-bar', 'route' => 'javascript:void(0);', 'color' => 'bg-secondary']
                ];
            @endphp

            @foreach ($cards as $card)
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card text-white {{ $card['color'] }} shadow">
                        <div class="card-body d-flex align-items-center">
                            <div class="mr-3">
                                <i class="{{ $card['icon'] }} fa-2x"></i>
                            </div>
                            <div>
                                <h5 class="mb-0">{{ $card['value'] }}</h5>
                                <p class="mb-0">{{ $card['title'] }}</p>
                            </div>
                        </div>
                        <div class="card-footer bg-light text-dark">
                            <a href="{{ $card['route'] }}" class="text-dark font-weight-bold">More Info <i class="fas fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                </div>
            @endforeach
        </div>
    </div>					
</section>
@endsection

@section('customJs')
<script>    
    console.log("Dashboard Loaded");
</script>
@endsection
