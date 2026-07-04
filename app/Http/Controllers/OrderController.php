<?php

namespace App\Http\Controllers;

use App\Models\Order;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    // Menampilkan semua data
    public function index()
    {
        return response()->json(Order::all());
    }

    // Menyimpan data baru
    public function store(Request $request)
    {
        $order = Order::create([
            'nama'            => $request->nama,
            'no_hp'           => $request->no_hp,
            'jenis_laundry'   => $request->jenis_laundry,
            'tanggal'         => $request->tanggal,
            'jam'             => $request->jam,
            'alamat'          => $request->alamat,
        ]);

        return response()->json([
            'message' => 'Booking laundry berhasil ditambahkan',
            'data' => $order
        ], 201);
    }

    // Menampilkan satu data
    public function show($id)
    {
        return response()->json(Order::findOrFail($id));
    }

    // Mengubah data
    public function update(Request $request, $id)
    {
        $order = Order::findOrFail($id);

        $order->update([
            'nama'            => $request->nama,
            'no_hp'           => $request->no_hp,
            'jenis_laundry'   => $request->jenis_laundry,
            'tanggal'         => $request->tanggal,
            'jam'             => $request->jam,
            'alamat'          => $request->alamat,
        ]);

        return response()->json([
            'message' => 'Booking laundry berhasil diupdate',
            'data' => $order
        ]);
    }

    // Menghapus data
    public function destroy($id)
    {
        Order::findOrFail($id)->delete();

        return response()->json([
            'message' => 'Booking laundry berhasil dihapus'
        ]);
    }
}