@section('title', $data->kode_produksi .' / '.$data->keterangan)
@section('parentPageTitle', 'Produk')
<div class="row clearfix">
    <div class="col-md-12 px-0 mx-0">
        <div class="card">
            <div class="body">
                <div class="row">
                    <div class="col-3">
                        <table class="table">
                            <tr>
                                <th>Kode Produksi</th>
                                <td> : </td>
                                <td>{{$data->kode_produksi}}</td>
                            </tr>
                            <tr>
                                <th>Produk</th>
                                <td> : </td>
                                <td>{{$data->keterangan}}</td>
                            </tr>
                            <tr>
                                <th>UOM</th>
                                <td> : </td>
                                <td>{{isset($data->uom->name) ? $data->uom->name : '-'}}</td>
                            </tr>
                            <tr>
                                <th>HPP</th>
                                <td> : </td>
                                <td>Rp. {{format_idr($data->harga)}}</td>
                            </tr>
                            <tr>
                                <th>Harga Jual</th>
                                <td> : </td>
                                <td>Rp. {{format_idr($data->harga_jual)}}</td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-3">
                        <table class="table">
                            <tr>
                                <th>Stok</th>
                                <td style="width:10px;"> : </td>
                                <td>{{$data->qty}}</td>
                            </tr>
                            <tr>
                                <th>Last Update</th>
                                <td style="width:10px;"> : </td>
                                <td>{{date('d-M-Y',strtotime($data->updated_at))}}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6 pl-0">
        <div class="card">
            <div class="body">
                <h6>Detail Pembelian</h6>
                <hr />
                <div class="table-responsive">
                    <table class="table table-striped m-b-0 c_list table-bordered">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>PR Number</th>
                                <th>PO Number</th>
                                <th>WO Number</th>
                                <th>Total</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6 pr-0">
        <div class="card">
            <div class="body">
                <h6>Detail Penjualan</h6>
                <hr />
                <div class="table-responsive">
                    <table class="table table-striped m-b-0 c_list table-bordered">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>No Transaksi</th>
                                <th>Harga Jual</th>
                                <th>QTY</th>
                                <th>Total</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        @foreach($penjualan as $k => $item)
                            <tr>
                                <td>{{$k+1}}</td>
                                <td>
                                    @if(isset($item->transaksi->no_transaksi))
                                        <a href="{{route('transaksi.items',$item->transaksi_id)}}" target="_blank">{{$item->transaksi->no_transaksi}}</a>
                                    @endif
                                </td>
                                <td>{{format_idr($item->price)}}</td>
                                <td>{{format_idr($item->qty)}}</td>
                                <td>{{format_idr($item->total)}}</td>
                                <td>{{date('d-M-Y',strtotime($item->created_at))}}</td>
                            </tr>
                        @endforeach
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

@push('after-scripts')
    <link rel="stylesheet" href="{{ asset('assets/vendor/select2/css/select2.min.css') }}"/>
    <script src="{{ asset('assets/vendor/select2/js/select2.min.js') }}"></script>
    <script>
        setTimeout(() => {
            select__2 = $('.select_anggota').select2();
            $('.select_anggota').on('change', function (e) {
                var data = $(this).select2("val");
                @this.set("user_member_id", data);
            });
        }, 1000);
    </script>
@endpush