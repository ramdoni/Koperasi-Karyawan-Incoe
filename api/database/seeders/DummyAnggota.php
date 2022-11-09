<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DummyAnggota extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        for($i=0;$i<500;$i++){

            $anggota = new \App\Models\Anggota();
            $anggota->nama = $this->generateRandomString();
            $anggota->telepon = '-';
            $anggota->jenis_kelamin = "L";
            $anggota->email = $anggota->nama ."@gmail.com";
            $anggota->alamat = "-";
            $anggota->no_ktp = rand();
            $anggota->save();
        }
    }

    public function generateRandomString($length = 10) {
        return substr(str_shuffle(str_repeat($x='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil($length/strlen($x)) )),1,$length);
    }
}
