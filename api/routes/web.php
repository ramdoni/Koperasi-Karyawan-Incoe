<?php

use Illuminate\Support\Facades\Route;
use App\Http\Livewire\Home;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', Home::class)->name('home')->middleware('auth');
Route::get('privacy', App\Http\Livewire\Privacy::class)->name('privacy');
Route::get('login', App\Http\Livewire\Login::class)->name('login');
Route::get('register', App\Http\Livewire\Register::class)->name('register');
Route::get('konfirmasi-pembayaran',App\Http\Livewire\KonfirmasiPembayaran::class)->name('konfirmasi-pembayaran');
Route::get('konfirmasi-pendaftaran',App\Http\Livewire\KonfirmasiPendaftaran::class)->name('konfirmasi-pendaftaran');
Route::get('linksakti',function(){
    \Auth::loginUsingId(4);

    return 'test';
});

Route::get('generate',function(){
    $user_member = \App\Models\UserMember::whereNull('no_anggota_platinum')->get();
    $num = 1;
    foreach($user_member as $item){
        $no_anggota = "NA".str_pad($num,5, '0', STR_PAD_LEFT);
        $item->no_anggota_platinum = $no_anggota;
        $item->save();

        $user = \App\Models\User::find($item->user_id);
        $user->username = $no_anggota;
        $user->save();
        $num++;
    }
});

// All login
Route::group(['middleware' => ['auth']], function(){    
    Route::get('profile',App\Http\Livewire\Profile::class)->name('profile');
    Route::get('back-to-admin',[App\Http\Controllers\IndexController::class,'backtoadmin'])->name('back-to-admin');
});
Route::get('user-member/print-member/{id}',[\App\Http\Controllers\UserMemberController::class,'printMember'])->name('user-member.print-member');
Route::get('user-member/print-iuran/{id}/{tahun}',[\App\Http\Controllers\UserMemberController::class,'printIuran'])->name('user-member.print-iuran');
Route::post('ajax/get-member', [\App\Http\Controllers\AjaxController::class,'getMember'])->name('ajax.get-member');   

// Administrator
Route::group(['middleware' => ['auth','access:1,5']], function(){    
    Route::get('setting',App\Http\Livewire\Setting::class)->name('setting');
    Route::get('users/insert',App\Http\Livewire\User\Insert::class)->name('users.insert');
    Route::get('user-access', App\Http\Livewire\UserAccess\Index::class)->name('user-access.index');
    Route::get('user-access/insert', App\Http\Livewire\UserAccess\Insert::class)->name('user-access.insert');
    Route::get('users',App\Http\Livewire\User\Index::class)->name('users.index');
    Route::get('users/edit/{id}',App\Http\Livewire\User\Edit::class)->name('users.edit');
    Route::post('users/autologin/{id}',[App\Http\Livewire\User\Index::class,'autologin'])->name('users.autologin');
    Route::get('module',App\Http\Livewire\Module\Index::class)->name('module.index');
    Route::get('module/insert',App\Http\Livewire\Module\Insert::class)->name('module.insert');
    Route::get('module/edit/{id}',App\Http\Livewire\Module\Edit::class)->name('module.edit');
    Route::get('user-member', App\Http\Livewire\UserMember\Index::class)->name('user-member.index');
    Route::get('user-member/insert', App\Http\Livewire\UserMember\Insert::class)->name('user-member.insert');
    Route::get('user-member/edit/{id}',App\Http\Livewire\UserMember\Edit::class)->name('user-member.edit');
    Route::get('user-member/approval/{id}',App\Http\Livewire\UserMember\Approval::class)->name('user-member.approval');
    Route::get('user-member/proses/{id}',App\Http\Livewire\UserMember\Proses::class)->name('user-member.proses');
    Route::get('user-member/klaim/{id}',App\Http\Livewire\UserMember\Klaim::class)->name('user-member.klaim');
    Route::get('bank-account',App\Http\Livewire\BankAccount\Index::class)->name('bank-account.index');
    Route::get('bank-account/insert',App\Http\Livewire\BankAccount\Insert::class)->name('bank-account.insert');
    Route::get('bank-account/edit/{id}',App\Http\Livewire\BankAccount\Edit::class)->name('bank-account.edit');
    Route::get('koordinator',App\Http\Livewire\Koordinator\Index::class)->name('koordinator.index');
    Route::get('koordinator/insert',App\Http\Livewire\Koordinator\Insert::class)->name('koordinator.insert');
    Route::get('koordinator/edit/{id}',App\Http\Livewire\Koordinator\Edit::class)->name('koordinator.edit');
    Route::get('iuran',App\Http\Livewire\Iuran\Index::class)->name('iuran.index');
    Route::get('iuran/proses/{id}',App\Http\Livewire\Iuran\Proses::class)->name('iuran.proses');
    Route::get('iuran/insert',App\Http\Livewire\Iuran\Insert::class)->name('iuran.insert');
    Route::get('iuran/cetak',App\Http\Livewire\Iuran\Cetak::class)->name('iuran.cetak');
    Route::get('klaim',App\Http\Livewire\Klaim\Index::class)->name('klaim.index');
    Route::get('klaim/edit/{id}',App\Http\Livewire\Klaim\Edit::class)->name('klaim.edit');
    Route::get('klaim/additionaledit/{id}',App\Http\Livewire\Klaim\AdditionalEdit::class)->name('klaim.additionaledit');
    Route::get('klaim/additionalindex/{klaim}',App\Http\Livewire\Klaim\AdditionalIndex::class)->name('klaim.additionalindex');
    Route::get('klaim/additionalinsert/{id}',App\Http\Livewire\Klaim\AdditionalInsert::class)->name('klaim.additionalinsert');
    Route::get('asuransi',App\Http\Livewire\Asuransi\Index::class)->name('asuransi.index');
    Route::get('asuransi/edit/{id}',App\Http\Livewire\Asuransi\Edit::class)->name('asuransi.edit');
    Route::get('cetak-tagihan/{id}/{tahun}',[App\Http\Controllers\IndexController::class,"cetaktagihan"])->name('cetak-tagihan');
    Route::get('klaim/fppma/{member}', [App\Http\Controllers\KlaimController::class,"fppma"])->name('klaim.fppma');
    Route::get('migration',App\Http\Livewire\Migration\Index::class)->name('migration.index');

    // Sapphire
    Route::get('sapphire/anggota', App\Http\Livewire\Sapphire\Anggota\Index::class)->name('sapphire.anggota.index');
    Route::get('sapphire/anggota/insert', App\Http\Livewire\Sapphire\Anggota\Insert::class)->name('sapphire.anggota.insert');
    Route::get('sapphire/anggota/edit/{id}',App\Http\Livewire\Sapphire\Anggota\Edit::class)->name('sapphire.anggota.edit');
    Route::get('sapphire/anggota/approval/{id}',App\Http\Livewire\Sapphire\Anggota\Approval::class)->name('sapphire.anggota.approval');
    //Route::get('sapphire/anggota/proses/{id}',App\Http\Livewire\Sapphire\Anggota\Proses::class)->name('sapphire.anggota.proses');
    //Route::get('sapphire/anggota/klaim/{id}',App\Http\Livewire\Sapphire\Anggota\Klaim::class)->name('sapphire.anggota.klaim');
    Route::get('sapphire/iuran/index',App\Http\Livewire\Sapphire\Iuran\Index::class)->name('sapphire.iuran.index');

});

