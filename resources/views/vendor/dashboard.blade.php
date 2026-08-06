@extends('vendor.layouts.app')

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
        @include('admin.message')
        <div class="row">
            @php
                $cards = [
                    ['title' => 'Total Products', 'value' => $totalProducts, 'icon' => 'fas fa-box', 'route' => route('vendor.products.index'), 'color' => 'bg-primary'],
                    ['title' => 'Active Products', 'value' => $activeProducts, 'icon' => 'fas fa-check-circle', 'route' => route('vendor.products.index'), 'color' => 'bg-success'],
                    ['title' => 'Inactive Products', 'value' => $inactiveProducts, 'icon' => 'fas fa-times-circle', 'route' => route('vendor.products.index'), 'color' => 'bg-warning'],
                    ['title' => 'Orders with My Products', 'value' => $totalOrders, 'icon' => 'fas fa-shopping-cart', 'route' => route('vendor.orders.index'), 'color' => 'bg-info'],
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
