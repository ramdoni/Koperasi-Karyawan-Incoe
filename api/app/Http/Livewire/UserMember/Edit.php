<?php

namespace App\Http\Livewire\UserMember;

use App\Models\UserAccess;
use Livewire\Component;
use Livewire\WithFileUploads;
use App\Models\UserMember;
use App\Models\Iuran;

class Edit extends Component
{
    use WithFileUploads;
    public $data;
    public $name;
    public $name_kta;
    public $email;
    public $tempat_lahir;
    public $tanggal_lahir;
    public $region;
    public $address;
    public $city;
    public $Id_Ktp;
    public $jenis_kelamin;
    public $phone_number;
    public $blood_type;
    public $foto_ktp;
    public $foto_kk;
    public $pas_foto;
    public $name_waris1;
    public $tempat_lahirwaris1;
    public $tanggal_lahirwaris1;
    public $address_waris1;
    public $Id_Ktpwaris1;
    public $jenis_kelaminwaris1;
    public $phone_numberwaris1;
    public $blood_typewaris1;
    public $hubungananggota1;
    public $foto_ktpwaris1;
    public $name_waris2;
    public $tempat_lahirwaris2;
    public $tanggal_lahirwaris2;
    public $address_waris2;
    public $Id_Ktpwaris2;
    public $jenis_kelaminwaris2;
    public $phone_numberwaris2;
    public $blood_typewaris2;
    public $hubungananggota2;
    public $foto_ktpwaris2;
    public $namektp;
    public $namekk;
    public $namepasfoto;
    public $namefotoktpwaris1;
    public $namefotoktpwaris2;
    public $is_approve,$is_success=false;
    public $messageWa,$agama,$umur,$form_no,$bank_account_id,$iuran_tetap,$sumbangan,$uang_pendaftaran;
    public $total_iuran_tetap=0,$total_sumbangan=0,$total_uang_pendaftaran=0,$total=0,$messageKtp=0;
    public $koordinator_id, $payment_date, $file_konfirmasi;
    public $referal_code;
    public $status, $user_id_recomendation,$user_id;
    public $foto_ktpUpdate;
    public $foto_kkUpdate;
    public $pas_fotoUpdate;
    public $foto_ktpwaris1Update;
    public $foto_ktpwaris2Update;
    public $file_konfirmasiUpdate;
    public $city_lainnya, $hubungananggota1_lainnya, $hubungananggota2_lainnya;
    public $koordinator_nama,$koordinator_nik,$koordinator_hp,$koordinator_alamat;

    protected $rules = [
        'name' => 'required|string',
        'name_kta' => 'required|string',
        'koordinator_name' => 'required',
        'koordinator_nik' => 'required',
        'koordinator_hp' => 'required',
        'koordinator_alamat' => 'required',
        //'email' => 'required|string',
    ];

    public function render()
    {
        return view('livewire.user-member.edit')
                        ->with([
                            'access' => UserAccess::all(),
                            'data' => $this->data
                        ]);
    }

