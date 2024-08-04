<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class printer extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('printer')->insert([
            "nama" => "Printer Kasir"
        ]);
        DB::table('printer')->insert([
            'id_kategori' => 1,
            "nama" => "Printer Dapur"
        ]);
        DB::table('printer')->insert([
            'id_kategori' => 2,
            "nama" => "Printer Bar"
        ]);
    }
}
