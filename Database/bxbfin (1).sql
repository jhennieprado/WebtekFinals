-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 12, 2017 at 05:14 PM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bxbfin`
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
  `status` enum('request','accepted','rejected','done','cancelled') NOT NULL DEFAULT 'request',
  `rating` int(11) NOT NULL DEFAULT '0',
  `spid` int(11) NOT NULL,
  `amount` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointmentno`, `sp_schedid`, `daterequest`, `clientno`, `serviceid`, `status`, `rating`, `spid`, `amount`) VALUES
(1, 20, '2017-05-12 13:04:52', 110010, 201, 'done', 3, 220012, 100),
(2, 20, '2017-05-12 17:06:26', 110010, 201, 'done', 5, 220012, 100);

--
-- Triggers `appointments`
--
DELIMITER $$
CREATE TRIGGER `add _rating` BEFORE UPDATE ON `appointments` FOR EACH ROW IF NEW.status = 'done' AND NEW.rating != 0 THEN
UPDATE serviceproviders SET totalrating = (SELECT AVG(rating) FROM appointments WHERE spid =  NEW.spid group by spid) 
WHERE serviceproviders.spid =  NEW.spid;
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `add_notif_client` AFTER UPDATE ON `appointments` FOR EACH ROW BEGIN
	IF NEW.status = 'accepted' THEN
		INSERT INTO `notify_client` (`appointmentno`,`receiver`, `spid` , `notifmessage`) VALUES ( OLD.appointmentno,OLD.clientno, OLD.spid, CONCAT((SELECT first_name from serviceproviders WHERE NEW.spid = serviceproviders.spid)," ",(SELECT last_name from serviceproviders WHERE NEW.spid = serviceproviders.spid)," has accepted your request"));
    ELSEIF NEW.status = 'done' THEN
		INSERT INTO `notify_client` (`appointmentno`,`receiver`, `spid` , `notifmessage`) VALUES (OLD.appointmentno,OLD.clientno, OLD.spid, CONCAT((SELECT first_name from serviceproviders WHERE NEW.spid = serviceproviders.spid)," ",(SELECT last_name from serviceproviders WHERE NEW.spid = serviceproviders.spid)," has marked your ", (SELECT servicename from services WHERE OLD.serviceid = services.serviceid)," appointment done"));
    ELSEIF NEW.status = 'rejected' THEN
		INSERT INTO `notify_client` (`appointmentno`,`receiver`, `spid` , `notifmessage`) VALUES ( OLD.appointmentno, OLD.clientno, OLD.spid, CONCAT((SELECT first_name from serviceproviders WHERE NEW.spid = serviceproviders.spid)," ",(SELECT last_name from serviceproviders WHERE NEW.spid = serviceproviders.spid)," has rejected your ", (SELECT servicename from services WHERE OLD.serviceid = services.serviceid)," request"));
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `add_notif_sp` AFTER INSERT ON `appointments` FOR EACH ROW INSERT INTO `notify_sp` (`appointmentno`,`receiver`, `clientno` , `notifmessage`) VALUES (NEW.appointmentno, NEW.spid, NEW.clientno, CONCAT((SELECT first_name from clients WHERE NEW.clientno = clients.clientno)," ",(SELECT last_name from clients WHERE NEW.clientno = clients.clientno)," has made a/an ", (SELECT servicename from services WHERE NEW.serviceid = services.serviceid)," appointment"))
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `notify_cancelled` AFTER UPDATE ON `appointments` FOR EACH ROW IF NEW.status = 'cancelled' THEN
INSERT INTO `notify_sp` (`appointmentno`,`receiver`, `clientno` , `notifmessage`) VALUES (OLD.appointmentno, OLD.spid, OLD.clientno, CONCAT((SELECT first_name from clients WHERE OLD.clientno = clients.clientno),(SELECT last_name from clients WHERE OLD.clientno = clients.clientno)," has cancelled your ", (SELECT servicename from services WHERE OLD.serviceid = services.serviceid), " appointment."));
END IF
$$
DELIMITER ;
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
DELIMITER $$
CREATE TRIGGER `update_vacancy_oncancel` BEFORE DELETE ON `appointments` FOR EACH ROW BEGIN
	UPDATE serviceprovider_schedules 
		SET vacant = 'yes'
	WHERE schedid = OLD.sp_schedid;
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
(101113, 'Joshua', 'Warren', '1982-03-23', 'WarrenJosh@gmail.com', 'JoshWarren', 'iyoyiw77', '09107392170', 'ABC Rd, Quantum Theory City', '2017-04-25 23:37:59', 'N', NULL),
(101134, 'Jared', 'Vasquez', '1986-04-22', 'jared01@yahoo.com', 'JaredVasquez', 'pjvde96s', '09472961670', 'Bagong Anak, Dinasilang Bldg., BC.', '2017-04-25 23:49:23', 'Y', NULL),
(101425, 'Aubrey', 'Aguilar', '1992-05-18', 'AguilarA@gmail.com', 'AubreyA', 'aub1992a', '09151940119', 'Alpaca 69, Dagupan City', '2017-04-25 23:48:48', 'N', NULL),
(102589, 'Loraine', 'Luna', '1989-02-16', 'Loraine992@gmail.com', 'LorLuna', 'lunapass7832', '09458127041', 'Orocan Rd., Dagupan, Pangasinan', '2017-04-25 23:38:39', 'Y', NULL),
(110005, 'Norma', 'Castro', '1990-01-03', 'NormaCastro77@yahoo.com', 'NormaCastro', 'cas456tro', '09081904216', '#22 Bonifacio St., Baguio City', '2017-04-26 07:35:50', 'Y', NULL),
(110006, 'Katie', 'Fuller', '1991-10-19', 'katfuller@gmail.com', 'Kat', '1991kabnm', '09184686141', 'Water Station Heaven Rd., BC', '2017-04-26 07:41:30', 'Y', NULL),
(110007, 'Rex', 'Scott', '1989-11-16', 'rex256@gmail.com', 'RexS', 'yuio567', '09774978637', 'Ang River, Sa Tubig City', '2017-04-26 07:41:30', 'Y', NULL),
(110009, 'Lynda', 'Riley', '1975-06-08', 'LynRil@gmail.com', 'Lynda', 'ril678da', '09288036814', 'Pels stop St., Last One Bldg, BC', '2017-04-26 07:35:18', 'Y', NULL),
(110010, 'Mark', 'Espiritu', '1990-02-02', 'ohmyara@gmail.com', '2150804', '123asd', '09412215644', 'Banal Ata St., Gotham City', '2017-04-29 18:46:33', 'Y', NULL);

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
-- Table structure for table `notify_client`
--

