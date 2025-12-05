-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 07, 2025 at 06:24 AM
-- Server version: 10.11.11-MariaDB-cll-lve
-- PHP Version: 8.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `siph9866_kimahdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

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

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `namaLengkap`, `createdAt`, `updatedAt`, `tanggalMasukKerja`, `gaji`) VALUES
('15044685-cb3c-4ad9-8b5f-1a4f7958e494', 'rafi', '$2b$10$7/iMV3T1v.3BCtb8wk42bO5OBrj0j.//ExB3iozAp87qHtWDlr2de', 'karyawan', 'Rafi', '2025-06-06 23:21:09', '2025-06-06 23:21:09', '2025-06-07', 0.00),
('4148dfcb-f91e-468e-a07a-e2d3d8cbd911', 'toni', '$2b$10$ttNtYuXcVEGLaEgHIs1cfu2pvH9kfFeCPW5BGrdfcvf0toemV4Ofm', 'karyawan', 'Toni', '2025-06-06 23:20:53', '2025-06-06 23:20:53', '2025-06-07', 0.00),
('460432c8-1209-43f9-b3e2-e3a23a788733', 'juman', '$2b$10$RB5J6pYDXQXnzw8lAiw9g.aJ6BBnttN5nE6ZZ7Ei8u8z8zoxq8gFK', 'karyawan', 'Juman', '2025-06-06 23:19:07', '2025-06-06 23:19:07', '2025-06-01', 0.00),
('65924e9c-f2b2-4e7f-93ca-93b8059e92c3', 'wida', '$2b$10$2YDnVE5bJLopdh4ekNdc3uOuFsx1Hv3YuY3Daafbw7glnK1BCYmxi', 'karyawan', 'Wida', '2025-06-06 23:20:38', '2025-06-06 23:20:38', '2025-06-07', 0.00),
('697c55be-6544-4e66-b33e-6b10cbdb5ac0', 'admin', '$2b$10$jdkV2sO8YQVtLmNfqgQ3gemacWCP1hKFkus5CcMmcNEp6ECrXzEd6', 'admin', 'Admin Perusahaan', '2025-06-04 13:00:14', '2025-06-06 11:53:09', '2025-06-03', 2000000.00),
('6aa6bfc0-2256-4ac6-ba8f-95651b9f9e30', 'andis', '$2b$10$Zmt91hY4tCbjqW9MrVYWi.PKGzdjYMErtqebmvETksm5AIKcL36V6', 'karyawan', 'Andis', '2025-06-06 23:19:45', '2025-06-06 23:19:45', '2025-06-07', 0.00),
('70d52649-cbb1-49d1-b81d-b777a2891929', 'alen', '$2b$10$eObMsroUeFY6Qf8w6ZZH4eVsRjq6zd1KII8BmEM7rWl3M1jaVmij6', 'karyawan', 'alen prastyaa', '2025-06-04 14:50:22', '2025-06-06 12:26:19', '2024-07-11', 2500000.00),
('77afa1f6-a901-451c-a2dd-296229353d18', 'tes', '$2b$10$RqtP7bc2HfAfEaYE0/i0WewOsG/7yy2ceL97wOqlg5BM0OtbDzHBu', 'karyawan', 'tes', '2025-06-04 15:02:39', '2025-06-06 11:53:22', '2025-03-07', 12000000.00),
('9657b25c-f043-4d68-9769-8f7a8a0bdee9', 'agung', '$2b$10$wIP2tniY6HC6y.F5KYu9rOviWPWfnzq7S4nTtyWqD8OmaQV6HsyUC', 'karyawan', 'Agung', '2025-06-06 23:20:21', '2025-06-06 23:20:21', '2025-06-07', 0.00),
('b06a770e-9f3b-4197-bca6-1ae1c25c0fa1', 'rizky', '$2b$10$LjMmf/YkiuItWxOdDE203OkHJOaXoXyy1R3uR21S4em.Qkz2.ybs.', 'karyawan', 'Rizky', '2025-06-06 23:21:26', '2025-06-06 23:21:26', '2025-06-07', 0.00),
('dde16bd4-8195-42f8-8af8-580afe44c7c3', 'parman', '$2b$10$ei3YKaBcAJQkjoaWn0vbcuQuPRjs6WJ6wXZqyh0W4FJbWTH9/c4Su', 'karyawan', 'Parman', '2025-06-06 23:20:02', '2025-06-06 23:20:02', '2025-06-07', 0.00),
('e51650ec-511f-4560-9cbf-687b825ec491', 'eri', '$2b$10$y./gswsDzTxvPVhfp8D9nuZg4ax77c3dZ/v1sVUBppbhERixsIWLO', 'karyawan', 'Eri', '2025-06-06 23:19:29', '2025-06-06 23:19:29', '2025-06-01', 0.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
