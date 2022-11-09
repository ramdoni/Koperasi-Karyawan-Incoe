<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Iuran;
use App\Models\UserMember;

class UserMember extends Model
{
    use HasFactory;

    protected $guarded = [];
    
    protected $table = 'user_member';

    public function provinsi()
    {
        return $this->hasOne('\App\Models\Provinsi','id_prov','provinsi_id');
    }
    public function kabupaten()
    {
        return $this->hasOne('\App\Models\Kabupaten','id_kab','kabupaten_id');
    }
    public function koordinator()
    {
        return $this->hasOne('\App\Models\Koordinator','id','koordinator_id');
    }
    
    public function iuran()
    {
        return $this->hasMany(Iuran::class,'user_member_id','id');
    }
    
    public function klaim()
    {
        return $this->hasOne('\App\Models\Klaim','user_member_id','id');
    }
    
    public function kota()
    {
        return $this->hasOne('\App\Models\City','code','city');
    }

    public function user_rekomendasi()
    {
        return $this->belongsTo(UserMember::class,'user_id_recomendation','id')->where('status',2);
    }

    public function anggota_rekomendasi()
    {
        return $this->hasMany('\App\Models\UserMember','user_id_recomendation','id');
    }

    public function koordinatorUser()
    {
        return $this->hasOne('\App\Models\UserMember','id','koordinator_id');
    }

    public function asuransi()
    {
        return $this->hasMany('\App\Models\Asuransi','user_member_id','id')->latest();
    }

    public function asuransiMax()
    {
        return $this->hasOne('\App\Models\Asuransi','user_member_id','id')->latest();
    }
   
}
