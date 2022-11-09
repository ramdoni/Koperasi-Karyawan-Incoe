<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Anggota;

class AnggotaController extends Controller
{

    public function data()
    {
        $data = Anggota::orderBy('id','DESC')->get();

        return response()->json(['status'=>200,'message' => 'success','data'=>$data]);
    }

    /**
     * @param Request
     * @return json
     */
    public function insert(Request $r)
    {
        $data = new Anggota();
        $data->nama = $r->nama;
        $data->telepon = $r->telepon;
        $data->alamat = $r->alamat;
        $data->save();

        return response()->json(['status'=>200,'message' => 'success']);
    }
}
