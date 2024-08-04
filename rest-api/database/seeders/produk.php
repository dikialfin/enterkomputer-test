<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class produk extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('produk')->insert([
            'id_kategori' => 2,
            'id_varian' => 1,
            'nama' => "Jeruk",
            'harga' => 12000,
        ]);
        DB::table('produk')->insert([
            'id_kategori' => 2,
            'id_varian' => 2,
            'nama' => "Jeruk",
            'harga' => 12000,
        ]);
        DB::table('produk')->insert([
            'id_kategori' => 2,
            'id_varian' => 3,
            'nama' => "Teh",
            'harga' => 8000,
        ]);
        DB::table('produk')->insert([
            'id_kategori' => 2,
            'id_varian' => 4,
            'nama' => "Teh",
            'harga' => 5000,
        ]);
        DB::table('produk')->insert([
            'id_kategori' => 2,
            'id_varian' => 1,
            'nama' => "Kopi",
            'harga' => 8000,
        ]);
        DB::table('produk')->insert([
            'id_kategori' => 2,
            'id_varian' => 2,
            'nama' => "Kopi",
            'harga' => 6000,
        ]);
        DB::table('produk')->insert([
            'id_kategori' => 2,
            'id_varian' => 1,
            'nama' => "EKSTRA ES BATU",
            'harga' => 2000,
        ]);
        DB::table('produk')->insert([
            'id_kategori' => 1,
            'id_varian' => 5,
            'nama' => "Mie",
            'harga' => 15000,
        ]);
        DB::table('produk')->insert([
            'id_kategori' => 1,
            'id_varian' => 6,
            'nama' => "Mie",
            'harga' => 15000,
        ]);
        DB::table('produk')->insert([
            'id_kategori' => 1,
            'id_varian' => 5,
            'nama' => "Nasi Goreng",
            'harga' => 15000,
        ]);
    }
}
