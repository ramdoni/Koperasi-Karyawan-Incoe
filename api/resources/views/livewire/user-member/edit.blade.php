@section('title', $data->name .' / '. $data->no_anggota_platinum)
@section('parentPageTitle', 'Anggota')
<div class="mt-2 card">
    <div class="card-body">
    <form class="form-auth-small" method="POST" wire:submit.prevent="save">
        <div class="row">
            <div class="col-md-6">
                <table>
                    <tr>
                        <th>No Form</th>
                        <td> : {{$data->no_form}}</td>
                    </tr>
                    <tr>
                        <th>No Anggota</th>
                        <td> : {{$data->no_anggota_platinum}}</td>
                    </tr>
                </table>
                <hr />
                <div class="row">   
                    <div class="form-group col-md-6">
                        <label>No Anggota ex Gold</label>
                        <input type="text" class="form-control" wire:model="no_anggota_gold">
                    </div> 
                    <div class="form-group col-md-6">
                        <label>No KTP</label>
                        <input type="text" class="form-control" id="Id_Ktp" placeholder="Enter ID" wire:model="Id_Ktp">
                        @error('Id_Ktp') <span class="text-danger">{{ $message }}</span> @enderror
                    </div> 
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label>Nama (sesuai KTP)</label>
                        <input type="text" class="form-control" id="name" placeholder="Enter name" wire:model="name">
                        @error('name') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    <div class="form-group col-md-6">
                        <label>Nama yang dicantumkan di KTA</label>
                        <input type="text" class="form-control" id="name_kta" placeholder="Enter here" wire:model="name_kta">
                        @error('name_kta') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label>E-mail</label>
                        <input type="E-mail" class="form-control" id="email" placeholder="Enter name" wire:model="email">
                        @error('email') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    <div class="form-group col-md-6">
                        <label>No Telp. / HP</label>
                        <input type="text" class="form-control" id="phone_number" placeholder="Enter Phone Number" wire:model="phone_number">
                        @error('phone_number') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label>Tempat Lahir</label>
                        <input type="text" class="form-control" id="tempat_lahir" placeholder="Enter Place of Birth" wire:model="tempat_lahir">
                        @error('tempat_lahir') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    <div class="form-group col-md-6">
                        <label>Tanggal Lahir</label>
                        <input type="date" class="form-control datepicker" id="tanggal_lahir" placeholder="Enter Date of Birth" wire:model="tanggal_lahir">
                        @error('tanggal_lahir') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Alamat</label>
                    <input type="text" class="form-control" id="address" placeholder="Enter address" wire:model="address">
                    @error('address') <span class="text-danger">{{ $message }}</span> @enderror
                </div> 
                <div class="form-group">
                    <label>Kota/Kabupaten</label>
                    <select class="form-control" wire:model="city">
                        <option value=""> --- Kota/Kabupaten --- </option>
                        @foreach(\App\Models\City::orderBy('code','ASC')->get() as $item)
                        <option value="{{$item->code}}">{{$item->name}}</option>
                        @endforeach
                    </select>
                    @error('city')
                    <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>
                @if($city=='OTHER')
                    <div class="form-group">
                            <input type="text" class="form-control" id="city_lainnya" placeholder="Enter Other City" wire:model="city_lainnya">
                            @error('city_lainnya') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                @endif
                <div class="row">
                    <div class="form-group col-md-6">
                        <label>Jenis Kelamin</label>
                        <select class="form-control" name="jenis_kelamin" wire:model="jenis_kelamin">
                            <option value=""> --- Jenis Kelamin --- </option>
                            @foreach(config('vars.jenis_kelamin') as $i)
                            <option>{{$i}}</option> 
                            @endforeach
                        </select>
                        @error('jenis_kelamin') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    <div class="form-group col-md-6">
                        <label>Golongan Darah</label>
                        <select class="form-control" wire:model="blood_type">
                            <option value=""> --- Select --- </option>
                            @foreach(config('vars.golongan_darah') as $i)
                            <option>{{$i}}</option> 
                            @endforeach
                        </select>
                        @error('blood_type') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="row">
                    
                    <div class="form-group col-md-6">
                        <label>Koordinator Nama</label>
                        <input type="text" class="form-control" wire:model="koordinator_nama">
                        @error('koordinator_nama') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>  
                    <div class="form-group col-md-6">
                        <label>Koordinator NIK</label>
                        <input type="text" class="form-control" wire:model="koordinator_nik">
                        @error('koordinator_nik') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>  
                    <div class="form-group col-md-6">
                        <label>Koordinator HP</label>
                        <input type="text" class="form-control" wire:model="koordinator_hp">
                        @error('koordinator_nama') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>  
                    <div class="form-group col-md-6">
                        <label>Koordinator Alamat</label>
                        <input type="text" class="form-control" wire:model="koordinator_alamat">
                        @error('koordinator_alamat') <span class="text-danger">{{ $message }}</span> @enderror
                    </div> 

                </div>
                <div class="row">
                    <div class="col-md-6">
                        <label>User Rekomendator</label>
                        <input list="rekomendator" type="text" class="form-control" id="user_id_recomendation" name="user_id_recomendation" wire:model="user_id_recomendation">
                        <datalist id="rekomendator">
                            @foreach(App\Models\UserMember::orderBy('id','desc')->get() as $item)
                                @if(hitung_umur($item->tanggal_lahir) < 60)
                                    continue;
                                @else
                                    <option value="{{ $item->no_anggota_platinum }}">{{ $item->name }}</option> 
                                @endif
                            
                            @endforeach
                        </datalist>
                        @error('user_rekomendator') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label><strong>Ganti Foto KTP</strong></label>
                        @if(!empty($data->foto_ktp))
                            <a href="{{ asset('storage/'. $data->foto_ktp) }}" target="_blank"><strong>Lihat Foto KTP</strong></a>
                        @endif
                        <input type="file" class="form-control" id="foto_ktpUpdate" wire:model="foto_ktpUpdate">
                        @error('foto_ktpUpdate') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    <div class="form-group col-md-6">
                        <label><strong>Ganti Pasphoto 4x6</strong></label>
                        @if(!empty($data->pas_foto))
                        <a href="{{ asset('storage/'. $data->pas_foto) }}" target="_blank"><strong>Lihat Pasphoto 4x6</strong></a>
                        @endif
                        <input type="file" class="form-control" id="pas_fotoUpdate" wire:model="pas_fotoUpdate">
                        @error('pas_fotoUpdate') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                </div>
                <div class="row">            
                    <div class="form-group col-md-6">
                        <label><strong>Ganti Foto KK</strong></label>
                        @if(!empty($data->foto_kk))
                        <a href="{{ asset('storage/'. $data->foto_kk) }}" target="_blank"><strong>Lihat Foto KK</strong></a>
                        @endif
                        <input type="file" class="form-control" id="foto_kkUpdate" wire:model="foto_kkUpdate">
                        @error('foto_kkUpdate') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    <div class="form-group col-md-6">
                        @if(!empty($data->file_konfirmasi))
                        <a href="{{ asset('storage/'. $data->file_konfirmasi) }}" target="_blank"><strong>Lihat File Bukti Pembayaran</strong></a>
                        @else
                        <label><strong>File Bukti Pembayaran</strong></label>
                        @endif
                        <input type="file" class="form-control" id="file_konfirmasiUpdate" wire:model="file_konfirmasiUpdate">
                        @error('file_konfirmasiUpdate') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label>{{ __('Payment Date')}}</label>
                        <input type="date" class="form-control" w:model="payment_date" readonly="true"/>
                        @error('payment_date')
                        <span class="text-danger">{{ $message }}</span>
                        @enderror
                    </div> 
                    <div class="form-group col-md-6">
                        <label>{{ __('Tanggal Diterima')}}</label>
                        <input type="date" class="form-control" value="{{$data->tanggal_diterima}}" readonly="true"/>
                    </div> 
                </div>
                
                <div class="form-group">
                    <p class="mb-0">Iuran <strong class="text-danger float-right">{{$iuran_tetap}} x Rp. {{format_idr(get_setting('iuran_tetap'))}} = {{format_idr($iuran_tetap*get_setting('iuran_tetap'))}}</strong></p>
                    <hr class="mt-0" />
                    <p class="mb-0">Uang Pendaftaran - Sukarela <strong class="text-danger float-right">Rp. {{format_idr($uang_pendaftaran)}}</strong></p>           
                    <hr class="mt-0" />
                    <p>Total <strong class="text-danger float-right">Rp. {{format_idr($uang_pendaftaran+($iuran_tetap*get_setting('iuran_tetap')))}}</strong></p>
                </div>
                
