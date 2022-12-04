<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group(['middleware' => 'cors', 'json.response'], function(){
	Route::post('auth-login', [\App\Http\Controllers\Api\UserController::class,'login']);
	Route::post('submit-pendaftaran',[\App\Http\Controllers\Api\UserController::class,'submitPendaftaran'])->name('api.submit-pendaftaran');
	Route::post('find-no-ktp',[\App\Http\Controllers\Api\UserController::class,'findNoKtp'])->name('api.find-no-ktp');
	Route::post('konfirmasi-pendaftaran',[\App\Http\Controllers\Api\UserController::class,'konfirmasiPendaftaran'])->name('api.konfirmasi-pendaftaran');
	Route::get('get-bank',[\App\Http\Controllers\Api\IuranController::class,'get_bank'])->name('api.get-bank');
});

Route::group(['middleware' => 'auth:api'], function(){
	Route::get('user/check-token',[\App\Http\Controllers\Api\UserController::class,'checkToken']);
	Route::post('user/upload-photo',[\App\Http\Controllers\Api\UserController::class,'uploadPhoto'])->name('api.user.upload-photo');
	Route::post('user/change-password',[\App\Http\Controllers\Api\UserController::class,'changePassword'])->name('api.user.change-password');
	Route::get('iuran',[\App\Http\Controllers\Api\IuranController::class,'iuran'])->name('api.iuran');
	Route::get('iuran/get-last',[\App\Http\Controllers\Api\IuranController::class,'getLast'])->name('api.iuran.get-last');
	Route::post('iuran/store',[\App\Http\Controllers\Api\IuranController::class,'store'])->name('api.iuran.store');
	Route::get('tagihan/tunai',[\App\Http\Controllers\Api\TagihanController::class,'tagihanTunai'])->name('tagihan.tunai');
	Route::get('tagihan/first',[\App\Http\Controllers\Api\TagihanController::class,'tagihanFirst'])->name('tagihan.first');
	Route::get('pinjaman/kuota',[\App\Http\Controllers\Api\PinjamanController::class,'kuota'])->name('pinjaman.kuota');
});