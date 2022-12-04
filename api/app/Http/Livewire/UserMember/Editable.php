<?php

namespace App\Http\Livewire\UserMember;

use Livewire\Component;

class Editable extends Component
{
    public $data,$field,$is_edit=false,$value;
    public function render()
    {
        return view('livewire.user-member.editable');
    }

    public function mount($field,$data,$id)
    {
        $this->field = $field;
        $this->value = $data;
        $this->data = $id;
    }

    public function save()
    {
        $field = $this->field;
        $data = UserMember::find($data);
        $data->$field = $this->value;
        $data->save();

        $this->is_edit = false;
    }
}
