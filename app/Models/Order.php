<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $fillable = [
        'nama',
        'no_hp',
        'jenis_laundry',
        'tanggal',
        'jam',
        'alamat',
    ];
}