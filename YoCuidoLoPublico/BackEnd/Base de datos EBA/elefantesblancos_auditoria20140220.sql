-- MySQL dump 10.13  Distrib 5.6.13, for Linux (x86_64)
--
-- Host: 192.168.1.32    Database: elefantesblancos-auditoriapreproduccion
-- ------------------------------------------------------
-- Server version	5.6.14

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
-- Table structure for table `stra_acciones`
--

DROP TABLE IF EXISTS `stra_acciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stra_acciones` (
  `id_stra_accion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id_stra_accion`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stra_acciones`
--

LOCK TABLES `stra_acciones` WRITE;
/*!40000 ALTER TABLE `stra_acciones` DISABLE KEYS */;
INSERT INTO `stra_acciones` VALUES (1,'Crear elefante'),(2,'Validar elefante'),(3,'Rechazar elefante'),(4,'Ya no es un elefante'),(5,'Actualizar información adicional'),(6,'Validar foto'),(7,'Rechazar foto'),(8,'Adicionar foto'),(9,'Cambiar imagén principal');
/*!40000 ALTER TABLE `stra_acciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stra_auditoria`
--

DROP TABLE IF EXISTS `stra_auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stra_auditoria` (
  `id_stra_auditoria` int(11) NOT NULL AUTO_INCREMENT,
  `id_stra_accion` int(11) NOT NULL,
  `id_stra_elefante` int(11) NOT NULL,
  `id_stra_usuario` int(11) NOT NULL,
  `id_stra_tipo` int(11) NOT NULL,
  `datos` varchar(2028) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `titulo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_stra_auditoria`),
  KEY `fk_stra_auditoria_fk_stra_acciones_idx` (`id_stra_accion`),
  KEY `fk_stra_auditoria_fk_stra_tipos_idx` (`id_stra_tipo`),
  CONSTRAINT `fk_stra_auditoria_fk_stra_acciones` FOREIGN KEY (`id_stra_accion`) REFERENCES `stra_acciones` (`id_stra_accion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_stra_auditoria_fk_stra_tipos` FOREIGN KEY (`id_stra_tipo`) REFERENCES `stra_tipos` (`id_stra_tpo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stra_auditoria`
--

LOCK TABLES `stra_auditoria` WRITE;
/*!40000 ALTER TABLE `stra_auditoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `stra_auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stra_tipos`
--

DROP TABLE IF EXISTS `stra_tipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stra_tipos` (
  `id_stra_tpo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id_stra_tpo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stra_tipos`
--

LOCK TABLES `stra_tipos` WRITE;
/*!40000 ALTER TABLE `stra_tipos` DISABLE KEYS */;
INSERT INTO `stra_tipos` VALUES (1,'Crear'),(2,'Actualizar'),(3,'Eliminar');
/*!40000 ALTER TABLE `stra_tipos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-02-20 10:55:41
