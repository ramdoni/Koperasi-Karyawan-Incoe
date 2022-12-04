<?php

namespace App\Http\Livewire;

use Livewire\Component;

class Home extends Component
{
    public function render()
    { 
        $this->redirect('user-member'); // anggota
        
        return view('livewire.home');
    }
}