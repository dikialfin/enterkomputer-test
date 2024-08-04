<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class promo_detail extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('promo_detail')->insert([
            'id_promo' => 1,
            'id_produk' => 10,
        ]);
        DB::table('promo_detail')->insert([
            'id_promo' => 1,
            'id_produk' => 1,
        ]);
    }
}
