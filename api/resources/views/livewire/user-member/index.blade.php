@section('title', 'Anggota')
@section('parentPageTitle', 'Home')
<div class="clearfix row">
    <div class="col-lg-12">
        <div class="card">
            <div class="header row">
                <div class="col-md-2">
                    <select class="form-control" wire:model="koordinator_id">
                        <option value=""> --- Koordinator --- </option>
                        @foreach(\App\Models\UserMember::select('user_member.*')->join('users','users.id','=','user_member.user_id')->where('users.user_access_id','=',3)->orderBy('user_member.name','ASC')->get() as $koordinator)
                        <option value="{{$koordinator->id}}">{{$koordinator->name}}</option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-2">
                    <input type="text" class="form-control" wire:model="keyword" placeholder="Pencarian" />
                </div>
                <div class="col-md-2 px-0">
                    <select class="form-control" wire:model="status">
                        <option value=""> --- Status --- </option>
                        <option value="1">Inactive</option>
                        <option value="2">Active</option>
                        <option value="3">Ditolak</option>
                        <option value="4">Meninggal</option>
                        <option value="5">Keluar</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <a href="javascript:;" class="ml-2 btn btn-info" wire:click="downloadExcel"><i class="fa fa-download"></i> Download</a>
                    <a href="{{route('user-member.insert')}}" class="btn btn-primary"><i class="fa fa-plus"></i> Anggota</a>
                    <span wire:loading>
                        <i class="fa fa-spinner fa-pulse fa-2x fa-fw"></i>
                        <span class="sr-only">{{ __('Loading...') }}</span>
                    </span>
                </div>
            </div>
            <div class="body pt-0">
                <div class="table-responsive" style="min-height:400px;">
                    <table class="table table-hover m-b-0 c_list">
                        <thead>
                            <tr style="background: #eee;">
                                <th>No</th>
                                <th>Koordinator</th>
                                <th>No Anggota</th>
                                <th>Nama</th>                                 
                                <th>No Telepon</th>
                                <th>No KTP</th>
                                <th>Jenis Kelamin</th>
                                <th>Tempat / Tanggal Lahir</th>
                                <th></th>
                                <th>Agama</th>
                                <th>Keanggotaan</th>
                                <th>Rekomendator</th>
                                <th>Tanggal Meninggal</th>
                                <th>Santunan Pelayanan</th>
                                <th>Santunan Uang Duka</th>
                                <th>Pembayaran Pendaftaran</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            @php($number= $data->total() - (($data->currentPage() -1) * $data->perPage()) )
                            @foreach($data as $k => $item)
                            <tr>
                                <td style="width: 50px;">{{$number}}</td>
                                <td>{{isset($item->koordinatorUser->name)?$item->koordinatorUser->name:$item->koordinator_nama}}</td>
                                <td>{{$item->no_anggota_platinum?$item->no_anggota_platinum:'-'}}</td>
                                <td><a href="{{route('user-member.edit',['id'=>$item->id])}}" class="{{$item->status==4?"text-danger" : ""}}">{{$item->name}}</a></td>
                                <td>{{$item->phone_number}}</td>
                                <td>{{$item->Id_Ktp}}</td>
                                <td>@livewire('user-member.editable',['field'=>'jenis_kelamin','data'=>$item],key($item->id))</td>
                                <td>{{$item->tempat_lahir}} - {{$item->tanggal_lahir ? date('d M Y',strtotime($item->tanggal_lahir)) : ''}}</td>
                                <td class="px-0"><span class="text-success"> {{$item->tanggal_lahir ? hitung_umur($item->tanggal_lahir) .' thn' : ''}} </span></td>
                                <td>@livewire('user-member.editable',['field'=>'agama','data'=>$item],key($item->id))</td>
                                <td> 
                                    @switch($item->status)
                                        @case(0)
                                            <a href="javascript:void(0)" class="badge badge-warning">Inactive</a>
                                            @break
                                        @case(1)
                                            <a href="javascript:void(0)" class="badge badge-warning">Inactive</a>
                                        @break
                                        @case(2)
                                            <?php
                                                $countrec = $item->user_rekomendasi_count;
                                                $recmember = 0;
                                                if(hitung_umur($item->tanggal_lahir) >60 and hitung_umur($item->tanggal_lahir) <=64) $recmember = 1;
                                                if(hitung_umur($item->tanggal_lahir) >=65 and hitung_umur($item->tanggal_lahir) <=74) $recmember = 3;
                                                if(hitung_umur($item->tanggal_lahir) >=75) $recmember = 5;
                                            ?>
                                            @if(hitung_umur($item->tanggal_lahir) >= 60)
                                                @if($recmember > $countrec)
                                                    <a href="javascript:void(0)" class="badge badge-warning" data-toggle="tooltip" title="Perlu menyertakan anggota rekomendasi">Inactive</a>   
                                                @else
                                                    <a href="javascript:void(0)" wire:click="$emit('modal-konfirmasi-meninggal',{{$item->id}})" class="badge badge-success" title="{{ $item->tanggal_diterima ?  date('d M Y',strtotime($item->tanggal_diterima)):''}}">Active</a>
                                                @endif
                                            @else
                                                <a href="javascript:void(0)" wire:click="$emit('modal-konfirmasi-meninggal',{{$item->id}})" class="badge badge-success" title="{{ $item->tanggal_diterima ?  date('d M Y',strtotime($item->tanggal_diterima)):''}}">Active</a>
                                            @endif
                                        @break
                                        @case(3)
                                            <a href="javascript:void(0)" wire:click="$emit('modal-konfirmasi-meninggal',{{$item->id}})" class="badge badge-danger">Ditolak</a>
                                        @break
                                        @case(4)
                                            <a href="javascript:void(0)" wire:click="$emit('modal-detail-meninggal',{{$item->id}})" class="badge badge-danger">Meninggal</a>
                                        @break
                                        @case(5)
                                            <span class="badge badge-danger">Keluar</span>
                                        @break
                                    @endswitch
                                </td>
                                <td>{{isset($item->user_rekomendasi->name) ? $item->user_rekomendasi->name : '-'}}</td>
                                <td><a href="javascript:void(0)" wire:click="$emit('modal-detail-meninggal',{{$item->id}})">{{isset($item->klaim->tgl_kematian) ? date('d-M-Y',strtotime($item->klaim->tgl_kematian)) : ''}}</a></td>
                                <td>{{isset($item->klaim->santunan_pelayanan) ? format_idr($item->klaim->santunan_pelayanan) : ''}}</td>
                                <td>{{isset($item->klaim->santunan_uang_duka) ? format_idr($item->klaim->santunan_uang_duka) : ''}}</td>
                                <td>{!!status_registration_payment($item)!!}</td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <a href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-navicon"></i></a>
                                        <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                            @if($item->user_id && $item->status < 4)
                                            <a href="#" class="dropdown-item text-success" onclick="autologin('{{ route('users.autologin',['id'=>$item->user_id]) }}','{{$item->name}}')" title="Autologin"><i class="fa fa-sign-in"></i> Autologin</a>
                                            @endif
                                            <a class="dropdown-item" href="{{route('user-member.edit',['id'=>$item->id])}}"><i class="fa fa-search-plus"></i> Detail</a>
                                            <a class="dropdown-item" href="{{route('user-member.print-member',['id'=>$item->id])}}" target="_blank"><i class="fa fa-print"></i> Print</a>
                                            @if($item->status_pembayaran < 1)
                                                <a class="dropdown-item text-danger" href="{{route('user-member.proses',['id'=>$item->id])}}"><i class="fa fa-check"></i> Konfirmasi</a>
                                            @endif
                                            @if($item->status_pembayaran == 1)
                                                @if($item->admin_approval === NULL || $item->admin_approval < 0)
                                                <a class="dropdown-item text-danger" href="{{route('user-member.approval',['id'=>$item->id])}}"><i class="fa fa-check"></i> Konfirmasi</a>
                                                @endif
                                            @endif
                                            <a class="dropdown-item" href="javascript:void(0)" wire:click="set_member({{$item->id}})" data-toggle="modal" data-target="#modal_set_password"><i class="fa fa-key"></i> Set Password</a>
                                        </div>
                                    </div>    
                                </td>
                            </tr>
                            @php($number--)
                            @endforeach
                        </tbody>
                    </table>
                </div>
                <br />
                {{$data->links()}}
            </div>
        </div>
    </div>

    <div wire:ignore.self class="modal fade" id="modal_set_password" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form wire:submit.prevent="changePassword">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel"><i class="fa fa-sign-in"></i> Set Password</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true close-btn">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Password</label>
                            <input type="text" class="form-control" wire:model="password" />
                            @error('password') <span class="text-danger">{{ $message }}</span> @enderror
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-danger close-modal">Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="modal_autologin" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form method="POST" action="">
                {{ csrf_field() }}
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"><i class="fa fa-sign-in"></i> Autologin</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true close-btn">×</span>
                    </button>
                </div>
                <div class="modal-body"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary close-btn" data-dismiss="modal">No</button>
                    <button type="submit" class="btn btn-danger close-modal">Yes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="modal_upload" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <livewire:user-member.upload />
        </div>
    </div>