CREATE TABLE `notify_client` (
  `clinotif` int(11) NOT NULL,
  `appointmentno` int(11) DEFAULT NULL,
  `spid` int(11) NOT NULL,
  `receiver` int(11) NOT NULL,
  `notifmessage` varchar(100) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `seen` enum('false','true') NOT NULL DEFAULT 'false'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notify_client`
--

INSERT INTO `notify_client` (`clinotif`, `appointmentno`, `spid`, `receiver`, `notifmessage`, `timestamp`, `seen`) VALUES
(1, 1, 220012, 110010, 'Irma Baker has accepted your request', '2017-05-12 13:07:22', 'true'),
(2, 1, 220012, 110010, 'Irma Baker has marked your Haircut appointment done', '2017-05-12 13:07:34', 'true'),
(3, 1, 220012, 110010, 'Irma Baker has marked your Haircut appointment done', '2017-05-12 13:07:39', 'true'),
(4, 2, 220012, 110010, 'Irma Baker has accepted your request', '2017-05-12 17:06:48', 'true'),
(5, 2, 220012, 110010, 'Irma Baker has marked your Haircut appointment done', '2017-05-12 17:07:35', 'true'),
(6, 2, 220012, 110010, 'Irma Baker has marked your Haircut appointment done', '2017-05-12 17:08:33', 'true');

-- --------------------------------------------------------

--
-- Table structure for table `notify_sp`
--

CREATE TABLE `notify_sp` (
  `notifspid` int(11) NOT NULL,
  `appointmentno` int(11) DEFAULT NULL,
  `receiver` int(11) NOT NULL,
  `clientno` int(11) NOT NULL,
  `notifmessage` varchar(100) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notify_sp`
--

INSERT INTO `notify_sp` (`notifspid`, `appointmentno`, `receiver`, `clientno`, `notifmessage`, `timestamp`) VALUES
(1, 1, 220012, 110010, 'Mark Espiritu has made a/an Haircut appointment', '2017-05-12 13:04:52'),
(2, 2, 220012, 110010, 'Mark Espiritu has made a/an Haircut appointment', '2017-05-12 17:06:26');

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
  `accepted` enum('A','P','D') NOT NULL DEFAULT 'P',
  `totalrating` int(11) NOT NULL DEFAULT '0',
  `profpic` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `serviceproviders`
--

INSERT INTO `serviceproviders` (`spid`, `first_name`, `last_name`, `email`, `contactno`, `username`, `password`, `accepted`, `totalrating`, `profpic`) VALUES
(220012, 'Irma', 'Baker', 'irmabaker9@gmail.com', '09188988995', 'Irma', 'bakeeer56', 'A', 2, NULL),
(220042, 'Thomas', 'Ryan', 'ThomasR88@gmail.com', '09465694371', 'Thomas', 'jaden1456', 'A', 0, NULL),
(220052, 'Jessie', 'Lee', 'jessie03@yahoo.com', '09772213075', 'JessieLee', '03qwerty', 'P', 0, NULL),
(220125, 'Myron', 'Franklin', 'MFranklin@yahoo.com', '09436845560', 'Myron', 'ixabun27', 'A', 0, NULL),
(220254, 'Lela', 'Salazar', 'lela52salazar@yahoo.com', '09158847461', 'Lela', '123LS52', 'P', 0, NULL),
(220582, 'Angelica', 'Sherman', 'angel67@gmail.com', '09265751126', 'angel', 'sherang546', 'A', 0, NULL),
(224695, 'Gerard', 'West', 'GW67@gmail.com', '09282713478', 'GW', '67drareg', 'P', 0, NULL),
(226482, 'May', 'Ellis', 'ellismay@yahoo.com', '09499251352', 'Maye', '1983may', 'A', 0, NULL);

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
(20, 220012, '2017-05-11', '09:30:00', '11:30:00', 'yes'),
(21, 220012, '2017-05-12', '09:30:00', '11:30:00', 'yes'),
(22, 220012, '2017-05-13', '09:30:00', '11:30:00', 'no'),
(23, 220012, '2017-05-14', '09:30:00', '11:30:00', 'yes'),
(24, 220042, '2017-05-11', '09:30:00', '11:30:00', 'yes'),
(25, 220042, '2017-05-12', '09:30:00', '11:30:00', 'yes'),
(26, 220042, '2017-05-13', '09:30:00', '11:30:00', 'yes'),
(27, 220042, '2017-05-14', '09:30:00', '11:30:00', 'yes'),
(28, 220052, '2017-05-11', '09:30:00', '11:30:00', 'yes'),
(29, 220052, '2017-05-12', '09:30:00', '11:30:00', 'yes'),
(30, 220052, '2017-05-13', '09:30:00', '11:30:00', 'yes'),
(31, 220125, '2017-05-11', '09:30:00', '11:30:00', 'yes'),
(32, 220125, '2017-05-12', '09:30:00', '11:30:00', 'yes'),
(33, 220125, '2017-05-13', '09:30:00', '11:30:00', 'yes'),
(34, 220254, '2017-05-11', '09:30:00', '11:30:00', 'yes'),
(35, 220254, '2017-05-12', '09:30:00', '11:30:00', 'yes'),
(36, 220254, '2017-05-13', '09:30:00', '11:30:00', 'yes'),
(37, 220582, '2017-05-12', '01:00:00', '04:30:00', 'yes'),
(38, 220582, '2017-05-13', '01:00:00', '04:30:00', 'yes'),
(39, 220582, '2017-05-14', '01:00:00', '04:30:00', 'yes'),
(40, 224695, '2017-05-12', '01:00:00', '04:30:00', 'yes'),
(41, 224695, '2017-05-13', '01:00:00', '04:30:00', 'yes'),
(42, 224695, '2017-05-14', '01:00:00', '04:30:00', 'yes'),
(43, 226482, '2017-05-11', '01:00:00', '04:30:00', 'yes'),
(44, 226482, '2017-05-12', '01:00:00', '04:30:00', 'yes'),
(45, 226482, '2017-05-13', '01:00:00', '04:30:00', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `serviceid` int(11) NOT NULL,
  `servicename` char(20) NOT NULL,
  `description` varchar(50) NOT NULL,
  `category` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`serviceid`, `servicename`, `description`, `category`) VALUES
(201, 'Haircut', 'starting price for minimum length ', 'Hair Styling'),
(202, 'shampoo and blowdry', 'simple shampoo and blowdry for damaged hair', 'Hair Styling'),
(203, 'Iron/Curling', 'straighten or curl hair', 'Hair Styling'),
(204, 'Eye makeup', 'any style for eye makeup', 'Makeup'),
(205, 'Full makeup', 'full face makeup', 'Makeup'),
(206, 'tint (root)', 'hair coloring at the roots', 'Hair Coloring'),
(207, 'tint (full)', 'hair coloring of full length', 'Hair Coloring'),
(208, 'Conditioning', 'hair color conditioning', 'Hair Coloring'),
(209, 'Highlights', 'hair highlights, any style', 'Hair Coloring'),
(210, 'hot oil', 'regular hot oil treatment', 'Hair Treatment'),
(211, 'hair spa', 'regular hair treatment', 'Hair Treatment'),
(212, 'Keratherapy', 'express keratherapy', 'Hair Treatment'),
(213, 'eyebrow wax', 'eyebrow waxing', 'Waxing'),
(214, 'Underarm wax', 'underarm waxing', 'Waxing'),
(215, 'Arm wax', 'full arm waxing', 'Waxing'),
(216, 'Leg wax', 'full leg waxing', 'Waxing'),
(217, 'Bikini wax', 'bikini area waxing', 'Waxing'),
(218, 'Brazilian wax', 'brazilian type of waxing', 'Waxing'),
(219, 'Perm', 'hair perm', 'Hair Form'),
(220, 'Relax', 'hair relax', 'Hair Form'),
(221, 'Rebond', 'hair rebond', 'Hair Form'),
(222, 'manicure', 'fingernails and hand treatment', 'Nails'),
(223, 'foot spa', 'foot care', 'Foot'),
(224, 'Pedicure', 'foot and toenails treatment', 'Nails'),
(225, 'Nail art', 'choose from any nail design available', 'Foot');

-- --------------------------------------------------------

--
-- Table structure for table `sp_skills`
--

CREATE TABLE `sp_skills` (
  `spid` int(11) NOT NULL,
  `serviceid` int(11) NOT NULL,
  `price` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sp_skills`
--

INSERT INTO `sp_skills` (`spid`, `serviceid`, `price`) VALUES
(220012, 201, 100),
(220012, 202, 150),
(220012, 203, 120),
(220012, 208, 100),
(220042, 209, 300);

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
  ADD KEY `sp_schedid` (`sp_schedid`),
  ADD KEY `spid` (`spid`);

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
-- Indexes for table `notify_client`
--
ALTER TABLE `notify_client`
  ADD PRIMARY KEY (`clinotif`),
  ADD KEY `fk_spid_notif_idx` (`spid`),
  ADD KEY `fk_client_rec_idx` (`receiver`),
  ADD KEY `fk_appoint_nc_idx` (`appointmentno`);

--
-- Indexes for table `notify_sp`
--
ALTER TABLE `notify_sp`
  ADD PRIMARY KEY (`notifspid`),
  ADD KEY `fk_spid_rec_idx` (`receiver`),
  ADD KEY `fk_clientno_not_idx` (`clientno`),
  ADD KEY `fk_appoint_ns_idx` (`appointmentno`);

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
  ADD UNIQUE KEY `ServiceId_UNIQUE` (`serviceid`);

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
  MODIFY `appointmentno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `clientno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110011;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `messageid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `notify_client`
--
ALTER TABLE `notify_client`
  MODIFY `clinotif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `notify_sp`
--
ALTER TABLE `notify_sp`
  MODIFY `notifspid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `serviceproviders`
--
ALTER TABLE `serviceproviders`
  MODIFY `spid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=226483;
--
-- AUTO_INCREMENT for table `serviceprovider_schedules`
--
ALTER TABLE `serviceprovider_schedules`
  MODIFY `schedid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;
--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `serviceid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=226;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `fk_app_client` FOREIGN KEY (`clientno`) REFERENCES `clients` (`clientno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_service` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`),
  ADD CONSTRAINT `sched_fk` FOREIGN KEY (`sp_schedid`) REFERENCES `serviceprovider_schedules` (`schedid`),
  ADD CONSTRAINT `spid_fk` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `client_username` FOREIGN KEY (`client_username`) REFERENCES `clients` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sp_username` FOREIGN KEY (`sp_username`) REFERENCES `serviceproviders` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notify_client`
--
ALTER TABLE `notify_client`
  ADD CONSTRAINT `fk_appoint_nc` FOREIGN KEY (`appointmentno`) REFERENCES `appointments` (`appointmentno`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_client_rec` FOREIGN KEY (`receiver`) REFERENCES `clients` (`clientno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_spid_notif` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notify_sp`
--
ALTER TABLE `notify_sp`
  ADD CONSTRAINT `fk_appoint_sp` FOREIGN KEY (`appointmentno`) REFERENCES `appointments` (`appointmentno`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_clientno_not` FOREIGN KEY (`clientno`) REFERENCES `clients` (`clientno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_spid_rec` FOREIGN KEY (`receiver`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `serviceprovider_schedules`
--
ALTER TABLE `serviceprovider_schedules`
  ADD CONSTRAINT `sp_fk` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sp_skills`
--
ALTER TABLE `sp_skills`
  ADD CONSTRAINT `fk_skill` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_skills_sp` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
