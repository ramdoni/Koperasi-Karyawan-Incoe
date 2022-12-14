<?php
use Illuminate\Support\Str;

function getRomawi($bln){
    switch ($bln){
        case 1: 
            return "I";
            break;
        case 2:
            return "II";
            break;
        case 3:
            return "III";
            break;
        case 4:
            return "IV";
            break;
        case 5:
            return "V";
            break;
        case 6:
            return "VI";
            break;
        case 7:
            return "VII";
            break;
        case 8:
            return "VIII";
            break;
        case 9:
            return "IX";
            break;
        case 10:
            return "X";
            break;
        case 11:
            return "XI";
            break;
        case 12:
            return "XII";
            break;
    }
}

function getMonthName($key)
{
    $month = [
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

    return @$month[(int)$key];
}


function countMount($start,$end)
{
    $d1 = strtotime($start);
    $d2 = strtotime($end);
    
    return abs((date('Y', $d2) - date('Y', $d1))*12 + (date('m', $d2) - date('m', $d1)));
}

function calculate_masa_tenggang($date){
    $birthDate = new \DateTime('today');
	$today = new \DateTime($date);
	if ($birthDate > $today) { 
	    return 0;
    }
    $day = $today->diff($birthDate)->d;
    $month = $today->diff($birthDate)->m;
    if($day || $month) return "<span>".($month!=0?$month." Month " : '') . ($day!=0?$day.' Day' : '').'</span>';
}

function hitung_masa_klaim($tanggal_diterima,$format="y")
{
    $birthDate = new \DateTime($tanggal_diterima);
    $today = new \DateTime("today");
    if ($birthDate > $today) { 
        return 0;
    }
    $tahun = $today->diff($birthDate)->$format;
    return $tahun; 
}

function hitung_umur($tanggal_lahir){
    $birthDate = new \DateTime($tanggal_lahir);
	$today = new \DateTime("today");
	if ($birthDate > $today) { 
	    return 0;
    }
    $tahun = $today->diff($birthDate)->y;

    if($today->diff($birthDate)->d > 1) $tahun = $tahun +1; // Perhitungan umur lewat dari satu hari ulang tahun dihitung menjadi 1 tahun 
    return $tahun;
}

function format_idr($number)
{
    return number_format($number,0,0,'.');
}

function get_setting($key,$absolute_path=false)
{
    $setting = \App\Models\Settings::where('key',$key)->first();

    if($setting)
    {
        if($key=='logo' || $key=='favicon' ){
            if($absolute_path)
                return  public_path("storage/{$setting->value}");
            else
                return  asset("storage/{$setting->value}");
        }

        return $setting->value;
    }
}

function update_setting($key,$value)
{
    $setting = \App\Models\Settings::where('key',$key)->first();
    if($setting){
        $setting->value = $value;
        $setting->save();
    }else{
        $setting = new \App\Models\Settings();
        $setting->key = $key;
        $setting->value = $value;
        $setting->save();
    }
}

function sendNotifWa ($messageWa, $phone)
{
    return false; // disable notif wa
    $message = strip_tags($messageWa ."\n\n_Do not reply to this message, as it is generated by system._");
    $message = $message;
    $number = Str::replaceFirst('0','62',  $phone);
    $number = str_replace('-', '', $number);
    
    $curl = curl_init(); 
    $token = "HioVXgQTselUx6alx9GmtfcJgpySCDnH3FCZh2tARb0C7vRtQon5shmOwx0KmGl1";
    $data = [
        'phone' => $number,
        'message' => $message,
    ];

    curl_setopt($curl, CURLOPT_HTTPHEADER,
        array(
            "Authorization: ". $token,
        )
    );
    curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "POST");
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($data));
    curl_setopt($curl, CURLOPT_URL, "https://console.wablas.com/api/send-message");
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
    $result = curl_exec($curl);
    curl_close($curl);
}

function getMonth($start,$end)
{
    if($start == $end) return date('F Y',strtotime($start));
    
    $begin = new DateTime($start);
    $end = new DateTime($end);
    $end->add(new DateInterval("P1M"));
    $interval = DateInterval::createFromDateString('1 month');
    $period = new DatePeriod($begin, $interval, $end);
    $counter = 0;
    foreach($period as $dt) {
        echo $dt->format('M  Y');
        echo "<br>";
        $counter++;
    }
}

function getTotalMonth($start,$end)
{
    $begin = new DateTime($start);
    $end = new DateTime($end);
    $end->add(new DateInterval("P1M"));
    $interval = DateInterval::createFromDateString('1 month');
    $period = new DatePeriod($begin, $interval, $end);
    $counter = 0;
    foreach($period as $dt) {
        $counter++;
    }
    return $counter;
}

function replace_idr($nominal)
{
    if($nominal == "") return 0;

    $nominal = str_replace('Rp. ', '', $nominal);
    $nominal = str_replace(' ', '', $nominal);
    $nominal = str_replace('.', '', $nominal);
    $nominal = str_replace(',', '', $nominal);
    $nominal = str_replace('-', '', $nominal);
    $nominal = str_replace('(', '', $nominal);
    $nominal = str_replace(')', '', $nominal);

    return (int)$nominal;
}

function getAsuransi($id)
{
    $user = \App\Models\UserMember::where('id',$id)->first();
    $umur = hitung_umur($user->tanggal_lahir);
    
    if($umur < 80)
    {
        $asuransi = \App\Models\Asuransi::where('user_member_id',$id)->get()->last();
        if($asuransi)
            return '<label class="badge badge-success">'.$asuransi->membernostr.'</label>';
        else
            return '<label class="badge badge-warning">Inactive</label>';
    } else {
        return '<label class="badge badge-danger">No Criteria</label>';
    }    
}
