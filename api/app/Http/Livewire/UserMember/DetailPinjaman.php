<?php

namespace App\Http\Livewire\UserMember;

use Livewire\Component;
use App\Models\JenisPinjaman;
use App\Models\Pinjaman;
use App\Models\UserMember;

class DetailPinjaman extends Component
{
    public $jenis_pinjaman,$member;
    protected $listeners = ['reload'=>'$refresh'];
    public function render()
    {
        $data = Pinjaman::with(['jenis_pinjaman'])->where(['user_member_id'=>$this->member->id]);

        return view('livewire.user-member.detail-pinjaman')->with(['data'=>$data->paginate(100)]);
    }

    public function mount(UserMember $data)
    {
        $this->member = $data;
        $this->jenis_pinjaman = JenisPinjaman::get();
    }
}