    public function mount($id)
    {
        $this->data = UserMember::find($id);
        $this->form_no = $this->data->no_form;
        $this->name = $this->data->name;
        $this->name_kta = $this->data->name_kta;
        $this->email = $this->data->email;
        $this->tempat_lahir = $this->data->tempat_lahir;
        $this->tanggal_lahir = $this->data->tanggal_lahir;
        $this->region = $this->data->region;
        $this->address = $this->data->address;
        $this->city = $this->data->city;
        $this->city_lainnya= $this->data->city_lainnya;
        $this->koordinator_id= $this->data->koordinator_id;
        $this->Id_Ktp = $this->data->Id_Ktp;
        $this->jenis_kelamin = $this->data->jenis_kelamin;
        $this->phone_number = $this->data->phone_number;
        $this->blood_type = $this->data->blood_type;
        $this->foto_ktp = $this->data->foto_ktp;
        $this->foto_kk = $this->data->foto_kk;
        $this->pas_foto = $this->data->pas_foto;
        $this->name_waris1 = $this->data->name_waris1;
        $this->tempat_lahirwaris1 = $this->data->tempat_lahirwaris1;
        $this->tanggal_lahirwaris1 = $this->data->tanggal_lahirwaris1;
        $this->address_waris1 = $this->data->address_waris1;
        $this->Id_Ktpwaris1 = $this->data->Id_Ktpwaris1;
        $this->jenis_kelaminwaris1 = $this->data->jenis_kelaminwaris1;
        $this->phone_numberwaris1 = $this->data->phone_numberwaris1;
        $this->blood_typewaris1 = $this->data->blood_typewaris1;
        $this->hubungananggota1 = $this->data->hubungananggota1;
        $this->hubungananggota1_lainnya= $this->data->hubungananggota1_lainnya;
        $this->foto_ktpwaris1 = $this->data->foto_ktpwaris1;
        $this->name_waris2 = $this->data->name_waris2;
        $this->tempat_lahirwaris2 = $this->data->tempat_lahirwaris2;
        $this->tanggal_lahirwaris2 = $this->data->tanggal_lahirwaris2;
        $this->address_waris2 = $this->data->address_waris2;
        $this->Id_Ktpwaris2 = $this->data->Id_Ktpwaris2;
        $this->jenis_kelaminwaris2 = $this->data->jenis_kelaminwaris2;
        $this->phone_numberwaris2 = $this->data->phone_numberwaris2;
        $this->blood_typewaris2 = $this->data->blood_typewaris2;
        $this->hubungananggota2 = $this->data->hubungananggota2;
        $this->hubungananggota2_lainnya= $this->data->hubungananggota2_lainnya;
        $this->foto_ktpwaris2 = $this->data->foto_ktpwaris2;
        $this->is_approve = $this->data->is_approve;
        $this->iuran_tetap = $this->data->iuran_tetap;
        $this->sumbangan = $this->data->sumbangan;
        $this->total_iuran_tetap= $this->data->total_iuran_tetap;
        $this->total_sumbangan= $this->data->total_sumbangan; 
        $this->total = $this->data->total_pembayaran;
        $this->uang_pendaftaran = $this->data->uang_pendaftaran;
        $this->koordinator_nama = $this->data->koordinator_nama;
		$this->koordinator_nik = $this->data->koordinator_nik;
		$this->koordinator_hp = $this->data->koordinator_hp;
		$this->koordinator_alamat = $this->data->koordinator_alamat;
        
        $payment_date = Iuran::where(['iuran_pertama'=>1,'user_member_id'=>$this->data->id])->first();
        if($payment_date) $this->payment_date = $payment_date->payment_date; 

        $this->file_konfirmasi = $this->data->file_konfirmasi;
        $this->user_id = $this->data->user_id;
        $this->region = $this->data->region;

        $user_recomendation = UserMember::find($this->user_id_recomendation);
		if($user_recomendation) $this->user_id_recomendation = $user_recomendation->no_anggota_platinum;
    }

