<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\TypeTransaksi;

class TypeTransaksiController extends Controller
{
    public function data()
    {
        $data = TypeTransaksi::orderBy('id','DESC')->get();

        return response()->json(['status'=>200,'message' => 'success','data'=>$data]);
    }

    public function store(Request $r)
    {
        $data = new TypeTransaksi();
        $data->name = $r->name;
        $data->save();

        return response()->json(['status'=>200,'message' => 'success']);
    }
}
