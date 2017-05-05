-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 05, 2017 at 11:20 AM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bxb2`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointmentno` int(11) NOT NULL,
  `sp_schedid` int(11) NOT NULL,
  `daterequest` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `clientno` int(11) NOT NULL,
  `serviceid` int(11) NOT NULL,
  `status` enum('request','accepted','rejected','done') NOT NULL DEFAULT 'request'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointmentno`, `sp_schedid`, `daterequest`, `clientno`, `serviceid`, `status`) VALUES
(4, 3, '2017-05-04 20:09:11', 110010, 209, 'accepted');

--
-- Triggers `appointments`
--
DELIMITER $$
CREATE TRIGGER `update_vacancy` BEFORE UPDATE ON `appointments` FOR EACH ROW BEGIN
	IF NEW.status = 'accepted' THEN
		UPDATE serviceprovider_schedules 
			SET vacant = 'no'
		WHERE schedid = NEW.sp_schedid;
    ELSEIF NEW.status = 'done' THEN
		UPDATE serviceprovider_schedules 
			SET vacant = 'yes'
		WHERE schedid = NEW.sp_schedid;
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `clientno` int(11) NOT NULL,
  `first_name` char(20) NOT NULL,
  `last_name` char(15) NOT NULL,
  `birthdate` date NOT NULL,
  `email` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `contactno` varchar(11) NOT NULL,
  `address` varchar(60) NOT NULL,
  `accountcreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accepted` enum('Y','N') NOT NULL DEFAULT 'N',
  `profpic` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`clientno`, `first_name`, `last_name`, `birthdate`, `email`, `username`, `password`, `contactno`, `address`, `accountcreated`, `accepted`, `profpic`) VALUES
(101113, 'Joshua', 'Warren', '1982-03-23', 'WarrenJosh@gmail.com', 'JoshWarren', 'iyoyiw77', '09107392170', 'ABC Rd, Quantum Theory City', '2017-04-26 23:37:59', 'N', NULL),
(101134, 'Jared', 'Vasquez', '1986-04-22', 'jared01@yahoo.com', 'JaredVasquez', 'pjvde96s', '09472961670', 'Bagong Anak, Dinasilang Bldg., BC.', '2017-04-26 23:49:23', 'Y', NULL),
(101425, 'Aubrey', 'Aguilar', '1992-05-18', 'AguilarA@gmail.com', 'AubreyA', 'aub1992a', '09151940119', 'Alpaca 69, Dagupan City', '2017-04-26 23:48:48', 'N', NULL),
(102589, 'Loraine', 'Luna', '1989-02-16', 'Loraine992@gmail.com', 'LorLuna', 'lunapass7832', '09458127041', 'Orocan Rd., Dagupan, Pangasinan', '2017-04-26 23:38:39', 'Y', NULL),
(110005, 'Norma', 'Castro', '1990-01-03', 'NormaCastro77@yahoo.com', 'NormaCastro', 'cas456tro', '09081904216', '#22 Bonifacio St., Baguio City', '2017-04-27 07:35:50', 'Y', NULL),
(110006, 'Katie', 'Fuller', '1991-10-19', 'katfuller@gmail.com', 'Kat', '1991kabnm', '09184686141', 'Water Station Heaven Rd., BC', '2017-04-27 07:41:30', 'Y', NULL),
(110007, 'Rex', 'Scott', '1989-11-16', 'rex256@gmail.com', 'RexS', 'yuio567', '09774978637', 'Ang River, Sa Tubig City', '2017-04-27 07:41:30', 'Y', NULL),
(110009, 'Lynda', 'Riley', '1975-06-08', 'LynRil@gmail.com', 'Lynda', 'ril678da', '09288036814', 'Pels stop St., Last One Bldg, BC', '2017-04-27 07:35:18', 'Y', NULL),
(110010, 'Alden', 'Samson', '2002-02-02', 'quack@quk.com', '2150804', '123asd', '09412215644', 'Banal Ata St., Gotham City', '2017-04-30 18:46:33', 'N', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `messageid` int(11) NOT NULL,
  `sender_username` varchar(45) NOT NULL,
  `message` varchar(160) NOT NULL,
  `client_username` varchar(45) NOT NULL,
  `sp_username` varchar(45) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `idrating` int(11) NOT NULL,
  `clientno` int(11) NOT NULL,
  `spid` int(11) NOT NULL,
  `rating` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`idrating`, `clientno`, `spid`, `rating`) VALUES
(2, 101134, 220012, 3),
(3, 102589, 220012, 4),
(4, 110005, 220012, 4),
(5, 110007, 220042, 4),
(6, 102589, 220042, 3),
(7, 110006, 220125, 4),
(8, 110007, 220582, 5),
(9, 110009, 226482, 5);

--
-- Triggers `ratings`
--
DELIMITER $$
CREATE TRIGGER `INSERT_TOTAL` AFTER INSERT ON `ratings` FOR EACH ROW UPDATE serviceproviders SET totalrating = ( SELECT AVG(rating) FROM ratings WHERE spid =  NEW.spid group by spid) 
WHERE serviceproviders.spid =  NEW.spid
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `serviceproviders`
--

CREATE TABLE `serviceproviders` (
  `spid` int(11) NOT NULL,
  `first_name` char(20) NOT NULL,
  `last_name` char(10) NOT NULL,
  `email` varchar(45) NOT NULL,
  `contactno` varchar(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `accepted` enum('Y','N') NOT NULL DEFAULT 'N',
  `totalrating` int(11) NOT NULL DEFAULT '0',
  `profpic` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `serviceproviders`
--

INSERT INTO `serviceproviders` (`spid`, `first_name`, `last_name`, `email`, `contactno`, `username`, `password`, `accepted`, `totalrating`, `profpic`) VALUES
(220012, 'Irma', 'Baker', 'irmabaker9@gmail.com', '09188988995', 'Irma', 'bakeeer56', 'Y', 4, NULL),
(220042, 'Thomas', 'Ryan', 'ThomasR88@gmail.com', '09465694371', 'Thomas', 'jaden1456', 'Y', 4, NULL),
(220052, 'Jessie', 'Lee', 'jessie03@yahoo.com', '09772213075', 'JessieLee', '03qwerty', 'N', 0, NULL),
(220125, 'Myron', 'Franklin', 'MFranklin@yahoo.com', '09436845560', 'Myron', 'ixabun27', 'Y', 4, NULL),
(220254, 'Lela', 'Salazar', 'lela52salazar@yahoo.com', '09158847461', 'Lela', '123LS52', 'N', 0, NULL),
(220582, 'Angelica', 'Sherman', 'angel67@gmail.com', '09265751126', 'angel', 'sherang546', 'Y', 5, NULL),
(224695, 'Gerard', 'West', 'GW67@gmail.com', '09282713478', 'GW', '67drareg', 'N', 0, NULL),
(226482, 'May', 'Ellis', 'ellismay@yahoo.com', '09499251352', 'Maye', '1983may', 'Y', 5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `serviceprovider_schedules`
--

CREATE TABLE `serviceprovider_schedules` (
  `schedid` int(11) NOT NULL,
  `spid` int(11) NOT NULL,
  `sched_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `vacant` enum('yes','no') NOT NULL DEFAULT 'yes'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `serviceprovider_schedules`
