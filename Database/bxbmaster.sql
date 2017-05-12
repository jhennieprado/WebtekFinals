CREATE DATABASE  IF NOT EXISTS `bxbmaster` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `bxbmaster`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: bxbmaster
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
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
  PRIMARY KEY (`clinotif`),
  KEY `fk_spid_notif_idx` (`spid`),
  KEY `fk_client_rec_idx` (`receiver`),
  KEY `fk_appoint_nc_idx` (`appointmentno`),
  CONSTRAINT `fk_appoint_nc` FOREIGN KEY (`appointmentno`) REFERENCES `appointments` (`appointmentno`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_client_rec` FOREIGN KEY (`receiver`) REFERENCES `clients` (`clientno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_spid_notif` FOREIGN KEY (`spid`) REFERENCES `serviceproviders` (`spid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notify_sp`
--

LOCK TABLES `notify_sp` WRITE;
/*!40000 ALTER TABLE `notify_sp` DISABLE KEYS */;
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
INSERT INTO `serviceprovider_schedules` VALUES (202,226480,'2017-05-12','07:00:00','17:00:00','yes'),(203,226480,'2017-05-13','08:00:00','15:00:00','yes'),(204,226480,'2017-05-14','07:00:00','17:00:00','yes'),(205,226481,'2017-05-15','07:00:00','17:00:00','yes'),(206,226481,'2017-05-16','08:00:00','15:00:00','yes'),(207,226481,'2017-05-17','07:00:00','17:00:00','yes'),(208,226482,'2017-05-18','07:00:00','17:00:00','yes'),(209,226482,'2017-05-19','08:00:00','15:00:00','yes'),(210,226482,'2017-05-20','01:00:00','17:00:00','yes'),(211,226483,'2017-05-12','07:00:00','17:00:00','yes'),(212,226483,'2017-05-13','08:00:00','15:00:00','yes'),(213,226483,'2017-05-14','01:00:00','17:00:00','yes'),(214,226484,'2017-05-15','07:00:00','15:00:00','yes'),(215,226484,'2017-05-16','08:00:00','15:00:00','yes'),(216,226484,'2017-05-17','01:00:00','17:00:00','yes'),(217,226485,'2017-05-18','07:00:00','15:00:00','yes'),(218,226485,'2017-05-19','08:00:00','15:00:00','yes'),(219,226485,'2017-06-20','01:00:00','17:00:00','yes'),(220,226486,'2017-05-21','07:00:00','15:00:00','yes'),(221,226486,'2017-06-20','08:00:00','15:00:00','yes'),(222,226486,'2017-06-03','01:00:00','17:00:00','yes'),(223,226487,'2017-05-22','07:00:00','15:00:00','yes'),(224,226487,'2017-05-12','08:00:00','15:00:00','yes'),(225,226487,'2017-05-13','01:00:00','17:00:00','yes'),(226,226488,'2017-05-14','07:00:00','15:00:00','yes'),(227,226488,'2017-05-27','08:00:00','15:00:00','yes'),(228,226488,'2017-05-22','01:00:00','17:00:00','yes'),(229,226489,'2017-05-27','07:00:00','15:00:00','yes'),(230,226489,'2017-05-28','08:00:00','15:00:00','yes'),(231,226489,'2017-05-21','01:00:00','17:00:00','yes'),(232,226490,'2017-05-28','07:00:00','15:00:00','yes'),(233,226490,'2017-05-29','08:00:00','15:00:00','yes'),(234,226490,'2017-06-01','07:30:00','17:00:00','yes'),(235,226491,'2017-06-03','07:00:00','15:00:00','yes'),(236,226491,'2017-06-02','08:00:00','15:00:00','yes'),(237,226491,'2017-06-01','07:30:00','17:00:00','yes'),(238,226492,'2017-06-01','07:00:00','15:00:00','yes'),(239,226492,'2017-06-02','08:00:00','17:00:00','yes'),(240,226492,'2017-06-03','07:30:00','17:00:00','yes'),(241,226493,'2017-05-30','07:00:00','17:00:00','yes'),(242,226493,'2017-06-02','08:00:00','17:00:00','yes'),(243,226493,'2017-06-03','07:30:00','17:00:00','yes'),(244,226494,'2017-06-03','07:00:00','15:00:00','yes'),(245,226494,'2017-06-04','08:00:00','15:00:00','yes'),(246,226494,'2017-06-05','07:30:00','17:00:00','yes'),(247,226495,'2017-06-04','07:00:00','15:00:00','yes'),(248,226495,'2017-06-15','08:00:00','15:00:00','yes'),(249,226495,'2017-06-16','07:30:00','17:00:00','yes');
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
  `accepted` enum('Y','N') NOT NULL DEFAULT 'N',
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
INSERT INTO `serviceproviders` VALUES (226480,'Alainne','Fernandez','fernandez@gmail.com','09254687877','alainne','123alainne','Y',5,NULL),(226481,'Anthony','Fernandez','fernandez@yahoo.com','09654687721','anthony','123anthony','Y',5,NULL),(226482,'Samantha','Lopez','lopez@yahoo.com','09231475454','samantha','123samantha','Y',5,NULL),(226483,'Randylle','Manlansing','manlansing@gmail.com','09484784843','randylle','123randylle','Y',4,NULL),(226484,'Jovi','Ugaldo','ugaldo@yahoo.com','09687887998','jovi','123jovi','Y',5,NULL),(226485,'Rosmella','Soriano','soriano@yahoo.com','09321848479','rosmella','123rosmella','Y',5,NULL),(226486,'Troy','Zareno','zareno@yahoo.com','09879842113','troy','123troy','Y',5,NULL),(226487,'Bobbie','Mortel','mortel@yahoo.com','09887132458','bobbie','123bobbie','Y',4,NULL),(226488,'Louella','Sevilla','sevilla@yahoo.com','09313454654','louella','123louella','Y',4,NULL),(226489,'Paul','Reynon','reynon@gmail.com','09111111111','paul','123paul','Y',4,NULL),(226490,'Tyus','Fablatin','fablatin@gmail.com','09999999999','tyus','123tyus','Y',4,NULL),(226491,'Josepablo','David','david@gmail.com','09124687244','josepablo','123josepablo','Y',4,NULL),(226492,'Zara','Baliton','baliton@gmail.com','09364484645','zara','123zara','Y',4,NULL),(226493,'Raphael','Abaya','abaya@gmail.com','09987654321','raphael','123raphael','Y',4,NULL),(226494,'Jules','Eguilos','eguilos@gmail.com','09878741324','jules','123jules','Y',4,NULL),(226495,'Derik','Liwanag','liwanag@gmail.com','09874512135','derik','123derik','Y',4,NULL);
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
  `serviceamount` float NOT NULL,
  `description` varchar(100) NOT NULL,
  `category` varchar(20) NOT NULL,
  PRIMARY KEY (`serviceid`),
  UNIQUE KEY `ServiceId_UNIQUE` (`serviceid`),
  KEY `serviceamount_idx` (`serviceamount`)
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (226,'Olive Oil Salt Body Glow',500,'Skin renewal that comes from nature','Body'),(242,'Detoxifying Seaweed Wrap',500,'Purifying, marine-based treatment that detoxifies the body while restoring skin tone and vitality','Body'),(243,'Swedish Massage',600,'Uses varied strokes of gliding and kneading to promote circulation and overall sense of well-being','Massage'),(244,'Deep Tissue Massage',400,'Slowand skillful hand movements target stressed muscles, unlock tension and relieve pain','Massage'),(245,'BxB Signature Massage',700,'Incorporates essences of butter cream, facial acupressure and foot reflexology for head to toe','Massage'),(247,'Arden Standard Facial',400,'Our experts will cleanse, exfoliate and hydrate to address the essential needs of your skin','Face'),(248,'Back Facial',400,'Purifies and tones back with the refined technique of our finest facial','Face'),(249,'Ceramide Anti-aging Facial',450,'This deeply plumping treatment uses a line of advanced, rejuvenating skincare','Face'),(250,'BxB Signature Facial',500,'Most requested treatment incorporating classic facial massage technique','Face'),(251,'Collagen - Face + Eye',300,'Visit your local BxB Spa for more information','Face'),(252,'Collagen - Eye',175,'Fine lines are plumped, skin is tightened, moisture is restored with a collagen mask','Face'),(253,'Collagen Mask - Face',175,'Visit your local BxB Spa for more information.','Face'),(254,'Keratin Hair Therapy Treatment',200,'This revolutionary straightening system is gentle, can be used on all hair types','Hair'),(255,'Full Highlights',250,'Visit your local BxB Spa for more information','Hair'),(256,'Shampoo Blow Dry and Finish',200,'Visit your local BxB Spa for more information','Hair'),(257,'Special Occasion Hair',350,'Visit your local BxB Spa for more information','Hair'),(258,'Deep Hair Condition Treatment',200,'Visit your local BxB Spa for more information','Hair'),(259,'Eyelash Tints',100,'Visit your local BxB Spa for more information','Makeup'),(260,'Makeup Application',300,'Visit your local BxB Spa for more information','Makeup'),(261,'Olive Oil Manicure',350,'A hydrating wrap and paraffin treatment provide rejuvenating results','Manicure'),(262,'BxB Signature Manicure',400,'Includes our signature luxurious sugar exfoliation and warm cream reflexology inspired massage','Manicure'),(263,'Youth Restoring Manicure',350,'This oriented treatment manicure will slough away dry skin and replenish moisture','Manicure'),(264,'Healing Pedicure',300,'Includes a gentle bamboo granule exfoliation, hydrating massage with our therapy moisturizer','Pedicure'),(265,'Pedicure Refresher',350,'A foot smoothing treatment, shaping and polishing of nails to perfection.','Pedicure'),(266,'Warm Cream Pedicure',350,'Includes a moisturizing massage with rich, warm cream, leaving feet velvety smooth','Pedicure'),(267,'Youth Restoring Pedicure',300,'This will slough away dry skin and seal in moisture to restore a youthful hydration for feet','Pedicure'),(268,'Bikini Plus',180,'Visit your local BxB Spa for more information','Wax'),(269,'Lip Threading',150,'Visit your local BxB Spa for more information','Wax');
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
INSERT INTO `sp_skills` VALUES (226480,226),(226480,226),(226480,226),(226480,226),(226480,226),(226480,226),(226481,242),(226482,242),(226483,242),(226484,242),(226486,243),(226486,243),(226486,243),(226486,243),(226486,243),(226480,244),(226481,244),(226482,244),(226483,244),(226484,244),(226480,245),(226481,245),(226482,245),(226483,245),(226484,245),(226480,268),(226481,268),(226482,268),(226483,268),(226484,268),(226480,269),(226481,269),(226482,269),(226483,269),(226484,269),(226485,261),(226486,261),(226487,261),(226488,261),(226489,261),(226485,262),(226486,262),(226487,262),(226488,262),(226489,262),(226485,263),(226486,263),(226487,263),(226488,263),(226489,263),(226485,264),(226486,264),(226487,264),(226488,264),(226489,264),(226485,265),(226486,265),(226487,265),(226488,265),(226489,265),(226485,266),(226486,266),(226487,266),(226488,266),(226489,266),(226485,267),(226486,267),(226487,267),(226488,267),(226489,267),(226490,247),(226490,248),(226490,249),(226490,250),(226490,251),(226490,252),(226490,253),(226490,254),(226490,255),(226490,256),(226490,257),(226490,258),(226490,259),(226480,226),(226491,247),(226491,248),(226491,249),(226491,250),(226491,251),(226491,252),(226491,253),(226491,254),(226491,255),(226491,256),(226491,257),(226491,258),(226491,259),(226491,260),(226492,247),(226492,248),(226492,249),(226492,250),(226492,251),(226492,252),(226492,253),(226492,254),(226492,255),(226492,256),(226492,257),(226492,258),(226492,259),(226492,260),(226493,247),(226493,248),(226493,249),(226493,250),(226493,251),(226493,252),(226493,253),(226493,254),(226493,255),(226493,256),(226493,257),(226493,258),(226493,259),(226493,260),(226494,247),(226494,248),(226494,249),(226494,250),(226494,251),(226494,252),(226494,253),(226494,254),(226494,255),(226494,256),(226494,257),(226494,258),(226494,259),(226494,260),(226495,247),(226495,248),(226495,249),(226495,250),(226495,251),(226495,252),(226495,253),(226495,254),(226495,255),(226495,256),(226495,257),(226495,258),(226495,259),(226495,260);
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

-- Dump completed on 2017-05-12 16:51:29
