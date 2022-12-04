<?php

namespace App\Http\Livewire\Pinjaman;

use Livewire\Component;
use App\Models\UserMember;
use App\Models\Pinjaman;
use App\Models\PinjamanItem;

class Insert extends Component
{
    public $user_member_id,$pinjaman,$angsuran,$detail_angsuran,$user_member=[],$angsuran_perbulan,$jasa,$jasa_nominal;
    public $items=[];
    public function render()
    {
        return view('livewire.pinjaman.insert');
    }

    public function mount()
    {
        $this->user_member = UserMember::orderBy('name')->get();
    }

    public function updated($propertyName)
    {
        if($this->pinjaman and $this->angsuran){
            $pembiayaan = $this->pinjaman;
            $this->items = [];
            $this->jasa = round((get_setting('pinjaman_jasa')*2)/24,2);
            
            for($item=0;$item<$this->angsuran;$item++){
                $pembiayaan -= $this->pinjaman / $this->angsuran;
                $this->items[$item]['bulan'] = date('Y-m-d',strtotime("+".($item+1)."month"));
                $this->items[$item]['pembiayaan'] = $pembiayaan;
                $this->items[$item]['angsuran_perbulan'] = $this->pinjaman / $this->angsuran;
                $this->items[$item]['jasa'] = round($this->jasa,2);
                $this->items[$item]['jasa_nominal'] = $this->pinjaman * $this->jasa / 100;
                $this->items[$item]['total'] = $this->items[$item]['jasa_nominal'] + $this->items[$item]['angsuran_perbulan'];
                
                $this->angsuran_perbulan = $this->items[$item]['total'];
                $this->jasa_nominal = $this->items[$item]['jasa_nominal'];
            }
        }
    }

    public function save()
    {
        $this->validate([
            'user_member_id'=>'required',
            'pinjaman'=>'required',
            'angsuran'=>'required'
        ]);

        $data = new Pinjaman();
        $data->no_pengajuan = date('my').$this->user_member_id.str_pad((Pinjaman::count()+1),4, '0', STR_PAD_LEFT);
        $data->user_member_id = $this->user_member_id;
        $data->amount = $this->pinjaman;
        $data->angsuran = $this->angsuran;
        $data->angsuran_perbulan = $this->angsuran_perbulan;
        $data->jasa_persen = $this->jasa;
        $data->jasa = $this->jasa_nominal;
        $data->save();

        foreach($this->items as $k => $val){
            $item = new PinjamanItem();
            $item->pinjaman_id = $data->id;
            $item->bulan = $val['bulan'];
            $item->angsuran_ke = $k+1;
            $item->angsuran_nominal = $val['angsuran_perbulan'];
            $item->jasa = $val['jasa'];
            $item->jasa_nominal = $val['jasa_nominal'];
            $item->tagihan = $val['jasa_nominal'] + $val['angsuran_perbulan'];
            $item->save();
        }

        session()->flash('message-success',__('Pinjaman berhasil diajukan, selanjutnya menunggu proses persetujuan.'));

        return redirect()->route('pinjaman.index');
    }
}