<!--
                <div class="form-group text-center">
                    <label>Foto KTP</label><br /> 
                    @if(!empty($data->foto_ktp))
                    <a href="{{ asset('storage/'. $data->foto_ktp) }}" target="_blank">
                        <img src="{{asset('storage/'. $data->foto_ktp)}}" style="width: 50%;" />
                    </a>
                    @endif
                    <input type="file" class="form-control" id="foto_ktpUpdate" wire:model="foto_ktpUpdate">
                    @error('foto_ktpUpdate') <span class="text-danger">{{ $message }}</span> @enderror
                </div>
                <hr />

                <div class="form-group text-center">
                    <label>Pasphoto 4x6</label><br />
                    @if(!empty($data->pas_foto))
                    <a href="{{ asset('storage/'. $data->pas_foto) }}" target="_blank">
                        <img src="{{asset('storage/'. $data->pas_foto)}}" style="width: 50%;" />
                    </a>
                    @endif
                    <input type="file" class="form-control" id="pas_fotoUpdate" wire:model="pas_fotoUpdate">
                    @error('pas_fotoUpdate') <span class="text-danger">{{ $message }}</span> @enderror
                </div>
                <hr />
                <div class="form-group text-center">
                    <label>Foto KK</label><br />
                    @if(!empty($data->foto_kk))
                    <a href="{{ asset('storage/'. $data->foto_kk) }}" target="_blank">
                        <img src="{{asset('storage/'. $data->foto_kk)}}" style="width: 50%;" />
                    </a>
                    @endif
                    <input type="file" class="form-control" id="foto_kkUpdate" wire:model="foto_kkUpdate">
                    @error('foto_kkUpdate') <span class="text-danger">{{ $message }}</span> @enderror
                </div>
