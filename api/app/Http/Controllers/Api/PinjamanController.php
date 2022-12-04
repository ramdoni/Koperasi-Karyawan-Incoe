<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class PinjamanController extends Controller
{
    public function kuota()
    {
        $member = \Auth::user()->member;
        $data['kuota'] = format_idr($member->plafond);
        $data['kuota_digunakan'] = format_idr($member->plafond_digunakan);
        $data['kuota_sisa'] =  format_idr($member->plafond - $member->plafond_digunakan);
        
        return response()->json(['status'=>200,'message'=>'success','data'=>$data], 200);
    }
}
