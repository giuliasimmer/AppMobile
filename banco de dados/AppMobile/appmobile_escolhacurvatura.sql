-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: appmobile
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `escolhacurvatura`
--

DROP TABLE IF EXISTS `escolhacurvatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `escolhacurvatura` (
  `id` int NOT NULL AUTO_INCREMENT,
  `LISO` bit(1) DEFAULT NULL,
  `ONDULADO` bit(1) DEFAULT NULL,
  `CACHEADO` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escolhacurvatura`
--

LOCK TABLES `escolhacurvatura` WRITE;
/*!40000 ALTER TABLE `escolhacurvatura` DISABLE KEYS */;
INSERT INTO `escolhacurvatura` VALUES (1,_binary '',_binary '\0',_binary '\0'),(2,_binary '\0',_binary '',_binary '\0'),(3,_binary '',_binary '\0',_binary '\0'),(4,_binary '',_binary '\0',_binary '\0'),(5,_binary '',_binary '\0',_binary '\0'),(6,_binary '',_binary '\0',_binary '\0'),(7,_binary '',_binary '\0',_binary '\0'),(8,_binary '',_binary '\0',_binary '\0'),(9,_binary '',_binary '\0',_binary '\0'),(10,_binary '',_binary '\0',_binary '\0'),(11,_binary '',_binary '\0',_binary '\0'),(12,_binary '',_binary '\0',_binary '\0'),(13,_binary '',_binary '\0',_binary '\0'),(14,_binary '',_binary '\0',_binary '\0'),(15,_binary '',_binary '\0',_binary '\0'),(16,_binary '',_binary '\0',_binary '\0'),(17,_binary '',_binary '\0',_binary '\0'),(18,_binary '',_binary '\0',_binary '\0'),(19,_binary '',_binary '\0',_binary '\0'),(20,_binary '\0',_binary '',_binary '\0');
/*!40000 ALTER TABLE `escolhacurvatura` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-10 16:56:21
