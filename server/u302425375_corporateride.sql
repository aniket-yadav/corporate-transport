-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 24, 2022 at 09:31 AM
-- Server version: 10.5.15-MariaDB-cll-lve
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u302425375_corporateride`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `adminid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminid`, `username`, `email`, `password`, `role`, `mobile`, `gender`, `age`, `name`, `image`) VALUES
('ad62ce2ccfbc4a4', 'ap4614291', 'ap4614291@gmail.com\n', '936cdc8e6968b2451d294768c8af33e3', 'admin', '9833672690', 'male', '24', 'ASIP', 'https://mycorporaterider.tech/api/images/ad62ce2ccfbc4a4.jpeg'),
('ad62e15f89d6743', 'aniket4897', 'aniket4897@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'admin', '9833672290', 'Male', '25', 'Aniket Yadav', NULL);

--
-- Triggers `admin`
--
DELIMITER $$
CREATE TRIGGER `admindelete` AFTER DELETE ON `admin` FOR EACH ROW DELETE FROM users WHERE userid=OLD.adminid
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `admininsert` AFTER INSERT ON `admin` FOR EACH ROW INSERT INTO users(userid,username,password,role)VALUES(NEW.adminid,NEW.username,NEW.password,"admin")
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `adminupdate` AFTER UPDATE ON `admin` FOR EACH ROW UPDATE users SET password=NEW.password WHERE userid = OLD.adminid
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `billing`
--

CREATE TABLE `billing` (
  `billId` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employeeId` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bus` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billingMonthYear` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paymentStatus` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paymentid` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `billing`
--

INSERT INTO `billing` (`billId`, `employeeId`, `bus`, `billingMonthYear`, `amount`, `paymentStatus`, `paymentid`) VALUES
('bi6302071739d3d', 'emp62f740ced8864', 've62f71c161fe4f', 'August 2022', '700', 'true', NULL),
('bi63020a4d1b287', 'emp62f745eed0d8b', 've62f71c161fe4f', 'August 2022', '700', 'true', NULL),
('bi63020ab75fd99', 'emp62d242845e3de', 've62f740fdeda75', 'August 2022', '700', 'true', 'pay63021bc663865'),
('bi631c8e240d6d5', 'emp62d242845e3de', 've62f740fdeda75', 'September 2022', '700', 'true', 'pay631c8e6249953'),
('bi632714cb43f41', 'emp62f745eed0d8b', 've62f71c161fe4f', 'September 2022', '700', 'true', NULL),
('bi632714d07cc02', 'emp62d242845e3de', 've62f71c161fe4f', 'September 2022', '700', 'true', 'pay632714f932e3b');

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `driverid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `experience` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pincode` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aadharno` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicleid` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `drivers`
--

INSERT INTO `drivers` (`driverid`, `username`, `email`, `password`, `role`, `mobile`, `gender`, `age`, `experience`, `address`, `pincode`, `aadharno`, `image`, `vehicleid`, `name`) VALUES
('dr632b111046521', 'nikhilgharate365', 'nikhilgharate365@gmail.com', '350d89c1cd6592bbbd1ed2e8a4f3ddba', 'driver', '9183904990', 'Male', '27', '3', 'Dhule', '420001', '846469468389', NULL, 've62f71c161fe4f', 'Nikhile Gharate');

