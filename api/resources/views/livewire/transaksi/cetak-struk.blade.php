<html>
    <head>
    <style>
        @page {
            size: 7.5cm 23.5cm;  potrait; 
            margin:0 10px; 
            font-size:10px;
        }
        @media print {
            @page {
                size: 7.5cm 23.5cm;  potrait; 
                margin:0 10px; 
                font-size:10px;
            }
        }
    </style>
    </head>
<body>
    <div style="border-bottom:1px dotted black;margin-top:20px;width:100%">
        <img src="{{get_setting('logo')}}" style="width:20px;float:left;margin-right:20px;" />
        <p style="float:left;margin-top:0;padding-top:0;text-align:center;">
            {{get_setting('company')}}<br />
            <small>{!!get_setting('address')!!}</small>
        </p>
        <div style="clear:both"></div>
    </div>
    <div style="border-bottom:1px dotted black;width:100%">
        <div style="width:50%;float:left;margin:0;padding:0;">{{$data->no_transaksi}} </div>
        <div style="width:50%;float:right;margin:0;padding:0;text-align:right;">{{date('d.F.Y H:i:s',strtotime($data->created_at))}}</div>
        <div style="clear:both"></div>
    </div>
    <table style="width:100%">
        @php($total=0)
        @foreach($data->items as $item)
            <tr>
                <td style="width:80%;padding-right:10px;">{{$item->description}}</td>
                <td style="width:10%;">{{$item->qty}}</td>
                <td style="width:10%;">{{format_idr($item->price)}}</td>
                <td style="width:10%;padding-left:10px;">{{format_idr($item->price*$item->qty)}}</td>
            </tr>
            @php($total += $item->price)
        @endforeach
        <tr>
            <td colspan="2" style="border-top:1px dotted black; text-align:right">Harga Jual</td>
            <td style="text-align:right;border-top:1px dotted black;"> : </td>
            <td style="text-align:right;border-top:1px dotted black;">Rp.{{format_idr($total)}}</td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:right">PPN</td>
            <td style="text-align:right;"> : </td>
            <td style="text-align:right;">Rp.{{format_idr($total*0.11)}}</td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:right">Total</td>
            <td style="text-align:right;"></td>
            <td style="text-align:right;">Rp.{{format_idr(($total*0.11) + $total)}}</td>
        </tr>
    </table>
    <p style="text-align:center;">Layanan Konsumen WA/SMS ke -<br />Call: - Email : info@stalavista.com</p>
</body>
</html>