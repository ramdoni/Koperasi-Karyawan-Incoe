<?php

namespace App\Http\Livewire;

use Livewire\Component;
use Livewire\WithFileUploads;
use Illuminate\Support\Facades\Storage;

class Setting extends Component
{
    use WithFileUploads;

    public $logoUrl;
    public $logo;
    public $faviconUrl;
    public $favicon;
    public $message;
    public $company;
    public $email;
    public $phone,$mobile;
    public $website,$santunan_pelayanan_in_semarang,$santunan_uang_duka_in_semarang,$santunan_pelayanan_out_semarang,$santunan_uang_duka_out_semarang;
    public $address,$iuran_tetap,$sumbangan,$uang_pendaftaran,$pic_nama,$pic_tempat_lahir,$pic_tanggal_lahir,$pic_nomor_telp,$pic_alamat,$pic_jenis_kelamin,$pic_tanda_tangan;

    public function render()
    {
        return view('livewire.setting')->with(['title'=>'General']);
    }

    public function mount()
    {
        $this->company = get_setting('company');
        $this->email = get_setting('email');
        $this->phone = get_setting('phone');
        $this->mobile = get_setting('mobile');
        $this->website = get_setting('website');
        $this->address = get_setting('address');
        $this->logoUrl = get_setting('logo');
        $this->faviconUrl = get_setting('favicon');
        $this->iuran_tetap = get_setting('iuran_tetap');
        $this->sumbangan = get_setting('sumbangan');
        $this->uang_pendaftaran = get_setting('uang_pendaftaran');
        $this->pic_nama = get_setting('pic_nama');
        $this->pic_tempat_lahir = get_setting('pic_tempat_lahir');
        $this->pic_tanggal_lahir = get_setting('pic_tanggal_lahir');
        $this->pic_nomor_telp = get_setting('pic_nomor_telp');
        $this->pic_alamat = get_setting('pic_alamat');
        $this->pic_jenis_kelamin = get_setting('pic_jenis_kelamin');
        $this->santunan_pelayanan_in_semarang = get_setting('santunan_pelayanan_in_semarang');
        $this->santunan_uang_duka_in_semarang = get_setting('santunan_uang_duka_in_semarang');
        $this->santunan_pelayanan_out_semarang = get_setting('santunan_pelayanan_out_semarang');
        $this->santunan_uang_duka_out_semarang = get_setting('santunan_uang_duka_out_semarang');
        $this->pic_tanda_tangan = asset(get_setting('pic_tanda_tangan'));
    }

    public function updateBasic()
    {
        update_setting('company',$this->company);
        update_setting('email',$this->email);
        update_setting('phone',$this->phone);
        update_setting('mobile',$this->mobile);
        update_setting('website',$this->website);
        update_setting('address',$this->address);
        update_setting('iuran_tetap',$this->iuran_tetap);
        update_setting('sumbangan',$this->sumbangan);
        update_setting('uang_pendaftaran',$this->uang_pendaftaran);
        update_setting('pic_nama',$this->pic_nama);
        update_setting('pic_tempat_lahir',$this->pic_tempat_lahir);
        update_setting('pic_tanggal_lahir',$this->pic_tanggal_lahir);
        update_setting('pic_nomor_telp',$this->pic_nomor_telp);
        update_setting('pic_alamat',$this->pic_alamat);
        update_setting('pic_jenis_kelamin',$this->pic_jenis_kelamin);
        update_setting('santunan_pelayanan_in_semarang',$this->santunan_pelayanan_in_semarang);
        update_setting('santunan_uang_duka_in_semarang',$this->santunan_uang_duka_in_semarang);
        update_setting('santunan_pelayanan_out_semarang',$this->santunan_pelayanan_out_semarang);
        update_setting('santunan_uang_duka_out_semarang',$this->santunan_uang_duka_out_semarang);

        if($this->pic_tanda_tangan!=""){
            $this->validate([
                'pic_tanda_tangan' => 'image:max:1024', // 1Mb Max
            ]);
            $name = 'pic_tanda_tangan.'.$this->pic_tanda_tangan->extension();
            $this->pic_tanda_tangan->storePubliclyAs('public',$name);
    
            update_setting('pic_tanda_tangan',"storage/$name");
        }
    }

    public function save()
    {
        if($this->logo!=""){
            $this->validate([
                'logo' => 'image:max:1024', // 1Mb Max
            ]);
            $name = 'logo'.date('Ymdhis').'.'.$this->logo->extension();
            $this->logo->storePubliclyAs('public',$name);
    
            update_setting('logo',$name);
        }

        if($this->favicon!=""){
            $this->validate([
                'favicon' => 'image:max:1024', // 1Mb Max
            ]);
            $name = 'favicon'.date('YmdHis').'.'.$this->favicon->extension();
            $this->favicon->storePubliclyAs('public',$name);

            update_setting('favicon',$name);
        }
        session()->flash('message-success',__('Data saved successfully'));

        return redirect()->to('setting');
    }
}