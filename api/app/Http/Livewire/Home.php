<?php

namespace App\Http\Livewire;

use Livewire\Component;

class Home extends Component
{
    public function render()
    {
        if(\Auth::user()->user_access_id==3) $this->redirect('koordinator/member'); // koordinator
        if(\Auth::user()->user_access_id==2) $this->redirect('ketua-yayasan'); // ketua yayasan
        if(\Auth::user()->user_access_id==4) $this->redirect('anggota/member'); // anggota
        return view('livewire.home');
    }
}