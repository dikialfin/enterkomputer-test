<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class meja extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('meja')->insert([
            'nama' => "MEJA NO 1",
        ]);
        DB::table('meja')->insert([
            'nama' => "MEJA NO 2",
        ]);
        DB::table('meja')->insert([
            'nama' => "MEJA NO 3",
        ]);
    }
}