--
-- Triggers `drivers`
--
DELIMITER $$
CREATE TRIGGER `driverdelete` AFTER DELETE ON `drivers` FOR EACH ROW DELETE FROM users WHERE userid=OLD.driverid
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `driverinsert` AFTER INSERT ON `drivers` FOR EACH ROW INSERT INTO users(userid,username,password,role)VALUES(NEW.driverid,NEW.username,NEW.password,"driver")
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `driverupdate` AFTER UPDATE ON `drivers` FOR EACH ROW UPDATE users SET password=NEW.password WHERE userid = OLD.driverid
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employeeid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `empid` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pincode` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicleid` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `riding` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT 'no',
  `latitude` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employeeid`, `username`, `password`, `email`, `role`, `mobile`, `gender`, `age`, `empid`, `address`, `pincode`, `vehicleid`, `name`, `image`, `riding`, `latitude`, `longitude`) VALUES
('emp62d242845e3de', 'pankaj', '25d55ad283aa400af464c76d713c07ad', 'pankaj@gmail.com', 'employee', '3423423435', 'Male', '31', 'dd242232', 'kisan nagar', '309945', 've62f71c161fe4f', 'Pankaj Yadav', NULL, 'yes', NULL, NULL),
('emp632b11f2cb846', 'tanay.surve.ts', '1187ec0b0b679b1f7dc63c391722b247', 'tanay.surve.ts@gmail', 'employee', '9436494986', 'Male', '25', '1626737', 'Khopoli', '843469', NULL, 'Tanay Surve', NULL, 'no', NULL, NULL),
('emp632b124b17b48', 'gayebif587', 'd23f0023f0ce0763017c4f27857314cd', 'gayebif587@ploneix.c', 'employee', '5466491986', 'Male', '26', '6263667', 'Thane', '400604', 've62f71c161fe4f', 'Aniket Tiwari', NULL, 'no', '73.85769300162792', '18.523850753377683'),
('emp632b136934eb6', 'rofoj65971', 'd7e8ae970ee8e85b0ca0cb2179adce1a', 'rofoj65971@orlydns.c', 'employee', '9434695986', 'Male', '27', '3737478', 'Pune', '646959', 've62f71c161fe4f', 'Anmol Kumar', NULL, 'no', '73.76734647899866', '18.65088857417412'),
('emp632b14024a143', 'nefawox148', '2eda949370d317191e38cd66e43fcdc4', 'nefawox148@orlydns.c', 'employee', '5434949566', 'Female', '24', '3674848', 'Mumbai', '643190', NULL, 'Neha Verma', NULL, 'no', NULL, NULL),
('emp632b145862d0a', 'mayagev711', '90c64ad11122edb3547ddf0dee91ee7d', 'mayagev711@pahed.com', 'employee', '8431991686', 'Female', '27', '6388399', 'Raigad', '646919', NULL, 'Anuja Mahadik', NULL, 'no', NULL, NULL);

--
-- Triggers `employee`
--
DELIMITER $$
CREATE TRIGGER `employeedelete` AFTER DELETE ON `employee` FOR EACH ROW DELETE FROM users WHERE userid=OLD.employeeid
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `employeeinsert` AFTER INSERT ON `employee` FOR EACH ROW INSERT INTO users(userid,username,password,role)VALUES(NEW.employeeid,NEW.username,NEW.password,"employee")
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `employeeupdate` AFTER UPDATE ON `employee` FOR EACH ROW UPDATE users SET password=NEW.password WHERE userid = OLD.employeeid
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

CREATE TABLE `feedbacks` (
  `feedbackid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feedbacks`
--

INSERT INTO `feedbacks` (`feedbackid`, `comment`, `author`, `rate`, `date`, `email`) VALUES
('fd62cf00babb6b4', 'nice app', 'Ajay Prajapati', '5', '2022-07-13T22:59', 'ap4614291@gmail.com'),
('fd62d3a686a9b82', '', 'Ajay Prajapati', '5', '2022-07-17T11:34', 'ajay@gmail.com'),
('fd62d42e36a4930', 'nice', 'Pankaj Yadav', '5', '2022-07-17T21:13', 'pankaj@gmail.com'),
('fd62f743a077027', 'Good.', 'Raj', '4', '2022-08-13T11:54', 'bolokol104@hauzgo.com'),
('fd62f74516e3399', 'Well done', 'Rajkumar', '5', '2022-08-13T12:00', 'novexi9525@yubua.com'),
('fd62f74646aec69', 'would be better', 'Tanay', '3', '2022-08-13T12:05', 'fadina4081@yubua.com'),
('fd632b401828570', 'Good App', 'Nikhile Gharate', '5', '2022-09-21T22:17', 'nikhilgharate365@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userid`, `username`, `password`, `role`) VALUES
('ad62ce2ccfbc4a4', 'ap4614291', '936cdc8e6968b2451d294768c8af33e3', 'admin'),
('ad62e15f89d6743', 'aniket4897', '25d55ad283aa400af464c76d713c07ad', 'admin'),
('dr632b111046521', 'nikhilgharate365', '350d89c1cd6592bbbd1ed2e8a4f3ddba', 'driver'),
('emp62d242845e3de', 'pankaj', '25d55ad283aa400af464c76d713c07ad', 'employee'),
('emp632b11f2cb846', 'tanay.surve.ts', '1187ec0b0b679b1f7dc63c391722b247', 'employee'),
('emp632b124b17b48', 'gayebif587', 'd23f0023f0ce0763017c4f27857314cd', 'employee'),
('emp632b136934eb6', 'rofoj65971', 'd7e8ae970ee8e85b0ca0cb2179adce1a', 'employee'),
('emp632b14024a143', 'nefawox148', '2eda949370d317191e38cd66e43fcdc4', 'employee'),
('emp632b145862d0a', 'mayagev711', '90c64ad11122edb3547ddf0dee91ee7d', 'employee');

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `vehicleid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `platno` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capacity` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driverid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `longitude` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`vehicleid`, `name`, `model`, `platno`, `color`, `type`, `capacity`, `driverid`, `longitude`, `latitude`) VALUES
('ve62f71c161fe4f', 'Tata', 'Zen', 'MH04JH6384', 'White', 'bus', '30', 'dr632b111046521', '73.7683453', '18.6528305');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`adminid`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `mobile` (`mobile`);

--
-- Indexes for table `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`billId`);

--
-- Indexes for table `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`driverid`),
  ADD UNIQUE KEY `email` (`email`,`mobile`),
  ADD UNIQUE KEY `aadharno` (`aadharno`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employeeid`),
  ADD UNIQUE KEY `email` (`email`,`mobile`) USING BTREE;

--
-- Indexes for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD PRIMARY KEY (`feedbackid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userid`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`vehicleid`),
  ADD UNIQUE KEY `driverid` (`driverid`),
  ADD UNIQUE KEY `platno` (`platno`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