-->
            </div>
            <div class="form-group col-md-12">
                <hr />
            </div>
            <div class="col-md-6">
                <h6>DATA AHLI WARIS 1</h6>
                <hr />
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="exampleInputName">Nama (sesuai KTP)</label>
                        <input type="text" class="form-control" id="name_waris1" placeholder="Enter name" wire:model="name_waris1">
                        @error('name_waris1') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    <div class="form-group col-md-6">
                        <label for="exampleInputAlamat">No KTP</label>
                        <input type="text" class="form-control" id="Id_Ktpwaris1" placeholder="Enter ID" wire:model="Id_Ktpwaris1">
                        @error('Id_Ktpwaris1') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                </div>
                <div class="form-group">
                    <label for="exampleInputName">Tempat Lahir</label>
                    <input type="text" class="form-control" id="tempat_lahirwaris1" placeholder="Enter Place of Birth" wire:model="tempat_lahirwaris1">
                    @error('tempat_lahirwaris1') <span class="text-danger">{{ $message }}</span> @enderror
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="exampleInputName">Tanggal Lahir</label>
                        <input type="date" class="form-control datepicker" id="tanggal_lahirwaris1" placeholder="Enter Date of Birth" wire:model="tanggal_lahirwaris1">
                        @error('tanggal_lahirwaris1') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    <div class="form-group col-md-6">
                        <label for="exampleInputAlamat">No Telp. / HP</label>
                        <input type="number" class="form-control" id="phone_numberwaris1" placeholder="Enter Phone Number" wire:model="phone_numberwaris1">
                        @error('phone_numberwaris1') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                </div>
                <div class="form-group">
                    <label for="exampleInputAlamat">Alamat</label>
                    <input type="text" class="form-control" id="address_waris1" placeholder="Enter address" wire:model="address_waris1">
                    @error('address_waris1') <span class="text-danger">{{ $message }}</span> @enderror
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="exampleInputAlamat">Jenis Kelamin</label>
                        <select class="form-control" name="jenis_kelaminwaris1" wire:model="jenis_kelaminwaris1">
                            <option value=""> --- Jenis Kelamin --- </option>
                            @foreach(config('vars.jenis_kelamin') as $i)
                            <option>{{$i}}</option> 
                            @endforeach
                        </select>
                        @error('jenis_kelaminwaris1') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    <div class="form-group col-md-6">
                        <label for="exampleInputAlamat">Golongan Darah</label>
                        <select class="form-control" wire:model="blood_typewaris1">
                            <option value=""> --- Select --- </option>
                            @foreach(config('vars.golongan_darah') as $i)
                            <option>{{$i}}</option> 
                            @endforeach
                        </select>
                        @error('blood_typewaris1') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                </div>
                    <div class="form-group">
                        <label for="exampleInputAlamat">Hubungan dengan Anggota</label>
                        <select class="form-control" wire:model="hubungananggota1">
                            <option value=""> --- Select --- </option>
                            @foreach(config('vars.hubungan_keluarga') as $i)
                            <option>{{$i}}</option> 
                            @endforeach
                        </select>
                        @error('hubungananggota1') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    @if($hubungananggota1=='Lainnya')
                    <div class="form-group">
                            <input type="text" class="form-control" id="hubungananggota1_lainnya" placeholder="Hubungan Anggota" wire:model="hubungananggota1_lainnya">
                            @error('hubungananggota1_lainnya') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    @endif
                    <div class="form-group">
                        @if(!empty($data->foto_ktpwaris1))
                        <a href="{{ asset('storage/'. $data->foto_ktpwaris1) }}" target="_blank"><strong>Lihat Foto KTP</strong></a>
                        @endif
                        <hr>
                        <label for="exampleInputAlamat"><strong>Ganti Foto KTP</strong></label>
                        <input type="file" class="form-control" id="foto_ktpwaris1Update" wire:model="foto_ktpwaris1Update">
                        @error('foto_ktpwaris1Update') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
            </div>
            <div class="col-md-6">
                <h6>DATA AHLI WARIS 2</h6>
                <hr />
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="exampleInputName">Nama (sesuai KTP)</label>
                        <input type="text" class="form-control" id="name_waris2" placeholder="Enter name" wire:model="name_waris2">
                        @error('name_waris2') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    <div class="form-group col-md-6">
                        <label for="exampleInputAlamat">No KTP</label>
                        <input type="text" class="form-control" id="Id_Ktpwaris2" placeholder="Enter ID" wire:model="Id_Ktpwaris2">
                        @error('Id_Ktpwaris2') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                </div>
                <div class="form-group">
                    <label for="exampleInputName">Tempat Lahir</label>
                    <input type="text" class="form-control" id="tempat_lahirwaris2" placeholder="Enter Place of Birth" wire:model="tempat_lahirwaris2">
                    @error('tempat_lahirwaris2') <span class="text-danger">{{ $message }}</span> @enderror
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="exampleInputName">Tanggal Lahir</label>
                        <input type="date" class="form-control datepicker" id="tanggal_lahirwaris2" placeholder="Enter Date of Birth" wire:model="tanggal_lahirwaris2">
                        @error('tanggal_lahirwaris2') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    <div class="form-group col-md--6">
                        <label for="exampleInputAlamat">No Telp. / HP</label>
                        <input type="text" class="form-control" id="phone_numberwaris2" placeholder="Enter Phone Number" wire:model="phone_numberwaris2">
                        @error('phone_numberwaris2') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                </div>
                <div class="form-group">
                    <label for="exampleInputAlamat">Alamat</label>
                    <input type="text" class="form-control" id="address_waris2" placeholder="Enter address" wire:model="address_waris2">
                    @error('address_waris2') <span class="text-danger">{{ $message }}</span> @enderror
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="exampleInputAlamat">Jenis Kelamin</label>
                        <select class="form-control" name="jenis_kelaminwaris2" wire:model="jenis_kelaminwaris2">
                            <option value=""> --- Jenis Kelamin --- </option>
                            @foreach(config('vars.jenis_kelamin') as $i)
                            <option>{{$i}}</option> 
                            @endforeach
                        </select>
                        @error('jenis_kelaminwaris2') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    <div class="form-group col-md-6">
                        <label for="exampleInputAlamat">Golongan Darah</label>
                        <select class="form-control" wire:model="blood_typewaris2">
                            <option value=""> --- Select --- </option>
                            @foreach(config('vars.golongan_darah') as $i)
                            <option>{{$i}}</option> 
                            @endforeach
                        </select>
                        @error('blood_typewaris2') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                </div>
                    <div class="form-group">
                        <label for="exampleInputAlamat">Hubungan dengan Anggota</label>
                        <select class="form-control" wire:model="hubungananggota2">
                            <option value=""> --- Select --- </option>
                            @foreach(config('vars.hubungan_keluarga') as $i)
                            <option>{{$i}}</option> 
                            @endforeach
                        </select>
                        @error('hubungananggota2') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                     @if($hubungananggota2=='Lainnya')
                    <div class="form-group">
                        <input type="text" class="form-control" id="hubungananggota2_lainnya" placeholder="Hubungan Anggota" wire:model="hubungananggota2_lainnya">
                        @error('hubungananggota2_lainnya') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                    @endif
                    <div class="form-group">
                        @if(!empty($data->foto_ktpwaris2))
                        <a href="{{ asset('storage/'. $data->foto_ktpwaris2) }}" target="_blank"><strong>Lihat Foto KTP</strong></a>
                        @endif
                        <hr>
                        <label for="exampleInputAlamat"><strong>Ganti Foto KTP</strong></label>
                        <input type="file" class="form-control" id="foto_ktpwaris2Update" wire:model="foto_ktpwaris2Update">
                        @error('foto_ktpwaris2Update') <span class="text-danger">{{ $message }}</span> @enderror
                    </div>
                <hr />
            </div>
            <div class="form-group col-md-12">
                <hr />
                <a href="/"><i class="fa fa-arrow-left"></i> {{__('Kembali')}}</a>
                @if(\Auth::user()->user_access_id == 1)
                    @if($data->status < 4)
                    <button type="submit" class="btn btn-primary ml-3"><i class="fa fa-save"></i> {{ __('Simpan Perubahan') }}</button>   
                    @endif
                @endif
            </div>
        </div>
    </form>
    </div>
</div>