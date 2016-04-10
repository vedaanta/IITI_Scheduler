-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
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
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch` (
  `batch_id` varchar(40) NOT NULL,
  `batch_name` varchar(40) NOT NULL,
  PRIMARY KEY (`batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
INSERT INTO `batch` VALUES ('b2013','B.Tech. 2013'),('b2014','B.Tech. 2014'),('b2015','B.Tech. 2015'),('b2016','B.Tech. 2016'),('m2015','M.Tech. 2015'),('m2016','M.Tech. 2016'),('msc2015','M.Sc. 2015'),('msc2016','M.Sc. 2016'),('phd','Phd.');
/*!40000 ALTER TABLE `batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `course_id` varchar(40) NOT NULL,
  `course_name` varchar(40) NOT NULL,
  `lecture_hour` int(11) NOT NULL,
  `tutorial_hour` int(11) NOT NULL,
  `practical_hour` int(11) NOT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES ('Break','Break',0,0,0),('BSE102','Bio-Sciences',2,1,0),('CH103','Chemistry',3,1,0),('CH153','Chemistry Lab',0,0,3),('CS103','Computer Programming',2,0,0),('CS153','Computer Programming Lab',0,0,3),('CS201','Discrete Mathematical Structures',2,1,0),('CS202','Automata Theory and Logic',2,1,0),('CS203','Data Structures and Algorithms',2,1,0),('CS204','Design and Analysis of Algorithms',2,1,0),('CS206','Logic Design',2,1,0),('CS207','Data Base & Information Systems',3,0,0),('CS208','Software Engineering',2,1,0),('CS253','Data Structures and Algorithms Lab',0,0,3),('CS254','Design and Analysis of Algorithms Lab',0,0,3),('CS256','Logic Design Lab',0,0,3),('CS257','Data Base & Information Systems Lab',0,0,3),('CS258','Software Engineering Lab',0,0,3),('CS302','Computer Graphics and Visualization',2,1,0),('CS303','Operating Systems',2,1,0),('CS304','Computational Intelligence',2,1,0),('CS305','Computer Architecture',2,1,0),('CS306','Computer Networks',2,1,0),('CS307','Optimization Algorithms and Techniques',2,1,0),('CS308','Compiler Techniques',2,1,0),('CS309','Parallel Computing',2,1,0),('CS352','Computer Graphics and Visualization Lab',0,0,3),('CS353','Operating Systems Lab',0,0,3),('CS354','Computational Intelligence Lab',0,0,3),('CS355','Computer Architecture Lab',0,0,3),('CS356','Computer Networks Lab',0,0,3),('CS357','Opt. Algorithms and Techniques Lab',0,0,3),('CS358','Compiler Techniques Lab',0,0,3),('CS359','Parallel Computing Lab',0,0,3),('CS402','qwe',1,1,1),('CS602','qwe',1,1,1),('CS702','qwe',1,1,1),('EE104','Basic Electrical Engineering',2,1,0),('EE154','Basic Electrical Engineering Lab',0,0,2),('ES302','Env. Stud.: Scientific & Eng. Aspects',3,0,0),('HS108','Fundamentals of Economics',3,0,0),('HS159','English Language and Communication',0,3,0),('HS206','Paradigms and Turning Points',3,0,0),('HS208','French Language-II',3,0,0),('HS302','Environmental Studies: Social Aspects',3,0,0),('IC211','Experimental Engineering Lab',0,0,3),('MA105','Calculus',3,1,0),('MA106','Linear Algebra and ODE-I',3,1,0),('MA203','Complex Analysis and DE-II',3,1,0),('MA204','Numerical Methods',3,1,0),('ME106','Basic Mechanical Engineering',3,0,0),('ME153','Engineering Graphics',1,0,3),('ME156','Basic Manufacturing Techniques',0,0,3),('PH105','Physics-I',2,1,0),('PH106','Physics-II',2,1,0),('PH156','Physics Lab',0,0,3);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `initials`
--

DROP TABLE IF EXISTS `initials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `initials` (
  `course_instructor` varchar(40) NOT NULL,
  `short` varchar(40) NOT NULL,
  PRIMARY KEY (`course_instructor`,`short`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `initials`
--

LOCK TABLES `initials` WRITE;
/*!40000 ALTER TABLE `initials` DISABLE KEYS */;
INSERT INTO `initials` VALUES ('Dr. Kapil Ahuja','KA');
/*!40000 ALTER TABLE `initials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master`
--

DROP TABLE IF EXISTS `master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master` (
  `batch_id` varchar(40) NOT NULL,
  `course_id` varchar(40) NOT NULL,
  `type` varchar(40) NOT NULL,
  `serial` int(11) NOT NULL,
  `timeslot_id` varchar(40) DEFAULT NULL,
  `classroom` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`batch_id`,`course_id`,`type`,`serial`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `master_ibfk_1` FOREIGN KEY (`batch_id`) REFERENCES `batch` (`batch_id`),
  CONSTRAINT `master_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master`
--

LOCK TABLES `master` WRITE;
/*!40000 ALTER TABLE `master` DISABLE KEYS */;
INSERT INTO `master` VALUES ('b2013','Break','-',1,NULL,NULL),('b2013','Break','-',2,'slot5','null'),('b2013','Break','-',3,NULL,NULL),('b2013','Break','-',4,'slot15','null'),('b2013','Break','-',5,NULL,NULL),('b2013','CS402','L',1,'slot11','345'),('b2013','CS402','P',1,NULL,NULL),('b2013','CS402','T',1,'slot17','12'),('b2014','Break','-',1,'slot4','null'),('b2014','Break','-',2,'slot14','null'),('b2014','Break','-',3,'slot24','null'),('b2014','Break','-',4,'slot34','null'),('b2014','Break','-',5,'slot44','null'),('b2014','CS201','L',1,'slot1','314B'),('b2014','CS201','L',2,'slot21','314B'),('b2014','CS201','T',1,NULL,NULL),('b2014','CS202','L',1,NULL,NULL),('b2014','CS202','L',2,NULL,NULL),('b2014','CS202','T',1,NULL,NULL),('b2014','CS203','L',1,'slot2','314B'),('b2014','CS203','L',2,NULL,NULL),('b2014','CS203','T',1,'slot11','314'),('b2014','CS204','L',1,NULL,NULL),('b2014','CS204','L',2,'slot27','314B'),('b2014','CS204','T',1,NULL,NULL),('b2014','CS206','L',1,NULL,NULL),('b2014','CS206','L',2,NULL,NULL),('b2014','CS206','T',1,NULL,NULL),('b2014','CS207','L',1,'slot3','314B'),('b2014','CS207','L',2,NULL,NULL),('b2014','CS207','L',3,NULL,NULL),('b2014','CS208','L',1,NULL,NULL),('b2014','CS208','L',2,NULL,NULL),('b2014','CS208','T',1,NULL,NULL),('b2014','CS253','P',1,'slot5','PG09'),('b2014','CS253','P',2,'slot6','PG09'),('b2014','CS253','P',3,'slot7','PG09'),('b2014','CS254','P',1,NULL,NULL),('b2014','CS254','P',2,NULL,NULL),('b2014','CS254','P',3,NULL,NULL),('b2014','CS256','P',1,NULL,NULL),('b2014','CS256','P',2,NULL,NULL),('b2014','CS256','P',3,NULL,NULL),('b2014','CS257','P',1,NULL,NULL),('b2014','CS257','P',2,NULL,NULL),('b2014','CS257','P',3,NULL,NULL),('b2014','CS258','P',1,NULL,NULL),('b2014','CS258','P',2,NULL,NULL),('b2014','CS258','P',3,NULL,NULL),('b2014','HS206','L',1,NULL,NULL),('b2014','HS206','L',2,NULL,NULL),('b2014','HS206','L',3,NULL,NULL),('b2014','HS208','L',1,NULL,NULL),('b2014','HS208','L',2,NULL,NULL),('b2014','HS208','L',3,NULL,NULL),('b2014','IC211','P',1,NULL,NULL),('b2014','IC211','P',2,NULL,NULL),('b2014','IC211','P',3,NULL,NULL),('b2014','MA203','L',1,NULL,NULL),('b2014','MA203','L',2,NULL,NULL),('b2014','MA203','L',3,NULL,NULL),('b2014','MA203','T',1,NULL,NULL),('b2014','MA204','L',1,NULL,NULL),('b2014','MA204','L',2,NULL,NULL),('b2014','MA204','L',3,NULL,NULL),('b2014','MA204','T',1,NULL,NULL),('b2015','Break','-',1,'slot4','123'),('b2015','Break','-',2,NULL,NULL),('b2015','Break','-',3,NULL,NULL),('b2015','Break','-',4,'slot15','123'),('b2015','Break','-',5,NULL,NULL),('b2015','CS201','L',1,NULL,NULL),('b2015','CS201','L',2,NULL,NULL),('b2015','CS201','T',1,'slot17','123'),('b2015','CS202','L',1,NULL,NULL),('b2015','CS202','L',2,NULL,NULL),('b2015','CS202','T',1,NULL,NULL),('b2015','CS203','L',1,'slot36','12'),('b2015','CS203','L',2,NULL,NULL),('b2015','CS203','T',1,NULL,NULL),('b2015','CS204','L',1,'slot8','253'),('b2015','CS204','L',2,NULL,NULL),('b2015','CS204','T',1,NULL,NULL),('b2015','CS206','L',1,NULL,NULL),('b2015','CS206','L',2,'slot27','3'),('b2015','CS206','T',1,NULL,NULL),('b2015','CS207','L',1,NULL,NULL),('b2015','CS207','L',2,NULL,NULL),('b2015','CS207','L',3,NULL,NULL),('b2015','CS208','L',1,NULL,NULL),('b2015','CS208','L',2,NULL,NULL),('b2015','CS208','T',1,NULL,NULL),('b2015','CS253','P',1,NULL,NULL),('b2015','CS253','P',2,NULL,NULL),('b2015','CS253','P',3,NULL,NULL),('b2015','CS254','P',1,NULL,NULL),('b2015','CS254','P',2,NULL,NULL),('b2015','CS254','P',3,NULL,NULL),('b2015','CS256','P',1,NULL,NULL),('b2015','CS256','P',2,NULL,NULL),('b2015','CS256','P',3,NULL,NULL),('b2015','CS257','P',1,NULL,NULL),('b2015','CS257','P',2,NULL,NULL),('b2015','CS257','P',3,NULL,NULL),('b2015','CS258','P',1,NULL,NULL),('b2015','CS258','P',2,NULL,NULL),('b2015','CS258','P',3,NULL,NULL),('b2015','HS206','L',1,NULL,NULL),('b2015','HS206','L',2,NULL,NULL),('b2015','HS206','L',3,NULL,NULL),('b2015','HS208','L',1,NULL,NULL),('b2015','HS208','L',2,NULL,NULL),('b2015','HS208','L',3,NULL,NULL),('b2015','IC211','P',1,NULL,NULL),('b2015','IC211','P',2,NULL,NULL),('b2015','IC211','P',3,NULL,NULL),('b2015','MA203','L',1,NULL,NULL),('b2015','MA203','L',2,NULL,NULL),('b2015','MA203','L',3,NULL,NULL),('b2015','MA203','T',1,NULL,NULL),('b2015','MA204','L',1,NULL,NULL),('b2015','MA204','L',2,NULL,NULL),('b2015','MA204','L',3,NULL,NULL),('b2015','MA204','T',1,NULL,NULL),('b2016','Break','-',1,NULL,NULL),('b2016','Break','-',2,NULL,NULL),('b2016','Break','-',3,NULL,NULL),('b2016','Break','-',4,NULL,NULL),('b2016','Break','-',5,NULL,NULL),('b2016','BSE102','L',1,'slot1','42'),('b2016','BSE102','L',2,NULL,NULL),('b2016','BSE102','T',1,NULL,NULL),('b2016','CH103','L',1,NULL,NULL),('b2016','CH103','L',2,'slot17','12'),('b2016','CH103','L',3,NULL,NULL),('b2016','CH103','T',1,NULL,NULL),('b2016','CH153','P',1,NULL,NULL),('b2016','CH153','P',2,NULL,NULL),('b2016','CH153','P',3,'slot27','42'),('b2016','CS103','L',1,'slot36','12'),('b2016','CS103','L',2,NULL,NULL),('b2016','CS153','P',1,NULL,NULL),('b2016','CS153','P',2,NULL,NULL),('b2016','CS153','P',3,NULL,NULL),('b2016','EE104','L',1,NULL,NULL),('b2016','EE104','L',2,NULL,NULL),('b2016','EE104','T',1,NULL,NULL),('b2016','EE154','P',1,NULL,NULL),('b2016','EE154','P',2,NULL,NULL),('b2016','HS108','L',1,NULL,NULL),('b2016','HS108','L',2,NULL,NULL),('b2016','HS108','L',3,NULL,NULL),('b2016','HS159','T',1,NULL,NULL),('b2016','HS159','T',2,NULL,NULL),('b2016','HS159','T',3,NULL,NULL),('b2016','MA105','L',1,NULL,NULL),('b2016','MA105','L',2,NULL,NULL),('b2016','MA105','L',3,NULL,NULL),('b2016','MA105','T',1,NULL,NULL),('b2016','MA106','L',1,NULL,NULL),('b2016','MA106','L',2,NULL,NULL),('b2016','MA106','L',3,NULL,NULL),('b2016','MA106','T',1,NULL,NULL),('b2016','ME106','L',1,NULL,NULL),('b2016','ME106','L',2,NULL,NULL),('b2016','ME106','L',3,NULL,NULL),('b2016','ME153','L',1,NULL,NULL),('b2016','ME153','P',1,NULL,NULL),('b2016','ME153','P',2,NULL,NULL),('b2016','ME153','P',3,NULL,NULL),('b2016','ME156','P',1,NULL,NULL),('b2016','ME156','P',2,NULL,NULL),('b2016','ME156','P',3,NULL,NULL),('b2016','PH105','L',1,NULL,NULL),('b2016','PH105','L',2,NULL,NULL),('b2016','PH105','T',1,NULL,NULL),('b2016','PH106','L',1,NULL,NULL),('b2016','PH106','L',2,NULL,NULL),('b2016','PH106','T',1,NULL,NULL),('b2016','PH156','P',1,NULL,NULL),('b2016','PH156','P',2,NULL,NULL),('b2016','PH156','P',3,NULL,NULL),('m2015','Break','-',1,NULL,NULL),('m2015','Break','-',2,NULL,NULL),('m2015','Break','-',3,NULL,NULL),('m2015','Break','-',4,NULL,NULL),('m2015','Break','-',5,NULL,NULL),('m2015','CS602','L',1,NULL,NULL),('m2015','CS602','P',1,NULL,NULL),('m2015','CS602','T',1,'slot6','141'),('m2015','CS702','L',1,'slot1','42'),('m2015','CS702','P',1,NULL,NULL),('m2015','CS702','T',1,NULL,NULL),('m2016','Break','-',1,NULL,NULL),('m2016','Break','-',2,NULL,NULL),('m2016','Break','-',3,NULL,NULL),('m2016','Break','-',4,NULL,NULL),('m2016','Break','-',5,NULL,NULL),('m2016','CS602','L',1,NULL,NULL),('m2016','CS602','P',1,NULL,NULL),('m2016','CS602','T',1,NULL,NULL),('m2016','CS702','L',1,NULL,NULL),('m2016','CS702','P',1,NULL,NULL),('m2016','CS702','T',1,NULL,NULL),('msc2015','Break','-',1,NULL,NULL),('msc2015','Break','-',2,NULL,NULL),('msc2015','Break','-',3,NULL,NULL),('msc2015','Break','-',4,NULL,NULL),('msc2015','Break','-',5,NULL,NULL),('msc2015','CS602','L',1,NULL,NULL),('msc2015','CS602','P',1,NULL,NULL),('msc2015','CS602','T',1,NULL,NULL),('msc2015','CS702','L',1,NULL,NULL),('msc2015','CS702','P',1,NULL,NULL),('msc2015','CS702','T',1,NULL,NULL),('msc2016','Break','-',1,NULL,NULL),('msc2016','Break','-',2,NULL,NULL),('msc2016','Break','-',3,NULL,NULL),('msc2016','Break','-',4,NULL,NULL),('msc2016','Break','-',5,NULL,NULL),('msc2016','CS602','L',1,NULL,NULL),('msc2016','CS602','P',1,NULL,NULL),('msc2016','CS602','T',1,NULL,NULL),('msc2016','CS702','L',1,NULL,NULL),('msc2016','CS702','P',1,NULL,NULL),('msc2016','CS702','T',1,NULL,NULL),('phd','Break','-',1,NULL,NULL),('phd','Break','-',2,NULL,NULL),('phd','Break','-',3,NULL,NULL),('phd','Break','-',4,NULL,NULL),('phd','Break','-',5,NULL,NULL),('phd','CS602','L',1,NULL,NULL),('phd','CS602','P',1,NULL,NULL),('phd','CS602','T',1,NULL,NULL),('phd','CS702','L',1,NULL,NULL),('phd','CS702','P',1,NULL,NULL),('phd','CS702','T',1,NULL,NULL);
/*!40000 ALTER TABLE `master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slave`
--

DROP TABLE IF EXISTS `slave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slave` (
  `course_id` varchar(40) NOT NULL,
  `timeslot_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  CONSTRAINT `slave_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slave`
--

LOCK TABLES `slave` WRITE;
/*!40000 ALTER TABLE `slave` DISABLE KEYS */;
INSERT INTO `slave` VALUES ('BSE102',NULL),('CH103','slot5'),('CH153',NULL),('CS103','slot5'),('CS153',NULL),('CS201',NULL),('CS202',NULL),('CS203','slot7'),('CS204',NULL),('CS206','slot12'),('CS207','slot17'),('CS208','slot2'),('CS253',NULL),('CS254',NULL),('CS256',NULL),('CS257',NULL),('CS258',NULL),('CS302',NULL),('CS303','slot11'),('CS304',NULL),('CS305','slot1'),('CS306',NULL),('CS307',NULL),('CS308',NULL),('CS309',NULL),('CS352',NULL),('CS353',NULL),('CS354',NULL),('CS355',NULL),('CS356',NULL),('CS357',NULL),('CS358',NULL),('CS359',NULL),('CS402','slot13'),('CS602','slot14'),('CS702','slot24'),('EE104','slot5'),('EE154',NULL),('ES302',NULL),('HS108','slot5'),('HS159',NULL),('HS206',NULL),('HS208',NULL),('HS302',NULL),('IC211','slot32'),('MA105',NULL),('MA106',NULL),('MA203',NULL),('MA204','slot37'),('ME106',NULL),('ME153',NULL),('ME156',NULL),('PH105',NULL),('PH106',NULL),('PH156',NULL);
/*!40000 ALTER TABLE `slave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `roll_no` varchar(40) NOT NULL,
  `course_id` varchar(40) NOT NULL,
  PRIMARY KEY (`roll_no`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('140001037','CS103'),('140001038','CS103'),('140001037','CS203'),('140001038','CS203');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher` (
  `course_id` varchar(40) NOT NULL,
  `course_instructor` varchar(40) NOT NULL,
  PRIMARY KEY (`course_id`,`course_instructor`),
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES ('CS204','Dr. Kapil Ahuja'),('CS302','Dr. Kapil Ahuja');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-10 15:11:28
