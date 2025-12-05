-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 06, 2025 at 08:20 PM
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
-- Table structure for table `Bons`
--

CREATE TABLE `Bons` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tanggal` date NOT NULL,
  `jumlahBon` decimal(10,2) NOT NULL,
  `keperluan` text NOT NULL,
  `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Bons`
--

INSERT INTO `Bons` (`id`, `tanggal`, `jumlahBon`, `keperluan`, `userId`, `createdAt`, `updatedAt`) VALUES
('0d0b45f5-4c5d-4102-b147-93f8fc8bc68b', '2025-05-04', 350000.00, 'Membeli Roko', '1a7bd658-6749-4644-8efc-688a0977f747', '2025-06-05 04:05:39', '2025-06-05 04:05:39'),
('18d05d14-3aa3-4894-bef9-a7e03ac00a61', '2025-05-04', 314000.00, 'Membeli Roko', 'b83cba26-6321-4024-ad8b-6a8ea3320996', '2025-06-05 04:10:04', '2025-06-05 04:10:04'),
('19ccd388-8a7c-4ccb-8af0-c465318d99a3', '2025-05-04', 2400000.00, '-', '3230b5a9-e5ae-4945-8a36-6dedd8274afb', '2025-06-05 04:01:31', '2025-06-05 04:01:31'),
('3eed371b-7952-4d81-a9e0-57227603336c', '2025-05-04', 1500000.00, '-', 'fc8c2249-e4c4-4380-82d4-c1b575be78bd', '2025-06-05 04:19:23', '2025-06-05 04:19:23'),
('43310f76-b24f-4e61-844b-66150093e901', '2025-05-04', 192500.00, 'Membeli Roko', 'fc88d4ab-5979-4ad8-823b-6cd4345b2b1b', '2025-06-05 04:03:02', '2025-06-05 04:03:02'),
('46dd23e7-5c2f-48e7-8f72-d531b141eea0', '2025-05-04', 1500000.00, '-', 'fc88d4ab-5979-4ad8-823b-6cd4345b2b1b', '2025-06-05 04:02:42', '2025-06-05 04:02:42'),
('50fff04e-69c1-4fec-9a2a-a049a9cc9e86', '2025-05-04', 3058000.00, '-', 'fc8c2249-e4c4-4380-82d4-c1b575be78bd', '2025-06-05 04:19:09', '2025-06-05 04:19:09'),
('6c1b50bd-3c6b-4019-810a-f2074c90b3d9', '2025-05-04', 1000000.00, '-', '1a7bd658-6749-4644-8efc-688a0977f747', '2025-06-05 04:16:43', '2025-06-05 04:16:43'),
('6fc3d67f-133c-40bb-b19b-26a0009be54f', '2025-05-04', 572500.00, 'Membeli Roko', 'fc8c2249-e4c4-4380-82d4-c1b575be78bd', '2025-06-05 04:03:55', '2025-06-05 04:03:55'),
('750b49bb-ebae-460f-898a-305a55752938', '2025-05-04', 450000.00, '-', 'fc8c2249-e4c4-4380-82d4-c1b575be78bd', '2025-06-05 04:19:41', '2025-06-05 04:19:41'),
('7c858666-f82e-4856-bc70-97e44eaabd38', '2025-05-04', 100000.00, '-', '1a7bd658-6749-4644-8efc-688a0977f747', '2025-06-05 04:07:23', '2025-06-05 04:07:23'),
('8443730e-b7f5-4f22-8c55-e1332b02916e', '2025-05-04', 330000.00, '-', '00757da8-c5ab-4476-97b8-5f99ef963acd', '2025-06-05 04:15:06', '2025-06-05 04:15:06'),
('9305be8d-2478-4c71-8e69-d060023966e2', '2025-05-04', 220000.00, 'membeli roko', '00757da8-c5ab-4476-97b8-5f99ef963acd', '2025-06-05 04:12:37', '2025-06-05 04:12:37'),
('985cda3b-bf5d-4297-aead-75e8d977fc3e', '2025-05-04', 60000.00, 'Membeli Roko', '80c4cd9c-52cf-4e2d-9482-a058a03b2daa', '2025-06-05 04:11:32', '2025-06-05 04:11:32'),
('a2c98317-2016-453f-aa56-efbd9a0f15d9', '2025-05-04', 1000000.00, 'Bon uang pertama', '9f03d73c-c9ef-4303-b421-2630bddff137', '2025-06-05 04:10:49', '2025-06-05 04:10:49'),
('a7970bbc-a58a-4f85-8f30-83748e015748', '2025-05-04', 325000.00, 'Membeli Roko', '0a3f4c60-a73e-4e56-a922-f8ae01fcc1a1', '2025-06-05 03:58:14', '2025-06-05 03:58:14'),
('b9c176be-be68-41f9-9859-b532c3b940df', '2025-05-04', 500000.00, '-', '00757da8-c5ab-4476-97b8-5f99ef963acd', '2025-06-05 04:15:34', '2025-06-05 04:15:34'),
('bdf6157b-6401-4279-b47c-d717b9fbffb7', '2025-05-04', 1000000.00, 'Bon Uang ', '0a3f4c60-a73e-4e56-a922-f8ae01fcc1a1', '2025-06-05 03:58:59', '2025-06-05 03:58:59'),
('cbc2fbcf-c99b-4f98-84d8-2f7d73b1a344', '2025-05-04', 4500000.00, '-', '80c4cd9c-52cf-4e2d-9482-a058a03b2daa', '2025-06-05 04:16:08', '2025-06-05 04:16:08'),
('d38f728f-e7fe-406f-9bef-9917e1e853b6', '2025-05-04', 100000.00, '-', '1a7bd658-6749-4644-8efc-688a0977f747', '2025-06-05 04:08:10', '2025-06-05 04:08:10'),
('d68ef023-b5a6-48d7-bd2c-c07613c31794', '2025-05-04', 100000.00, '-', '1a7bd658-6749-4644-8efc-688a0977f747', '2025-06-05 04:08:30', '2025-06-05 04:08:30'),
('e115e432-8015-4c06-8283-90fa3c7780c8', '2025-05-04', 500000.00, '-', '1a7bd658-6749-4644-8efc-688a0977f747', '2025-06-05 04:06:23', '2025-06-05 04:06:23'),
('e3d4dbcb-05c7-4da9-bda7-810c9648cbed', '2025-05-04', 500000.00, '-', '1a7bd658-6749-4644-8efc-688a0977f747', '2025-06-05 04:07:47', '2025-06-05 04:07:47');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('karyawan','admin') DEFAULT 'karyawan',
  `namaLengkap` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`id`, `username`, `password`, `role`, `namaLengkap`, `createdAt`, `updatedAt`) VALUES
('00757da8-c5ab-4476-97b8-5f99ef963acd', 'juman', '$2b$10$eT7j/3NJ.gK6G54RiT7SnOag9EgyBVDNuhik7p5WGmtEZcLpajCjO', 'karyawan', 'Juman', '2025-06-05 03:56:49', '2025-06-05 03:56:49'),
('0a3f4c60-a73e-4e56-a922-f8ae01fcc1a1', 'eri', '$2b$10$7Sf53OZI1J5SRUZnVFa/K.qw8eX1UBk9A52L8sVW6iMhMjrD7rpOO', 'karyawan', 'Eri', '2025-06-05 03:53:43', '2025-06-05 03:53:43'),
('1a7bd658-6749-4644-8efc-688a0977f747', 'andis', '$2b$10$qhfMMpgdc.fA3e0nTQMPsOyWkInHqMdY7gN6gPPsA14BVv5TAE6C6', 'karyawan', 'Andis', '2025-06-05 03:55:27', '2025-06-05 03:55:27'),
('3230b5a9-e5ae-4945-8a36-6dedd8274afb', 'parman', '$2b$10$.apKosKE34pI2uhnfuOS8.gcUemPV/i/jBMOs1efoOSAqRMrdeObi', 'karyawan', 'Suparman', '2025-06-05 03:54:23', '2025-06-05 03:54:23'),
('697c55be-6544-4e66-b33e-6b10cbdb5ac0', 'admin', '$2b$10$jWUbrPpfewNqXdeNC/iYOu7q9V00An4z7rpJe8Gzf8ygtL1jJ.AMu', 'admin', 'Admin Toko Hakimah', '2025-06-04 13:00:14', '2025-06-04 22:18:02'),
('7c75b9c6-4160-4aa2-9b9f-9f0938d5938c', 'alenadmin', '$2b$10$O6sVP2qVEH9LqMdxw5DGDuFyIBttU1KHcsI2Qs/gSRMZF./nQOp7.', 'admin', 'Alen Admin', '2025-06-04 22:18:29', '2025-06-05 21:09:52'),
('80c4cd9c-52cf-4e2d-9482-a058a03b2daa', 'agung', '$2b$10$7JEwF3v6uVJx04DqXm1gSOpKAgG3iDsRn1moEzzxEQPXh.tfFDGBC', 'karyawan', 'Agung', '2025-06-05 03:56:30', '2025-06-05 03:56:30'),
('9f03d73c-c9ef-4303-b421-2630bddff137', 'wida', '$2b$10$pSBIiOsNsH3LMlmR.qiiUODD4phnBlLWn3I0QKChzDWdtXTB3YKGG', 'karyawan', 'Wida', '2025-06-05 03:56:16', '2025-06-05 03:56:16'),
('b83cba26-6321-4024-ad8b-6a8ea3320996', 'toni', '$2b$10$Na0XQCY1tJ3Z/xMdxWxLY.519y2Z8.IF2L6khbBIIl4OM2SJ8YY3i', 'karyawan', 'Anzar Priyantoni', '2025-06-05 03:55:58', '2025-06-05 03:55:58'),
('fc88d4ab-5979-4ad8-823b-6cd4345b2b1b', 'rafi', '$2b$10$uDZThN8pojd.VX2rkkLkg.4C2soGxRX0v53adYag6JXRvVslfqEWS', 'karyawan', 'Rafi', '2025-06-05 03:54:46', '2025-06-05 03:54:46'),
('fc8c2249-e4c4-4380-82d4-c1b575be78bd', 'rizky', '$2b$10$bqNYGVFfglPwvW/y5pujZuookAiAQoFnKXTnc9uxDfArxX6DM29TK', 'karyawan', 'Rizky', '2025-06-05 03:55:08', '2025-06-05 03:55:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Bons`
--
ALTER TABLE `Bons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `username_2` (`username`),
  ADD UNIQUE KEY `username_3` (`username`),
  ADD UNIQUE KEY `username_4` (`username`),
  ADD UNIQUE KEY `username_5` (`username`),
  ADD UNIQUE KEY `username_6` (`username`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Bons`
--
ALTER TABLE `Bons`
  ADD CONSTRAINT `Bons_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
