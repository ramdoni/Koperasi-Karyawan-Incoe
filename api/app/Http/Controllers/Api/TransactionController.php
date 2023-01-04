<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Transaksi;
use App\Models\UserMember;
use App\Models\TransaksiItem;

class TransactionController extends Controller
{
    public function store(Request $r)
    {
        $validator = \Validator::make($r->all(), [
            'transaction_id'=> 'required',
            'no_anggota'=> 'required',
            'token'=>'required'
        ]);
        
        if($r->token != env('COOPZONE_TOKEN')) return response()->json(['status'=>'failed','message'=>'Token Invalid'], 200);

        if ($validator->fails()) {
            $msg = '';
            foreach ($validator->errors()->getMessages() as $key => $value) {
                $msg .= $value[0]."\n";
            }
            return response()->json(['status'=>'failed','message'=>$msg], 200);
        }

        $member = UserMember::where('no_anggota_platinum',$r->no_anggota)->first();
        
        $transaksi = Transaksi::where('no_transaksi',$r->transaction_id)->first();
        if(!$transaksi){
            $transaksi = new Transaksi();
            $transaksi->no_transaksi = $r->transaction_id;
            $transaksi->user_member_id = $member?$member->id:0;
            $transaksi->tanggal_transaksi = date('Y-m-d',strtotime($r->date));
            $transaksi->metode_pembayaran = $r->metode_pembayaran;
            if($metode_pembayaran==4) $transaksi->payment_date = date('Y-m-d',strtotime($tanggal));
            $transaksi->status = $r->status;
            $transaksi->save();
        }

        $item = new TransaksiItem();
        $item->transaksi_id = $transaksi->id;
        $item->description = $r->produk;
        $item->qty = $r->qty;
        $item->price = $r->price;
        $item->total = $r->total;
        $item->save();

        $transaksi->amount = TransaksiItem::where('transaksi_id',$transaksi->id)->sum('price');
        $transaksi->save();

        return response()->json(['status'=>200,'message'=>'success'], 200);
    }
}