@section('title', 'Setting')
@section('parentPageTitle', 'Dashboard')

<div class="row clearfix">
    <div class="col-lg-12">
        <div class="card">
            <div class="body">
                <form wire:submit.prevent="save">
                    <div class="row">
                        <div class="col-md-3">
                            <h6>Logo</h6>
                            <div class="media photo">
                                <div class="media-left m-r-15">
                                    @if($logoUrl)
                                    <img src="{{$logoUrl}}" class="user-photo media-object" style="height:50px;" alt="User">
                                    @endif
                                </div>
                                <div class="media-body">
                                    @error('logo')
                                    <p class="text-danger">{{$message}}</p>
                                    @enderror
                                    <p>Upload your logo.
                                        <br> <em>Image should be at least 140px x 140px</em></p>
                                    <button type="button" class="btn btn-default-dark" id="btn-upload-photo"><i class="fa fa-upload"></i> Select File</button>
                                    <input type="file" wire:model="logo" id="filePhoto" class="sr-only">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <h6>Favicon</h6>
                            <div class="media photo">
                                <div class="media-left m-r-15">
                                    @if($faviconUrl)
                                    <img src="{{$faviconUrl}}" class="user-photo media-object" style="height:50px;" alt="User">
                                    @endif
                                </div>
                                <div class="media-body">
                                    @error('favicon')
                                    <p class="text-danger">{{$message}}</p>
                                    @enderror
                                    <p>Upload your Favicon.
                                        <br> <em>Image should be at least 16px x 16px</em></p>
                                    <button type="button" class="btn btn-default-dark" id="btn-upload-favicon"><i class="fa fa-upload"></i> Select File</button>
                                    <input type="file" wire:model="favicon" id="fileFavicon" class="sr-only">
                                </div>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Simpan Perubahan</button>
                </form>
            </div>
            <form  wire:submit.prevent="updateBasic">
                <div class="body">
                    <h6>Basic Information</h6>
                    <hr />
                    <div class="row clearfix mb-4">
                        <div class="col-lg-6 col-md-12">
                            <div class="form-group">              
                                <label>Company</label>                                  
                                <input type="text" class="form-control" placeholder="Company" wire:model="company">
                            </div>
                            <div class="form-group">                                                
                                <input type="text" class="form-control" placeholder="Phone" wire:model="phone">
                            </div>
                            <div class="form-group">                                                
                                <input type="text" class="form-control" placeholder="Mobile" wire:model="mobile">
                            </div>
                            <div class="form-group">                                                
                                <input type="text" class="form-control" placeholder="Email" wire:model="email">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="http://" wire:model="website">
                            </div>
                            <div class="form-group">    
                                <textarea class="form-control" wire:model="address" style="height:80px;" placeholder="Address"></textarea>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-12">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label>Iuran</label>                                                
                                    <input type="text" class="form-control" wire:model="iuran_tetap" />
                                </div>
                                <!-- <div class="form-group col-md-6">
                                    <label>Sumbangan</label>                                                
                                    <input type="text" class="form-control" wire:model="sumbangan" />
                                </div> -->
                                <div class="form-group col-md-6">
                                    <label>Uang Pendaftaran</label>                                                
                                    <input type="text" class="form-control" wire:model="uang_pendaftaran" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <h6>PIC Information</h6>
                    <hr />
                    <div class="row mb-4 clearfix">
                        <div class="col-lg-6 col-md-12">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label>Nama</label>                                                
                                    <input type="text" class="form-control" wire:model="pic_nama" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label>Tempat Lahir</label>                                                
                                    <input type="text" class="form-control" wire:model="pic_tempat_lahir" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label>Tanggal Lahir ({{hitung_umur($pic_tanggal_lahir)}} tahun)</label>                                                
                                    <input type="date" class="form-control" wire:model="pic_tanggal_lahir" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label>Nomor Telp</label>                                                
                                    <input type="text" class="form-control" wire:model="pic_nomor_telp" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="fancy-group col-md-6">
                                    <label>Jenis Kelamin</label><br />
                                    <label class="fancy-radio"><input type="radio" value="Pria" wire:model="pic_jenis_kelamin" />
                                        <span><i></i>Pria</span>
                                    </label>
                                    <label class="fancy-radio">
                                        <input type="radio" value="Wanita" wire:model="pic_jenis_kelamin" />
                                        <span><i></i>Wanita</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Alamat</label>
                                <textarea class="form-control" wire:model="pic_alamat" style="height:80px;"></textarea>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label>Tanda Tangan</label>
                            <div class="media photo">
                                <div class="media-left m-r-15">
                                    @if($pic_tanda_tangan)
                                    <img src="{{$pic_tanda_tangan}}" class="user-photo media-object" style="height:50px;" alt="User">
                                    @endif
                                </div>
                                <div class="media-body">
                                    @error('pic_tanda_tangan')
                                    <p class="text-danger">{{$message}}</p>
                                    @enderror
                                    <input type="file" wire:model="pic_tanda_tangan">
                                </div>
                            </div>
                        </div>
                    </div>
                    <h6>Klaim Information</h6>
                    <hr />
                    <div class="row clearfix mb-4">
                        <div class="col-lg-6 col-md-12">
                            <div class="alert alert-warning" role="alert">Untuk Anggota yang berdomisili di kota Semarang</div>
                            <div class="row">
                                <div class="form-group col-md-6">              
                                    <label>Santunan Pelayanan</label>                                  
                                    <input type="text" class="form-control" wire:model="santunan_pelayanan_in_semarang">
                                </div>
                                <div class="form-group col-md-6">              
                                    <label>Santunan Uang Duka</label>                                  
                                    <input type="text" class="form-control" wire:model="santunan_uang_duka_in_semarang">
                                </div>
                            </div>
                            <hr />
                            <div class="alert alert-warning" role="alert">Untuk Anggota yang berdomisili di Kab Semarang, Kota Salatiga, Kab Kendal, Kab Purwodadi</div>
                            <div class="row">
                                <div class="form-group col-md-6">              
                                    <label>Santunan Pelayanan</label>                                  
                                    <input type="text" class="form-control" wire:model="santunan_pelayanan_out_semarang">
                                </div>
                                <div class="form-group col-md-6">              
                                    <label>Santunan Uang Duka</label>                                  
                                    <input type="text" class="form-control" wire:model="santunan_uang_duka_out_semarang">
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    <hr />
                    <button type="submit" class="btn btn-primary">Simpan Perubahan</button>
                </div>
            </form>
                
        </div>
    </div>
</div>
@section('page-script')
    $(function() {
        // favicon upload
        $('#btn-upload-favicon').on('click', function() {
            $(this).siblings('#fileFavicon').trigger('click');
        });

        // photo upload
        $('#btn-upload-photo').on('click', function() {
            $(this).siblings('#filePhoto').trigger('click');
        });

        // plans
        $('.btn-choose-plan').on('click', function() {
            $('.plan').removeClass('selected-plan');
            $('.plan-title span').find('i').remove();

            $(this).parent().addClass('selected-plan');
            $(this).parent().find('.plan-title').append('<span><i class="fa fa-check-circle"></i></span>');
        });
    });

@stop
