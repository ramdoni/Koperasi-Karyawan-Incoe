@section('title', __('No Pengajuan : '. $data->no_pengajuan))
@section('parentPageTitle', 'Users')

<div class="row clearfix">
    <div class="col-md-7">
        <div class="card">
            <div class="body">
                <div class="row">
                    <div class="form-group col-md-6">
                        <div class="table-responsive">
                            <table class="table m-b-0 c_list table-striped">
                                <thead>
                                    <tr>
                                        <th>Pinjaman</th>
                                        <td style="width:5px;">:</td> 
                                        <td>{{format_idr($data->amount)}}</td>
                                    </tr>
                                    <tr>
                                        <th>Lama Angsuran</th>
                                        <td>:</td> 
                                        <td>{{$data->angsuran}} Bulan</td>
                                    </tr>
                                    <tr>
                                        <th>Jasa</th>
                                        <td>:</td> 
                                        <td>{{format_idr($data->jasa)}}</td>
                                    </tr>
                                    <tr>
                                        <th>Keterangan</th>
                                        <td>:</td> 
                                        <td>{{$data->description}}</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-striped m-b-0 c_list table-bordered">
                        <thead>
                            <tr>
                                <th rowspan="2">Bulan</th>                                    
                                <th rowspan="2">Pembiayan</th>                                    
                                <th colspan="2" class="text-center">Angsuran</th>                                    
                                <th colspan="2" class="text-center">Jasa</th>                                    
                                <th rowspan="2" class="text-center">Tagihan</th>
                                <th rowspan="2">Status</th>
                                <th rowspan="2"></th>
                            </tr>
                            <tr>
                                <th class="text-center">Ke</th>
                                <th class="text-right">Rp</th>
                                <th class="text-center">%</th>
                                <th class="text-right">Rp</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($data->items as $k => $item)
                                <tr>
                                    <td>{{date('d-M-Y',strtotime($item['bulan']))}}</td>
                                    <td>{{format_idr($item['pembiayaan'])}}</td>
                                    <td class="text-center">{{$k+1}}</td>
                                    <td class="text-right">{{format_idr($item['angsuran_perbulan'])}}</td>
                                    <td class="text-center">{{@abs($item['jasa'])}}</td>
                                    <td class="text-center">{{format_idr($item['jasa_nominal'])}}</td>
                                    <td class="text-right">{{format_idr($item['total'])}}</td>
                                    <td>
                                        @if($item->status==0)
                                            <span class="badge badge-danger">Belum lunas</span>
                                        @endif
                                        @if($item->status==1)
                                            <span class="badge badge-success">Lunas</span>
                                        @endif
                                    </td>
                                    <td>
                                        @if($item->status==0)
                                            <a href="javascript:void(0)" wire:click="lunas({{$item->id}})" class="badge badge-warning badge-active"><i class="fa fa-check"></i> Lunas</a>
                                        @endif
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                    <span wire:loading>
                        <i class="fa fa-spinner fa-pulse fa-2x fa-fw"></i>
                        <span class="sr-only">{{ __('Loading...') }}</span>
                    </span>
                </div>
                <hr />
                <div class="form-group">
                    <a href="javascript:void(0)" onclick="history.back()"><i class="fa fa-arrow-left"></i> {{ __('Kembali') }}</a>
                </div>
            </div>
        </div>
    </div>
</div>

@push('after-scripts')
    <link rel="stylesheet" href="{{ asset('assets/vendor/select2/css/select2.min.css') }}"/>
    <script src="{{ asset('assets/vendor/select2/js/select2.min.js') }}"></script>
    <script>
        select__2 = $('.select_anggota').select2();
        $('.select_anggota').on('change', function (e) {
            var data = $(this).select2("val");
            @this.set("user_member_id", data);
        });
    </script>
@endpush