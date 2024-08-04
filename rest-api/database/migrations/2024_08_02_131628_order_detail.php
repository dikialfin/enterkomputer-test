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
        Schema::create('order_detail', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("id_order");
            $table->unsignedBigInteger("id_produk")->nullable(true);
            $table->unsignedBigInteger("id_promo")->nullable(true);
            $table->integer("jumlah");
            $table->timestamps();

            $table->foreign("id_order")->references('id')->on('order');
            $table->foreign("id_produk")->references('id')->on('produk');
            $table->foreign("id_promo")->references('id')->on('promo');
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
