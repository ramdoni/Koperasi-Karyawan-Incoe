<?php

namespace App\Http\Controllers;

use App\Models\Transaksi;

class TransaksiController extends Controller
{
    public function cetakStruk(Transaksi $data)
    {   
        $pdf = \App::make('dompdf.wrapper');
        
        $pdf->loadView('livewire.transaksi.cetak-struk',['data'=>$data]);

        return $pdf->stream();
    }

    public function cetakBarcode($no)
    {   
        $pdf = \App::make('dompdf.wrapper');
        
        $pdf->loadView('livewire.transaksi.cetak-barcode',['no'=>$no]);

        return $pdf->stream();
    }
}
