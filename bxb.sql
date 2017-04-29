-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2017 at 12:25 AM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bxb`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `appointmentno` int(11) NOT NULL,
  `amount` double NOT NULL,
  `daterequest` date NOT NULL,
  `dateofservice` date NOT NULL,
  `dateFinished` date NOT NULL,
  `status` char(10) NOT NULL,
  `clientno` int(11) NOT NULL,
  `spid` int(11) NOT NULL,
  `serviceid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appointmentno`, `amount`, `daterequest`, `dateofservice`, `dateFinished`, `status`, `clientno`, `spid`, `serviceid`) VALUES
(1, 800, '2016-08-17', '2016-10-17', '2016-10-17', 'finished', 101134, 220012, 205),
(2, 1500, '2016-08-24', '2017-04-30', '2017-04-30', 'finished', 110005, 220042, 209),
(3, 450, '2017-02-13', '2017-02-13', '2017-02-13', 'cancelled', 101113, 224695, 214),
(4, 1050, '2016-03-14', '2016-03-24', '2016-03-24', 'finished', 102589, 220254, 206),
(5, 950, '2016-07-06', '2016-07-14', '2016-07-14', 'finished', 110006, 220125, 211),
(6, 650, '2015-12-13', '2015-12-15', '2015-12-15', 'cancelled', 101425, 220052, 218),
(7, 210, '2017-03-15', '2017-03-19', '2017-03-19', 'finished', 110010, 226482, 213),
(8, 2200, '2016-05-13', '2016-05-17', '2016-05-17', 'finished', 110007, 2225142, 220);

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `clientno` int(11) NOT NULL,
  `first_name` char(20) NOT NULL,
  `last_name` char(15) NOT NULL,
  `birthdate` date NOT NULL,
  `email` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `contactNo` varchar(15) NOT NULL,
  `accountcreated` timestamp(2) NOT NULL,
  `accepted` enum('Y','N') NOT NULL,
  `profpic` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`clientno`, `first_name`, `last_name`, `birthdate`, `email`, `username`, `password`, `contactNo`, `accountcreated`, `accepted`, `profpic`) VALUES
(101113, 'Joshua', 'Warren', '1982-03-23', 'WarrenJosh@gmail.com', 'JoshWarren', 'iyoyiw77', '09107392170', '2017-04-27 15:37:59.00', 'N', NULL),
(101134, 'Jared', 'Vasquez', '1986-04-22', 'jared01@yahoo.com', 'JaredVasquez', 'pjvde96s', '09472961670', '2017-04-27 15:49:23.00', 'Y', NULL),
(101425, 'Aubrey', 'Aguilar', '1992-05-18', 'AguilarA@gmail.com', 'AubreyA', 'aub1992a', '09151940119', '2017-04-27 15:48:48.00', 'N', NULL),
(102589, 'Loraine', 'Luna', '1989-02-16', 'Loraine992@gmail.com', 'LorLuna', 'lunapass7832', '09458127041', '2017-04-27 15:38:39.00', 'Y', NULL),
(110005, 'Norma', 'Castro', '1990-01-03', 'NormaCastro77@yahoo.com', 'NormaCastro', 'cas456tro', '09081904216', '2017-04-27 23:35:50.00', 'Y', NULL),
(110006, 'Katie', 'Fuller', '1991-10-19', 'katfuller@gmail.com', 'Kat', '1991kabnm', '09184686141', '2017-04-27 23:41:30.00', 'Y', NULL),
(110007, 'Rex', 'Scott', '1989-11-16', 'rex256@gmail.com', 'RexS', 'yuio567', '09774978637', '2017-04-27 23:41:30.00', 'Y', NULL),
(110009, 'Lynda', 'Riley', '1975-06-08', 'LynRil@gmail.com', 'Lynda', 'ril678da', '09288036814', '2017-04-27 23:35:18.00', 'Y', NULL),
(110010, 'Anita', 'Berry', '1992-05-11', 'Aberry@yahoo.com', 'Anita', 'zxc234', '09196925493', '2017-04-27 23:35:18.00', 'Y', NULL),
(110012, 'Walter', 'Black', '1990-09-13', 'walterblack12@yahoo.com', 'Walter', '987walter', '09287042539', '2017-04-27 23:46:44.00', 'Y', NULL),
(110015, 'Elaine', 'Estrada', '1982-07-19', 'elaine34@gmail.com', 'elestrada', 'salonpw', '09268130247', '2017-04-27 23:46:44.00', 'Y', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `messageid` varchar(45) NOT NULL,
  `receiver` int(11) NOT NULL,
  `sender` int(11) NOT NULL,
  `mdesc` varchar(160) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `serviceid` int(11) NOT NULL,
  `servicename` char(20) NOT NULL,
  `serviceamount` float NOT NULL,
  `description` varchar(50) NOT NULL,
  `category` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`serviceid`, `servicename`, `serviceamount`, `description`, `category`) VALUES
(201, 'Haircut', 150, 'starting price for minimum length ', 'hair'),
(202, 'shampoo and blowdry', 100, '', 'hair'),
(203, 'Iron/Curling', 500, 'straighten or curl hair', 'hair'),
(204, 'Eye makeup', 400, 'any style for eye makeup', 'Makeup'),
(205, 'Full makeup', 800, 'full face makeup', 'Makeup'),
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
-- Table structure for table `serviceprovider`
--

CREATE TABLE `serviceprovider` (
  `spid` int(11) NOT NULL,
  `first_name` char(20) NOT NULL,
  `last_name` char(10) NOT NULL,
  `email` varchar(45) NOT NULL,
  `contactno` varchar(15) NOT NULL,
  `totalrating` float NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `accepted` enum('Y','N') NOT NULL,
  `profpic` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `serviceprovider`
--

INSERT INTO `serviceprovider` (`spid`, `first_name`, `last_name`, `email`, `contactno`, `totalrating`, `username`, `password`, `accepted`, `profpic`) VALUES
(220012, 'Irma', 'Baker', 'irmabaker9@gmail.com', '09188988995', 92, 'Irma', 'bakeeer56', 'Y', NULL),
(220042, 'Thomas', 'Ryan', 'ThomasR88@gmail.com', '09465694371', 92, 'Thomas', 'jaden1456', 'Y', NULL),
(220052, 'Jessie', 'Lee', 'jessie03@yahoo.com', '09772213075', 79, 'JessieLee', '03qwerty', 'N', NULL),
(220125, 'Myron', 'Franklin', 'MFranklin@yahoo.com', '09436845560', 80, 'Myron', 'ixabun27', 'Y', NULL),
(220254, 'Lela', 'Salazar', 'lela52salazar@yahoo.com', '09158847461', 92, 'Lela', '123LS52', 'N', NULL),
(220582, 'Angelica', 'Sherman', 'angel67@gmail.com', '09265751126', 89, 'angel', 'sherang546', 'Y', NULL),
(224695, 'Gerard', 'West', 'GW67@gmail.com', '09282713478', 82, 'GW', '67drareg', 'N', NULL),
(226482, 'May', 'Ellis', 'ellismay@yahoo.com', '09499251352', 86, 'MayE', '1983may', 'Y', NULL),
(2225142, 'Carmen', 'Flores', 'carmenflores12@gmail.com', '09129062721', 78, 'CarmenF', 'c12flores', 'Y', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `spservice`
--

CREATE TABLE `spservice` (
  `spid` int(11) NOT NULL,
  `serviceid` int(11) NOT NULL,
  `rating` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `spservice`
--

INSERT INTO `spservice` (`spid`, `serviceid`, `rating`) VALUES
(220012, 205, 92),
(220042, 209, 92),
(224695, 214, 82),
(220254, 206, 92),
(220125, 211, 80),
(220052, 218, 79),
(226482, 213, 86),
(2225142, 220, 78);

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `idtransaction` int(11) NOT NULL,
  `transdate` timestamp(2) NOT NULL,
  `appointmentno` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`idtransaction`, `transdate`, `appointmentno`) VALUES
(1, '2017-04-28 00:22:24.00', 1),
(2, '2017-04-28 00:24:47.00', 2),
(3, '2017-04-28 00:24:47.00', 4),
(4, '2017-04-28 00:24:47.00', 5),
(5, '2017-04-28 00:24:47.00', 7),
(6, '2017-04-28 00:24:47.00', 8);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`appointmentno`),
  ADD UNIQUE KEY `appointmentNo_UNIQUE` (`appointmentno`),
  ADD KEY `clientNo_idx` (`clientno`),
  ADD KEY `spID_idx` (`spid`),
  ADD KEY `serviceID_idx` (`serviceid`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`clientno`),
  ADD UNIQUE KEY `clientNo_UNIQUE` (`clientno`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`messageid`),
  ADD KEY `fk_sender_clientno_idx` (`sender`),
  ADD KEY `fk_reciever_spid` (`receiver`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`serviceid`),
  ADD UNIQUE KEY `ServiceId_UNIQUE` (`serviceid`);

--
-- Indexes for table `serviceprovider`
--
ALTER TABLE `serviceprovider`
  ADD PRIMARY KEY (`spid`),
  ADD UNIQUE KEY `spID_UNIQUE` (`spid`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Indexes for table `spservice`
--
ALTER TABLE `spservice`
  ADD KEY `serviceID_idx` (`serviceid`),
  ADD KEY `spID_idx` (`spid`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`idtransaction`),
  ADD KEY `fk_appointmentNo_appointmentNo_idx` (`appointmentno`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `fk_clientno_clientno` FOREIGN KEY (`clientno`) REFERENCES `client` (`clientno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_serviceid_serviceid` FOREIGN KEY (`serviceid`) REFERENCES `service` (`serviceid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_spid_spid` FOREIGN KEY (`spid`) REFERENCES `serviceprovider` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `fk_reciever_clientno` FOREIGN KEY (`receiver`) REFERENCES `client` (`clientno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reciever_spid` FOREIGN KEY (`receiver`) REFERENCES `serviceprovider` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sender_clientno` FOREIGN KEY (`sender`) REFERENCES `client` (`clientno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sender_spid` FOREIGN KEY (`sender`) REFERENCES `serviceprovider` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `spservice`
--
ALTER TABLE `spservice`
  ADD CONSTRAINT `fk_serviceid_serviceidsp` FOREIGN KEY (`serviceid`) REFERENCES `service` (`serviceid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_spid_spidsp` FOREIGN KEY (`spid`) REFERENCES `serviceprovider` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `fk_appointmentNo_appointmentNo` FOREIGN KEY (`appointmentno`) REFERENCES `appointment` (`appointmentno`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