// Ketua Yayasan
Route::group(['middleware' => ['auth','access:2'],'prefix'=>'ketua-yayasan'], function(){    
    Route::get('/',App\Http\Livewire\KetuaYayasan\Index::class)->name('ketua-yayasan.index');
    Route::get('member', App\Http\Livewire\KetuaYayasan\Member\Index::class)->name('ketua-yayasan.member');
    Route::get('member/approval/{id}',App\Http\Livewire\KetuaYayasan\Member\Approval::class)->name('ketua-yayasan.member.approval');
    Route::get('member/edit/{id}', App\Http\Livewire\KetuaYayasan\Member\Edit::class)->name('ketua-yayasan.member.edit');
    Route::get('klaim', App\Http\Livewire\KetuaYayasan\Klaim\Index::class)->name('ketua-yayasan.klaim');
    Route::get('klaim/approval/{id}',App\Http\Livewire\KetuaYayasan\Klaim\Approval::class)->name('ketua-yayasan.klaim.approval');
    Route::get('klaim/edit/{id}',App\Http\Livewire\KetuaYayasan\Klaim\Edit::class)->name('ketua-yayasan.klaim.edit');
    Route::get('klaim/additional/{id}',App\Http\Livewire\KetuaYayasan\Klaim\Additional::class)->name('ketua-yayasan.klaim.additional');
});
// Koordinator
Route::group(['middleware' => ['auth','access:3'],'prefix'=>'koordinator'], function(){    
    Route::get('member', App\Http\Livewire\Koordinator\Member\Index::class)->name('koordinator.member');
    Route::get('member/insert', App\Http\Livewire\Koordinator\Member\Insert::class)->name('koordinator.member.insert');
    Route::get('member/edit/{id}', App\Http\Livewire\Koordinator\Member\Edit::class)->name('koordinator.member.edit');
    Route::get('iuranmember', App\Http\Livewire\Koordinator\Iuranmember\Index::class)->name('koordinator.iuranmember');
    Route::get('iuranmember/insert', App\Http\Livewire\Koordinator\Iuranmember\Insert::class)->name('koordinator.iuranmember.insert');
    Route::get('iuranmember/cetak',App\Http\Livewire\Koordinator\Iuranmember\Cetak::class)->name('koordinator.iuranmember.cetak');
    Route::get('biodata', App\Http\Livewire\Koordinator\Biodata\Index::class)->name('koordinator.biodata');
    Route::get('iuran', App\Http\Livewire\Koordinator\Iuran\Index::class)->name('koordinator.iuran');
    Route::get('iuran/insert', App\Http\Livewire\Koordinator\Iuran\Insert::class)->name('koordinator.iuran.insert');
});
//Anggota
Route::group(['middleware' => ['auth','access:4'],'prefix'=>'anggota'], function(){  
    Route::get('member', App\Http\Livewire\Anggota\Member\Index::class)->name('anggota.member');
    Route::get('iuran', App\Http\Livewire\Anggota\Iuran\Index::class)->name('anggota.iuran');
    Route::get('iuran/insert', App\Http\Livewire\Anggota\Iuran\Insert::class)->name('anggota.iuran.insert');
});
// Kasir
Route::group(['middleware' => ['auth','access:6'],'prefix'=>'kasir'], function(){    
    Route::get('home', App\Http\Livewire\Kasir\Index::class)->name('kasir.index');
    Route::get('pembayaran', App\Http\Livewire\Kasir\Pembayaran::class)->name('kasir.pembayaran');
});