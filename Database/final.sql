CREATE DATABASE  IF NOT EXISTS `bxbfin(1)` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `bxbfin(1)`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: bxbfin(1)
-- ------------------------------------------------------
-- Server version	5.7.14

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointments` (
  `appointmentno` int(11) NOT NULL AUTO_INCREMENT,
  `sp_schedid` int(11) NOT NULL,
  `daterequest` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `clientno` int(11) NOT NULL,
  `serviceid` int(11) NOT NULL,
  `status` enum('request','accepted','rejected','done','cancelled') NOT NULL DEFAULT 'request',
  `rating` int(11) NOT NULL DEFAULT '0',
  `spid` int(11) NOT NULL,
  `amount` float NOT NULL,
  PRIMARY KEY (`appointmentno`),
  UNIQUE KEY `appointmentNo_UNIQUE` (`appointmentno`),
  KEY `serviceID_idx` (`serviceid`),
  KEY `fk_app_client_idx` (`clientno`),
  KEY `sp_schedid` (`sp_schedid`),
  KEY `spid` (`spid`),
  CONSTRAINT `fk_app_client` FOREIGN KEY (`clientno`) REFERENCES `clients` (`clientno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_service` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`),
  CONSTRAINT `sched_fk` FOREIGN KEY (`sp_schedid`) REFERENCES `serviceprovider_schedules` (`schedid`),
  CONSTRAINT `spid_fk` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (28,202,'2017-05-12 00:30:00',110046,245,'done',4,226480,300),(29,203,'2017-05-13 00:00:00',110047,269,'done',4,226480,670),(30,205,'2017-05-14 23:00:00',110048,244,'accepted',0,226481,450),(31,206,'2017-05-16 00:00:00',110049,268,'accepted',0,226481,340),(32,208,'2017-05-17 23:00:00',110050,242,'accepted',0,226482,300),(33,209,'2017-05-19 00:00:00',110051,244,'accepted',0,226482,450),(34,211,'2017-05-11 23:00:00',110052,244,'done',4,226483,450),(35,212,'2017-05-13 00:00:00',110053,245,'done',4,226483,150),(36,214,'2017-05-14 23:00:00',110054,268,'accepted',0,226484,340),(37,215,'2017-05-16 00:00:00',110055,269,'accepted',0,226484,670),(38,217,'2017-05-17 23:00:00',110056,261,'accepted',0,226485,630),(39,218,'2017-05-19 00:00:00',110057,262,'accepted',0,226485,640),(40,220,'2017-05-20 23:00:00',110058,265,'request',0,226486,340),(41,221,'2017-06-20 00:00:00',110059,266,'request',0,226486,760),(42,223,'2017-05-21 23:00:00',110060,261,'request',0,226487,630),(43,224,'2017-05-12 00:00:00',110061,262,'done',4,226487,640),(44,226,'2017-05-13 23:00:00',110062,265,'accepted',0,226488,340),(45,227,'2017-05-27 00:00:00',110063,266,'request',0,226488,760),(46,229,'2017-05-26 23:00:00',110064,262,'request',0,226489,640),(47,230,'2017-05-28 00:00:00',110065,263,'request',0,226489,980),(48,232,'2017-05-27 23:00:00',110066,249,'request',0,226490,180),(49,233,'2017-05-29 00:00:00',110067,250,'request',0,226490,250),(50,235,'2017-06-02 23:00:00',110068,259,'request',0,226491,350),(51,236,'2017-06-02 00:00:00',110069,260,'request',0,226491,300),(52,238,'2017-05-31 23:00:00',110070,247,'request',0,226492,400),(53,239,'2017-06-02 00:00:00',110060,248,'request',0,226492,550),(54,241,'2017-05-29 23:00:00',110061,253,'request',0,226493,120),(55,242,'2017-06-02 00:00:00',110062,254,'request',0,226493,140),(56,244,'2017-06-02 23:00:00',110063,257,'request',0,226494,300),(57,245,'2017-06-04 00:00:00',110064,258,'request',0,226494,400),(58,247,'2017-06-03 23:00:00',110065,259,'request',0,226495,350),(59,248,'2017-06-15 00:00:00',110066,260,'request',0,226495,300);
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `clientno` int(11) NOT NULL AUTO_INCREMENT,
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
  `profpic` blob,
  PRIMARY KEY (`clientno`),
  UNIQUE KEY `clientNo_UNIQUE` (`clientno`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=110071 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (110046,'Joseph','Dupingay','1997-04-24','dupingay@gmail.com','joseph','joseph123','09214548656','Trancoville, Baguio City','2014-05-04 10:25:51','Y',NULL),(110047,'Patricia','Canaria','1997-08-30','canaria@yahoo.com','patricia','patricia123','09415775454','Engineers Hill, Baguio City','2016-05-04 09:25:51','Y',NULL),(110048,'Riechel','Fabrigas','1996-12-22','fabrigas@gmail.com','achel','riechl123','09295200241','DPS, Baguio City','2013-05-04 08:25:51','Y',NULL),(110049,'Sean','Sahagun','1997-02-15','sahagun@gmail.com','sean','sean123','09212256287','Navy Base, Baguio City','2013-05-04 06:25:51','Y',NULL),(110050,'Jhennie','Prado','1997-08-22','prado@gmail.com','jhennie','jhennie123','09099949495','Pacdal, Baguio City','2013-05-04 05:25:51','Y',NULL),(110051,'David','Cardenas','1997-06-01','cardenas@gmail.com','david','david123','09999932152','Mines View, Baguio City','2013-05-04 04:25:51','Y',NULL),(110052,'Isaac','Medina','1996-05-13','medina@gmail.com','vash','isaac123','09321456752','Liteng, Baguio City','2013-05-04 03:25:51','Y',NULL),(110053,'Ali','Mondiguing','1997-05-25','mondiguing@gmail.com','ali','ali123','09215642632','Aurora Hill, Baguio City','2014-05-04 02:25:51','Y',NULL),(110054,'Dominik','De Leon','1996-09-15','deleon@gmail.com','dominik','dominik123','09584874847','Upper Loakan, Baguio City','2015-05-04 01:25:51','Y',NULL),(110055,'Adrian','Aspiras','1998-02-27','aspiras@gmail.com','adrian','adrian123','09634897425','Lower Loakan, Baguio City','2015-05-04 00:25:51','Y',NULL),(110056,'Ethnica','Carantes','1997-04-05','carantes@gmail.com','ethnica','ethnica123','09521847585','Mines View, Baguio City','2015-05-04 11:25:51','Y',NULL),(110057,'Kyla','Alunday','1997-01-03','alunday@gmail.com','kyla','kyla123','09153548322','Gibraltar, Baguio City','2014-05-04 05:25:51','Y',NULL),(110058,'Mandy','Lee','1997-07-05','lee@gmail.com','mandy','mandy123','09546481328','Teacher\'s Camp, Baguio City','2014-05-04 12:25:51','Y',NULL),(110059,'Paul','Catalan','1996-07-12','catalan@gmail.com','paul','paul123','09684784512','Asin, Baguio City','2014-05-04 05:25:51','Y',NULL),(110060,'John Carlo','Manantan','1997-09-02','manantan@yahoo.com','johncarlo','johncarlo123','09095478545','Trancoville, Baguio City','2016-05-04 04:25:51','Y',NULL),(110061,'Francesca','Sarmiento','1997-12-30','sarmiento@yahoo.com','francesca','sarmiento123','09153544716','Sagada, Baguio City','2016-05-03 17:25:51','Y',NULL),(110062,'Alissa','Castro','1997-09-24','castro@yahoo.com','alissa','alissa123','09211487889','Hillside, Baguio City','2016-05-04 03:25:51','Y',NULL),(110063,'Clark','Mariano','1996-03-29','mariano@gmail.com','clark','clark123','09321548755','Trancoville, Baguio City','2015-05-04 11:25:51','Y',NULL),(110064,'April','Agcon','1998-04-16','agcon@yahoo.com','april','april123','09877514125','Green Valley, Baguio City','2015-05-04 11:25:51','Y',NULL),(110065,'Shania','Dicen','1997-03-26','dicen@yahoo.com','shania','shania123','09521247579','Hillside, Baguio City','2016-05-04 11:25:51','Y',NULL),(110066,'Hiro','Uematsu','1995-02-07','uematsu@yahoo.com','hiro','hiro123','09521242212','Camp 7, Baguio City','2017-05-04 11:25:51','N',NULL),(110067,'Rio','Kolodzik','1997-03-25','kolodzik@yahoo.com','rio','rio123','09121212121','Crystal Cave, Baguio City','2017-05-04 11:25:51','N',NULL),(110068,'Shary','Chakas','1997-08-20','chakas@yahoo.com','shary','shary123','09323232323','Holy Ghost, Baguio City','2017-05-04 06:25:51','N',NULL),(110069,'Angelica','Mones','1998-03-22','mones@yahoo.com','angelica','angalica123','09451545778','Green Water, Baguio City','2017-05-04 04:25:51','N',NULL),(110070,'Seanneil','De Ayre','1997-01-03','deayre@yahoo.com','seanneil','seanneil123','09123456664','Irisan, Baguio City','2017-05-04 11:25:51','N',NULL);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `messageid` int(11) NOT NULL AUTO_INCREMENT,
  `sender_username` varchar(45) NOT NULL,
  `message` varchar(160) NOT NULL,
  `client_username` varchar(45) NOT NULL,
  `sp_username` varchar(45) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`messageid`),
  KEY `fk_message_clientno_idx` (`client_username`),
  KEY `fk_message_spid_idx` (`sp_username`),
  CONSTRAINT `client_username` FOREIGN KEY (`client_username`) REFERENCES `clients` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sp_username` FOREIGN KEY (`sp_username`) REFERENCES `serviceproviders` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notify_client`
