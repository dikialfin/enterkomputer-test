<?php

use App\Http\Controllers\Transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::post("/order", [Transaction::class,"order"]);
Route::get("/order", [Transaction::class,"bill"]);