</div>

<div wire:ignore.self class="modal fade" id="modal_konfirmasi_meninggal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" style="min-width: 90%;" role="document">
        <div class="modal-content">
            <livewire:user-member.konfirmasi-meninggal />
        </div>
    </div>
</div>

<div wire:ignore.self class="modal fade" id="modal_detail_meninggal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" style="min-width: 90%;" role="document">
        <div class="modal-content">
            <livewire:user-member.detail-meninggal />
        </div>
    </div>
</div>

<div wire:ignore.self class="modal fade" id="modal_ajukan_klaim" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="min-width: 90%;" role="document">
        <div class="modal-content">
            <livewire:user-member.ajukan-klaim />
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="confirm_delete" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"><i class="fa fa-warning"></i> Confirm Delete</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true close-btn">×</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <p>Are you want delete this data ?</p>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close-btn" data-dismiss="modal">No</button>
                <button type="button" wire:click="delete()" class="btn btn-danger close-modal">Yes</button>
            </div>
        </div>
    </div>
</div>
@push('after-scripts')
<script>
    Livewire.on('modal-konfirmasi-meninggal',(data)=>{
        $("#modal_konfirmasi_meninggal").modal("show");
    });
    Livewire.on('modal-detail-meninggal',(data)=>{
        $("#modal_detail_meninggal").modal("show");
    });
</script>
@endpush
@section('page-script')
function autologin(action,name){
    $("#modal_autologin form").attr("action",action);
    $("#modal_autologin .modal-body").html('<p>Autologin as '+name+' ?</p>');
    $("#modal_autologin").modal("show");
}
@endsection