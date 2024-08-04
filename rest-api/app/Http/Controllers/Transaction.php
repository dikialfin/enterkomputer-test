<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Printer;
use App\Models\mejaModel;
use App\Models\orderDetailModel;
use App\Models\orderModel;
use App\Models\produkModel;
use App\Models\promoDetailModel;
use App\Models\promoModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class Transaction extends Controller
{
    private Printer $printer;

    public function __construct()
    {
        $this->printer = new Printer();
    }

    public function order(Request $request)
    {
        try {
            $rules = [
                "id_meja" => "required|integer",
                "items" => "required|array"
            ];

            $validator = validator($request->input(), $rules);

            if ($validator->fails()) {
                return response([
                    "status_code" => 400,
                    "status" => "failed",
                    "messages" => $validator->errors()
                ], 400);
            }

            $requestData = json_decode($request->getContent(), true);
            $meja = mejaModel::where('id', '=', $requestData['id_meja'])->get();

            if (count($meja) < 1) {
                return response([
                    "status_code" => 400,
                    "status" => "failed",
                    "messages" => ['id_meja' => 'id meja not valid']
                ], 400);
            }

            foreach ($requestData['items'] as $item) {
                if (!array_key_exists('id_produk', $item)) {
                    return response([
                        "status_code" => 400,
                        "status" => "failed",
                        "messages" => ['items' => 'id produk on items is required']
                    ], 400);
                }
                if (!array_key_exists('jumlah', $item)) {
                    return response([
                        "status_code" => 400,
                        "status" => "failed",
                        "messages" => ['items' => 'jumlah on items is required']
                    ], 400);
                }

                $produk = produkModel::where('id', '=', $item['id_produk'])->get();
                if (count($produk) < 1) {
                    return response([
                        "status_code" => 400,
                        "status" => "failed",
                        "messages" => ['items' => 'id produk on items not valid']
                    ], 400);
                }

                if (array_key_exists('id_promo', $item) && $item['id_promo'] != null) {
                    $promo = promoModel::where('id', '=', $item['id_promo'])->get();
                    $productPromo = promoDetailModel::where('id_produk', '=', $item['id_produk'])->where("id_promo", '=', $item['id_promo'])->get();
                    if (count($promo) < 1) {
                        return response([
                            "status_code" => 400,
                            "status" => "failed",
                            "messages" => ['items' => 'id promo on items not valid']
                        ], 400);
                    }
                    if (count($productPromo) < 1) {
                        return response([
                            "status_code" => 400,
                            "status" => "failed",
                            "messages" => ['items' => 'id promo for product id : ' . $item['id_produk'] . " is not valid"]
                        ], 400);
                    }
                }
            }

            return $this->makeOrder(json_decode($request->getContent(), true));
        } catch (\Throwable $th) {
            return response([
                "status_code" => 500,
                "status" => "failed",
                "messages" => ["sorry an error occurred" . $th->getMessage()]
            ], 500);
        }
    }

    private function makeOrder(array $dataOrder)
    {
        try {
            DB::beginTransaction();

            $orderModel = new orderModel();
            $orderModel->id_meja = $dataOrder['id_meja'];
            $orderModel->save();

            foreach ($dataOrder["items"] as $item) {
                $orderDetailModel = new orderDetailModel();
                $orderDetailModel->id_order = $orderModel->id;
                $orderDetailModel->id_produk = $item['id_produk'];
                if (array_key_exists('id_promo', $item) && $item['id_promo'] != null) {
                    $orderDetailModel->id_promo = $item['id_promo'];
                }
                $orderDetailModel->jumlah = $item['jumlah'];
                $orderDetailModel->save();
            }

            DB::commit();

            return response([
                "status_code" => 201,
                "status" => "ok",
                "data" => $this->printer->print($orderModel)
            ], 201);
        } catch (\Throwable $th) {
            DB::rollBack();
            return response([
                "status_code" => 500,
                "status" => "failed",
                "messages" => ["sorry an error occurred" . $th->getMessage()]
            ], 500);
        }
    }

    public function bill(Request $request)
    {
        try {
            $rules = [
                "order_id" => "required|integer",
            ];

            $validator = validator($request->input(), $rules);

            if ($validator->fails()) {
                return response([
                    "status_code" => 400,
                    "status" => "failed",
                    "messages" => $validator->errors()
                ], 400);
            }

            $dataOrder = orderModel::where("order.id", "=", $request->input('order_id'))->get()->first();

            if ($dataOrder == null) {
                return response([
                    "status_code" => 404,
                    "status" => "failed",
                    "messages" => ["order_id" => ["data not found"]]
                ], 404);
            }

            return $this->getBill($dataOrder);
        } catch (\Throwable $th) {
            return response([
                "status_code" => 500,
                "status" => "failed",
                "messages" => ["sorry an error occurred" . $th->getMessage()]
            ], 500);
        }
    }

    private function getBill(orderModel $dataOrder)
    {
        try {
            $dataMeja = mejaModel::where('id', '=', $dataOrder->id_meja)->get()->first();

            $dataProdukNonPromo = orderDetailModel::select(
                "produk.nama as produk_nama",
                "varian.nama as varian_nama",
                "order_detail.jumlah as jumlah",
                "produk.harga as harga_satuan"
            )
                ->join("produk", "produk.id", "=", "order_detail.id_produk")
                ->join("varian", "varian.id", "=", "produk.id_varian")
                ->where("order_detail.id_order", "=", $dataOrder->id)
                ->whereNull("id_promo")
                ->get();

            $dataProdukPromo = orderDetailModel::select(
                DB::raw("DISTINCT order_detail.id_promo"),
                "promo.nama as nama_promo",
                "order_detail.jumlah as jumlah",
                "promo.harga as harga_satuan"
            )
                ->join("promo", "promo.id", "=", "order_detail.id_promo")
                ->where("order_detail.id_order", "=", $dataOrder->id)
                ->whereNotNull("id_promo")
                ->get();

            $rincianProduk = [];
            $totalHarga = 0;

            foreach ($dataProdukNonPromo as $produk) {
                array_push($rincianProduk, [
                    "nama" => $produk->produk_nama . " (" . $produk->varian_nama . ")",
                    "jumlah" => $produk->jumlah,
                    "harga_satuan" => $produk->harga_satuan,
                    "total_harga" => ($produk->harga_satuan * $produk->jumlah)
                ]);
                $totalHarga += ($produk->harga_satuan * $produk->jumlah);
            }

            if (count($dataProdukPromo) > 0) {
                foreach ($dataProdukPromo as $produk) {
                    array_push($rincianProduk, [
                        "nama" => $produk->nama_promo,
                        "jumlah" => $produk->jumlah,
                        "harga_satuan" => $produk->harga_satuan,
                        "total_harga" => ($produk->harga_satuan * $produk->jumlah)
                    ]);
                    $totalHarga += ($produk->harga_satuan * $produk->jumlah);
                }
            }

            $dataBill = [
                "order_id" => $dataOrder->id,
                "nama_meja" => $dataMeja->nama,
                "waktu_pemesanan" => $dataOrder->created_at->format('d/m/y H:i:s'),
                "total_harga" => $totalHarga,
                "rincian" => $rincianProduk
            ];

            return response([
                "status_code" => 200,
                "status" => "ok",
                "data" => $dataBill
            ], 200);
        } catch (\Throwable $th) {
            return response([
                "status_code" => 500,
                "status" => "failed",
                "messages" => ["sorry an error occurred" . $th->getMessage()]
            ], 500);
        }
    }
}
