<?php

namespace App\Http\Livewire\JenisSimpanan;

use Livewire\Component;
use App\Models\JenisSimpanan;
use Livewire\WithPagination;

class Index extends Component
{
    use WithPagination;
    protected $paginationTheme = 'bootstrap';
    public $insert=false,$name;
    public function render()
    {
        $data = JenisSimpanan::orderBy('id','DESC');

        return view('livewire.jenis-simpanan.index')->with(['data'=>$data->paginate(100)]);
    }

    public function save()
    {
        $this->validate([
            'name'=>'required'
        ]);

        $data = new JenisSimpanan();
        $data->name = $this->name;
        $data->save();

        $this->insert = false;
        $this->reset(['name']);
    }
}
