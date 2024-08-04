<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class varian extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('varian')->insert([
            'nama' => "dingin",
        ]);
        DB::table('varian')->insert([
            'nama' => "panas",
        ]);
        DB::table('varian')->insert([
            'nama' => "manis",
        ]);
        DB::table('varian')->insert([
            'nama' => "tawar",
        ]);
        DB::table('varian')->insert([
            'nama' => "goreng",
        ]);
        DB::table('varian')->insert([
            'nama' => "kuah",
        ]);
    }
}
