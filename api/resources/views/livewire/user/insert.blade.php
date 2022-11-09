@section('title', __('Insert'))
@section('parentPageTitle', 'Users')

<div class="row clearfix">
    <div class="col-md-6">
        <div class="card">
            <div class="body">
                <form id="basic-form" method="post" wire:submit.prevent="save">
                    <div class="form-group">
                        <label>{{ __('NIK') }}</label>
                        <input type="text" class="form-control" wire:model="nik" >
                        @error('nik')
                        <ul class="parsley-errors-list filled" id="parsley-id-29"><li class="parsley-required">{{ $message }}</li></ul>
                        @enderror
                    </div>
                    <div class="form-group">
                        <label>{{ __('Name') }}</label>
                        <input type="text" class="form-control" wire:model="name" >
                        @error('name')
                        <ul class="parsley-errors-list filled" id="parsley-id-29"><li class="parsley-required">{{ $message }}</li></ul>
                        @enderror
                    </div>
                    <div class="form-group">
                        <label>{{ __('Email') }}</label>
                        <input type="text" class="form-control"  wire:model="email" >
                        @error('email')
                        <ul class="parsley-errors-list filled" id="parsley-id-29"><li class="parsley-required">{{ $message }}</li></ul>
                        @enderror
                    </div>
                    <div class="form-group">
                        <label>{{ __('Telepon') }}</label>
                        <input type="text" class="form-control"  wire:model="telepon" >
                        @error('telepon')
                        <ul class="parsley-errors-list filled" id="parsley-id-29"><li class="parsley-required">{{ $message }}</li></ul>
                        @enderror
                    </div>
                    <div class="form-group">
                        <label>{{ __('Address') }}</label>
                        <textarea class="form-control" wire:model="address"></textarea>
                        @error('address')
                        <ul class="parsley-errors-list filled" id="parsley-id-29"><li class="parsley-required">{{ $message }}</li></ul>
                        @enderror
                    </div>
                    <div class="form-group">
                        <label>{{ __('User Access') }}</label>
                        <select class="form-control" wire:model="user_access_id" name="user_access_id" id="user_access_id">
                            <option value="">{{__('--- User Access --- ')}} </option>
                            @foreach($access as $item)
                            <option value="{{$item->id}}">{{$item->name}}</option>
                            @endforeach
                        </select>
                        @error('user_access_id')
                        <ul class="parsley-errors-list filled" id="parsley-id-29"><li class="parsley-required">{{ $message }}</li></ul>
                        @enderror
                    </div>
                    <div class="form-group" >
                        <label>{{ __('Password') }}</label>
                        <input type="password" class="form-control"  wire:model="password" >
                        @error('password')
                        <ul class="parsley-errors-list filled" id="parsley-id-29"><li class="parsley-required">{{ $message }}</li></ul>
                        @enderror
                    </div>
                    @if($user_access_id==3)
                    <div class="form-group" name="barcodeDiv" id="referalCodeDiv">
                        <label>{{ __('Referal Code') }}</label>
                        <input type="text" class="form-control"  wire:model="referal_code">
                        @error('referal_code')
                        <ul class="parsley-errors-list filled" id="parsley-id-29"><li class="parsley-required">{{ $message }}</li></ul>
                        @enderror
                    </div>
                    <div class="form-group" name="urlDiv" id="urlDiv">
                        <label>{{ __('URL') }}</label>
                        <input type="text" class="form-control"  wire:model="url" readonly="true">
                        @error('url')
                        <ul class="parsley-errors-list filled" id="parsley-id-29"><li class="parsley-required">{{ $message }}</li></ul>
                        @enderror
                    </div>
                    @endif
                    
                    <hr>
                    <a href="{{route('users.index')}}"><i class="fa fa-arrow-left"></i> {{ __('Back') }}</a>
                    <button type="submit" class="btn btn-primary ml-3"><i class="fa fa-save"></i> {{ __('Save') }}</button>
                </form>
            </div>
        </div>
    </div>
</div>