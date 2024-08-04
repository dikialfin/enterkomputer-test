<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('produk', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("id_kategori");
            $table->unsignedBigInteger("id_varian");
            $table->string('nama');
            $table->integer("harga");
            $table->timestamps();

            $table->foreign("id_kategori")->references('id')->on('kategori');
            $table->foreign("id_varian")->references('id')->on('varian');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};
