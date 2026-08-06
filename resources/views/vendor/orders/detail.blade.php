@extends('vendor.layouts.app')

@section('content')
<!-- Content Header (Page header) -->
<section class="content-header">
    <div class="container-fluid my-2">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Order: #{{ $order->id }}</h1>
            </div>
            <div class="col-sm-6 text-right">
                <a href="{{ route('vendor.orders.index') }}" class="btn btn-primary">Back</a>
            </div>
        </div>
    </div>
    <!-- /.container-fluid -->
</section>
<!-- Main content -->
<section class="content">
    <!-- Default box -->
    <div class="container-fluid">
        @include('admin.message')
        <p class="text-muted">Only the items from your own products in this order are shown below.</p>
        <div class="card">
            <div class="card-header pt-3">
                <div class="row invoice-info">
                    <div class="col-sm-4 invoice-col">
                        <b>Order ID:</b> {{ $order->id }}<br>
                        <b>Status:</b>
                        @if ($order->status == 'pending')
                            <span class="text-danger">Pending</span>
                           @elseif ($order->status == 'shipped')
                            <span class="text-info">Shipped</span>
                           @elseif ($order->status == 'delivered')
                           <span class="text-success">Delivered</span>
                           @else
                           <span class="text-danger">Cancelled</span>
                           @endif
                        <br>
                        <b>Date:</b> {{ \Carbon\Carbon::parse($order->created_at)->format('d M, Y') }}
                    </div>
                </div>
            </div>
            <div class="card-body table-responsive p-3">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th width="100">Price</th>
                            <th width="100">Qty</th>
                            <th width="100">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($orderItems as $item)
                         <tr>
                            <td>{{ $item->name }}</td>
                            <td>₹{{ number_format($item->price,2) }}</td>
                            <td>{{ $item->qty }}</td>
                            <td>₹{{ number_format($item->total,2) }}</td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- /.card -->
</section>
<!-- /.content -->
@endsection
