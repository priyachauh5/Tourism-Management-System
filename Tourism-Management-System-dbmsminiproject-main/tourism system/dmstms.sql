-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 22, 2021 at 11:52 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tms`
--

-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

CREATE TABLE `visitors` (
  `vis_id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `vis_name` varchar(50) NOT NULL,
  `occupation` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `visitors`
--

INSERT INTO `visitors` (`vis_id`, `email`, `vis_name`, `occupation`) VALUES
(1, 'priya@gmail.com', 'priya', 'student'),
(2, 'praharsha@gmail.com', 'praharsha', 'student'),
(3, 'sonali@gmail.com', 'sonali', 'student'),
(4, 'ashar@gmail', 'ashar', 'teacher'),
(5, 'rohan@gmail.com', 'rohan', 'employee');

-- --------------------------------------------------------

--
-- Table structure for table `tourist`
--

CREATE TABLE `tourist` (
  `t_id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `slot` varchar(50) NOT NULL,
  `location` varchar(50) NOT NULL,
  `time` time NOT NULL,
  `date` date NOT NULL,
  `occupation` varchar(50) NOT NULL,
  `number` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tourist`
--

INSERT INTO `tourist` (`t_id`, `email`, `name`, `gender`, `slot`, `location`, `time`, `date`, `occupation`, `number`) VALUES
(2, 'priya@gmail.com', 'priya chauhan', 'Female', 'evening', 'Agra', '21:20:00', '2024-02-02', 'student', '9874561110'),
(5, 'prasharsha@gmail.com', 'prasharsha chaudhary', 'Female', 'morning', 'kerala', '18:06:00', '2024-11-18', 'student', '9874563210'),
(7, 'sonali@gmail.com', 'sonali podkar', 'Female', 'evening', 'Jammu Kashmir', '22:18:00', '2024-11-05', 'student', '9874563210'),
(8, 'ashar@gmail.com', 'ashar singh', 'Male', 'evening', 'Ladakh', '22:18:00', '2024-11-05', 'teacher', '9874563210'),
(9, 'rohan@gmail.com', 'rohan patel', 'Male', 'morning', 'mumbai', '17:27:00', '2024-11-26', 'employee', '9874563210'),
(10, 'reena@gmail.com', 'reena agarwal', 'Female', 'evening', 'Jaisalmar', '16:25:00', '2024-12-09', 'teacher', '9874589654'),
(15, 'mayuri@gmail.com', 'mayuri yadav', 'Female', 'morning', 'Bodhgaya', '20:42:00', '2024-01-23', 'student', '9874563210'),
(16, 'ruchi@gmail.com', 'ruchi sinha', 'Female', 'evening', 'Varanasi', '15:46:00', '2024-01-31', 'employee', '9874587496'),
(17, 'deepak@gmail.com', 'deepak rathod', 'Male', 'evening', 'Amritsar', '15:48:00', '2024-01-23', 'employee', '9874563210');

--
-- Triggers `tourist`
--
DELIMITER $$
CREATE TRIGGER `TouristDelete` BEFORE DELETE ON `tourist` FOR EACH ROW INSERT INTO trigr VALUES(null,OLD.t_id,OLD.email,OLD.name,'TOURIST DELETED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TouristUpdate` AFTER UPDATE ON `tourist` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.t_id,NEW.email,NEW.name,'TOURIST UPDATED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `touristinsertion` AFTER INSERT ON `tourist` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.t_id,NEW.email,NEW.name,'TOURIST INSERTED',NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `b_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`b_id`, `name`, `email`) VALUES
(1, 'priya', 'priya@gmail.COM'),
(2, 'nidhi', 'nidhi@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `trigr`
--

CREATE TABLE `trigr` (
  `tid` int(11) NOT NULL,
  `t_id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `trigr`
--

INSERT INTO `trigr` (`tid`, `t_id`, `email`, `name`, `action`, `timestamp`) VALUES
(1, 12, 'reena@gmail.com', 'reena', 'TOURIST INSERTED', '2024-12-02 16:35:10'),
(2, 11, 'reena@gmail.com', 'reena', 'TOURIST INSERTED', '2024-12-02 16:37:34'),
(3, 10, 'reena@gmail.com', 'reena', 'TOURIST UPDATED', '2024-12-02 16:38:27'),
(4, 11, 'reena@gmail.com', 'reena', 'TOURIST UPDATED', '2024-12-02 16:38:33'),
(5, 12, 'reena@gmail.com', 'reena', 'TOURIST Deleted', '2024-12-02 16:40:40'),
(6, 11, 'reena@gmail.com', 'reena', 'TOURIST DELETED', '2024-12-02 16:41:10'),
(7, 13, 'mayuri@gmail.com', 'mayuri', 'TOURIST INSERTED', '2024-12-02 16:50:21'),
(8, 13, 'mayuri@gmail.com', 'mayuri', 'TOURIST UPDATED', '2024-12-02 16:50:32'),
(9, 13, 'mayuri@gmail.com', 'mayuri', 'TOURIST DELETED', '2024-12-02 16:50:57'),
(10, 14, 'rohan@gmail.com', 'rohan', 'TOURIST INSERTED', '2024-01-22 15:18:09'),
(11, 14, 'rohan@gmail.com', 'rohan', 'TOURIST UPDATED', '2024-01-22 15:18:29'),
(12, 14, 'rohan@gmail.com', 'rohan', 'TOURIST DELETED', '2024-01-22 15:41:48'),
(13, 15, 'priya@gmail.com', 'priya', 'TOURIST INSERTED', '2024-01-22 15:43:02'),
(14, 15, 'priya@gmail.com', 'priya', 'TOURIST UPDATED', '2024-01-22 15:43:11'),
(15, 16, 'priya@gmail.com', 'priya', 'TOURIST INSERTED', '2024-01-22 15:43:37'),
(16, 16, 'priya@gmail.com', 'priya', 'TOURIST UPDATED', '2024-01-22 15:43:49'),
(17, 17, 'ashar@gmail.com', 'ashar', 'TOURIST INSERTED', '2024-01-22 15:44:41'),
(18, 17, 'ashar@gmail.com', 'ashar', 'TOURIST UPDATED', '2024-01-22 15:44:52'),
(19, 17, 'ashar@gmail.com', 'ashar', 'TOURIST UPDATED', '2024-01-22 15:44:59');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `usertype` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `usertype`, `email`, `password`) VALUES
(13, 'priya', 'Student', 'priya@gmail.com', 'pbkdf2:sha256:150000$xAKZCiJG$4c7a7e704708f86659d730565ff92e8327b01be5c49a6b1ef8afdf1c531fa5c3'),
(14, 'praharsha', 'Student', 'praharsha@gmail.com', 'pbkdf2:sha256:150000$Yf51ilDC$028cff81a536ed9d477f9e45efcd9e53a9717d0ab5171d75334c397716d581b8'),
(15, 'sonali', 'Student', 'sonali@gmail.com', 'pbkdf2:sha256:150000$BeSHeRKV$a8b27379ce9b2499d4caef21d9d387260b3e4ba9f7311168b6e180a00db91f22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `visitors`
--
ALTER TABLE `visitors`
  ADD PRIMARY KEY (`vis_id`);

--
-- Indexes for table `tourist`
--
ALTER TABLE `tourist`
  ADD PRIMARY KEY (`t_id`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`b_id`);

--
-- Indexes for table `trigr`
--
ALTER TABLE `trigr`
  ADD PRIMARY KEY (`tid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `visitors`
--
ALTER TABLE `visitors`
  MODIFY `vis_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tourist`
--
ALTER TABLE `tourist`
  MODIFY `t_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `booking`
  MODIFY `b_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `trigr`
--
ALTER TABLE `trigr`
  MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
