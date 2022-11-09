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

    public function mount($field,$data)
    {
        $this->field = $field;
        $this->data = $data;
        $this->value = $data->$field;
    }

    public function save()
    {
        $field = $this->field;
        $this->data->$field = $this->value;
        $this->data->save();

        $this->is_edit = false;
    }
}
