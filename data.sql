/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : enterkomputer

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 04/08/2024 14:33:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache
-- ----------------------------

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for kategori
-- ----------------------------
DROP TABLE IF EXISTS `kategori`;
CREATE TABLE `kategori`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `kategori_nama_unique`(`nama` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kategori
-- ----------------------------
INSERT INTO `kategori` VALUES (1, 'makanan', NULL, NULL);
INSERT INTO `kategori` VALUES (2, 'minuman', NULL, NULL);

-- ----------------------------
-- Table structure for meja
-- ----------------------------
DROP TABLE IF EXISTS `meja`;
CREATE TABLE `meja`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meja
-- ----------------------------
INSERT INTO `meja` VALUES (1, 'MEJA NO 1', NULL, NULL);
INSERT INTO `meja` VALUES (2, 'MEJA NO 2', NULL, NULL);
INSERT INTO `meja` VALUES (3, 'MEJA NO 3', NULL, NULL);

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` VALUES (2, '2024_08_02_131453_kategori', 1);
INSERT INTO `migrations` VALUES (3, '2024_08_02_131502_varian', 1);
INSERT INTO `migrations` VALUES (4, '2024_08_02_131525_produk', 1);
INSERT INTO `migrations` VALUES (5, '2024_08_02_131541_promo', 1);
INSERT INTO `migrations` VALUES (6, '2024_08_02_131553_promo_detail', 1);
INSERT INTO `migrations` VALUES (7, '2024_08_02_131607_meja', 1);
INSERT INTO `migrations` VALUES (8, '2024_08_02_131621_order', 1);
INSERT INTO `migrations` VALUES (9, '2024_08_02_131628_order_detail', 1);
INSERT INTO `migrations` VALUES (10, '2024_08_02_131637_printer', 1);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_meja` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id_meja_foreign`(`id_meja` ASC) USING BTREE,
  CONSTRAINT `order_id_meja_foreign` FOREIGN KEY (`id_meja`) REFERENCES `meja` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, 1, '2024-08-04 07:28:39', '2024-08-04 07:28:39');

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_order` bigint UNSIGNED NOT NULL,
  `id_produk` bigint UNSIGNED NULL DEFAULT NULL,
  `id_promo` bigint UNSIGNED NULL DEFAULT NULL,
  `jumlah` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_detail_id_order_foreign`(`id_order` ASC) USING BTREE,
  INDEX `order_detail_id_produk_foreign`(`id_produk` ASC) USING BTREE,
  INDEX `order_detail_id_promo_foreign`(`id_promo` ASC) USING BTREE,
  CONSTRAINT `order_detail_id_order_foreign` FOREIGN KEY (`id_order`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_detail_id_produk_foreign` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_detail_id_promo_foreign` FOREIGN KEY (`id_promo`) REFERENCES `promo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES (1, 1, 1, NULL, 1, '2024-08-04 07:28:39', '2024-08-04 07:28:39');
INSERT INTO `order_detail` VALUES (2, 1, 6, NULL, 1, '2024-08-04 07:28:39', '2024-08-04 07:28:39');
INSERT INTO `order_detail` VALUES (3, 1, 1, 1, 2, '2024-08-04 07:28:39', '2024-08-04 07:28:39');
INSERT INTO `order_detail` VALUES (4, 1, 10, 1, 2, '2024-08-04 07:28:39', '2024-08-04 07:28:39');
INSERT INTO `order_detail` VALUES (5, 1, 3, NULL, 1, '2024-08-04 07:28:39', '2024-08-04 07:28:39');
INSERT INTO `order_detail` VALUES (6, 1, 8, NULL, 1, '2024-08-04 07:28:39', '2024-08-04 07:28:39');

-- ----------------------------
-- Table structure for printer
-- ----------------------------
DROP TABLE IF EXISTS `printer`;
CREATE TABLE `printer`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_kategori` bigint UNSIGNED NULL DEFAULT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `printer_id_kategori_foreign`(`id_kategori` ASC) USING BTREE,
  CONSTRAINT `printer_id_kategori_foreign` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of printer
-- ----------------------------
INSERT INTO `printer` VALUES (1, NULL, 'Printer Kasir', NULL, NULL);
INSERT INTO `printer` VALUES (2, 1, 'Printer Dapur', NULL, NULL);
INSERT INTO `printer` VALUES (3, 2, 'Printer Bar', NULL, NULL);

-- ----------------------------
-- Table structure for produk
-- ----------------------------
DROP TABLE IF EXISTS `produk`;
CREATE TABLE `produk`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_kategori` bigint UNSIGNED NOT NULL,
  `id_varian` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `produk_id_kategori_foreign`(`id_kategori` ASC) USING BTREE,
  INDEX `produk_id_varian_foreign`(`id_varian` ASC) USING BTREE,
  CONSTRAINT `produk_id_kategori_foreign` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `produk_id_varian_foreign` FOREIGN KEY (`id_varian`) REFERENCES `varian` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of produk
-- ----------------------------
INSERT INTO `produk` VALUES (1, 2, 1, 'Jeruk', 12000, NULL, NULL);
INSERT INTO `produk` VALUES (2, 2, 2, 'Jeruk', 12000, NULL, NULL);
INSERT INTO `produk` VALUES (3, 2, 3, 'Teh', 8000, NULL, NULL);
INSERT INTO `produk` VALUES (4, 2, 4, 'Teh', 5000, NULL, NULL);
INSERT INTO `produk` VALUES (5, 2, 1, 'Kopi', 8000, NULL, NULL);
INSERT INTO `produk` VALUES (6, 2, 2, 'Kopi', 6000, NULL, NULL);
INSERT INTO `produk` VALUES (7, 2, 1, 'EKSTRA ES BATU', 2000, NULL, NULL);
INSERT INTO `produk` VALUES (8, 1, 5, 'Mie', 15000, NULL, NULL);
INSERT INTO `produk` VALUES (9, 1, 6, 'Mie', 15000, NULL, NULL);
INSERT INTO `produk` VALUES (10, 1, 5, 'Nasi Goreng', 15000, NULL, NULL);

-- ----------------------------
-- Table structure for promo
-- ----------------------------
DROP TABLE IF EXISTS `promo`;
CREATE TABLE `promo`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promo
-- ----------------------------
INSERT INTO `promo` VALUES (1, 'Nasi Goreng + Jeruk Dingin', 23000, NULL, NULL);

-- ----------------------------
-- Table structure for promo_detail
-- ----------------------------
DROP TABLE IF EXISTS `promo_detail`;
CREATE TABLE `promo_detail`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_promo` bigint UNSIGNED NOT NULL,
  `id_produk` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `promo_detail_id_promo_foreign`(`id_promo` ASC) USING BTREE,
  INDEX `promo_detail_id_produk_foreign`(`id_produk` ASC) USING BTREE,
  CONSTRAINT `promo_detail_id_produk_foreign` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `promo_detail_id_promo_foreign` FOREIGN KEY (`id_promo`) REFERENCES `promo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promo_detail
-- ----------------------------
INSERT INTO `promo_detail` VALUES (1, 1, 10, NULL, NULL);
INSERT INTO `promo_detail` VALUES (2, 1, 1, NULL, NULL);

-- ----------------------------
-- Table structure for varian
-- ----------------------------
DROP TABLE IF EXISTS `varian`;
CREATE TABLE `varian`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `varian_nama_unique`(`nama` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of varian
-- ----------------------------
INSERT INTO `varian` VALUES (1, 'dingin', NULL, NULL);
INSERT INTO `varian` VALUES (2, 'panas', NULL, NULL);
INSERT INTO `varian` VALUES (3, 'manis', NULL, NULL);
INSERT INTO `varian` VALUES (4, 'tawar', NULL, NULL);
INSERT INTO `varian` VALUES (5, 'goreng', NULL, NULL);
INSERT INTO `varian` VALUES (6, 'kuah', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
