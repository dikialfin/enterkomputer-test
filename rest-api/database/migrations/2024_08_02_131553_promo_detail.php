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
        Schema::create('promo_detail', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("id_promo");
            $table->unsignedBigInteger("id_produk");
            $table->timestamps();

            $table->foreign("id_promo")->references('id')->on('promo');
            $table->foreign("id_produk")->references('id')->on('produk');
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
