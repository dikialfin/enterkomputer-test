<?php
namespace App\Http\Controllers;

use App\Models\kategoriModel;
use App\Models\orderDetailModel;
use App\Models\orderModel;
use App\Models\printerModel;
use Illuminate\Support\Facades\DB;

class Printer extends Controller
{
    public function print(orderModel $orderModel) :array
    {

        try {
            $printers = printerModel::select(
                "printer.id as printer_id",
                "printer.nama as printer_nama",
                "kategori.id as kategori_id",
                "kategori.nama as kategori_nama",
            )
                ->leftJoin("kategori", "kategori.id", "=", "printer.id_kategori")
                ->get();

            $listProduk = orderDetailModel::select(
                "produk.id as produk_id",
                "produk.nama as produk_nama",
                "kategori.id as kategori_id",
                "kategori.nama as kategori_nama",
                "varian.id as varian_id",
                "varian.nama as varian_nama",
                DB::raw("sum(order_detail.jumlah) as jumlah")
            )
                ->join("produk", "produk.id", "=", "order_detail.id_produk")
                ->join("kategori", "kategori.id", "=", "produk.id_kategori")
                ->join("varian", "varian.id", "=", "produk.id_varian")
                ->where("id_order", $orderModel->id)
                ->groupBy("order_detail.id_produk")
                ->get();

            $produkPerPrinter = [];

            foreach ($printers as $printer) {
                if ($printer->printer_id != 1 || $printer->printer_nama != "Printer Kasir") {
                    $temporaryPrinter = [
                        "printer_nama" => $printer->printer_nama,
                        "produk" => []
                    ];
                    foreach ($listProduk as $produk) {
                        if ($printer->kategori_id == $produk->kategori_id) {
                            array_push($temporaryPrinter['produk'], [
                                "produk_nama" => $produk->produk_nama,
                                "kategori_nama" => $produk->kategori_nama,
                                "varian_nama" => $produk->varian_nama,
                                "jumlah" => $produk->jumlah
                            ]);
                        }
                    }
                    array_push($produkPerPrinter, $temporaryPrinter);
                }
            }

            return $produkPerPrinter;
        } catch (\Throwable $th) {
            return response([
                "status_code" => 500,
                "status" => "failed",
                "messages" => ["sorry an error occurred" . $th->getMessage()]
            ],500);
        }
    }
}
