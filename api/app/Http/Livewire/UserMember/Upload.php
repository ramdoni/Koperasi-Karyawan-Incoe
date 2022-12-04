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

        if(count($sheetData) > 0){
            $countLimit = 1;
            foreach($sheetData as $key => $i){
                if($key==1 || $i[1]=="") continue; // skip header
            
                $nama = $i[1];
                $nik = $i[2];
                $saldo = $i[3];
                
                $member = UserMember::where('no_anggota_platinum',$nik)->first();
                if($member){
                    $member->simpanan_lain_lain = $saldo;
                    $member->save();
                }
                
                // $find = User::where('username',$no_anggota)->first();
                // if($find) continue;

                // $user = new User();
                // $user->user_access_id = 4; // Member
                // $user->nik = $nik;
                // $user->name = $nama;
                // $user->password = Hash::make('12345678');
                // $user->username = $no_anggota;
                // $user->save();
                
                // $data = new UserMember();
                // $data->name = $nama; 
                // $data->user_id = $user->id;
                // $data->no_anggota_platinum = $no_anggota;
                // $data->seksi = $seksi;
                // $data->keterangan = $keterangan;
                // $data->save();
            }
        }

        session()->flash('message-success',__('Data berhasil di upload'));

        return redirect()->route('user-member.index');
    }
}