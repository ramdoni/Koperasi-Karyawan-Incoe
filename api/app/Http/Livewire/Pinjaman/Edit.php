<?php

namespace App\Http\Livewire\Pinjaman;

use Livewire\Component;
use App\Models\Pinjaman;
use App\Models\PinjamanItem;

class Edit extends Component
{
    public $data;
    protected $listeners = ['reload'=>'$refresh'];
    public function render()
    {
        return view('livewire.pinjaman.edit');
    }

    public function mount(Pinjaman $data)
    {
        $this->data = $data;
    }

    public function lunas($id)
    {
        PinjamanItem::find($id)->update(['status'=>1]);

        $this->emit('reload');
    }
}
