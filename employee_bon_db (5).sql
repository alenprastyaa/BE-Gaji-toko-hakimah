

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE `bons` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tanggal` date NOT NULL,
  `jumlahBon` decimal(10,2) NOT NULL,
  `keperluan` text NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `bons` (`id`, `tanggal`, `jumlahBon`, `keperluan`, `userId`, `createdAt`, `updatedAt`) VALUES
('58c370df-edea-4dcb-a2ed-7345e3ba2b3e', '2025-06-06', 120000.00, 'beli baju', '77afa1f6-a901-451c-a2dd-296229353d18', '2025-06-06 22:49:57', '2025-06-06 22:49:57');


CREATE TABLE `cutis` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tanggalMulai` date NOT NULL,
  `tanggalSelesai` date NOT NULL,
  `jenisCuti` varchar(255) NOT NULL,
  `keperluan` text DEFAULT NULL,
  `disetujui` tinyint(1) DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `cutis` (`id`, `userId`, `tanggalMulai`, `tanggalSelesai`, `jenisCuti`, `keperluan`, `disetujui`, `createdAt`, `updatedAt`) VALUES
('31f0f2b5-5115-4906-ae9f-790aa403a35e', '70d52649-cbb1-49d1-b81d-b777a2891929', '2025-06-04', '2025-06-18', 'Sakit', 're', 1, '2025-06-06 13:09:30', '2025-06-06 13:13:10'),
('5bad415f-ffe4-4df3-b955-8c9868173369', '70d52649-cbb1-49d1-b81d-b777a2891929', '2025-06-01', '2025-06-27', 'Lain-lain', 'alen cuti', 1, '2025-06-06 13:03:09', '2025-06-06 13:13:19'),
('f331d334-a604-4310-960a-8a22e315d02a', '70d52649-cbb1-49d1-b81d-b777a2891929', '2024-07-01', '2024-07-05', 'Tahunan', 'Liburan keluarga ke Bandung', 1, '2025-06-06 12:40:23', '2025-06-06 12:52:42'),
('f3fce27d-2229-441f-b01e-097f1e8561dd', '77afa1f6-a901-451c-a2dd-296229353d18', '2025-06-04', '2025-06-05', 'Ijin Cuti', 'Pergi ke mall', 1, '2025-06-06 13:14:17', '2025-06-06 13:14:27');


CREATE TABLE `users` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('karyawan','admin') DEFAULT 'karyawan',
  `namaLengkap` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `tanggalMasukKerja` date NOT NULL,
  `gaji` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `users` (`id`, `username`, `password`, `role`, `namaLengkap`, `createdAt`, `updatedAt`, `tanggalMasukKerja`, `gaji`) VALUES
('697c55be-6544-4e66-b33e-6b10cbdb5ac0', 'admin', '$2b$10$jdkV2sO8YQVtLmNfqgQ3gemacWCP1hKFkus5CcMmcNEp6ECrXzEd6', 'admin', 'Admin Perusahaan', '2025-06-04 13:00:14', '2025-06-06 11:53:09', '2025-06-03', 2000000.00),
('70d52649-cbb1-49d1-b81d-b777a2891929', 'alen', '$2b$10$eObMsroUeFY6Qf8w6ZZH4eVsRjq6zd1KII8BmEM7rWl3M1jaVmij6', 'karyawan', 'alen prastyaa', '2025-06-04 14:50:22', '2025-06-06 12:26:19', '2024-07-11', 2500000.00),
('77afa1f6-a901-451c-a2dd-296229353d18', 'tes', '$2b$10$RqtP7bc2HfAfEaYE0/i0WewOsG/7yy2ceL97wOqlg5BM0OtbDzHBu', 'karyawan', 'tes', '2025-06-04 15:02:39', '2025-06-06 11:53:22', '2025-03-07', 12000000.00);

ALTER TABLE `bons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

ALTER TABLE `cutis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `username_2` (`username`),
  ADD UNIQUE KEY `username_3` (`username`),
  ADD UNIQUE KEY `username_4` (`username`),
  ADD UNIQUE KEY `username_5` (`username`),
  ADD UNIQUE KEY `username_6` (`username`),
  ADD UNIQUE KEY `username_7` (`username`),
  ADD UNIQUE KEY `username_8` (`username`),
  ADD UNIQUE KEY `username_9` (`username`),
  ADD UNIQUE KEY `username_10` (`username`),
  ADD UNIQUE KEY `username_11` (`username`),
  ADD UNIQUE KEY `username_12` (`username`),
  ADD UNIQUE KEY `username_13` (`username`),
  ADD UNIQUE KEY `username_14` (`username`),
  ADD UNIQUE KEY `username_15` (`username`),
  ADD UNIQUE KEY `username_16` (`username`),
  ADD UNIQUE KEY `username_17` (`username`),
  ADD UNIQUE KEY `username_18` (`username`),
  ADD UNIQUE KEY `username_19` (`username`),
  ADD UNIQUE KEY `username_20` (`username`),
  ADD UNIQUE KEY `username_21` (`username`),
  ADD UNIQUE KEY `username_22` (`username`),
  ADD UNIQUE KEY `username_23` (`username`),
  ADD UNIQUE KEY `username_24` (`username`),
  ADD UNIQUE KEY `username_25` (`username`),
  ADD UNIQUE KEY `username_26` (`username`),
  ADD UNIQUE KEY `username_27` (`username`),
  ADD UNIQUE KEY `username_28` (`username`),
  ADD UNIQUE KEY `username_29` (`username`),
  ADD UNIQUE KEY `username_30` (`username`),
  ADD UNIQUE KEY `username_31` (`username`),
  ADD UNIQUE KEY `username_32` (`username`),
  ADD UNIQUE KEY `username_33` (`username`),
  ADD UNIQUE KEY `username_34` (`username`),
  ADD UNIQUE KEY `username_35` (`username`),
  ADD UNIQUE KEY `username_36` (`username`),
  ADD UNIQUE KEY `username_37` (`username`),
  ADD UNIQUE KEY `username_38` (`username`);

ALTER TABLE `bons`
  ADD CONSTRAINT `bons_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;


ALTER TABLE `cutis`
  ADD CONSTRAINT `cutis_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

