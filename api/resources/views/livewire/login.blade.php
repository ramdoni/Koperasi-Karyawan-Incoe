@section('title', 'Login')
<div class="vertical-align-wrap">
	<div class="vertical-align-middle auth-main">
		<div class="auth-box">

            <div class="top text-center d-block d-sm-none d-none d-sm-block d-md-none"> 
                <img src="{{get_setting('logo')}}" alt="{{get_setting('company')}}">
            </div>
			<div class="card">
                <div class="header">
                    <p class="lead">{{__('Login to your account')}}</p>
                </div>
                <div class="body">
                    <form class="form-auth-small" method="POST" wire:submit.prevent="login" action="">
                        <div class="form-group">
                            <label><input type="radio" wire:model="type_login" value="1" /> Sapphire </label>
                            <label><input type="radio" wire:model="type_login" value="2" /> Platinum</label>
                        </div>
                        @if($message)
                       <p class="text-danger">{{$message}}</p>
                        @endif
                        @if($type_login==1)
                            <div class="form-group">
                                <label for="signin-email" class="sr-only control-label">{{ __('Email') }}</label>
                                <input type="text" class="form-control" id="signin-email" wire:model="email" placeholder="{{ __('NIK / No Anggota') }}">
                                @error('email')
                                <p class="text-danger">{{ $message }}</p>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label for="signin-password" class="sr-only control-label">{{ __('Password') }}</label>
                                <input type="password" class="form-control" id="signin-password" wire:model="password" placeholder="{{ __('Password') }}">
                                @error('password')
                                    <p class="text-danger">{{ $message }}</p>
                                @enderror
                            </div>
                            <div class="clearfix form-group">
                                <label class="fancy-checkbox element-left">
                                    <input type="checkbox" wire:model="remember_me">
                                    <span>{{__('Remember me')}}</span>
                                </label>								
                            </div>
                            <button type="submit" class="btn btn-primary btn-lg btn-block mt-1"><i class="fa fa-sign-in mr-2"></i>{{ __('LOGIN') }}</button>
                            <a href="register" class="btn btn-info btn-lg btn-block mt-1"><i class="fa fa-edit mr-2"></i>{{ __('DAFTAR') }}</a>
                            <div class="bottom">
                                <span class="helper-text m-b-10"><i class="fa fa-money"></i> <a href="konfirmasi-pendaftaran">{{ __('Konfirmasi Pembayaran') }}</a></span>
                            </div> 
                        @else
                            <div class="form-group">
                                <label for="signin-email" class="sr-only control-label">{{ __('Email') }}</label>
                                <input type="text" class="form-control" id="signin-email" wire:model="email" placeholder="{{ __('NIK / No Anggota') }}">
                                @error('email')
                                <p class="text-danger">{{ $message }}</p>
                                @enderror
                            </div>
                            <div class="form-group">
                                <label for="signin-password" class="sr-only control-label">{{ __('Password') }}</label>
                                <input type="password" class="form-control" id="signin-password" wire:model="password" placeholder="{{ __('Password') }}">
                                @error('password')
                                    <p class="text-danger">{{ $message }}</p>
                                @enderror
                            </div>
                            <div class="clearfix form-group">
                                <label class="fancy-checkbox element-left">
                                    <input type="checkbox" wire:model="remember_me">
                                    <span>{{__('Remember me')}}</span>
                                </label>								
                            </div>
                            <button type="submit" class="btn btn-primary btn-lg btn-block mt-1"><i class="fa fa-sign-in mr-2"></i>{{ __('LOGIN') }}</button>
                        @endif
                    </form>
                </div>
            </div>
		</div>
        <div class="col-md-12" style="position: absolute;bottom:0;">
            <p>Address : {{get_setting('address')}} | Phone : {{get_setting('phone')}} | Mobile : {{get_setting('mobile')}}</p>
        </div>

	</div>
    
</div>