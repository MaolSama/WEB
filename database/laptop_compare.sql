-- =========================================================
-- CompareDeck - Database Laptop Comparison
-- Berisi struktur asli (kebutuhan, laptop, rule_kebutuhan)
-- + tabel users (tambahan untuk fitur login admin)
-- =========================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `laptop_compare` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `laptop_compare`;

-- --------------------------------------------------------
-- Tabel `kebutuhan`
-- --------------------------------------------------------
CREATE TABLE `kebutuhan` (
  `kebutuhan_id` int(11) NOT NULL,
  `nama_kebutuhan` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `kebutuhan` (`kebutuhan_id`, `nama_kebutuhan`) VALUES
(1, 'Programming'),
(2, 'Data Science'),
(3, 'Design Graphics'),
(4, 'Gaming'),
(5, 'Office');

-- --------------------------------------------------------
-- Tabel `laptop`
-- --------------------------------------------------------
CREATE TABLE `laptop` (
  `laptop_id` int(11) NOT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `spec_rating` int(11) DEFAULT NULL,
  `processor` varchar(150) DEFAULT NULL,
  `cpu` varchar(100) DEFAULT NULL,
  `ram_gb` int(11) DEFAULT NULL,
  `ram_type` varchar(150) DEFAULT NULL,
  `storage_gb` int(11) DEFAULT NULL,
  `rom_type` varchar(100) DEFAULT NULL,
  `gpu` varchar(150) DEFAULT NULL,
  `display_size` varchar(50) DEFAULT NULL,
  `resolution_width` int(11) DEFAULT NULL,
  `resolution_height` int(11) DEFAULT NULL,
  `warranty` int(11) DEFAULT NULL,
  `os` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `laptop` (`laptop_id`, `brand`, `name`, `price`, `spec_rating`, `processor`, `cpu`, `ram_gb`, `ram_type`, `storage_gb`, `rom_type`, `gpu`, `display_size`, `resolution_width`, `resolution_height`, `warranty`, `os`) VALUES
(1, 'Samsung', 'Galaxy Book2 15 Laptop', 74990, 65, '12th Gen Intel Core i7 1255U', '10 Cores (2P + 8E), 12 Threads', 16, 'LPDDR4', 512, 'SSD', 'Intel Iris Xe Graphics', '15', 1920, 1080, 1, 'Windows 11 OS'),
(2, 'Asus', 'Zenbook 14 OLED 2023 UM3402YA-KM741WS Laptop', 90990, 70, '7th Gen AMD Ryzen 7 7730U', 'Octa Core, 16 Threads', 16, 'LPDDR4X', 512, 'SSD', 'AMD Radeon AMD', '14', 2880, 1800, 1, 'Windows 11 OS'),
(3, 'Acer', 'Nitro V ANV15-51 UN.QNASI.002 Gaming Laptop', 62990, 64, '13th Gen Intel Core i5 13420H', 'Octa Core (4P + 4E), 12 Threads', 16, 'DDR5', 512, 'SSD', '4GB NVIDIA GeForce RTX 2050', '15', 1920, 1080, 1, 'Windows 11 OS'),
(4, 'HP', '15s-eq2132AU Laptop', 43990, 63, '5th Gen AMD Ryzen 5 5500U', 'Hexa Core, 12 Threads', 16, 'DDR4', 512, 'SSD', 'AMD Radeon AMD', '15', 1920, 1080, 1, 'Windows 11 OS'),
(5, 'Asus', 'Zenbook Flip 14 OLED UP5401ZA-KU741WS Laptop', 94990, 75, '12th Gen Intel Core i7 12700H', '14 Cores (6P + 8E), 20 Threads', 16, 'LPDDR5', 512, 'SSD', 'Intel Integrated Iris Xe', '14', 3840, 2400, 1, 'Windows 11 OS'),
(6, 'Asus', 'Vivobook 14X OLED 2023 K3405VCB-KM542WS Laptop', 93980, 70, '13th Gen Intel Core i5 13500H', '12 Cores (4P + 8E), 16 Threads', 16, 'DDR4', 512, 'SSD', '4GB NVIDIA Geforce RTX 3050', '14', 2880, 1800, 1, 'Windows 11 OS'),
(7, 'Dell', 'Inspiron 5518 D560667WIN9S Laptop', 67999, 65, '11th Gen Intel Core i5 11320H', 'Quad Core, 8 Threads', 16, 'DDR4', 512, 'SSD', '2GB NVIDIA GeForce MX450', '15', 1920, 1080, 1, 'Windows 11 OS'),
(8, 'HP', 'Envy x360 13-bf0121TU  Laptop', 85490, 71, '12th Gen Intel Core i5 1230U', '10 Cores, 12 Threads', 16, 'LPDDR4X', 512, 'SSD', 'Intel Integrated Iris Xe', '13', 1920, 1200, 1, 'Windows 11 OS'),
(9, 'Lenovo', 'IdeaPad Slim 5 82XE0072IN Laptop', 63990, 69, '7th Gen AMD Ryzen 7 7730U', 'Octa Core, 16 Threads', 16, 'DDR4', 512, 'SSD', 'AMD Integrated SoC', '14', 1920, 1200, 1, 'Windows 11 OS'),
(10, 'Lenovo', 'IdeaPad 5 15ITL05 82FG01UUIN Laptop', 74888, 64, 'Intel Core i7', 'Quad Core, 8 Threads', 16, 'DDR4', 512, 'SSD', '2GB NVIDIA GeForce MX450', '15', 1920, 1080, 1, 'Windows 11 OS'),
(11, 'Acer', 'Aspire 5 A515-58GM 15 2023 Gaming Laptop', 64990, 65, '13th Gen Intel Core i5 13420H', 'Octa Core (4P + 4E), 12 Threads', 16, 'DDR4', 512, 'SSD', '4GB NVIDIA GeForce RTX 2050', '15', 1920, 1080, 1, 'Windows 11 OS'),
(12, 'Asus', 'Vivobook S14 OLED S3402ZA-KM501WS Laptop', 72490, 62, '12th Gen Intel Core i5 12500H', '12 Cores (4P + 8E), 16 Threads', 16, 'DDR4', 512, 'SSD', 'Intel Iris Xe Graphics', '14', 2880, 1800, 1, 'Windows 11 OS'),
(13, 'Asus', 'Vivobook 16X 2023 K3605ZU-MB541WS Laptop', 89990, 75, '12th Gen Intel Core i5 12450H', 'Octa Core (4P + 4E), 12 Threads', 16, 'DDR4', 512, 'SSD', '6GB NVIDIA Geforce RTX 4050', '16', 1920, 1200, 1, 'Windows 11 OS'),
(14, 'Asus', 'Vivobook Pro 15 OLED M3500QC-L1502WS Gaming Laptop', 72990, 66, '5th Gen AMD Ryzen 5 5600H', 'Hexa Core, 12 Threads', 16, 'DDR4', 512, 'SSD', '4GB NVIDIA GeForce RTX 3050', '15', 1920, 1080, 1, 'Windows 11 OS'),
(15, 'Xiaomi', 'Mi Notebook Pro X 15 Laptop', 79990, 65, '11th Gen Intel Core i5 11300H ', 'Quad Core, 8 Threads', 16, 'LPDDR4x', 512, 'SSD', 'Intel Iris Xe Graphics', '15', 2160, 3456, 1, 'Windows 10  OS'),
(16, 'Fujitsu', 'UH-X ?4ZR1L12857 Laptop', 74990, 66, '13th Gen Intel Core i5 1335U', '10 Cores (2P + 8E), 12 Threads', 16, 'LPDDR5', 512, 'SSD', 'Intel Iris Xe Graphics', '14', 1920, 1200, 2, 'Windows 11 OS'),
(17, 'Asus', 'Zenbook S13 OLED 2023 UX5304VA-NQ542WS Laptop', 79990, 64, '13th Gen Intel Core i5 1335U', '10 Cores (2P + 8E), 12 Threads', 16, 'LPDDR5', 512, 'SSD', 'Intel Integrated Intel Iris Xe Graphics', '13', 2880, 1800, 1, 'Windows 11 OS'),
(18, 'Acer', 'Nitro 5 AN515-47 Gaming Laptop', 79990, 72, '7th Gen AMD Ryzen 7 7735HS', 'Octa Core, 16 Threads', 16, 'DDR5', 512, 'SSD', '4GB NVIDIA GeForce RTX 3050', '15', 1920, 1080, 1, 'Windows 11 OS'),
(19, 'Lenovo', 'LOQ 15IRH8 82XV00BQIN 2023 Gaming Laptop', 96990, 67, '13th Gen Intel Core i7 13620H', '10 Cores (6P + 4E), 16 Threads', 16, 'DDR5', 512, 'SSD', '6GB NVIDIA GeForce RTX 4050', '15', 1920, 1080, 1, 'Windows 11 OS'),
(20, 'HP', 'Victus 15-fa0666TX Gaming Laptop', 68990, 65, '12th Gen Intel Core i5 12450H', 'Octa Core (4P + 4E), 12 Threads', 16, 'DDR4', 512, 'SSD', '4GB NVIDIA GeForce RTX 3050', '15', 1920, 1080, 1, 'Windows 11 OS'),
(32, 'Samsung', 'Galaxy Book 3 Ultra NP960XFH-XA1IN Laptop', 281990, 82, '13th Gen Intel Core i9 13900H', '14 Cores (6P + 8E), 20 Threads', 32, 'LPDDR5', 1024, 'SSD', 'NVIDIA GeForce RTX 4070', '16', 2880, 1800, 1, 'Windows 11 OS'),
(33, 'Acer', 'Nitro 5 AN515-58 NH.QFSSI.001 Gaming Laptop', 96990, 77, '12th Gen Intel Core i7 12650H', '10 Cores (6P + 4E), 16 Threads', 16, 'DDR4', 1024, 'SSD', '8GB NVIDIA GeForce RTX 3070 Ti', '15', 2560, 1440, 1, 'Windows 11 OS'),
(34, 'Asus', 'Vivobook Pro 15 OLED M6500QC-LK541WS Laptop', 67990, 62, '5th Gen AMD Ryzen 5 5600H', 'Hexa Core, 12 Threads', 16, 'DDR4', 512, 'SSD', '4GB NVIDIA GeForce RTX 3050 GPU', '15', 1920, 1080, 1, 'Windows 11 OS'),
(35, 'Asus', 'ROG Zephyrus Duo 16 2022 GX650RXZ-LO227WS Gaming Laptop', 339990, 85, '6th Gen AMD Ryzen 9  6900HX', 'Octa Core, 16 Threads', 32, 'DDR5', 2048, 'SSD', '16GB NVIDIA GeForce RTX 3080 Ti', '16', 2560, 1600, 1, 'Windows 11 OS'),
(36, 'Acer', 'Predator Helios Neo 16 PHN16-71 Gaming Laptop', 114499, 75, '13th Gen Intel Core i7 13700HX', '16 Cores (8P + 8E), 24 Threads', 16, 'DDR5', 1024, 'SSD', '6GB NVIDIA GeForce RTX 4050', '16', 1920, 1200, 1, 'Windows 11 OS'),
(37, 'MSI', 'Thin GF63 11UC-1490IN Gaming Laptop', 57990, 73, '11th Gen Intel Core i5 11260H', 'Hexa Core, 12 Threads', 16, 'DDR4', 1024, 'Hard-Disk', '4GB NVIDIA GeForce RTX 3050', '15', 1920, 1080, 1, 'Windows 11 OS'),
(38, 'Lenovo', 'IdeaPad 5 15ITL05 82FG01UUIN Laptop', 74888, 64, 'Intel Core i7', 'Quad Core, 8 Threads', 16, 'DDR4', 512, 'SSD', '2GB NVIDIA GeForce MX450', '15', 1920, 1080, 1, 'Windows 11 OS'),
(39, 'Lenovo', 'Legion Slim 5 16APH8 82Y90042IN Gaming Laptop', 127990, 83, '7th Gen AMD Ryzen 7 7840HS', 'Octa Core, 16 Threads', 16, 'DDR5', 512, 'SSD', '8GB NVIDIA GeForce RTX 4060', '16', 2560, 1600, 1, 'Windows 11 OS'),
(40, 'Dell', 'Alienware x14 R2 Gaming Laptop', 208990, 72, '13th Gen Intel Core i7 13620H', '10 Cores (6P + 4E), 16 Threads', 16, 'LPDDR5', 1024, 'SSD', '6GB NVIDIA GEFORCE RTX 4050', '14', 2560, 1600, 1, 'Windows 11 OS'),
(107, 'Asus', 'Vivobook 15 X1504ZA-NJ321WS Laptop', 37980, 69, '12th Gen Intel Core i3 1215U', 'Hexa Core (2P + 4E), 8 Threads', 8, 'DDR4', 512, 'SSD', 'Integrated Intel UHD Graphics', '15', 1920, 1080, 1, 'Windows 11 OS'),
(108, 'Acer', 'Aspire Lite 15 AL15-51 2023  Laptop', 45999, 64, '11th Gen Intel Core i5 1155G7', 'Quad Core, 8 Threads', 16, 'DDR4', 1024, 'SSD', 'Intel Iris Xe Graphics', '15', 1920, 1080, 1, 'Windows 11 OS'),
(109, 'HP', 'Victus 15-fa1145TX Gaming Laptop', 64990, 72, '12th Gen Intel Core i5 12450H', 'Octa Core (4P + 4E), 12 Threads', 16, 'DDR4', 1024, 'SSD', '4GB NVIDIA GeForce RTX 2050', '15', 1920, 1080, 1, 'Windows 11 OS'),
(110, 'Xiaomi', 'Notebook Pro 120G Laptop', 72422, 68, '12th Gen Intel Core i5 12450H ', 'Octa Core, 12 Threads', 16, 'LPDDR5', 512, 'SSD', 'Intel UHD Graphics', '14', 2560, 1600, 1, 'Windows 11 OS'),
(111, 'Asus', 'Vivobook 15X 2023 K3504VAB-NJ321WS Laptop', 44990, 69, '13th Gen ?Intel Core i3 1315U', 'Hexa Core (2P + 4E), 8 Threads', 8, 'DDR4', 512, 'SSD', 'Integrated Intel UHD Graphics', '15', 1920, 1080, 1, 'Windows 11 OS'),
(112, 'Dell', 'Inspiron 14 5430 2023 Laptop', 67000, 60, '13th Gen Intel Core i5 1335U', '10 Cores (2P + 8E), 12 Threads', 8, 'LPDDR5', 1024, 'SSD', 'Intel Iris Xe Graphics', '14', 1920, 1200, 1, 'Windows 11 OS'),
(113, 'Lenovo', 'Legion 5 Pro 82JQ010EIN Laptop', 103395, 77, '5th Gen AMD Ryzen 7 5800H', 'Octa Core, 16 Threads', 16, 'DDR4', 512, 'SSD', '6GB NVIDIA GeForce RTX 3060', '16', 2560, 1600, 1, 'Windows 11 OS'),
(125, 'Acer', 'Aspire 5 A515-57G Gaming Laptop', 52128, 66, '12th Gen Intel Core i5 1240P', '12 Cores (4P + 8E), 16 Threads', 8, 'DDR4', 512, 'SSD', '4GB NVIDIA GeForce RTX 2050', '15', 1920, 1080, 1, 'Windows 11 OS'),
(126, 'Dell', 'Latitude 3430 Laptop', 108000, 60, '12th Gen Intel Core i5 1235U', '10 Cores (2P + 8E), 12 Threads', 8, 'DDR4', 512, 'SSD', 'Intel Iris Xe Graphics', '14', 1366, 768, 1, 'Windows 11 OS'),
(127, 'HP', '255 G9 841W6PA Laptop', 26990, 69, '3rd Gen AMD Ryzen 3  3250U', 'Dual Core, 4 Threads', 8, 'DDR4', 512, 'SSD', 'AMD Radeon Graphics', '15', 1366, 768, 1, 'DOS 3.0 OS'),
(128, 'Lenovo', 'IdeaPad Slim 5 82XE004RIN Laptop', 58990, 64, '7th Gen AMD Ryzen 5 7530U', 'Hexa Core, 12 Threads', 16, 'DDR4', 512, 'SSD', 'AMD Integrated SoC', '14', 1920, 1200, 1, 'Windows 11 OS'),
(129, 'Lenovo', 'V15 G3 82TTA00VIH Laptop', 33590, 69, '12th Gen Intel Core i3 1215U', 'Hexa Core (2P + 4E), 8 Threads', 8, 'DDR4', 512, 'SSD', 'Intel Integrated UHD', '15', 1920, 1080, 1, 'Windows 11 OS'),
(130, 'Acer', 'Aspire 3 A315-59 Laptop', 39990, 69, '12th Gen Intel Core i5 1235U', '10 Cores (2P + 8E), 12 Threads', 8, 'DDR4', 512, 'SSD', 'Intel Iris Xe Graphics ', '15', 1920, 1080, 1, 'Windows 11 OS'),
(131, 'Asus', 'Vivobook Go 14 2023 E1404FA-NK542WS Laptop', 49990, 69, '7th Gen AMD Ryzen 5 7520U', 'Quad Core, 8 Threads', 16, 'LPDDR5', 512, 'SSD', 'AMD Radeon AMD', '14', 1920, 1080, 1, 'Windows 11 OS'),
(132, 'Asus', 'ROG Strix G17 G713RC-HX109WS Gaming Laptop', 86189, 71, '6th Gen AMD Ryzen 7 6800H', 'Octa Core, 16 Threads', 16, 'DDR5', 512, 'SSD', '4GB NVIDIA GeForce RTX 3050', '17', 1920, 1080, 1, 'Windows 11 OS'),
(133, 'HP', 'Dragonfly G4 Laptop', 231746, 71, '13th Gen Intel Core i7 1365U', '10 Cores (2P + 8E), 12 Threads', 16, 'LPDDR5', 512, 'SSD', 'Intel Iris Xe Graphics', '13', 1920, 1280, 1, 'Windows 11 OS'),
(134, 'Zebronics', 'Pro Series Z ZEB-NBC 4S 2023 Laptop', 39990, 66, '12th Gen Intel Core i5 1235U', '10 Cores (2P + 8E), 12 Threads', 8, 'DDR4', 512, 'SSD', 'Intel Integrated', '15', 1920, 1080, 1, 'Windows 11 OS'),
(135, 'Lenovo', 'IdeaPad Gaming 3 15IHU6 82K101EDIN Laptop', 60990, 67, '11th Gen Intel Core i5 11300H', 'Quad Core, 8 Threads', 8, 'DDR4', 512, 'SSD', '4GB NVIDIA GeForce RTX 3050 Graphics', '15', 1920, 1080, 1, 'Windows 11 OS'),
(136, 'Dell', 'Vostro 3425 Laptop', 37990, 69, '5th Gen AMD Ryzen 5 5500U', 'Hexa Core, 12 Threads', 8, 'DDR4', 512, 'SSD', 'AMD Radeon Graphics', '14', 1920, 1080, 1, 'Windows 11 OS'),
(137, 'HP', '15s-fq2672TU Laptop', 34999, 60, '11th Gen Intel Core i3 1115G4', 'Dual Core, 4 Threads', 8, 'DDR4', 512, 'SSD', 'Intel Integrated UHD', '15', 1920, 1080, 1, 'Windows 11 OS'),
(138, 'Asus', 'Vivobook 15 X1504ZA-NJ325WS Laptop', 40990, 69, '12th Gen Intel Core i3 1215U', 'Hexa Core (2P + 4E), 8 Threads', 8, 'DDR4', 512, 'SSD', 'Integrated Intel UHD Graphics', '15', 1920, 1080, 1, 'Windows 11 OS'),
(139, 'HP', 'Victus15-fb0147AX Gaming Laptop', 47990, 62, '5th Gen AMD Ryzen 5  5600H', 'Hexa Core, 12 Threads', 8, 'DDR4', 512, 'SSD', '4GB AMD Radeon AMD Radeon RX 6500M', '15', 1920, 1080, 1, 'Windows 11 OS'),
(140, 'Zebronics', 'Pro Series Z ZEB-NBC 4S Laptop', 42990, 69, '12th Gen Intel Core i5 1235U', '10 Cores (2P + 8E), 12 Threads', 16, 'DDR4', 512, 'SSD', 'Intel Integrated', '15', 1920, 1080, 1, 'Windows 11 OS'),
(141, 'Asus', 'VivoBook 14 X415EA-EK344WS Notebook', 35990, 64, '11th Gen Intel Core i3 1115G4', 'Dual Core, 4 Threads', 16, 'DDR4', 512, 'SSD', 'Intel Integrated Intel UHD', '14', 1920, 1080, 1, 'Windows 11 OS'),
(142, 'HP', '250 G9 701H5PA Laptop', 67990, 66, '12th Gen Intel Core i5 1235U', '10 Cores (2P + 8E), 12 Threads', 16, 'DDR4', 512, 'SSD', 'Intel Iris Xe Graphics', '15', 1920, 1080, 1, 'Windows 11 OS'),
(143, 'Dell', 'Vostro 3420 Laptop', 52990, 63, '11th Gen Intel Core i5 1135G7', 'Quad Core, 8 Threads', 16, 'DDR4', 512, 'SSD', 'Intel Graphics', '14', 1920, 1080, 1, 'Windows 11 OS'),
(144, 'Samsung', 'Galaxy Book 3 Laptop', 69990, 69, '13th Gen Intel Core i5 1340P', '12 Cores (4P + 8E), 16 Threads', 8, 'LPDDR5', 512, 'SSD', 'Intel Iris Xe Graphics', '14', 1920, 1080, 1, 'Windows 11 OS');

-- --------------------------------------------------------
-- Tabel `rule_kebutuhan`
-- --------------------------------------------------------
CREATE TABLE `rule_kebutuhan` (
  `kebutuhan_id` int(11) NOT NULL,
  `min_ram` int(11) DEFAULT NULL,
  `min_storage` int(11) DEFAULT NULL,
  `gpu_required` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `rule_kebutuhan` (`kebutuhan_id`, `min_ram`, `min_storage`, `gpu_required`) VALUES
(1, 8, 256, 0),
(2, 16, 512, 0),
(3, 16, 256, 1),
(4, 8, 256, 1),
(5, 8, 128, 0);

-- --------------------------------------------------------
-- Tabel `users` (TAMBAHAN: untuk fitur login admin)
-- --------------------------------------------------------
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'admin',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Catatan: akun admin TIDAK di-insert di sini karena password harus
-- di-hash oleh PHP (password_hash). Jalankan setup.php sekali setelah
-- import database ini untuk membuat akun admin pertama. Lihat README.md.

-- --------------------------------------------------------
-- Indexes & Constraints
-- --------------------------------------------------------
ALTER TABLE `kebutuhan` ADD PRIMARY KEY (`kebutuhan_id`);
ALTER TABLE `laptop` ADD PRIMARY KEY (`laptop_id`);
ALTER TABLE `rule_kebutuhan` ADD PRIMARY KEY (`kebutuhan_id`);

ALTER TABLE `kebutuhan` MODIFY `kebutuhan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
ALTER TABLE `laptop` MODIFY `laptop_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

ALTER TABLE `rule_kebutuhan`
  ADD CONSTRAINT `fk_kebutuhan` FOREIGN KEY (`kebutuhan_id`) REFERENCES `kebutuhan` (`kebutuhan_id`);

COMMIT;