--

DROP TABLE IF EXISTS `notify_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notify_client` (
  `clinotif` int(11) NOT NULL AUTO_INCREMENT,
  `appointmentno` int(11) DEFAULT NULL,
  `spid` int(11) NOT NULL,
  `receiver` int(11) NOT NULL,
  `notifmessage` varchar(100) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `seen` enum('false','true') NOT NULL DEFAULT 'false',
  PRIMARY KEY (`clinotif`),
  KEY `fk_spid_notif_idx` (`spid`),
  KEY `fk_client_rec_idx` (`receiver`),
  KEY `fk_appoint_nc_idx` (`appointmentno`),
  CONSTRAINT `fk_appoint_nc` FOREIGN KEY (`appointmentno`) REFERENCES `appointments` (`appointmentno`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_client_rec` FOREIGN KEY (`receiver`) REFERENCES `clients` (`clientno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_spid_notif` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notify_client`
--

LOCK TABLES `notify_client` WRITE;
/*!40000 ALTER TABLE `notify_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `notify_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notify_sp`
--

DROP TABLE IF EXISTS `notify_sp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notify_sp` (
  `notifspid` int(11) NOT NULL AUTO_INCREMENT,
  `appointmentno` int(11) DEFAULT NULL,
  `receiver` int(11) NOT NULL,
  `clientno` int(11) NOT NULL,
  `notifmessage` varchar(100) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notifspid`),
  KEY `fk_spid_rec_idx` (`receiver`),
  KEY `fk_clientno_not_idx` (`clientno`),
  KEY `fk_appoint_ns_idx` (`appointmentno`),
  CONSTRAINT `fk_appoint_sp` FOREIGN KEY (`appointmentno`) REFERENCES `appointments` (`appointmentno`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_clientno_not` FOREIGN KEY (`clientno`) REFERENCES `clients` (`clientno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_spid_rec` FOREIGN KEY (`receiver`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notify_sp`
--

LOCK TABLES `notify_sp` WRITE;
/*!40000 ALTER TABLE `notify_sp` DISABLE KEYS */;
INSERT INTO `notify_sp` VALUES (28,28,226480,110046,'Joseph Dupingay has made a/an BxB Signature Massage appointment','2017-05-12 19:49:31'),(29,29,226480,110047,'Patricia Canaria has made a/an Lip Threading appointment','2017-05-12 19:49:31'),(30,30,226481,110048,'Riechel Fabrigas has made a/an Deep Tissue Massage appointment','2017-05-12 19:49:31'),(31,31,226481,110049,'Sean Sahagun has made a/an Bikini Plus appointment','2017-05-12 19:49:31'),(32,32,226482,110050,'Jhennie Prado has made a/an Detoxifying Seaweed Wrap appointment','2017-05-12 19:49:31'),(33,33,226482,110051,'David Cardenas has made a/an Deep Tissue Massage appointment','2017-05-12 19:49:31'),(34,34,226483,110052,'Isaac Medina has made a/an Deep Tissue Massage appointment','2017-05-12 19:49:31'),(35,35,226483,110053,'Ali Mondiguing has made a/an BxB Signature Massage appointment','2017-05-12 19:49:31'),(36,36,226484,110054,'Dominik De Leon has made a/an Bikini Plus appointment','2017-05-12 19:49:31'),(37,37,226484,110055,'Adrian Aspiras has made a/an Lip Threading appointment','2017-05-12 19:49:31'),(38,38,226485,110056,'Ethnica Carantes has made a/an Olive Oil Manicure appointment','2017-05-12 19:49:31'),(39,39,226485,110057,'Kyla Alunday has made a/an BxB Signature Manicure appointment','2017-05-12 19:49:31'),(40,40,226486,110058,'Mandy Lee has made a/an Pedicure Refresher appointment','2017-05-12 19:49:31'),(41,41,226486,110059,'Paul Catalan has made a/an Warm Cream Pedicure appointment','2017-05-12 19:49:31'),(42,42,226487,110060,'John Carlo Manantan has made a/an Olive Oil Manicure appointment','2017-05-12 19:49:31'),(43,43,226487,110061,'Francesca Sarmiento has made a/an BxB Signature Manicure appointment','2017-05-12 19:49:31'),(44,44,226488,110062,'Alissa Castro has made a/an Pedicure Refresher appointment','2017-05-12 19:49:31'),(45,45,226488,110063,'Clark Mariano has made a/an Warm Cream Pedicure appointment','2017-05-12 19:49:31'),(46,46,226489,110064,'April Agcon has made a/an BxB Signature Manicure appointment','2017-05-12 19:49:31'),(47,47,226489,110065,'Shania Dicen has made a/an Youth Restoring Manicure appointment','2017-05-12 19:49:31'),(48,48,226490,110066,'Hiro Uematsu has made a/an Ceramide Anti-aging Facial appointment','2017-05-12 19:49:31'),(49,49,226490,110067,'Rio Kolodzik has made a/an BxB Signature Facial appointment','2017-05-12 19:49:31'),(50,50,226491,110068,'Shary Chakas has made a/an Eyelash Tints appointment','2017-05-12 19:49:31'),(51,51,226491,110069,'Angelica Mones has made a/an Makeup Application appointment','2017-05-12 19:49:31'),(52,52,226492,110070,'Seanneil De Ayre has made a/an Arden Standard Facial appointment','2017-05-12 19:49:31'),(53,53,226492,110060,'John Carlo Manantan has made a/an Back Facial appointment','2017-05-12 19:49:31'),(54,54,226493,110061,'Francesca Sarmiento has made a/an Collagen Mask - Face appointment','2017-05-12 19:49:31'),(55,55,226493,110062,'Alissa Castro has made a/an Keratin Hair Therapy Treatment appointment','2017-05-12 19:49:31'),(56,56,226494,110063,'Clark Mariano has made a/an Special Occasion Hair appointment','2017-05-12 19:49:31'),(57,57,226494,110064,'April Agcon has made a/an Deep Hair Condition Treatment appointment','2017-05-12 19:49:31'),(58,58,226495,110065,'Shania Dicen has made a/an Eyelash Tints appointment','2017-05-12 19:49:31'),(59,59,226495,110066,'Hiro Uematsu has made a/an Makeup Application appointment','2017-05-12 19:49:31');
/*!40000 ALTER TABLE `notify_sp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serviceprovider_schedules`
--

DROP TABLE IF EXISTS `serviceprovider_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serviceprovider_schedules` (
  `schedid` int(11) NOT NULL AUTO_INCREMENT,
  `spid` int(11) NOT NULL,
  `sched_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `vacant` enum('yes','no') NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`schedid`),
  KEY `serviceID_idx` (`schedid`),
  KEY `fk_spservice_spid_idx` (`spid`),
  CONSTRAINT `sp_fk` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serviceprovider_schedules`
--

LOCK TABLES `serviceprovider_schedules` WRITE;
/*!40000 ALTER TABLE `serviceprovider_schedules` DISABLE KEYS */;
INSERT INTO `serviceprovider_schedules` VALUES (202,226480,'2017-05-12','07:00:00','11:00:00','yes'),(203,226480,'2017-05-13','08:00:00','12:00:00','yes'),(204,226480,'2017-05-14','07:00:00','11:00:00','yes'),(205,226481,'2017-05-15','07:00:00','11:00:00','yes'),(206,226481,'2017-05-16','08:00:00','12:00:00','yes'),(207,226481,'2017-05-17','07:00:00','11:00:00','yes'),(208,226482,'2017-05-18','07:00:00','11:00:00','yes'),(209,226482,'2017-05-19','08:00:00','12:00:00','yes'),(210,226482,'2017-05-20','01:00:00','17:00:00','yes'),(211,226483,'2017-05-12','07:00:00','11:00:00','yes'),(212,226483,'2017-05-13','08:00:00','12:00:00','yes'),(213,226483,'2017-05-14','01:00:00','17:00:00','yes'),(214,226484,'2017-05-15','07:00:00','11:00:00','yes'),(215,226484,'2017-05-16','08:00:00','12:00:00','yes'),(216,226484,'2017-05-17','01:00:00','17:00:00','yes'),(217,226485,'2017-05-18','07:00:00','11:00:00','yes'),(218,226485,'2017-05-19','08:00:00','12:00:00','yes'),(219,226485,'2017-06-20','01:00:00','17:00:00','yes'),(220,226486,'2017-05-21','07:00:00','11:00:00','yes'),(221,226486,'2017-06-20','08:00:00','12:00:00','yes'),(222,226486,'2017-06-03','01:00:00','17:00:00','yes'),(223,226487,'2017-05-22','07:00:00','11:00:00','yes'),(224,226487,'2017-05-12','08:00:00','12:00:00','yes'),(225,226487,'2017-05-13','01:00:00','17:00:00','yes'),(226,226488,'2017-05-14','07:00:00','11:00:00','yes'),(227,226488,'2017-05-27','08:00:00','12:00:00','yes'),(228,226488,'2017-05-22','01:00:00','17:00:00','yes'),(229,226489,'2017-05-27','07:00:00','11:00:00','yes'),(230,226489,'2017-05-28','08:00:00','12:00:00','yes'),(231,226489,'2017-05-21','01:00:00','17:00:00','yes'),(232,226490,'2017-05-28','07:00:00','11:00:00','yes'),(233,226490,'2017-05-29','08:00:00','12:00:00','yes'),(234,226490,'2017-06-01','07:30:00','12:30:00','yes'),(235,226491,'2017-06-03','07:00:00','11:00:00','yes'),(236,226491,'2017-06-02','08:00:00','12:00:00','yes'),(237,226491,'2017-06-01','07:30:00','12:30:00','yes'),(238,226492,'2017-06-01','07:00:00','11:00:00','yes'),(239,226492,'2017-06-02','08:00:00','12:00:00','yes'),(240,226492,'2017-06-03','07:30:00','12:30:00','yes'),(241,226493,'2017-05-30','07:00:00','11:00:00','yes'),(242,226493,'2017-06-02','08:00:00','12:00:00','yes'),(243,226493,'2017-06-03','07:30:00','12:30:00','yes'),(244,226494,'2017-06-03','07:00:00','11:00:00','yes'),(245,226494,'2017-06-04','08:00:00','12:00:00','yes'),(246,226494,'2017-06-05','07:30:00','12:30:00','yes'),(247,226495,'2017-06-04','07:00:00','11:00:00','yes'),(248,226495,'2017-06-15','08:00:00','12:00:00','yes'),(249,226495,'2017-06-16','07:30:00','12:30:00','yes');
/*!40000 ALTER TABLE `serviceprovider_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serviceproviders`
--

DROP TABLE IF EXISTS `serviceproviders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serviceproviders` (
  `spid` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` char(20) NOT NULL,
  `last_name` char(10) NOT NULL,
  `email` varchar(45) NOT NULL,
  `contactno` varchar(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `accepted` enum('A','P','D') NOT NULL DEFAULT 'P',
  `totalrating` int(11) NOT NULL DEFAULT '0',
  `profpic` blob,
  PRIMARY KEY (`spid`),
  UNIQUE KEY `spID_UNIQUE` (`spid`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=226496 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serviceproviders`
--

LOCK TABLES `serviceproviders` WRITE;
/*!40000 ALTER TABLE `serviceproviders` DISABLE KEYS */;
INSERT INTO `serviceproviders` VALUES (226480,'Alainne','Fernandez','fernandez@gmail.com','09254687877','alainne','123alainne','A',5,NULL),(226481,'Anthony','Fernandez','fernandez@yahoo.com','09654687721','anthony','123anthony','A',5,NULL),(226482,'Samantha','Lopez','lopez@yahoo.com','09231475454','samantha','123samantha','A',5,NULL),(226483,'Randylle','Manlansing','manlansing@gmail.com','09484784843','randylle','123randylle','A',4,NULL),(226484,'Jovi','Ugaldo','ugaldo@yahoo.com','09687887998','jovi','123jovi','A',5,NULL),(226485,'Rosmella','Soriano','soriano@yahoo.com','09321848479','rosmella','123rosmella','A',5,NULL),(226486,'Troy','Zareno','zareno@yahoo.com','09879842113','troy','123troy','A',5,NULL),(226487,'Bobbie','Mortel','mortel@yahoo.com','09887132458','bobbie','123bobbie','A',4,NULL),(226488,'Louella','Sevilla','sevilla@yahoo.com','09313454654','louella','123louella','A',4,NULL),(226489,'Paul','Reynon','reynon@gmail.com','09111111111','paul','123paul','A',4,NULL),(226490,'Tyus','Fablatin','fablatin@gmail.com','09999999999','tyus','123tyus','A',4,NULL),(226491,'Josepablo','David','david@gmail.com','09124687244','josepablo','123josepablo','A',4,NULL),(226492,'Zara','Baliton','baliton@gmail.com','09364484645','zara','123zara','A',4,NULL),(226493,'Raphael','Abaya','abaya@gmail.com','09987654321','raphael','123raphael','A',4,NULL),(226494,'Jules','Eguilos','eguilos@gmail.com','09878741324','jules','123jules','A',4,NULL),(226495,'Derik','Liwanag','liwanag@gmail.com','09874512135','derik','123derik','A',4,NULL);
/*!40000 ALTER TABLE `serviceproviders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `serviceid` int(11) NOT NULL AUTO_INCREMENT,
  `servicename` char(50) NOT NULL,
  `description` varchar(100) NOT NULL,
  `category` varchar(20) NOT NULL,
  PRIMARY KEY (`serviceid`),
  UNIQUE KEY `ServiceId_UNIQUE` (`serviceid`)
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (226,'Olive Oil Salt Body Glow','Skin renewal that comes from nature','Body'),(242,'Detoxifying Seaweed Wrap','Purifying, marine-based treatment that detoxifies the body while restoring skin tone and vitality','Body'),(243,'Swedish Massage','Uses varied strokes of gliding and kneading to promote circulation and overall sense of well-being','Massage'),(244,'Deep Tissue Massage','Slowand skillful hand movements target stressed muscles, unlock tension and relieve pain','Massage'),(245,'BxB Signature Massage','Incorporates essences of butter cream, facial acupressure and foot reflexology for head to toe','Massage'),(247,'Arden Standard Facial','Our experts will cleanse, exfoliate and hydrate to address the essential needs of your skin','Face'),(248,'Back Facial','Purifies and tones back with the refined technique of our finest facial','Face'),(249,'Ceramide Anti-aging Facial','This deeply plumping treatment uses a line of advanced, rejuvenating skincare','Face'),(250,'BxB Signature Facial','Most requested treatment incorporating classic facial massage technique','Face'),(251,'Collagen - Face + Eye','Visit your local BxB Spa for more information','Face'),(252,'Collagen - Eye','Fine lines are plumped, skin is tightened, moisture is restored with a collagen mask','Face'),(253,'Collagen Mask - Face','Visit your local BxB Spa for more information.','Face'),(254,'Keratin Hair Therapy Treatment','This revolutionary straightening system is gentle, can be used on all hair types','Hair'),(255,'Full Highlights','Visit your local BxB Spa for more information','Hair'),(256,'Shampoo Blow Dry and Finish','Visit your local BxB Spa for more information','Hair'),(257,'Special Occasion Hair','Visit your local BxB Spa for more information','Hair'),(258,'Deep Hair Condition Treatment','Visit your local BxB Spa for more information','Hair'),(259,'Eyelash Tints','Visit your local BxB Spa for more information','Makeup'),(260,'Makeup Application','Visit your local BxB Spa for more information','Makeup'),(261,'Olive Oil Manicure','A hydrating wrap and paraffin treatment provide rejuvenating results','Manicure'),(262,'BxB Signature Manicure','Includes our signature luxurious sugar exfoliation and warm cream reflexology inspired massage','Manicure'),(263,'Youth Restoring Manicure','This oriented treatment manicure will slough away dry skin and replenish moisture','Manicure'),(264,'Healing Pedicure','Includes a gentle bamboo granule exfoliation, hydrating massage with our therapy moisturizer','Pedicure'),(265,'Pedicure Refresher','A foot smoothing treatment, shaping and polishing of nails to perfection.','Pedicure'),(266,'Warm Cream Pedicure','Includes a moisturizing massage with rich, warm cream, leaving feet velvety smooth','Pedicure'),(267,'Youth Restoring Pedicure','This will slough away dry skin and seal in moisture to restore a youthful hydration for feet','Pedicure'),(268,'Bikini Plus','Visit your local BxB Spa for more information','Wax'),(269,'Lip Threading','Visit your local BxB Spa for more information','Wax');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_skills`
--

DROP TABLE IF EXISTS `sp_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_skills` (
  `spid` int(11) NOT NULL,
  `serviceid` int(11) NOT NULL,
  `price` float NOT NULL DEFAULT '0',
  KEY `serviceID_idx` (`serviceid`),
  KEY `fk_spservice_spid_idx` (`spid`),
  CONSTRAINT `fk_skill` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_skills_sp` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_skills`
--

LOCK TABLES `sp_skills` WRITE;
/*!40000 ALTER TABLE `sp_skills` DISABLE KEYS */;
INSERT INTO `sp_skills` VALUES (226480,226,300),(226481,242,300),(226482,242,300),(226483,242,300),(226484,242,300),(226486,243,200),(226480,244,450),(226481,244,450),(226482,244,450),(226483,244,450),(226484,244,450),(226480,245,150),(226481,245,150),(226482,245,150),(226483,245,150),(226484,245,150),(226480,268,340),(226481,268,340),(226482,268,340),(226483,268,340),(226484,268,340),(226480,269,670),(226481,269,670),(226482,269,670),(226483,269,670),(226484,269,670),(226485,261,630),(226486,261,630),(226487,261,630),(226488,261,630),(226489,261,630),(226485,262,640),(226486,262,640),(226487,262,640),(226488,262,640),(226489,262,640),(226485,263,980),(226486,263,980),(226487,263,980),(226488,263,980),(226489,263,980),(226485,264,980),(226486,264,980),(226487,264,980),(226488,264,980),(226489,264,980),(226485,265,340),(226486,265,340),(226487,265,340),(226488,265,340),(226489,265,340),(226485,266,760),(226486,266,760),(226487,266,760),(226488,266,760),(226489,266,760),(226485,267,670),(226486,267,670),(226487,267,670),(226488,267,670),(226489,267,670),(226490,247,400),(226490,248,550),(226490,249,180),(226490,250,250),(226490,251,100),(226490,252,120),(226490,253,120),(226490,254,140),(226490,255,130),(226490,256,300),(226490,257,300),(226490,258,400),(226490,259,350),(226491,247,400),(226491,248,550),(226491,249,180),(226491,250,250),(226491,251,100),(226491,252,120),(226491,253,120),(226491,254,140),(226491,255,130),(226491,256,300),(226491,257,300),(226491,258,400),(226491,259,350),(226491,260,300),(226492,247,400),(226492,248,550),(226492,249,180),(226492,250,250),(226492,251,100),(226492,252,120),(226492,253,120),(226492,254,140),(226492,255,130),(226492,256,300),(226492,257,300),(226492,258,400),(226492,259,350),(226492,260,300),(226493,247,400),(226493,248,550),(226493,249,180),(226493,250,250),(226493,251,100),(226493,252,120),(226493,253,120),(226493,254,140),(226493,255,130),(226493,256,300),(226493,257,300),(226493,258,400),(226493,259,350),(226493,260,300),(226494,247,400),(226494,248,550),(226494,249,180),(226494,250,250),(226494,251,100),(226494,252,120),(226494,253,120),(226494,254,140),(226494,255,130),(226494,256,300),(226494,257,300),(226494,258,400),(226494,259,350),(226494,260,300),(226495,247,400),(226495,248,550),(226495,249,180),(226495,250,250),(226495,251,100),(226495,252,120),(226495,253,120),(226495,254,140),(226495,255,130),(226495,256,300),(226495,257,300),(226495,258,400),(226495,259,350),(226495,260,300);
/*!40000 ALTER TABLE `sp_skills` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-13  4:02:26