--

INSERT INTO `serviceprovider_schedules` (`schedid`, `spid`, `sched_date`, `start_time`, `end_time`, `vacant`) VALUES
(1, 220012, '0000-00-00', '09:30:00', '11:30:00', 'yes'),
(3, 220042, '0000-00-00', '08:00:00', '10:00:00', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `serviceid` int(11) NOT NULL,
  `servicename` char(20) NOT NULL,
  `serviceamount` float NOT NULL,
  `description` varchar(50) NOT NULL,
  `category` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`serviceid`, `servicename`, `serviceamount`, `description`, `category`) VALUES
(201, 'Haircut', 150, 'starting price for minimum length ', 'hair'),
(202, 'shampoo and blowdry', 100, '', 'hair'),
(203, 'Iron/Curling', 500, 'straighten or curl hair', 'hair'),
(204, 'Eye makeup', 400, 'any style for eye makeup', 'makeup'),
(205, 'Full makeup', 800, 'full face makeup', 'makeup'),
(206, 'tint (root)', 1050, 'hair coloring at the roots', 'color'),
(207, 'tint (full)', 1450, 'hair coloring of full length', 'color'),
(208, 'Conditioning', 1300, 'hair color conditioning', 'color'),
(209, 'Highlights', 1500, 'hair highlights, any style', 'color'),
(210, 'hot oil', 500, 'regular hot oil treatment', 'treatment'),
(211, 'hair spa', 950, 'regular hair treatment', 'treatment'),
(212, 'Keratherapy', 1500, 'express keratherapy', 'treatment'),
(213, 'eyebrow wax', 210, 'eyebrow waxing', 'waxing'),
(214, 'Underarm wax', 450, 'underarm waxing', 'waxing'),
(215, 'Arm wax', 600, 'full arm waxing', 'waxing'),
(216, 'Leg wax', 460, 'full leg waxing', 'waxing'),
(217, 'Bikini wax', 450, 'bikini area waxing', 'waxing'),
(218, 'Brazilian wax', 650, 'brazilian type of waxing', 'waxing'),
(219, 'Perm', 1200, 'hair perm', 'form'),
(220, 'Relax', 2200, 'hair relax', 'form'),
(221, 'Rebond', 3800, 'hair rebond', 'form'),
(222, 'manicure', 175, 'fingernails and hand treatment', 'nails'),
(223, 'foot spa', 350, 'foot care', 'nails'),
(224, 'Pedicure', 210, 'foot and toenails treatment', 'nails'),
(225, 'Nail art', 150, 'choose from any nail design available', 'nails');

