<?php

namespace App\Http\Livewire\Kasir;

use Livewire\Component;
use Livewire\WithPagination;

class Index extends Component
{
    use WithPagination;
    public $keyword,$user_member_id,$koordinator_id;
    protected $paginationTheme = 'bootstrap';
    public function render()
    {
        $data = \App\Models\Iuran::orderBy('id','DESC');
        if($this->user_member_id) $data = $data->where('iuran.user_member_id',$this->user_member_id);
        
        return view('livewire.kasir.index')->with(['data'=>$data->paginate(50)]);
    }
}