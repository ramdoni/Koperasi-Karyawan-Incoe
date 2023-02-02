<?php

namespace App\Http\Livewire\Product;

use Livewire\Component;
use App\Models\Product;
use App\Models\TransaksiItem;

class Detail extends Component
{
    public $data,$penjualan;
    public function render()
    {
        return view('livewire.product.detail');
    }

    public function mount(Product $data)
    {
        $this->data = $data;
        $this->penjualan = TransaksiItem::where('product_id',$data->id)->get();
    }
}
