<?php

namespace App\Http\Livewire\UserMember;

use Livewire\Component;
use App\Models\JenisSimpanan;
use App\Models\Simpanan;
use App\Models\UserMember;
use App\Models\Transaksi;
use Illuminate\Support\Facades\Http;

class AddSimpanan extends Component
{
    public $jenis_simpanan,$jenis_simpanan_id,$amount,$member,$tahun,$bulan,$description,$payment_date;
    public function render()
    {
        return view('livewire.user-member.add-simpanan');
    }

    public function mount(UserMember $data)
    {
        $this->member = $data;
        $this->jenis_simpanan = JenisSimpanan::get();
    }

    public function save()
    {
        $this->validate([
            'jenis_simpanan_id'=>'required',
            'amount'=>'required',
            'tahun'=>'required',
            'bulan'=>'required'
        ]);

        $data = new Simpanan();
        $data->no_transaksi = $this->jenis_simpanan_id.date('my').str_pad((Simpanan::count()+1),4, '0', STR_PAD_LEFT);
        $data->description = $this->description;
        $data->jenis_simpanan_id = $this->jenis_simpanan_id;
        $data->amount = $this->amount;
        $data->user_member_id = $this->member->id;
        $data->status = $this->payment_date ? 1 : 0;
        if($this->payment_date) $data->payment_date = $this->payment_date;
        $data->tahun = $this->tahun;
        $data->bulan = $this->bulan;
        $data->status = 1;
        $data->save();

        $transaksi = new Transaksi();
        $transaksi->no_transaksi = "S".date('my').$this->member->id.str_pad((Transaksi::count()+1),4, '0', STR_PAD_LEFT);
        $transaksi->user_member_id = $this->member->id;
        $transaksi->user_id = \Auth::user()->id;
        $transaksi->amount = $this->amount;
        $transaksi->name = isset($data->jenis_simpanan->name) ? $data->jenis_simpanan->name :'-';
        $transaksi->status = 1;
        $transaksi->save();

        // Sinkron Coopzone
        $response = sinkronCoopzone([
            'url'=>'koperasi/simpanan/store',
            'no_transaksi'=>$transaksi->no_transaksi,
            'no_anggota'=>$data->anggota->no_anggota_platinum,
            'jenis_simpanan_id'=>$data->jenis_simpanan_id,
            'payment_date'=>$this->payment_date,
            'amount'=>$this->amount,
            'tahun'=>$this->tahun,
            'bulan'=>$this->bulan,
            'description'=>$this->description
        ]);
        
        session()->flash('message-success',"Simpanan berhasil ditambahkan");

        return redirect()->route('user-member.edit',$this->member->id);
    }
}
