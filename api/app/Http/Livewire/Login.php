<?php

namespace App\Http\Livewire;

use Livewire\Component;
use Illuminate\Support\Facades\Auth;
use App\Models\UserPlatinum;
use Illuminate\Support\Str;

class Login extends Component
{
    public $email;
    public $password,$remember_me=false;
    public $message,$type_login=1;
    public function render()
    {
        return view('livewire.login')
                ->layout('layouts.auth');
    }

    public function login()
    {
        $this->validate([
                'email' => 'required',
                'password' => 'required',
            ],
            [
                'email.required'=>'No Anggota is required'
            ]
        );

        if(is_numeric($this->email)){ 
            $credentials = ['username'=>$this->email,'password'=>$this->password]; // Login with NIK
        }else{
            $credentials = ['email'=>$this->email,'password'=>$this->password];
        }

        if($this->type_login==1){
            // dd(\Hash::make($this->password));
            // dd($credentials);
            if (Auth::attempt($credentials,$this->remember_me)) {
                // Authentication passed...
                return redirect('/user-member');
            }else $this->message = __('Email / Password incorrect please try again');
        }else{
            if(is_numeric($this->email))
                $user = UserPlatinum::where('nik',$this->email)->first();
            else
                $user = UserPlatinum::where('email',$this->email)->first();
            
            if (isset($user->name) and \Hash::check($this->password, $user->password)){
                $tokenLogin = base64_encode(\Str::random(40));

                $user->token_login = $tokenLogin;
                $user->save();

                return redirect(env('PLATINUM_URL')."/login-with-token/{$tokenLogin}");

            }else $this->message = __('Email / Password incorrect please try again');
        }
            
    }
}