-- --------------------------------------------------------

--
-- Table structure for table `sp_skills`
--

CREATE TABLE `sp_skills` (
  `spid` int(11) NOT NULL,
  `serviceid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sp_skills`
--

INSERT INTO `sp_skills` (`spid`, `serviceid`) VALUES
(220012, 201),
(220012, 202),
(220012, 203),
(220012, 208),
(220042, 209),
(220042, 204),
(220042, 205),
(220042, 211),
(220052, 214),
(220052, 210),
(220052, 211),
(220052, 212),
(220125, 206),
(220125, 207),
(220125, 208),
(220125, 209),
(220254, 211),
(220254, 210),
(220254, 213),
(220254, 214),
(220582, 218),
(220582, 215),
(220582, 216),
(220582, 217),
(224695, 213),
(224695, 218),
(224695, 219),
(224695, 220),
(226482, 221),
(226482, 222),
(226482, 223),
(226482, 224),
(226482, 225);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointmentno`),
  ADD UNIQUE KEY `appointmentNo_UNIQUE` (`appointmentno`),
  ADD KEY `serviceID_idx` (`serviceid`),
  ADD KEY `fk_app_client_idx` (`clientno`),
  ADD KEY `sp_schedid` (`sp_schedid`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`clientno`),
  ADD UNIQUE KEY `clientNo_UNIQUE` (`clientno`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`messageid`),
  ADD KEY `fk_message_clientno_idx` (`client_username`),
  ADD KEY `fk_message_spid_idx` (`sp_username`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`idrating`),
  ADD UNIQUE KEY `idrating_UNIQUE` (`idrating`),
  ADD KEY `fk_rate_clientno_idx` (`clientno`),
  ADD KEY `fk_rate_spid_idx` (`spid`);

--
-- Indexes for table `serviceproviders`
--
ALTER TABLE `serviceproviders`
  ADD PRIMARY KEY (`spid`),
  ADD UNIQUE KEY `spID_UNIQUE` (`spid`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Indexes for table `serviceprovider_schedules`
--
ALTER TABLE `serviceprovider_schedules`
  ADD PRIMARY KEY (`schedid`),
  ADD KEY `serviceID_idx` (`schedid`),
  ADD KEY `fk_spservice_spid_idx` (`spid`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`serviceid`),
  ADD UNIQUE KEY `ServiceId_UNIQUE` (`serviceid`),
  ADD KEY `serviceamount_idx` (`serviceamount`);

--
-- Indexes for table `sp_skills`
--
ALTER TABLE `sp_skills`
  ADD KEY `serviceID_idx` (`serviceid`),
  ADD KEY `fk_spservice_spid_idx` (`spid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointmentno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `clientno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110012;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `messageid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `idrating` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `serviceproviders`
--
ALTER TABLE `serviceproviders`
  MODIFY `spid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=226484;
--
-- AUTO_INCREMENT for table `serviceprovider_schedules`
--
ALTER TABLE `serviceprovider_schedules`
  MODIFY `schedid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `serviceid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=227;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `fk_app_client` FOREIGN KEY (`clientno`) REFERENCES `clients` (`clientno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_service` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`),
  ADD CONSTRAINT `sched_fk` FOREIGN KEY (`sp_schedid`) REFERENCES `serviceprovider_schedules` (`schedid`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `client_username` FOREIGN KEY (`client_username`) REFERENCES `clients` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sp_username` FOREIGN KEY (`sp_username`) REFERENCES `serviceproviders` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `fk_rate_clientno` FOREIGN KEY (`clientno`) REFERENCES `clients` (`clientno`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rate_spid` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `serviceprovider_schedules`
--
ALTER TABLE `serviceprovider_schedules`
  ADD CONSTRAINT `sp_fk` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sp_skills`
--
ALTER TABLE `sp_skills`
  ADD CONSTRAINT `fk_skill` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`),
  ADD CONSTRAINT `fk_skills_sp` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