    public function save()
    {
        $this->validate();
        
        $this->data->no_form = $this->form_no;
        $this->data->Id_Ktp = $this->Id_Ktp;
        $this->data->name = $this->name;
        $this->data->name_kta = $this->name_kta;
        $this->data->email = $this->email;
        $this->data->tempat_lahir = $this->tempat_lahir;
        $this->data->tanggal_lahir = $this->tanggal_lahir;
        $this->data->address = $this->address;
        $this->data->city = $this->city;
        $this->data->city_lainnya = $this->city_lainnya;
        $this->data->koordinator_id = $this->koordinator_id;
        $this->data->jenis_kelamin = $this->jenis_kelamin;
        $this->data->phone_number = $this->phone_number;
        $this->data->blood_type = $this->blood_type;

        $user_recomendation = UserMember::where('no_anggota_platinum',$this->user_id_recomendation)->first();
		if($user_recomendation) $this->data->user_id_recomendation = $user_recomendation->id;

        if($this->foto_ktpUpdate!=""){
            $this->validate([
                'foto_ktpUpdate' => 'image:max:1024', // 1Mb Max
            ]);
            $namektp = 'foto_ktp'.date('Ymdhis').'.'.$this->foto_ktpUpdate->extension();
            $this->foto_ktpUpdate->storePubliclyAs('public',$namektp);
            $this->data->foto_ktp = $namektp;
        }

        if($this->foto_kkUpdate!=""){
            $this->validate([
                'foto_kkUpdate' => 'image:max:1024', // 1Mb Max
            ]);
            $namekk = 'foto_kk'.date('Ymdhis').'.'.$this->foto_kkUpdate->extension();
            $this->foto_kkUpdate->storePubliclyAs('public',$namekk);
            $this->data->foto_kk = $namekk;
        }
        if($this->pas_fotoUpdate!=""){
            $this->validate([
                'pas_fotoUpdate' => 'image:max:1024', // 1Mb Max
            ]);
            $namepasfoto = 'pas_foto'.date('Ymdhis').'.'.$this->pas_fotoUpdate->extension();
            $this->pas_fotoUpdate->storePubliclyAs('public',$namepasfoto);
            $this->data->pas_foto = $namepasfoto;
        }
        if($this->file_konfirmasiUpdate!=""){
            $this->validate([
                'file_konfirmasiUpdate' => 'image:max:1024', // 1Mb Max
            ]);
            $namekonfirmasi = 'file_konfirmasi'.date('Ymdhis').'.'.$this->file_konfirmasiUpdate->extension();
            $this->file_konfirmasiUpdate->storePubliclyAs('public',$namekonfirmasi);
            $this->data->file_konfirmasi = $namekonfirmasi;
        }
        
        $this->data->name_waris1 = $this->name_waris1;
        $this->data->Id_Ktpwaris1 = $this->Id_Ktpwaris1;
        $this->data->tempat_lahirwaris1 = $this->tempat_lahirwaris1;
        $this->data->tanggal_lahirwaris1 = $this->tanggal_lahirwaris1;
        $this->data->phone_numberwaris1 = $this->phone_numberwaris1;
        $this->data->address_waris1 = $this->address_waris1;
        $this->data->jenis_kelaminwaris1 = $this->jenis_kelaminwaris1;
        $this->data->blood_typewaris1 = $this->blood_typewaris1;
        $this->data->hubungananggota1 = $this->hubungananggota1;
        $this->data->hubungananggota1_lainnya = $this->hubungananggota1_lainnya;

        if($this->foto_ktpwaris1Update!=""){
            $this->validate([
                'foto_ktpwaris1Update' => 'image:max:1024', // 1Mb Max
            ]);
            $namefotoktpwaris1 = 'foto_ktpwaris1'.date('Ymdhis').'.'.$this->foto_ktpwaris1Update->extension();
            $this->foto_ktpwaris1Update->storePubliclyAs('public',$namefotoktpwaris1);
            $this->data->foto_ktpwaris1 = $namefotoktpwaris1;
        }

        $this->data->name_waris2 = $this->name_waris2;
        $this->data->Id_Ktpwaris2 = $this->Id_Ktpwaris2;
        $this->data->tempat_lahirwaris2 = $this->tempat_lahirwaris2;
        $this->data->tanggal_lahirwaris2 = $this->tanggal_lahirwaris2;
        $this->data->phone_numberwaris2 = $this->phone_numberwaris2;
        $this->data->address_waris2 = $this->address_waris2;
        $this->data->jenis_kelaminwaris2 = $this->jenis_kelaminwaris2;
        $this->data->blood_typewaris2 = $this->blood_typewaris2;
        $this->data->hubungananggota2 = $this->hubungananggota2;
        $this->data->hubungananggota2_lainnya= $this->hubungananggota2_lainnya;
        $this->data->koordinator_nama = $this->koordinator_nama;
		$this->data->koordinator_nik = $this->koordinator_nik;
		$this->data->koordinator_hp = $this->koordinator_hp;
		$this->data->koordinator_alamat = $this->koordinator_alamat;

        if($this->foto_ktpwaris2Update!=""){
            $this->validate([
                'foto_ktpwaris2Update' => 'image:max:1024', // 1Mb Max
            ]);
            $namefotoktpwaris2 = 'foto_ktpwaris2'.date('Ymdhis').'.'.$this->foto_ktpwaris2Update->extension();
            $this->foto_ktpwaris2Update->storePubliclyAs('public',$namefotoktpwaris2);
            $this->data->foto_ktpwaris2 = $namefotoktpwaris2;
        }
        $this->data->region = $this->region;
        
        $this->data->save();

        $user = \App\Models\User::where('id',$this->user_id)->first();
        if($user){
            $user->name = $this->name;
            $user->email = $this->email;
            $user->telepon = $this->phone_number;
            $user->address = $this->address;
            $user->save();
        }

        session()->flash('message-success',__('Data updated successfully'));
        
        return redirect()->to('user-member');
    }
}
