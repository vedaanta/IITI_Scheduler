-- MySQL dump 10.13  Distrib 5.6.26, for Win64 (x86_64)
--
-- Host: localhost    Database: schData
-- ------------------------------------------------------
-- Server version	5.6.26-log

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
-- Table structure for table `b2014csespringtt`
--

DROP TABLE IF EXISTS `b2014csespringtt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `b2014csespringtt` (
  `timeslotid` varchar(20) NOT NULL,
  `starttime` time DEFAULT NULL,
  `endtime` time DEFAULT NULL,
  `dayofslot` varchar(20) DEFAULT NULL,
  `courseid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`timeslotid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `b2014csespringtt`
--

LOCK TABLES `b2014csespringtt` WRITE;
/*!40000 ALTER TABLE `b2014csespringtt` DISABLE KEYS */;
/*!40000 ALTER TABLE `b2014csespringtt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch` (
  `batchid` varchar(100) DEFAULT NULL,
  `batchname` varchar(100) DEFAULT NULL,
  `courseid` varchar(20) DEFAULT NULL,
  `noc` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
INSERT INTO `batch` VALUES ('B2014CSE','B.Tech. 2014 CSE','CS202',7),('B2014CSE','B.Tech. 2014 CSE','CS204',7),('B2014CSE','B.Tech. 2014 CSE','CS206',7),('B2014CSE','B.Tech. 2014 CSE','CS208',7),('B2014CSE','B.Tech. 2014 CSE','HS206',7),('B2014CSE','B.Tech. 2014 CSE','MA204',7),('B2014EE','B.Tech. 2014 EE','EE202',7),('B2014EE','B.Tech. 2014 EE','EE204',7),('B2014EE','B.Tech. 2014 EE','EE206',7),('B2014EE','B.Tech. 2014 EE','EE208',7),('B2014CSE','B.Tech. 2014 EE','HS208',7);
/*!40000 ALTER TABLE `batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `courseid` varchar(20) NOT NULL,
  `instructor` varchar(100) NOT NULL,
  `year` char(4) DEFAULT NULL,
  `sem` varchar(20) DEFAULT NULL,
  `lec` int(11) DEFAULT NULL,
  `tut` int(11) DEFAULT NULL,
  `pra` int(11) DEFAULT NULL,
  PRIMARY KEY (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES ('CS202','Dr. Neminath Hubbali','2','Spring',3,0,0),('CS204','Dr. Kapil Ahuja','2','Spring',3,0,0),('CS206','Dr. Anirban Sengupta','2','Spring',3,0,0),('CS208','Dr. Abhishek Shrivastava','2','Spring',3,0,0),('EE202','Dr. Ram Bilas Pachori','2','Spring',3,0,0),('EE204','Dr. Vipul Singh','2','Spring',3,0,0),('EE206','Dr. Amod Umarikar','2','Spring',3,0,0),('EE208','Dr. S. K. Vishwakarma','2','Spring',3,0,0),('HS206','Dr. C. Upendra','2','Spring',3,0,0),('HS208','Mrs. Alison Davies','2','Spring',3,0,0),('MA204','Dr. Shafique Ahmad','2','Spring',3,0,0);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-02 17:24:14
