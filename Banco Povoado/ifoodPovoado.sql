CREATE DATABASE  IF NOT EXISTS `ifoodlocal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ifoodlocal`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ifoodlocal
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Salgados'),(2,'Hambúrguer'),(3,'Pizzas'),(4,'Bebidas'),(5,'Doces');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `localidade`
--

DROP TABLE IF EXISTS `localidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `localidade` (
  `idUsuario` int NOT NULL,
  `localidade` varchar(100) NOT NULL,
  PRIMARY KEY (`idUsuario`,`localidade`),
  CONSTRAINT `fk_multLocalidadeUser` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `localidade`
--

LOCK TABLES `localidade` WRITE;
/*!40000 ALTER TABLE `localidade` DISABLE KEYS */;
/*!40000 ALTER TABLE `localidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcionais`
--

DROP TABLE IF EXISTS `opcionais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opcionais` (
  `idProduto` int NOT NULL,
  `opcional` varchar(100) NOT NULL,
  PRIMARY KEY (`idProduto`,`opcional`),
  CONSTRAINT `fk_multiOpcional` FOREIGN KEY (`idProduto`) REFERENCES `produto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcionais`
--

LOCK TABLES `opcionais` WRITE;
/*!40000 ALTER TABLE `opcionais` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcionais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `id` int NOT NULL,
  `localidade` varchar(100) NOT NULL,
  `taxaEntrega` decimal(5,2) NOT NULL,
  `statusPedido` enum('Aguardando Aprovação','Em Preparo','Em Entrega','Entregue','Cancelado') NOT NULL,
  `statusEntrega` enum('Pedido Retirado','Em Rota','Entregue') DEFAULT NULL,
  `statusPagamento` enum('Pago','Pendente','Reembolsado') NOT NULL,
  `tipoPagamento` enum('Cartão','PIX','Dinheiro') NOT NULL,
  `dataHora` datetime NOT NULL,
  `notaEntrega` int DEFAULT NULL,
  `notaRestaurante` int DEFAULT NULL,
  `comentario` text,
  `idUsuarioPede` int NOT NULL,
  `idUsuarioEntrega` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_entrega_idx` (`idUsuarioEntrega`),
  KEY `fk_realiza_idx` (`idUsuarioPede`),
  CONSTRAINT `fk_entrega` FOREIGN KEY (`idUsuarioEntrega`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_realiza` FOREIGN KEY (`idUsuarioPede`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `id` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  `preco` decimal(5,2) NOT NULL,
  `tempoPreparo` time DEFAULT NULL,
  `imagem` varchar(200) DEFAULT NULL,
  `ativo` tinyint NOT NULL DEFAULT '1',
  `idCategoria` int NOT NULL,
  `idRestaurante` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pertence_idx` (`idCategoria`),
  KEY `fk_possui_idx` (`idRestaurante`),
  CONSTRAINT `fk_pertence` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_possui` FOREIGN KEY (`idRestaurante`) REFERENCES `restaurante` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Hambúrguer',NULL,16.25,'00:40:00','/img/hamburguer1.webp',1,2,1),(2,'Pastel de Carne',NULL,10.99,'00:20:00','/img/pastel2.jpg',1,1,2),(3,'Pizza de Queijo',NULL,24.99,'00:53:00','/img/pizza2.jpg',1,3,3),(4,'Batatinha Frita',NULL,15.59,'00:25:00','/img/batatinha1.avif',1,1,4),(5,'Trufa de Maracujá',NULL,3.00,'00:10:00','/img/trufas.jpg',1,5,6),(6,'Sorvete',NULL,19.99,'00:15:00','/img/sorvete1.webp',1,5,7),(7,'Bolo de Chocolate',NULL,24.99,'00:53:00','/img/bolo1.avif',1,5,8),(8,'Tapioca de Carne Seca com Queijo',NULL,12.00,'00:15:00','/img/tapioca.png',1,1,9);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relaccontem`
--

DROP TABLE IF EXISTS `relaccontem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relaccontem` (
  `idProduto` int NOT NULL,
  `idPedido` int NOT NULL,
  `preco` decimal(5,2) NOT NULL,
  `quantidade` int NOT NULL,
  PRIMARY KEY (`idProduto`,`idPedido`),
  KEY `fk_contem2_idx` (`idPedido`),
  CONSTRAINT `fk_contem1` FOREIGN KEY (`idProduto`) REFERENCES `produto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_contem2` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relaccontem`
--

LOCK TABLES `relaccontem` WRITE;
/*!40000 ALTER TABLE `relaccontem` DISABLE KEYS */;
/*!40000 ALTER TABLE `relaccontem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relacreserva`
--

DROP TABLE IF EXISTS `relacreserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relacreserva` (
  `idUsuario` int NOT NULL,
  `idProduto` int NOT NULL,
  `quantidade` int NOT NULL,
  PRIMARY KEY (`idUsuario`,`idProduto`),
  KEY `fk_reserva1_idx` (`idProduto`),
  CONSTRAINT `fk_reserva1` FOREIGN KEY (`idProduto`) REFERENCES `produto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reserva2` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relacreserva`
--

LOCK TABLES `relacreserva` WRITE;
/*!40000 ALTER TABLE `relacreserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `relacreserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurante`
--

DROP TABLE IF EXISTS `restaurante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurante` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(11) NOT NULL,
  `ativo` tinyint NOT NULL DEFAULT '1',
  `cnpj` varchar(14) DEFAULT NULL,
  `localidade` varchar(100) DEFAULT NULL,
  `codigoCupom` varchar(10) DEFAULT NULL,
  `descontoCupom` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome_UNIQUE` (`nome`),
  UNIQUE KEY `cnpj_UNIQUE` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurante`
--

LOCK TABLES `restaurante` WRITE;
/*!40000 ALTER TABLE `restaurante` DISABLE KEYS */;
INSERT INTO `restaurante` VALUES (1,'Hambúrguer do Paulista','84987654321',1,'91653214000102','Avenida Engenheiro Roberto Freire, 3980 - Ponta Negra',NULL,NULL),(2,'Pastel da Anny','84976543210',1,'74289632000115','Rua Coronel Inácio Vale, 8847 - Ponta Negra',NULL,NULL),(3,'Pizzaria do João','84965432109',1,'08472951000136','Rua Dr. Manoel Varela, 123 - Centro Ceará-Mirim',NULL,NULL),(4,'Besteirinhas do Zé','84954321098',1,'53196847000199','Rua Heráclito Vilar, 456 - Centro Ceará-Mirim',NULL,NULL),(5,'Comida Japonesa','84943210987',1,'32578104000158','Avenida Amintas Barros, 3300 - Lagoa Nova',NULL,NULL),(6,'Trufas da Kali','84932109876',1,'15784269000141','Avenida Afonso Pena, 529 - Petrópolis',NULL,NULL),(7,'Gelado da M','84921098765',1,'62941578000183','Avenida Odilon Gomes de Lima, 1772 - Capim Macio',NULL,NULL),(8,'Bolos Já','84910987654',1,'89365120000170','Rua Guarapes, 1345 - Ceará-Mirim',NULL,NULL),(9,'Tropeira MIx','84909876543',1,'47125693000166','Avenida Engenheiro Roberto Freire, 4132 - Ponta Negra',NULL,NULL),(10,'Casa Solar','84998765432',1,'20659314000127','Rua Engenho Guaporé, 67 - Ceará-Mirim',NULL,NULL),(11,'Sanduicheria Beach','84987612345',1,'36841750000105','Rua da Alvorada, 321 - Muriú',NULL,NULL),(12,'Pastelaria Osnar','84976123456',1,'58702419000134','Rua Heráclito Galvão, 8820 - Ponta Negra',NULL,NULL);
/*!40000 ALTER TABLE `restaurante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `senha` varchar(256) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  `tipo` enum('cli','adm','ent','res') DEFAULT NULL,
  `foto` varchar(200) DEFAULT NULL,
  `idRestaurante` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_tem_idx` (`idRestaurante`),
  CONSTRAINT `fk_tem` FOREIGN KEY (`idRestaurante`) REFERENCES `restaurante` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'josefina.lima123@gmail.com','123456','Josefina Lima','84994065967','cli',NULL,NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ifoodlocal'
--

--
-- Dumping routines for database 'ifoodlocal'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-08 13:36:34
