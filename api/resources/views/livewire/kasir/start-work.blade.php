<form wire:submit.prevent="save">
    <div class="modal-header">
        <h5 class="modal-title text-center" id="exampleModalLabel"><i class="fa fa-clock-o"></i> Start Work Date</h5>
    </div>
    <div class="modal-body">
        <div class="form-group text-center">
            <h5>{{date('l, d M Y')}}</h5>
        </div>
        <div class="form-group">
            <label>Starting Cash</label>
            <input type="text" class="form-control"  />
            @error('file')
                <ul class="parsley-errors-list filled" id="parsley-id-29"><li class="parsley-required">{{ $message }}</li></ul>
            @enderror
        </div>
        <div class="form-group">
            <p>Untuk memulai transaksi silahkan isi Starting Cash dan klik tombol START</p>
        </div>
    </div>
    <div class="modal-footer">
        <button type="submit" class="btn btn-info col-12 btn-lg"><i class="fa fa-check-circle"></i> START</button>
    </div>
    <div wire:loading>
        <div class="page-loader-wrapper" style="display:block">
            <div class="loader" style="display:block">
                <div class="lds-ring"><div></div><div></div><div></div><div></div></div>
                <p>Please wait...</p>
            </div>
        </div>
    </div>
</form>
