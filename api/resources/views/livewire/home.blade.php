@section('title', 'Dashboard')
@section('parentPageTitle', '')

<div class="row clearfix">
    <div class="col-lg-3 col-md-6 col-sm-6">
        <div class="card overflowhidden number-chart">
            <div class="body">
                <div class="number">
                    <h6>Anggota Aktif</h6>
                    <span>{{format_idr(\App\Models\UserMember::where('status',2)->where('is_non_anggota',0)->count())}}</span>
                </div>
                {{-- <small class="text-muted">19% compared to last week</small> --}}
            </div>
            <div class="sparkline" data-type="line" data-spot-Radius="0" data-offset="90" data-width="100%" data-height="50px"
            data-line-Width="1" data-line-Color="#f79647" data-fill-Color="#fac091">1,4,1,3,7,1</div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6 col-sm-6">
        <div class="card overflowhidden number-chart">
            <div class="body">
                <div class="number">
                    <h6>Anggota Klaim</h6>
                    <span>{{format_idr(\App\Models\Klaim::count())}}</span>
                </div>
                {{-- <small class="text-muted">19% compared to last week</small> --}}
            </div>
            <div class="sparkline" data-type="line" data-spot-Radius="0" data-offset="90" data-width="100%" data-height="50px"
            data-line-Width="1" data-line-Color="#604a7b" data-fill-Color="#a092b0">1,4,2,3,6,2</div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6 col-sm-6">
        <div class="card overflowhidden number-chart">
            <div class="body">
                <div class="number">
                    <h6>Iuran</h6>
                    <span>{{format_idr(\App\Models\Iuran::sum('nominal'))}}</span>
                </div>
                {{-- <small class="text-muted">19% compared to last week</small> --}}
            </div>
            <div class="sparkline" data-type="line" data-spot-Radius="0" data-offset="90" data-width="100%" data-height="50px"
            data-line-Width="1" data-line-Color="#4aacc5" data-fill-Color="#92cddc">1,4,2,3,1,5</div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6 col-sm-6">
        <div class="card overflowhidden number-chart">
            <div class="body">
                <div class="number">
                    <h6>Klaim</h6>
                    <span>{{format_idr(\App\Models\Klaim::sum('total')+\App\Models\KlaimAdditional::sum('nominal'))}}</span>
                </div>
                {{-- <small class="text-muted">19% compared to last week</small> --}}
            </div>
            <div class="sparkline" data-type="line" data-spot-Radius="0" data-offset="90" data-width="100%" data-height="50px"
            data-line-Width="1" data-line-Color="#4f81bc" data-fill-Color="#95b3d7">1,3,5,1,4,2</div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="card">
            <div class="body">
                <ul class="nav nav-tabs">                                
                    <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#anggota">Anggota</a></li>
                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#klaim">Klaim</a></li>
                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#iuran">Iuran</a></li>
                </ul>
                <div class="tab-content px-0">
                    <div class="tab-pane active" id="anggota">
                        <livewire:home.anggota />
                    </div>
                    <div class="tab-pane" id="klaim">
                        <livewire:home.klaim />
                    </div>
                    <div class="tab-pane" id="iuran">
                        <livewire:home.iuran />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
