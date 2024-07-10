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
-- Table structure for table `consulta`
--

DROP TABLE IF EXISTS `consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulta` (
  `NOMEPRODUTO` varchar(100) DEFAULT NULL,
  `DESCRICAO` varchar(255) DEFAULT NULL,
  `MARCA` varchar(50) DEFAULT NULL,
  `TAMANHO_ML` int DEFAULT NULL,
  `VALOR` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulta`
--

LOCK TABLES `consulta` WRITE;
/*!40000 ALTER TABLE `consulta` DISABLE KEYS */;
INSERT INTO `consulta` VALUES ('Shampoo Anti-Caspa','Limpa e combate a caspa','Seda',300,15.99),('Condicionador Hidratante','Hidrata os fios, deixando-os macios e sedosos','Pantene',250,12.50),('Máscara de Hidratação Profunda','Recupera cabelos ressecados e danificados','Tresemmé',200,20.00),('Creme para Pentear','Facilita o pentear e controla o frizz','Garnier Fructis',150,9.99),('Óleo Reparador de Pontas','Nutre e protege as pontas do cabelo','LOréal Paris',100,18.75),('Gel Modelador','Define e fixa penteados','Pantene',150,7.50),('Spray Fixador','Fixação forte e duradoura','Tresemmé',200,14.99),('Shampoo Hidratante','Limpa suavemente e hidrata os cabelos','Dove',300,11.25),('Condicionador Reconstrutor','Reconstrói a fibra capilar','Pantene',250,16.99),('Máscara de Nutrição Intensa','Nutre profundamente os fios','LOréal Paris',200,22.50),('Creme para Cachos','Define e controla cachos','Seda',150,8.99),('Spray Protetor Térmico','Protege os cabelos do calor do secador e da chapinha','Tresemmé',200,13.75),('Shampoo Revitalizante','Revitaliza cabelos opacos e sem vida','Pantene',300,10.99),('Condicionador Reparador','Repara os danos dos cabelos','Garnier Fructis',250,14.50),('Creme para Pentear Antifrizz','Controla o frizz e deixa os cabelos mais lisos','LOréal Paris',150,11.99),('Óleo Capilar Nutritivo','Nutre e dá brilho aos cabelos','Dove',100,19.25),('Gel Fixador Extraforte','Fixação extraforte para penteados elaborados','Tresemmé',150,8.50),('Spray Texturizador','Cria textura e volume aos cabelos','Seda',200,12.99),('Shampoo Antirresíduos','Limpa profundamente os cabelos','Pantene',300,9.75),('Condicionador Fortalecedor','Fortalece os fios, reduzindo a quebra','Garnier Fructis',250,15.99),('Máscara de Reconstrução Capilar','Reconstrói os fios danificados por processos químicos','LOréal Paris',200,23.50),('Creme para Cabelos Tingidos','Protege a cor e hidrata os cabelos tingidos','Dove',150,10.99),('Spray Volume Extra','Dá volume e movimento aos cabelos finos','Tresemmé',200,14.25),('Shampoo Suave','Limpa delicadamente os cabelos','Seda',300,8.99);
/*!40000 ALTER TABLE `consulta` ENABLE KEYS */;
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
