@section('title', 'Dashboard')
@section('parentPageTitle', 'Kasir')
<div class="row clearfix">
    <div class="col-lg-12">
        <div class="card">
            <div class="header row">
                <div class="col-md-2">
                    <input type="text" class="form-control" wire:model="keyword" placeholder="Searching..." />
                </div>
                <div class="col-md-2 px-0">
                    <select class="form-control" wire:model="koordinator_id">
                        <option value=""> --- Koordinator --- </option>
                        @foreach(\App\Models\Koordinator::orderBy('name','ASC')->get() as $koor)
                        <option value="{{$koor->id}}">{{$koor->name}}</option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-2 pr-0">
                    <select class="form-control" wire:model="user_member_id">
                        <option value=""> --- Anggota --- </option>
                        @foreach(\App\Models\UserMember::orderBy('name','ASC')->get() as $anggota)
                        <option value="{{$anggota->id}}">{{$anggota->name}}</option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-2">
                    <a href="{{route('kasir.pembayaran')}}" class="btn btn-info"><i class="fa fa-plus"></i> Pembayaran</a>
                </div>
            </div>
            <div class="body pt-0">
                <div class="table-responsive">
                    <table class="table table-striped m-b-0 c_list">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Koordinator</th>                                    
                                <th>Member</th>                                    
                                <th>Periode</th>                                    
                                <th>Nominal</th>                                    
                                <th>Payment Date</th>
                                <th>Bank Account</th>
                                <th>Bukti Pembayaran</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($data as $k => $item)
                            <tr>
                                <td style="width: 50px;">{{$k+1}}</td>
                                <td>{{isset($item->user_member->koordinator->name)?$item->user_member->koordinator->name:''}}</td>
                                <td>{{isset($item->user_member->name)?$item->user_member->name:''}}</td>
                                <td>{{$item->from_periode}} - {{$item->to_periode}}</td>
                                <td>{{format_idr($item->nominal)}}</td>
                                <td>{{$item->payment_date}}</td>
                                <td>{{isset($item->bank_account->bank)?$item->bank_account->bank .'  '.$item->bank_account->no_rekening .' a/n '.$item->bank_account->owner:''}}</td>
                                <td><a href="{{ asset('storage/'. $item->file) }}" target="_blank"><i class="fa fa-image"></i></a></td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
                <br />
                {{$data->links()}}
            </div>
        </div>
    </div>
</div>