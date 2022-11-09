<?php

namespace App\Http\Livewire\UserMember;

use Livewire\Component;
use App\Models\UserMember;
use App\Models\User;
use App\Models\City;
use App\Models\Iuran;
use Livewire\WithFileUploads;
use Illuminate\Support\Facades\Hash;

class Upload extends Component
{
    use WithFileUploads;
    public $file;
    public function render()
    {
        return view('livewire.user-member.upload');
    }

    public function save()
    {
        set_time_limit(50000); // 
        $this->validate([
            'file'=>'required|mimes:xls,xlsx|max:51200' // 50MB maksimal
        ]);
        
        $path = $this->file->getRealPath();
        $reader = new \PhpOffice\PhpSpreadsheet\Reader\Xlsx();
        $reader->setReadDataOnly(true);
        $data = $reader->load($path);
        $sheetData = $data->getActiveSheet()->toArray();
        
        $month_arr = [
            1=>'Januari',
            2 =>'Februari',
            3=>'Maret',
            4=>'April',
            5=>'Mei',
            6=>'Juni',
            7=>'Juli',
            8=>'Agustus',
            9=>'September',
            10=>'Oktober',
            11=>'November',
            12=>'Desember'];

        if(count($sheetData) > 0){
            $countLimit = 1;
            foreach($sheetData as $key => $i){
                if($key<=1) continue; // skip header
                
                $no_anggota = $i[1];
                $no_anggota_gold = $i[2];
                $no_formulir = $i[3];
                $support = $i[4];
                $koordinator_no_anggota = $i[5];
                $koordinator_name = $i[6];
                $tgl_diterima = $i[7];
                $keanggotaan_baru = $i[8];
                $name = $i[9];
                $tempat_lahir = $i[10];
                $tanggal_lahir = $i[11];
                $alamat = $i[12];
                $gol_darah = $i[13];
                $kota = $i[14];
                $jenis_kelamin = $i[15];
                $no_ktp = $i[16];
                $tgl = $i[17];
                $no_telpon = $i[18];
                $agama = $i[19];
                $tanggal_meninggal = $i[20];
                // find no anggota
                $find_no_anggota = UserMember::where('no_anggota_platinum',$no_anggota)->first();
                if($find_no_anggota) continue;

                if($name =="") continue;

                $ahli1_nama = $i[21];
                $ahli1_alamat = $i[22];
                $ahli1_tempat_lahir = $i[23];
                $ahli1_tangal_lahir = $i[24];
                $ahli1_gol_darah = $i[25];
                $ahli1_jenis_kelamin = $i[26];
                $ahli1_no_ktp = $i[27];
                $ahli1_no_telpon = $i[28];
                $ahli1_hubungan = $i[29];

                $ahli2_nama = $i[30];
                $ahli2_alamat = $i[31];
                $ahli2_tempat_lahir = $i[32];
                $ahli2_tangal_lahir = $i[33];
                $ahli2_gol_darah = $i[34];
                $ahli2_jenis_kelamin = $i[35];
                $ahli2_no_ktp = $i[36];
                $ahli2_no_telpon = $i[37];
                $ahli2_hubungan = $i[38];

                $iuran_tetap  = $i[39];
                $sumbangan  = $i[40];
                $uang_pendaftaran  = $i[41];
                $total_bulan  = $i[42];
                $b_bulan  = $i[43];

                foreach($month_arr as $k => $month_name) if($month_name == $b_bulan) $bulan = $k;
                
                $tahun  = $i[44];
                $total = $i[45];
                
                $password = generate_password($name,$tanggal_lahir);

                $user = new User();
                $user->user_access_id = 4; // Member
                $user->nik = $no_ktp;
                $user->name = $name;
                // $user->email = $this->email;
                $user->telepon = $no_telpon;
                $user->address = $alamat;
                $user->password = Hash::make($password);
                $user->username = $no_anggota;
                $user->save();
                
                $data = new UserMember();
                $data->no_anggota_gold = $no_anggota_gold;
                $data->no_form = $no_formulir;
                $data->no_anggota_platinum = $no_anggota;
                $data->tanggal_diterima =  @\PhpOffice\PhpSpreadsheet\Shared\Date::excelToDateTimeObject($tgl_diterima)->format('Y-m-d');
                $data->masa_tenggang = date('Y-m-d',strtotime("+6 months",strtotime($data->tgl_diterima)));
                $data->name = $name;
                $data->name_kta = $name;
                $data->tempat_lahir = $tempat_lahir;
                $data->tanggal_lahir = @\PhpOffice\PhpSpreadsheet\Shared\Date::excelToDateTimeObject($tanggal_lahir)->format('Y-m-d');//date('Y-m-d',strtotime($tanggal_lahir));
                $data->region = $kota;
                $data->address = $alamat;

                $kota_row = City::where('name','LIKE', "%{$kota}%")->first();
                
                if(!$kota_row)  $kota_row = City::where('code','OTHER')->first();

                $data->city = $kota_row->code;
                $data->city_lainnya = $kota;
                $data->Id_Ktp = $no_ktp;
                $data->jenis_kelamin = $jenis_kelamin=='L'?'Laki-laki':'Perempuan';
                $data->phone_number = $no_telpon;
                $data->blood_type = $gol_darah;
                $data->agama = $agama;
                if($tanggal_meninggal) $data->tanggal_meninggal = @\PhpOffice\PhpSpreadsheet\Shared\Date::excelToDateTimeObject($tanggal_meninggal)->format('Y-m-d');

                $data->name_waris1 = $ahli1_nama;
                $data->tempat_lahirwaris1 = $ahli1_tempat_lahir;
                if($ahli1_tangal_lahir) $data->tanggal_lahirwaris1 = @\PhpOffice\PhpSpreadsheet\Shared\Date::excelToDateTimeObject($ahli1_tangal_lahir)->format('Y-m-d');//date('Y-m-d',strtotime($ahli1_tangal_lahir));
                $data->address_waris1 = $ahli1_alamat;
                $data->Id_Ktpwaris1 = $ahli1_no_ktp;
                $data->jenis_kelaminwaris1 = $ahli1_jenis_kelamin=='L'?'Laki-laki':'Perempuan';
                $data->phone_numberwaris1 = $ahli1_no_telpon;
                $data->blood_typewaris1 = $ahli1_gol_darah;
                $data->hubungananggota1 = $ahli1_hubungan;

                $data->name_waris2 = $ahli2_nama;
                $data->tempat_lahirwaris2 = $ahli2_tempat_lahir;
                if($ahli2_tangal_lahir) $data->tanggal_lahirwaris2 = @\PhpOffice\PhpSpreadsheet\Shared\Date::excelToDateTimeObject($ahli2_tangal_lahir)->format('Y-m-d');//date('Y-m-d',strtotime($ahli2_tangal_lahir));
                $data->address_waris2 = $ahli2_alamat;
                $data->Id_Ktpwaris2 = $ahli2_no_ktp;
                $data->jenis_kelaminwaris2 = $ahli2_jenis_kelamin=='L'?'Laki-laki':'Perempuan';
                $data->phone_numberwaris2 = $ahli2_no_telpon;
                $data->blood_typewaris2 = $ahli2_gol_darah;
                $data->hubungananggota2 = $ahli2_hubungan;
                // $data->hubungananggota2_lainnya = $this->hubungananggota2_lainnya;
                $data->is_approve = 1;
                $data->admin_approval = 1;
                $data->ketua_approval = 1;
                if($tanggal_meninggal)
                    $data->status = 4; // status meninggal
                else
                    $data->status = 2; // langsung approve ketika admin yang input
                // $data->bank_account_id = $this->bank_account_id;
                $data->iuran_tetap = (int)$total_bulan;
                $data->total_iuran_tetap = (int)$iuran_tetap;
                $data->sumbangan = $sumbangan;
                $data->total_sumbangan = $sumbangan;
                $data->uang_pendaftaran = $uang_pendaftaran;
                $data->total_pembayaran = $total;
                $data->status_pembayaran = 1; // pembayaran pendaftaran lunas
                // find koordinator
                $koordinator_row = UserMember::join('users','users.id','=','user_member.user_id')
                                        ->where('users.user_access_id',3)->where('status',2)
                                        ->where('user_member.no_anggota_platinum',$koordinator_no_anggota)
                                        ->select('user_member.*')->first();
                if(!$koordinator_row and $koordinator_no_anggota!=""){
                    $user_k = new User();
                    $user_k->user_access_id = 3; // Member
                    $user_k->name = $koordinator_name;
                    $user_k->username = $koordinator_no_anggota;
                    $user_k->password = Hash::make($koordinator_no_anggota);
                    $user_k->save();
                    
                    $koordinator_row = new UserMember();
                    $koordinator_row->name = $koordinator_name;
                    $koordinator_row->no_anggota_platinum = $koordinator_no_anggota;
                    $koordinator_row->user_id = $user_k->id;
                    $koordinator_row->is_approve = 1;
                    $koordinator_row->admin_approval = 1;
                    $koordinator_row->ketua_approval = 1;
                    $koordinator_row->status = 2; // langsung approve ketika admin yang input
                    $koordinator_row->save();
                }

                if($koordinator_no_anggota) $data->koordinator_id = $koordinator_row->id;		
                
                $data->user_id = $user->id;
                $data->save();

                // Iuran
                $bulan = date('m',strtotime($data->tanggal_diterima));
                $tahun = date('Y',strtotime($data->tanggal_diterima));
                for($count=1;$data->iuran_tetap>=$count;$count++){
                    if($bulan>12){ // jika sudah melebihi 12 bulan maka balik ke bulan ke 1 tapi tahun bertambah
                        $bulan = 1;
                        $tahun++;
                    }
                    // Iuran
                    $iuran = new Iuran();
                    $iuran->user_member_id = $data->id;
                    $iuran->type = 'Iuran';
                    $iuran->nominal = $data->total_iuran_tetap;
                    $iuran->from_periode = $data->tanggal_diterima;
                    $iuran->to_periode = date('Y-m-d',strtotime("+".($data->iuran_tetap-1)." months",strtotime($data->tanggal_diterima)));
                    // $iuran->bank_account_id = $this->bank_account_id;
                    // $iuran->file = $data->file_konfirmasi; 
                    $iuran->payment_date = date('Y-m-d');//$this->payment_date ? $this->payment_date : null;
                    $iuran->status = 2;
                    $iuran->bulan = $bulan;
                    $iuran->tahun = $tahun;
                    $iuran->iuran_pertama = 1;
                    $iuran->save();

                    $bulan++;
                }

            }
        }

        session()->flash('message-success',__('Data berhasil di upload'));

        return redirect()->route('user-member.index');

    }
}
