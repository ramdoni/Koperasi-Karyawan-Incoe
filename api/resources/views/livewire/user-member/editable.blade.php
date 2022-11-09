<div class="editable">
    @if($is_edit)
        @if($field=='agama')
            <select class="form-control" wire:model="value">
                <option value=""> --- Agama --- </option>
                <option>Islam</option> 
                <option>Kristen</option> 
                <option>Katolik</option> 
                <option>Hindu</option> 
                <option>Buddha</option> 
                <option>Konghucu</option> 
            </select>
        @elseif($field=='jenis_kelamin')
            <select class="form-control" wire:model="value">
                <option value=""> --- Jenis Kelamin --- </option>
                @foreach(config('vars.jenis_kelamin') as $i)
                    <option>{{$i}}</option> 
                @endforeach
            </select>
        @else
            <input type="text" class="form-control" wire:model="value" wire:keydown.enter="save" placeholder="{{$field}}"  />
        @endif
        <a href="javascript:void(0)" wire:click="$set('is_edit',false)"><i class="fa fa-close text-danger"></i></a>
        <a href="javascript:void(0)" wire:click="save"><i class="fa fa-save text-success"></i></a>
    @else
        @if($field=='amount')
            <a href="javascript:void(0)" wire:click="$set('is_edit',true)">{!!$value?format_idr($value):'<i style="color:grey">Empty</i>'!!}</a>
        @else
            <a href="javascript:void(0)" wire:click="$set('is_edit',true)">{!!$value?$value:'<i style="color:grey">Empty</i>'!!}</a>
        @endif
    @endif
</div>
