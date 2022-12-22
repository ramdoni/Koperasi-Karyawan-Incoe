<div>
    <div class="row">
        <div class="col-md-2">
            <select class="form-control">
                <option value=""> -- Tahun -- </option>
            </select>
        </div>
        <div class="col-md-2">
            <select class="form-control">
                <option value=""> -- Jenis Pinjaman -- </option>
                @foreach($jenis_pinjaman as $item)
                    <option value="{{$item->id}}">{{$item->name}}</option>
                @endforeach
            </select>
        </div>
        <div class="col-md-8">
            <a href="{{route('pinjaman.insert',['user_member_id'=>$member->id])}}" class="btn btn-info"><i class="fa fa-plus"></i> Tambah</a>
        </div>
    </div>
    <div class="table-responsive mt-3">
        <table class="table table-hover m-b-0 c_list">
            <thead>
                <tr style="background:#eee;">
                    <th style="width:50">No</th>
                    <th>No Transaksi</th>
                    <th>Jenis Pinjaman</th>
                    <th>Keterangan</th>
                    <th>Tanggal</th>
                    <th>Nominal</th>
                    <th class="text-center">Tenor</th>
                    <th class="text-center">Angsuran</th>
                    <th class="text-center">Jasa</th>
                    <th class="text-right">Tagihan</th>
                </tr>
            </thead>
            <tbody>
                @php($number= $data->total() - (($data->currentPage() -1) * $data->perPage()) )
                @foreach($data as $k => $item)
                    <tr>
                        <td style="width: 50px;">{{$number}}</td>
                        <td><a href="{{route('pinjaman.edit',$item->id)}}">{{$item->no_pengajuan}}</a></td>
                        <td>{{isset($item->jenis_pinjaman->name) ? $item->jenis_pinjaman->name : '-'}}</td>
                        <td>{{$item->description}}</td>
                        <td>{{date('d-M-Y',strtotime($item->created_at))}}</td>
                        <td>{{format_idr($item->amount)}}</td>
                        <td class="text-center">{{format_idr($item->angsuran)}}</td>
                        <td class="text-center">{{format_idr($item->angsuran_perbulan)}}</td>
                        <td class="text-center">{{$item->jasa_persen}}% - Rp. {{format_idr($item->jasa)}}</td>
                        <td class="text-right">{{format_idr($item->angsuran_perbulan)}}</td>
                    </tr>
                    @php($number--)
                @endforeach
            </tbody>
        </table>
    </div>
    <br />
    {{$data->links()}}
</div>
