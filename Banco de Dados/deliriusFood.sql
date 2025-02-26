-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: deliriusfood
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table ` cupom`
--

DROP TABLE IF EXISTS ` cupom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE ` cupom` (
  `valor` decimal(10,2) DEFAULT NULL,
  `regrasUso` varchar(100) DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `id cupom` int NOT NULL,
  `idRestaurante` int NOT NULL,
  PRIMARY KEY (`id cupom`,`idRestaurante`),
  KEY `fk_fornece_idx` (`idRestaurante`),
  CONSTRAINT `fk_fornece` FOREIGN KEY (`idRestaurante`) REFERENCES `restaurante` (`idRestaurante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table ` cupom`
--

LOCK TABLES ` cupom` WRITE;
/*!40000 ALTER TABLE ` cupom` DISABLE KEYS */;
/*!40000 ALTER TABLE ` cupom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliacoes`
--

DROP TABLE IF EXISTS `avaliacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacoes` (
  `dataHora` datetime DEFAULT NULL,
  `comentario` varchar(500) DEFAULT NULL,
  `nota` decimal(10,0) DEFAULT NULL,
  `idavaliacoes` int NOT NULL,
  `idCliente` int NOT NULL,
  `idEntregador` int NOT NULL,
  `idRestaurante` int NOT NULL,
  PRIMARY KEY (`idavaliacoes`,`idCliente`),
  KEY `fk_avalia_idx` (`idCliente`),
  KEY `fk_avalia_idx1` (`idEntregador`),
  KEY `fk_examina_idx` (`idRestaurante`),
  CONSTRAINT `fk_avalia` FOREIGN KEY (`idEntregador`) REFERENCES `entregador` (`idEntregador`),
  CONSTRAINT `fk_examina` FOREIGN KEY (`idRestaurante`) REFERENCES `restaurante` (`idRestaurante`),
  CONSTRAINT `fk_gera` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacoes`
--

LOCK TABLES `avaliacoes` WRITE;
/*!40000 ALTER TABLE `avaliacoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `idCliente` int NOT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`idCliente`,`idUsuario`),
  KEY `fk_idUsuario1_idx` (`idUsuario`),
  CONSTRAINT `fk_idUsuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enderecocliente`
--

DROP TABLE IF EXISTS `enderecocliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enderecocliente` (
  `ambiente` varchar(45) DEFAULT NULL,
  `proximidade` varchar(45) DEFAULT NULL,
  `sala` varchar(45) DEFAULT NULL,
  `idendereco` int NOT NULL,
  `idCliente` int NOT NULL,
  PRIMARY KEY (`idendereco`),
  KEY `fk_possui_idx` (`idCliente`),
  CONSTRAINT `fk_possui` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enderecocliente`
--

LOCK TABLES `enderecocliente` WRITE;
/*!40000 ALTER TABLE `enderecocliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `enderecocliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enderecoentregador`
--

DROP TABLE IF EXISTS `enderecoentregador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enderecoentregador` (
  `ambiente` varchar(45) DEFAULT NULL,
  `proximidade` varchar(45) DEFAULT NULL,
  `sala` varchar(45) DEFAULT NULL,
  `idendereco` int NOT NULL,
  `idEntregador` int NOT NULL,
  PRIMARY KEY (`idendereco`),
  KEY `fk_tem_idx` (`idEntregador`),
  CONSTRAINT `fk_tem` FOREIGN KEY (`idEntregador`) REFERENCES `entregador` (`idEntregador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enderecoentregador`
--

LOCK TABLES `enderecoentregador` WRITE;
/*!40000 ALTER TABLE `enderecoentregador` DISABLE KEYS */;
/*!40000 ALTER TABLE `enderecoentregador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enderecorestaurante`
--

DROP TABLE IF EXISTS `enderecorestaurante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enderecorestaurante` (
  `ambiente` varchar(10) DEFAULT NULL,
  `proximidade` varchar(10) DEFAULT NULL,
  `sala` varchar(10) DEFAULT NULL,
  `idEndereco` int NOT NULL,
  `idRestaurante` int NOT NULL,
  PRIMARY KEY (`idEndereco`,`idRestaurante`),
  KEY `fk_idrestaurante` (`idRestaurante`),
  CONSTRAINT `fk_idrestaurante` FOREIGN KEY (`idRestaurante`) REFERENCES `restaurante` (`idRestaurante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enderecorestaurante`
--

LOCK TABLES `enderecorestaurante` WRITE;
/*!40000 ALTER TABLE `enderecorestaurante` DISABLE KEYS */;
/*!40000 ALTER TABLE `enderecorestaurante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrega`
--

DROP TABLE IF EXISTS `entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrega` (
  `status` enum('entregue','em rota','pendente') DEFAULT NULL,
  `dataHora` datetime DEFAULT NULL,
  `idEntrega` int DEFAULT NULL,
  `idPedido` int NOT NULL,
  `idEntregador` int NOT NULL,
  KEY `fk_realiza_idx` (`idEntregador`),
  KEY `fk_abrange_idx` (`idPedido`),
  CONSTRAINT `fk_abrange` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`idpedido`),
  CONSTRAINT `fk_realiza` FOREIGN KEY (`idEntregador`) REFERENCES `entregador` (`idEntregador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrega`
--

LOCK TABLES `entrega` WRITE;
/*!40000 ALTER TABLE `entrega` DISABLE KEYS */;
/*!40000 ALTER TABLE `entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entregador`
--

DROP TABLE IF EXISTS `entregador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entregador` (
  `status` enum('ocupado','desocupado') DEFAULT NULL,
  `idEntregador` int NOT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`idEntregador`,`idUsuario`),
  KEY `fk_idUsuario3_idx` (`idUsuario`),
  CONSTRAINT `fk_idUsuario3` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entregador`
--

LOCK TABLES `entregador` WRITE;
/*!40000 ALTER TABLE `entregador` DISABLE KEYS */;
/*!40000 ALTER TABLE `entregador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itempedido`
--

DROP TABLE IF EXISTS `itempedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itempedido` (
  `quantidade` int DEFAULT NULL,
  `preco` decimal(10,0) DEFAULT NULL,
  `adicionaisOpcionais` varchar(100) DEFAULT NULL,
  `iditemPedido` int NOT NULL,
  `idPedido` int NOT NULL,
  `idproduto` int NOT NULL,
  PRIMARY KEY (`iditemPedido`,`idPedido`),
  KEY `fk_contem_idx` (`idPedido`),
  KEY `fk_agrega_idx` (`idproduto`),
  CONSTRAINT `fk_agrega` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`idProduto`),
  CONSTRAINT `fk_contem` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`idpedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itempedido`
--

LOCK TABLES `itempedido` WRITE;
/*!40000 ALTER TABLE `itempedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `itempedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento` (
  `valor` decimal(10,2) DEFAULT NULL,
  `status` enum('pendente','pago','reembolsado') DEFAULT NULL,
  `idPagamento` int NOT NULL,
  `idPedido` int NOT NULL,
  PRIMARY KEY (`idPagamento`,`idPedido`),
  KEY `fk_engloba_idx` (`idPedido`),
  CONSTRAINT `fk_engloba` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`idpedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamento`
--

LOCK TABLES `pagamento` WRITE;
/*!40000 ALTER TABLE `pagamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `taxaEntrega` decimal(4,2) DEFAULT NULL,
  `status` enum('aguardando aprovação','em preparo','em entrega','entregue','cancelado') DEFAULT NULL,
  `metodoPagamento` varchar(45) DEFAULT NULL,
  `valorBruto` decimal(10,2) DEFAULT NULL,
  `dataHora` datetime DEFAULT NULL,
  `valorPago` decimal(10,2) DEFAULT NULL,
  `idpedido` int NOT NULL,
  `idCliente` int NOT NULL,
  `idProduto` int NOT NULL,
  `idEnderecoCliente` int NOT NULL,
  `idRestaurante` int NOT NULL,
  PRIMARY KEY (`idpedido`,`idCliente`),
  KEY `fk_idcliente_idx` (`idCliente`),
  KEY `fk_idproduto_idx` (`idProduto`),
  KEY `fk_enderecoCliente_idx` (`idEnderecoCliente`),
  KEY `fk_atende_idx` (`idRestaurante`),
  CONSTRAINT `fk_atende` FOREIGN KEY (`idRestaurante`) REFERENCES `restaurante` (`idRestaurante`),
  CONSTRAINT `fk_enderecoCliente` FOREIGN KEY (`idEnderecoCliente`) REFERENCES `enderecocliente` (`idendereco`),
  CONSTRAINT `fk_idcliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`),
  CONSTRAINT `fk_idproduto` FOREIGN KEY (`idProduto`) REFERENCES `produto` (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
  `nome` varchar(45) DEFAULT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  `preco` decimal(10,2) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  `tempoPreparo` datetime DEFAULT NULL,
  `imagem` varchar(1000) DEFAULT NULL,
  `idProduto` int NOT NULL,
  `idRestaurante` int NOT NULL,
  PRIMARY KEY (`idProduto`,`idRestaurante`),
  KEY `fk_pertence_idx` (`idRestaurante`),
  CONSTRAINT `fk_pertence` FOREIGN KEY (`idRestaurante`) REFERENCES `restaurante` (`idRestaurante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurante`
--

DROP TABLE IF EXISTS `restaurante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurante` (
  `cnpj` varchar(14) DEFAULT NULL,
  `idRestaurante` int NOT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`idRestaurante`,`idUsuario`),
  KEY `fk_idUsuario2_idx` (`idUsuario`),
  CONSTRAINT `fk_idUsuario2` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurante`
--

LOCK TABLES `restaurante` WRITE;
/*!40000 ALTER TABLE `restaurante` DISABLE KEYS */;
/*!40000 ALTER TABLE `restaurante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefoneusuario`
--

DROP TABLE IF EXISTS `telefoneusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telefoneusuario` (
  `idtelefone` int NOT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`idtelefone`,`idUsuario`),
  KEY `fk_idUsuario_idx` (`idUsuario`),
  CONSTRAINT `fk_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefoneusuario`
--

LOCK TABLES `telefoneusuario` WRITE;
/*!40000 ALTER TABLE `telefoneusuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `telefoneusuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idusuario` int NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `senha` varchar(45) DEFAULT NULL,
  `tipoUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-26 19:06:08
