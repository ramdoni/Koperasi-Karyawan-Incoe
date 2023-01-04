@section('title', 'Anggota')
<div class="clearfix row">
    <div class="col-lg-12">
        <div class="card">
            <div class="header row">
                <div class="col-md-2">
                    <input type="text" class="form-control" wire:model="keyword" placeholder="Pencarian" />
                </div>
                <div class="col-md-2 px-0">
                    <select class="form-control" wire:model="status">
                        <option value=""> --- Status --- </option>
                        <option value="1">Inactive</option>
                        <option value="2">Active</option>
                        <option value="5">Keluar</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <div class="btn-group" role="group">
                        <button id="btnGroupDrop1" type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Action</button>
                        <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                            <a class="dropdown-item" href="javascript:void(0);" wire:click="downloadExcel"><i class="fa fa-download"></i> Download</a>
                            <a href="{{route('user-member.insert')}}" class="dropdown-item"><i class="fa fa-plus"></i> Anggota</a>
                            <a href="javascript:void(0)" class="dropdown-item" data-toggle="modal" data-target="#modal_upload"><i class="fa fa-upload"></i> Upload</a>
                        </div>
                    </div>
                    <span wire:loading>
                        <i class="fa fa-spinner fa-pulse fa-2x fa-fw"></i>
                        <span class="sr-only">{{ __('Loading...') }}</span>
                    </span>
                </div>
            </div>
            <div class="body pt-0">
                <div class="table-responsive" style="min-height:400px;">
                    <table class="table table-hover m-b-0 c_list">
                        <thead style="background: #eee;">
                            <tr>
                                <th rowspan="2">No</th>
                                <th rowspan="2">No Anggota</th>
                                <th rowspan="2">Nama</th>                                 
                                <th rowspan="2">No Telepon</th>
                                <th rowspan="2">No KTP</th>
                                <th rowspan="2">Jenis Kelamin</th>
                                <th rowspan="2">Tempat</th>
                                <th rowspan="2">Tanggal Lahir</th>
                                <th rowspan="2"></th>
                                <th rowspan="2">Agama</th>
                                <th colspan="4" class="text-center">Simpanan</th>
                                <th colspan="4" class="text-center">Pinjaman</th>
                                <th rowspan="2" style="background:#35a2b869;text-align:center;">SHU</th>
                                <th colspan="2" class="text-center">Plafond Pinjaman</th>
                                <th rowspan="2">Simpanan Ku</th>
                                <th rowspan="2"></th>
                            </tr>
                            <tr>
                                <th>Pokok</th>
                                <th>Wajib</th>
                                <th>Sukarela</th>
                                <th>Lain-lain</th>
                                <th>Uang</th>
                                <th>Astra</th>
                                <th>Toko</th>
                                <th>Motor</th>
                                <th>Kuota</th>
                                <th>Digunakan</th>
                            </tr>
                        </thead>
                        <tbody>
                            @php($number= $data->total() - (($data->currentPage() -1) * $data->perPage()) )
                            @foreach($data as $k => $item)
                            <tr>
                                <td style="width: 50px;">{{$number}}</td>
                                <td><a href="{{route('user-member.edit',['id'=>$item->id])}}" class="{{$item->status==4?"text-danger" : ""}}">{{$item->no_anggota_platinum?$item->no_anggota_platinum:'-'}}</a></td>
                                <td>@livewire('user-member.editable',['field'=>'name','data'=>$item->name,'id'=>$item->id],key('name'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'phone_number','data'=>$item->phone_number,'id'=>$item->id],key('phone_number'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'Id_Ktp','data'=>$item->Id_Ktp,'id'=>$item->id],key('Id_Ktp'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'jenis_kelamin','data'=>$item->jenis_kelamin,'id'=>$item->id],key('jenis_kelamin'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'tempat_lahir','data'=>$item->tempat_lahir,'id'=>$item->id],key('tempat_lahir'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'tanggal_lahir','data'=>$item->tanggal_lahir,'id'=>$item->id],key('tanggal_lahir'.$item->id))</td>
                                <td>{{$item->tanggal_lahir ? hitung_umur($item->tanggal_lahir) .' thn' : ''}}</td>
                                <td>@livewire('user-member.editable',['field'=>'agama','data'=>$item->agama,'id'=>$item->id],key('agama'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'simpanan_pokok','data'=>$item->simpanan_pokok,'id'=>$item->id],key('simpanan_pokok'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'simpanan_wajib','data'=>$item->simpanan_wajib,'id'=>$item->id],key('simpanan_wajib'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'simpanan_sukarela','data'=>$item->simpanan_sukarela,'id'=>$item->id],key('simpanan_sukarela'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'simpanan_lain_lain','data'=>$item->simpanan_lain_lain,'id'=>$item->id],key('simpanan_lain_lain'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'pinjaman_uang','data'=>$item->pinjaman_uang,'id'=>$item->id],key('pinjaman_uang'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'pinjaman_astra','data'=>$item->pinjaman_astra,'id'=>$item->id],key('pinjaman_astra'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'pinjaman_toko','data'=>$item->pinjaman_toko,'id'=>$item->id],key('pinjaman_toko'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'pinjaman_motor','data'=>$item->pinjaman_motor,'id'=>$item->id],key('pinjaman_motor'.$item->id))</td>
                                <td>@livewire('user-member.editable',['field'=>'shu','data'=>$item->shu,'id'=>$item->id],key('shu'.$item->id))</td>
                                <td class="text-right">@livewire('user-member.editable',['field'=>'plafond','data'=>$item->plafond,'id'=>$item->id],key('plafond'.$item->id))</td>
                                <td class="text-right">@livewire('user-member.editable',['field'=>'plafond_digunakan','data'=>$item->plafond_digunakan,'id'=>$item->id],key('plafond_digunakan'.$item->id))</td>
                                <td class="text-right">@livewire('user-member.editable',['field'=>'simpanan_ku','data'=>$item->simpanan_ku,'id'=>$item->id],key('simpanan_ku'.$item->id))</td>
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
                        @if($number==0)
                            <tfoot>
                                <tr>
                                    <td colspan="9" class="text-center">Empty data</td>
                                </tr>
                            </tfoot>
                        @endif
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