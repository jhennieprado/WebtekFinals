-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 11, 2017 at 12:17 PM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bxbmaster`
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
  `status` enum('request','accepted','rejected','done') NOT NULL DEFAULT 'request',
  `rating` int(11) NOT NULL DEFAULT '0',
  `spid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
		INSERT INTO `notify_client` (`receiver`, `spid` , `notifmessage`, `status`) VALUES ( OLD.clientno, OLD.spid, CONCAT((SELECT first_name from serviceproviders WHERE NEW.spid = serviceproviders.spid)," ",(SELECT last_name from serviceproviders WHERE NEW.spid = serviceproviders.spid)," has accepted your request"), 'Unread');
    ELSEIF NEW.status = 'done' THEN
		INSERT INTO `notify_client` (`receiver`, `spid` , `notifmessage`, `status`) VALUES (OLD.clientno, OLD.spid, CONCAT((SELECT first_name from serviceproviders WHERE NEW.spid = serviceproviders.spid)," ",(SELECT last_name from serviceproviders WHERE NEW.spid = serviceproviders.spid)," has marked your ", OLD.daterequest," appointment done"), 'Unread');
    ELSEIF NEW.status = 'rejected' THEN
		INSERT INTO `notify_client` (`receiver`, `spid` , `notifmessage`, `status`) VALUES ( OLD.clientno, OLD.spid, CONCAT((SELECT first_name from serviceproviders WHERE NEW.spid = serviceproviders.spid)," ",(SELECT last_name from serviceproviders WHERE NEW.spid = serviceproviders.spid)," has rejected your ", OLD.daterequest," request"), 'Unread');
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `add_notif_sp` BEFORE INSERT ON `appointments` FOR EACH ROW INSERT INTO `notify_sp` (`receiver`, `clientno` , `notifmessage`, `status`) VALUES (NEW.spid, NEW.clientno, CONCAT((SELECT first_name from clients WHERE NEW.clientno = clients.clientno)," ",(SELECT last_name from clients WHERE NEW.clientno = clients.clientno)," has made an appointment"), 'Unread')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `notify_cancelled` BEFORE DELETE ON `appointments` FOR EACH ROW INSERT INTO `notify_sp` (`receiver`, `clientno` , `notifmessage`, `status`) VALUES (OLD.spid, OLD.clientno, CONCAT((SELECT first_name from clients WHERE OLD.clientno = clients.clientno),(SELECT last_name from clients WHERE OLD.clientno = clients.clientno)," has cancelled your ", OLD.daterequest, " appointmenmt."), 'Unread')
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
  `spid` int(11) NOT NULL,
  `receiver` int(11) NOT NULL,
  `notifmessage` varchar(100) NOT NULL,
  `status` enum('Read','Unread') NOT NULL DEFAULT 'Unread',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `notify_sp`
--

CREATE TABLE `notify_sp` (
  `notifspid` int(11) NOT NULL,
  `receiver` int(11) NOT NULL,
  `clientno` int(11) NOT NULL,
  `notifmessage` varchar(100) NOT NULL,
  `status` enum('Read','Unread') NOT NULL DEFAULT 'Unread',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

-- --------------------------------------------------------

--
-- Table structure for table `sp_skills`
--

CREATE TABLE `sp_skills` (
  `spid` int(11) NOT NULL,
  `serviceid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  ADD KEY `fk_client_rec_idx` (`receiver`);

--
-- Indexes for table `notify_sp`
--
ALTER TABLE `notify_sp`
  ADD PRIMARY KEY (`notifspid`),
  ADD KEY `fk_spid_rec_idx` (`receiver`),
  ADD KEY `fk_clientno_not_idx` (`clientno`);

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
  MODIFY `appointmentno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `clientno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110013;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `messageid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `notify_client`
--
ALTER TABLE `notify_client`
  MODIFY `clinotif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `notify_sp`
--
ALTER TABLE `notify_sp`
  MODIFY `notifspid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `serviceproviders`
--
ALTER TABLE `serviceproviders`
  MODIFY `spid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=226485;
--
-- AUTO_INCREMENT for table `serviceprovider_schedules`
--
ALTER TABLE `serviceprovider_schedules`
  MODIFY `schedid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;
--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `serviceid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=228;
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
  ADD CONSTRAINT `fk_client_rec` FOREIGN KEY (`receiver`) REFERENCES `clients` (`clientno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_spid_notif` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notify_sp`
--
ALTER TABLE `notify_sp`
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
  ADD CONSTRAINT `fk_skill` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`),
  ADD CONSTRAINT `fk_skills_sp` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
