-- MySQL dump 10.13  Distrib 5.1.60, for Win32 (ia32)
--
-- Host: localhost    Database: mifostenant-default
-- ------------------------------------------------------
-- Server version	5.1.60-community

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
-- Table structure for table `acc_gl_account`
--

DROP TABLE IF EXISTS `acc_gl_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `gl_code` varchar(45) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `manual_journal_entries_allowed` tinyint(1) NOT NULL DEFAULT '1',
  `account_usage` tinyint(1) NOT NULL DEFAULT '2',
  `classification_enum` smallint(5) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acc_gl_code` (`gl_code`),
  KEY `FK_ACC_0000000001` (`parent_id`),
  CONSTRAINT `FK_ACC_0000000001` FOREIGN KEY (`parent_id`) REFERENCES `acc_gl_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_account`
--

LOCK TABLES `acc_gl_account` WRITE;
/*!40000 ALTER TABLE `acc_gl_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_gl_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_gl_closure`
--

DROP TABLE IF EXISTS `acc_gl_closure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_closure` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `office_id` bigint(20) NOT NULL,
  `closing_date` date NOT NULL,
  `is_deleted` int(20) NOT NULL DEFAULT '0',
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `comments` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `office_id_closing_date` (`office_id`,`closing_date`),
  KEY `FK_acc_gl_closure_m_office` (`office_id`),
  KEY `FK_acc_gl_closure_m_appuser` (`createdby_id`),
  KEY `FK_acc_gl_closure_m_appuser_2` (`lastmodifiedby_id`),
  CONSTRAINT `FK_acc_gl_closure_m_appuser` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_closure_m_appuser_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_closure_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_closure`
--

LOCK TABLES `acc_gl_closure` WRITE;
/*!40000 ALTER TABLE `acc_gl_closure` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_gl_closure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_gl_journal_entry`
--

DROP TABLE IF EXISTS `acc_gl_journal_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_gl_journal_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `reversal_id` bigint(20) DEFAULT NULL,
  `transaction_id` varchar(50) NOT NULL,
  `reversed` tinyint(1) NOT NULL DEFAULT '0',
  `manual_entry` tinyint(1) NOT NULL DEFAULT '0',
  `entry_date` date NOT NULL,
  `type_enum` smallint(5) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `entity_type_enum` smallint(5) DEFAULT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `createdby_id` bigint(20) NOT NULL,
  `lastmodifiedby_id` bigint(20) NOT NULL,
  `created_date` datetime NOT NULL,
  `lastmodified_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_acc_gl_journal_entry_m_office` (`office_id`),
  KEY `FK_acc_gl_journal_entry_m_appuser` (`createdby_id`),
  KEY `FK_acc_gl_journal_entry_m_appuser_2` (`lastmodifiedby_id`),
  KEY `FK_acc_gl_journal_entry_acc_gl_journal_entry` (`reversal_id`),
  KEY `FK_acc_gl_journal_entry_acc_gl_account` (`account_id`),
  CONSTRAINT `FK_acc_gl_journal_entry_acc_gl_account` FOREIGN KEY (`account_id`) REFERENCES `acc_gl_account` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_acc_gl_journal_entry` FOREIGN KEY (`reversal_id`) REFERENCES `acc_gl_journal_entry` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_appuser` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_appuser_2` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_acc_gl_journal_entry_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_gl_journal_entry`
--

LOCK TABLES `acc_gl_journal_entry` WRITE;
/*!40000 ALTER TABLE `acc_gl_journal_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_gl_journal_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_product_mapping`
--

DROP TABLE IF EXISTS `acc_product_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_product_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gl_account_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `product_type` smallint(5) DEFAULT NULL,
  `financial_account_type` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_product_mapping`
--

LOCK TABLES `acc_product_mapping` WRITE;
/*!40000 ALTER TABLE `acc_product_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc_product_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_configuration`
--

DROP TABLE IF EXISTS `c_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_configuration`
--

LOCK TABLES `c_configuration` WRITE;
/*!40000 ALTER TABLE `c_configuration` DISABLE KEYS */;
INSERT INTO `c_configuration` VALUES (1,'maker-checker',0);
/*!40000 ALTER TABLE `c_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_appuser`
--

DROP TABLE IF EXISTS `m_appuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_appuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `office_id` bigint(20) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `firsttime_login_remaining` bit(1) NOT NULL,
  `nonexpired` bit(1) NOT NULL,
  `nonlocked` bit(1) NOT NULL,
  `nonexpired_credentials` bit(1) NOT NULL,
  `enabled` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_org` (`username`),
  KEY `FKB3D587CE0DD567A` (`office_id`),
  CONSTRAINT `FKB3D587CE0DD567A` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_appuser`
--

LOCK TABLES `m_appuser` WRITE;
/*!40000 ALTER TABLE `m_appuser` DISABLE KEYS */;
INSERT INTO `m_appuser` VALUES (1,0,1,'mifos','App','Administrator','5787039480429368bf94732aacc771cd0a3ea02bcf504ffe1185ab94213bc63a','demomfi@mifos.org','\0','','','','');
/*!40000 ALTER TABLE `m_appuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_appuser_role`
--

DROP TABLE IF EXISTS `m_appuser_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_appuser_role` (
  `appuser_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`appuser_id`,`role_id`),
  KEY `FK7662CE59B4100309` (`appuser_id`),
  KEY `FK7662CE5915CEC7AB` (`role_id`),
  CONSTRAINT `FK7662CE5915CEC7AB` FOREIGN KEY (`role_id`) REFERENCES `m_role` (`id`),
  CONSTRAINT `FK7662CE59B4100309` FOREIGN KEY (`appuser_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_appuser_role`
--

LOCK TABLES `m_appuser_role` WRITE;
/*!40000 ALTER TABLE `m_appuser_role` DISABLE KEYS */;
INSERT INTO `m_appuser_role` VALUES (1,1);
/*!40000 ALTER TABLE `m_appuser_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_charge`
--

DROP TABLE IF EXISTS `m_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `charge_applies_to_enum` smallint(5) NOT NULL,
  `charge_time_enum` smallint(5) NOT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `is_penalty` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_charge`
--

LOCK TABLES `m_charge` WRITE;
/*!40000 ALTER TABLE `m_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client`
--

DROP TABLE IF EXISTS `m_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_no` varchar(20) NOT NULL,
  `office_id` bigint(20) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `display_name` varchar(100) NOT NULL,
  `image_key` varchar(500) DEFAULT NULL,
  `joined_date` date DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_no_UNIQUE` (`account_no`),
  UNIQUE KEY `external_id` (`external_id`),
  KEY `FKCE00CAB3E0DD567A` (`office_id`),
  CONSTRAINT `FKCE00CAB3E0DD567A` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client`
--

LOCK TABLES `m_client` WRITE;
/*!40000 ALTER TABLE `m_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_client_identifier`
--

DROP TABLE IF EXISTS `m_client_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_client_identifier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `document_type_id` int(11) NOT NULL,
  `document_key` varchar(50) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_identifier_key` (`document_type_id`,`document_key`),
  UNIQUE KEY `unique_client_identifier` (`client_id`,`document_type_id`),
  KEY `FK_m_client_document_m_client` (`client_id`),
  KEY `FK_m_client_document_m_code_value` (`document_type_id`),
  CONSTRAINT `FK_m_client_document_m_client` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK_m_client_document_m_code_value` FOREIGN KEY (`document_type_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_client_identifier`
--

LOCK TABLES `m_client_identifier` WRITE;
/*!40000 ALTER TABLE `m_client_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_client_identifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_code`
--

DROP TABLE IF EXISTS `m_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_name` varchar(100) DEFAULT NULL,
  `is_system_defined` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_name` (`code_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_code`
--

LOCK TABLES `m_code` WRITE;
/*!40000 ALTER TABLE `m_code` DISABLE KEYS */;
INSERT INTO `m_code` VALUES (1,'Customer Identifier',1),(2,'LoanCollateral',1),(3,'LoanPurpose',1),(4,'Gender',1),(5,'YesNo',1);
/*!40000 ALTER TABLE `m_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_code_value`
--

DROP TABLE IF EXISTS `m_code_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_code_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_id` int(11) NOT NULL,
  `code_value` varchar(100) DEFAULT NULL,
  `order_position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_value` (`code_id`,`code_value`),
  KEY `FKCFCEA42640BE071Z` (`code_id`),
  CONSTRAINT `FKCFCEA42640BE071Z` FOREIGN KEY (`code_id`) REFERENCES `m_code` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_code_value`
--

LOCK TABLES `m_code_value` WRITE;
/*!40000 ALTER TABLE `m_code_value` DISABLE KEYS */;
INSERT INTO `m_code_value` VALUES (1,1,'Passport',1),(2,1,'Id',1),(3,1,'Drivers License',2),(4,1,'Any Other Id Type',3);
/*!40000 ALTER TABLE `m_code_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_currency`
--

DROP TABLE IF EXISTS `m_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) NOT NULL,
  `decimal_places` smallint(5) NOT NULL,
  `display_symbol` varchar(10) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `internationalized_name_code` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_currency`
--

LOCK TABLES `m_currency` WRITE;
/*!40000 ALTER TABLE `m_currency` DISABLE KEYS */;
INSERT INTO `m_currency` VALUES (1,'AED',2,NULL,'UAE Dirham','currency.AED'),(2,'AFN',2,NULL,'Afghanistan Afghani','currency.AFN'),(3,'ALL',2,NULL,'Albanian Lek','currency.ALL'),(4,'AMD',2,NULL,'Armenian Dram','currency.AMD'),(5,'ANG',2,NULL,'Netherlands Antillian Guilder','currency.ANG'),(6,'AOA',2,NULL,'Angolan Kwanza','currency.AOA'),(7,'ARS',2,'$','Argentine Peso','currency.ARS'),(8,'AUD',2,'A$','Australian Dollar','currency.AUD'),(9,'AWG',2,NULL,'Aruban Guilder','currency.AWG'),(10,'AZM',2,NULL,'Azerbaijanian Manat','currency.AZM'),(11,'BAM',2,NULL,'Bosnia and Herzegovina Convertible Marks','currency.BAM'),(12,'BBD',2,NULL,'Barbados Dollar','currency.BBD'),(13,'BDT',2,NULL,'Bangladesh Taka','currency.BDT'),(14,'BGN',2,NULL,'Bulgarian Lev','currency.BGN'),(15,'BHD',3,NULL,'Bahraini Dinar','currency.BHD'),(16,'BIF',0,NULL,'Burundi Franc','currency.BIF'),(17,'BMD',2,NULL,'Bermudian Dollar','currency.BMD'),(18,'BND',2,'B$','Brunei Dollar','currency.BND'),(19,'BOB',2,'Bs.','Bolivian Boliviano','currency.BOB'),(20,'BRL',2,'R$','Brazilian Real','currency.BRL'),(21,'BSD',2,NULL,'Bahamian Dollar','currency.BSD'),(22,'BTN',2,NULL,'Bhutan Ngultrum','currency.BTN'),(23,'BWP',2,NULL,'Botswana Pula','currency.BWP'),(24,'BYR',0,NULL,'Belarussian Ruble','currency.BYR'),(25,'BZD',2,'BZ$','Belize Dollar','currency.BZD'),(26,'CAD',2,NULL,'Canadian Dollar','currency.CAD'),(27,'CDF',2,NULL,'Franc Congolais','currency.CDF'),(28,'CHF',2,NULL,'Swiss Franc','currency.CHF'),(29,'CLP',0,'$','Chilean Peso','currency.CLP'),(30,'CNY',2,NULL,'Chinese Yuan Renminbi','currency.CNY'),(31,'COP',2,'$','Colombian Peso','currency.COP'),(32,'CRC',2,'₡','Costa Rican Colon','currency.CRC'),(33,'CSD',2,NULL,'Serbian Dinar','currency.CSD'),(34,'CUP',2,'$MN','Cuban Peso','currency.CUP'),(35,'CVE',2,NULL,'Cape Verde Escudo','currency.CVE'),(36,'CYP',2,NULL,'Cyprus Pound','currency.CYP'),(37,'CZK',2,NULL,'Czech Koruna','currency.CZK'),(38,'DJF',0,NULL,'Djibouti Franc','currency.DJF'),(39,'DKK',2,NULL,'Danish Krone','currency.DKK'),(40,'DOP',2,'RD$','Dominican Peso','currency.DOP'),(41,'DZD',2,NULL,'Algerian Dinar','currency.DZD'),(42,'EEK',2,NULL,'Estonian Kroon','currency.EEK'),(43,'EGP',2,NULL,'Egyptian Pound','currency.EGP'),(44,'ERN',2,NULL,'Eritrea Nafka','currency.ERN'),(45,'ETB',2,NULL,'Ethiopian Birr','currency.ETB'),(46,'EUR',2,'€','Euro','currency.EUR'),(47,'FJD',2,NULL,'Fiji Dollar','currency.FJD'),(48,'FKP',2,NULL,'Falkland Islands Pound','currency.FKP'),(49,'GBP',2,NULL,'Pound Sterling','currency.GBP'),(50,'GEL',2,NULL,'Georgian Lari','currency.GEL'),(51,'GHC',2,'GHc','Ghana Cedi','currency.GHC'),(52,'GIP',2,NULL,'Gibraltar Pound','currency.GIP'),(53,'GMD',2,NULL,'Gambian Dalasi','currency.GMD'),(54,'GNF',0,NULL,'Guinea Franc','currency.GNF'),(55,'GTQ',2,'Q','Guatemala Quetzal','currency.GTQ'),(56,'GYD',2,NULL,'Guyana Dollar','currency.GYD'),(57,'HKD',2,NULL,'Hong Kong Dollar','currency.HKD'),(58,'HNL',2,'L','Honduras Lempira','currency.HNL'),(59,'HRK',2,NULL,'Croatian Kuna','currency.HRK'),(60,'HTG',2,'G','Haiti Gourde','currency.HTG'),(61,'HUF',2,NULL,'Hungarian Forint','currency.HUF'),(62,'IDR',2,NULL,'Indonesian Rupiah','currency.IDR'),(63,'ILS',2,NULL,'New Israeli Shekel','currency.ILS'),(64,'INR',2,'₹','Indian Rupee','currency.INR'),(65,'IQD',3,NULL,'Iraqi Dinar','currency.IQD'),(66,'IRR',2,NULL,'Iranian Rial','currency.IRR'),(67,'ISK',0,NULL,'Iceland Krona','currency.ISK'),(68,'JMD',2,NULL,'Jamaican Dollar','currency.JMD'),(69,'JOD',3,NULL,'Jordanian Dinar','currency.JOD'),(70,'JPY',0,NULL,'Japanese Yen','currency.JPY'),(71,'KES',2,'KSh','Kenyan Shilling','currency.KES'),(72,'KGS',2,NULL,'Kyrgyzstan Som','currency.KGS'),(73,'KHR',2,NULL,'Cambodia Riel','currency.KHR'),(74,'KMF',0,NULL,'Comoro Franc','currency.KMF'),(75,'KPW',2,NULL,'North Korean Won','currency.KPW'),(76,'KRW',0,NULL,'Korean Won','currency.KRW'),(77,'KWD',3,NULL,'Kuwaiti Dinar','currency.KWD'),(78,'KYD',2,NULL,'Cayman Islands Dollar','currency.KYD'),(79,'KZT',2,NULL,'Kazakhstan Tenge','currency.KZT'),(80,'LAK',2,NULL,'Lao Kip','currency.LAK'),(81,'LBP',2,'L£','Lebanese Pound','currency.LBP'),(82,'LKR',2,NULL,'Sri Lanka Rupee','currency.LKR'),(83,'LRD',2,NULL,'Liberian Dollar','currency.LRD'),(84,'LSL',2,NULL,'Lesotho Loti','currency.LSL'),(85,'LTL',2,NULL,'Lithuanian Litas','currency.LTL'),(86,'LVL',2,NULL,'Latvian Lats','currency.LVL'),(87,'LYD',3,NULL,'Libyan Dinar','currency.LYD'),(88,'MAD',2,NULL,'Moroccan Dirham','currency.MAD'),(89,'MDL',2,NULL,'Moldovan Leu','currency.MDL'),(90,'MGA',2,NULL,'Malagasy Ariary','currency.MGA'),(91,'MKD',2,NULL,'Macedonian Denar','currency.MKD'),(92,'MMK',2,'K','Myanmar Kyat','currency.MMK'),(93,'MNT',2,NULL,'Mongolian Tugrik','currency.MNT'),(94,'MOP',2,NULL,'Macau Pataca','currency.MOP'),(95,'MRO',2,NULL,'Mauritania Ouguiya','currency.MRO'),(96,'MTL',2,NULL,'Maltese Lira','currency.MTL'),(97,'MUR',2,NULL,'Mauritius Rupee','currency.MUR'),(98,'MVR',2,NULL,'Maldives Rufiyaa','currency.MVR'),(99,'MWK',2,NULL,'Malawi Kwacha','currency.MWK'),(100,'MXN',2,'$','Mexican Peso','currency.MXN'),(101,'MYR',2,NULL,'Malaysian Ringgit','currency.MYR'),(102,'MZM',2,NULL,'Mozambique Metical','currency.MZM'),(103,'NAD',2,NULL,'Namibia Dollar','currency.NAD'),(104,'NGN',2,NULL,'Nigerian Naira','currency.NGN'),(105,'NIO',2,'C$','Nicaragua Cordoba Oro','currency.NIO'),(106,'NOK',2,NULL,'Norwegian Krone','currency.NOK'),(107,'NPR',2,NULL,'Nepalese Rupee','currency.NPR'),(108,'NZD',2,NULL,'New Zealand Dollar','currency.NZD'),(109,'OMR',3,NULL,'Rial Omani','currency.OMR'),(110,'PAB',2,'B/.','Panama Balboa','currency.PAB'),(111,'PEN',2,'S/.','Peruvian Nuevo Sol','currency.PEN'),(112,'PGK',2,NULL,'Papua New Guinea Kina','currency.PGK'),(113,'PHP',2,NULL,'Philippine Peso','currency.PHP'),(114,'PKR',2,NULL,'Pakistan Rupee','currency.PKR'),(115,'PLN',2,NULL,'Polish Zloty','currency.PLN'),(116,'PYG',0,'₲','Paraguayan Guarani','currency.PYG'),(117,'QAR',2,NULL,'Qatari Rial','currency.QAR'),(118,'RON',2,NULL,'Romanian Leu','currency.RON'),(119,'RUB',2,NULL,'Russian Ruble','currency.RUB'),(120,'RWF',0,NULL,'Rwanda Franc','currency.RWF'),(121,'SAR',2,NULL,'Saudi Riyal','currency.SAR'),(122,'SBD',2,NULL,'Solomon Islands Dollar','currency.SBD'),(123,'SCR',2,NULL,'Seychelles Rupee','currency.SCR'),(124,'SDD',2,NULL,'Sudanese Dinar','currency.SDD'),(125,'SEK',2,NULL,'Swedish Krona','currency.SEK'),(126,'SGD',2,NULL,'Singapore Dollar','currency.SGD'),(127,'SHP',2,NULL,'St Helena Pound','currency.SHP'),(128,'SIT',2,NULL,'Slovenian Tolar','currency.SIT'),(129,'SKK',2,NULL,'Slovak Koruna','currency.SKK'),(130,'SLL',2,NULL,'Sierra Leone Leone','currency.SLL'),(131,'SOS',2,NULL,'Somali Shilling','currency.SOS'),(132,'SRD',2,NULL,'Surinam Dollar','currency.SRD'),(133,'STD',2,NULL,'Sao Tome and Principe Dobra','currency.STD'),(134,'SVC',2,NULL,'El Salvador Colon','currency.SVC'),(135,'SYP',2,NULL,'Syrian Pound','currency.SYP'),(136,'SZL',2,NULL,'Swaziland Lilangeni','currency.SZL'),(137,'THB',2,NULL,'Thai Baht','currency.THB'),(138,'TJS',2,NULL,'Tajik Somoni','currency.TJS'),(139,'TMM',2,NULL,'Turkmenistan Manat','currency.TMM'),(140,'TND',3,'DT','Tunisian Dinar','currency.TND'),(141,'TOP',2,NULL,'Tonga Pa\'anga','currency.TOP'),(142,'TRY',2,NULL,'Turkish Lira','currency.TRY'),(143,'TTD',2,NULL,'Trinidad and Tobago Dollar','currency.TTD'),(144,'TWD',2,NULL,'New Taiwan Dollar','currency.TWD'),(145,'TZS',2,NULL,'Tanzanian Shilling','currency.TZS'),(146,'UAH',2,NULL,'Ukraine Hryvnia','currency.UAH'),(147,'UGX',2,'USh','Uganda Shilling','currency.UGX'),(148,'USD',2,'$','US Dollar','currency.USD'),(149,'UYU',2,'$U','Peso Uruguayo','currency.UYU'),(150,'UZS',2,NULL,'Uzbekistan Sum','currency.UZS'),(151,'VEB',2,'Bs.F.','Venezuelan Bolivar','currency.VEB'),(152,'VND',2,NULL,'Vietnamese Dong','currency.VND'),(153,'VUV',0,NULL,'Vanuatu Vatu','currency.VUV'),(154,'WST',2,NULL,'Samoa Tala','currency.WST'),(155,'XAF',0,NULL,'CFA Franc BEAC','currency.XAF'),(156,'XCD',2,NULL,'East Caribbean Dollar','currency.XCD'),(157,'XDR',5,NULL,'SDR (Special Drawing Rights)','currency.XDR'),(158,'XOF',0,'CFA','CFA Franc BCEAO','currency.XOF'),(159,'XPF',0,NULL,'CFP Franc','currency.XPF'),(160,'YER',2,NULL,'Yemeni Rial','currency.YER'),(161,'ZAR',2,'R','South African Rand','currency.ZAR'),(162,'ZMK',2,NULL,'Zambian Kwacha','currency.ZMK'),(163,'ZWD',2,NULL,'Zimbabwe Dollar','currency.ZWD');
/*!40000 ALTER TABLE `m_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_account`
--

DROP TABLE IF EXISTS `m_deposit_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `status_enum` smallint(5) NOT NULL DEFAULT '0',
  `external_id` varchar(100) DEFAULT NULL,
  `client_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `deposit_amount` decimal(19,6) DEFAULT NULL,
  `maturity_nominal_interest_rate` decimal(19,6) NOT NULL,
  `tenure_months` int(11) NOT NULL,
  `interest_compounded_every` smallint(5) NOT NULL DEFAULT '1',
  `interest_compounded_every_period_enum` smallint(5) NOT NULL DEFAULT '2',
  `projected_commencement_date` date NOT NULL,
  `actual_commencement_date` date DEFAULT NULL,
  `matures_on_date` datetime DEFAULT NULL,
  `projected_interest_accrued_on_maturity` decimal(19,6) NOT NULL,
  `actual_interest_accrued` decimal(19,6) DEFAULT NULL,
  `projected_total_maturity_amount` decimal(19,6) NOT NULL,
  `actual_total_amount` decimal(19,6) DEFAULT NULL,
  `is_compounding_interest_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `interest_paid` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_interest_withdrawable` tinyint(1) NOT NULL DEFAULT '0',
  `available_interest` decimal(19,6) DEFAULT '0.000000',
  `interest_posted_amount` decimal(19,6) DEFAULT '0.000000',
  `last_interest_posted_date` date DEFAULT NULL,
  `next_interest_posting_date` date DEFAULT NULL,
  `is_renewal_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `renewed_account_id` bigint(20) DEFAULT NULL,
  `is_preclosure_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `pre_closure_interest_rate` decimal(19,6) NOT NULL,
  `is_lock_in_period_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `lock_in_period` bigint(20) DEFAULT NULL,
  `lock_in_period_type` smallint(5) NOT NULL DEFAULT '2',
  `withdrawnon_date` datetime DEFAULT NULL,
  `rejectedon_date` datetime DEFAULT NULL,
  `closedon_date` datetime DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deposit_acc_external_id` (`external_id`),
  KEY `FKKW0000000000001` (`client_id`),
  KEY `FKKW0000000000002` (`product_id`),
  KEY `FKKW0000000000003` (`renewed_account_id`),
  CONSTRAINT `FKKW0000000000001` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FKKW0000000000002` FOREIGN KEY (`product_id`) REFERENCES `m_product_deposit` (`id`),
  CONSTRAINT `FKKW0000000000003` FOREIGN KEY (`renewed_account_id`) REFERENCES `m_deposit_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_account`
--

LOCK TABLES `m_deposit_account` WRITE;
/*!40000 ALTER TABLE `m_deposit_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_deposit_account_transaction`
--

DROP TABLE IF EXISTS `m_deposit_account_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_deposit_account_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deposit_account_id` bigint(20) NOT NULL,
  `transaction_type_enum` smallint(5) NOT NULL,
  `contra_id` bigint(20) DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `interest` decimal(19,6) NOT NULL,
  `total` decimal(19,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKKW00000000000005` (`deposit_account_id`),
  KEY `FKKW00000000000006` (`contra_id`),
  CONSTRAINT `FKKW00000000000005` FOREIGN KEY (`deposit_account_id`) REFERENCES `m_deposit_account` (`id`),
  CONSTRAINT `FKKW00000000000006` FOREIGN KEY (`contra_id`) REFERENCES `m_deposit_account_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_deposit_account_transaction`
--

LOCK TABLES `m_deposit_account_transaction` WRITE;
/*!40000 ALTER TABLE `m_deposit_account_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_deposit_account_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_document`
--

DROP TABLE IF EXISTS `m_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_document` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `parent_entity_type` varchar(50) NOT NULL,
  `parent_entity_id` int(20) NOT NULL DEFAULT '0',
  `name` varchar(250) NOT NULL,
  `file_name` varchar(250) NOT NULL,
  `size` int(20) DEFAULT '0',
  `type` varchar(50) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `location` varchar(500) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_document`
--

LOCK TABLES `m_document` WRITE;
/*!40000 ALTER TABLE `m_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_fund`
--

DROP TABLE IF EXISTS `m_fund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_fund` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fund_name_org` (`name`),
  UNIQUE KEY `fund_externalid_org` (`external_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_fund`
--

LOCK TABLES `m_fund` WRITE;
/*!40000 ALTER TABLE `m_fund` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_group`
--

DROP TABLE IF EXISTS `m_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `office_id` bigint(20) NOT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `level_Id` int(11) NOT NULL,
  `hierarchy` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `external_id` (`external_id`),
  KEY `office_id` (`office_id`),
  KEY `staff_id` (`staff_id`),
  KEY `Parent_Id_reference` (`parent_id`),
  KEY `FK_m_group_level` (`level_Id`),
  CONSTRAINT `m_group_ibfk_1` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `Parent_Id_reference` FOREIGN KEY (`parent_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FK_m_group_level` FOREIGN KEY (`level_Id`) REFERENCES `m_group_level` (`id`),
  CONSTRAINT `FK_m_group_m_staff` FOREIGN KEY (`staff_id`) REFERENCES `m_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_group`
--

LOCK TABLES `m_group` WRITE;
/*!40000 ALTER TABLE `m_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_group_client`
--

DROP TABLE IF EXISTS `m_group_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_group_client` (
  `group_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`group_id`,`client_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `m_group_client_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `m_group_client_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_group_client`
--

LOCK TABLES `m_group_client` WRITE;
/*!40000 ALTER TABLE `m_group_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_group_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_group_level`
--

DROP TABLE IF EXISTS `m_group_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_group_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `super_parent` tinyint(1) NOT NULL,
  `level_name` varchar(100) NOT NULL,
  `recursable` tinyint(1) NOT NULL,
  `can_have_clients` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Parent_levelId_reference` (`parent_id`),
  CONSTRAINT `Parent_levelId_reference` FOREIGN KEY (`parent_id`) REFERENCES `m_group_level` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_group_level`
--

LOCK TABLES `m_group_level` WRITE;
/*!40000 ALTER TABLE `m_group_level` DISABLE KEYS */;
INSERT INTO `m_group_level` VALUES (1,NULL,1,'Center',1,0),(2,1,0,'Group',0,1);
/*!40000 ALTER TABLE `m_group_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_guarantor`
--

DROP TABLE IF EXISTS `m_guarantor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_guarantor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `type_enum` smallint(5) NOT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address_line_1` varchar(500) DEFAULT NULL,
  `address_line_2` varchar(500) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `house_phone_number` varchar(20) DEFAULT NULL,
  `mobile_number` varchar(20) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_guarantor_m_loan` (`loan_id`),
  CONSTRAINT `FK_m_guarantor_m_loan` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_guarantor`
--

LOCK TABLES `m_guarantor` WRITE;
/*!40000 ALTER TABLE `m_guarantor` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_guarantor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan`
--

DROP TABLE IF EXISTS `m_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_no` varchar(20) NOT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `fund_id` bigint(20) DEFAULT NULL,
  `loan_officer_id` bigint(20) DEFAULT NULL,
  `loanpurpose_cv_id` int(11) DEFAULT NULL,
  `loan_transaction_strategy_id` bigint(20) DEFAULT NULL,
  `loan_status_id` smallint(5) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `principal_amount` decimal(19,6) NOT NULL,
  `arrearstolerance_amount` decimal(19,6) DEFAULT NULL,
  `nominal_interest_rate_per_period` decimal(19,6) NOT NULL,
  `interest_period_frequency_enum` smallint(5) NOT NULL,
  `annual_nominal_interest_rate` decimal(19,6) NOT NULL,
  `interest_method_enum` smallint(5) NOT NULL,
  `interest_calculated_in_period_enum` smallint(5) NOT NULL DEFAULT '1',
  `term_frequency` smallint(5) NOT NULL DEFAULT '0',
  `term_period_frequency_enum` smallint(5) NOT NULL DEFAULT '2',
  `number_of_repayments` smallint(5) NOT NULL,
  `repay_every` smallint(5) NOT NULL,
  `repayment_period_frequency_enum` smallint(5) NOT NULL,
  `amortization_method_enum` smallint(5) NOT NULL,
  `interest_calculated_from_date` date DEFAULT NULL,
  `expected_disbursedon_date` date DEFAULT NULL,
  `expected_firstrepaymenton_date` date DEFAULT NULL,
  `expected_maturedon_date` date DEFAULT NULL,
  `maturedon_date` date DEFAULT NULL,
  `submittedon_date` date DEFAULT NULL,
  `submittedon_userid` bigint(20) DEFAULT NULL,
  `approvedon_date` date DEFAULT NULL,
  `approvedon_userid` bigint(20) DEFAULT NULL,
  `rejectedon_date` date DEFAULT NULL,
  `rejectedon_userid` bigint(20) DEFAULT NULL,
  `withdrawnon_date` date DEFAULT NULL,
  `withdrawnon_userid` bigint(20) DEFAULT NULL,
  `disbursedon_date` date DEFAULT NULL,
  `disbursedon_userid` bigint(20) DEFAULT NULL,
  `rescheduledon_date` date DEFAULT NULL,
  `writtenoffon_date` date DEFAULT NULL,
  `closedon_date` date DEFAULT NULL,
  `closedon_userid` bigint(20) DEFAULT NULL,
  `total_charges_due_at_disbursement_derived` decimal(19,6) DEFAULT NULL,
  `principal_disbursed_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `principal_repaid_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `principal_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `principal_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `principal_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_charged_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_repaid_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_waived_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `interest_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_charged_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_repaid_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_waived_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fee_charges_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_charged_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_repaid_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_waived_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `penalty_charges_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_expected_repayment_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_repayment_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_expected_costofloan_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_costofloan_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_waived_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_writtenoff_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `total_overdue_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `overdue_since_date_derived` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `loan_account_no_UNIQUE` (`account_no`),
  UNIQUE KEY `loan_externalid_UNIQUE` (`external_id`),
  KEY `FKB6F935D87179A0CB` (`client_id`),
  KEY `FKB6F935D8C8D4B434` (`product_id`),
  KEY `FK7C885877240145` (`fund_id`),
  KEY `FK_loan_ltp_strategy` (`loan_transaction_strategy_id`),
  KEY `FK_m_loan_m_staff` (`loan_officer_id`),
  KEY `FK_m_loanpurpose_codevalue` (`loanpurpose_cv_id`),
  KEY `group_id` (`group_id`),
  KEY `FK_submittedon_userid` (`submittedon_userid`),
  KEY `FK_approvedon_userid` (`approvedon_userid`),
  KEY `FK_rejectedon_userid` (`rejectedon_userid`),
  KEY `FK_withdrawnon_userid` (`withdrawnon_userid`),
  KEY `FK_closedon_userid` (`closedon_userid`),
  KEY `FK_disbursedon_userid` (`disbursedon_userid`),
  CONSTRAINT `FKB6F935D87179A0CB` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `m_loan_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `m_group` (`id`),
  CONSTRAINT `FKB6F935D8C8D4B434` FOREIGN KEY (`product_id`) REFERENCES `m_product_loan` (`id`),
  CONSTRAINT `FK7C885877240145` FOREIGN KEY (`fund_id`) REFERENCES `m_fund` (`id`),
  CONSTRAINT `FK_loan_ltp_strategy` FOREIGN KEY (`loan_transaction_strategy_id`) REFERENCES `ref_loan_transaction_processing_strategy` (`id`),
  CONSTRAINT `FK_m_loanpurpose_codevalue` FOREIGN KEY (`loanpurpose_cv_id`) REFERENCES `m_code_value` (`id`),
  CONSTRAINT `FK_m_loan_m_staff` FOREIGN KEY (`loan_officer_id`) REFERENCES `m_staff` (`id`),
  CONSTRAINT `FK_submittedon_userid` FOREIGN KEY (`submittedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_approvedon_userid` FOREIGN KEY (`approvedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_rejectedon_userid` FOREIGN KEY (`rejectedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_withdrawnon_userid` FOREIGN KEY (`withdrawnon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_disbursedon_userid` FOREIGN KEY (`disbursedon_userid`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_closedon_userid` FOREIGN KEY (`closedon_userid`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan`
--

LOCK TABLES `m_loan` WRITE;
/*!40000 ALTER TABLE `m_loan` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_charge`
--

DROP TABLE IF EXISTS `m_loan_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_charge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  `is_penalty` tinyint(1) NOT NULL DEFAULT '0',
  `charge_time_enum` smallint(5) NOT NULL,
  `due_for_collection_as_of_date` date DEFAULT NULL,
  `charge_calculation_enum` smallint(5) NOT NULL,
  `calculation_percentage` decimal(19,6) DEFAULT NULL,
  `calculation_on_amount` decimal(19,6) DEFAULT NULL,
  `amount` decimal(19,6) NOT NULL,
  `amount_paid_derived` decimal(19,6) DEFAULT NULL,
  `amount_waived_derived` decimal(19,6) DEFAULT NULL,
  `amount_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `is_paid_derived` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `charge_id` (`charge_id`),
  KEY `m_loan_charge_ibfk_2` (`loan_id`),
  CONSTRAINT `m_loan_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_loan_charge_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_charge`
--

LOCK TABLES `m_loan_charge` WRITE;
/*!40000 ALTER TABLE `m_loan_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_collateral`
--

DROP TABLE IF EXISTS `m_loan_collateral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_collateral` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `type_cv_id` int(11) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_collateral_m_loan` (`loan_id`),
  KEY `FK_collateral_code_value` (`type_cv_id`),
  CONSTRAINT `FK_collateral_m_loan` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK_collateral_code_value` FOREIGN KEY (`type_cv_id`) REFERENCES `m_code_value` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_collateral`
--

LOCK TABLES `m_loan_collateral` WRITE;
/*!40000 ALTER TABLE `m_loan_collateral` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_collateral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_officer_assignment_history`
--

DROP TABLE IF EXISTS `m_loan_officer_assignment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_officer_assignment_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `loan_officer_id` bigint(20) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_m_loan_officer_assignment_history_0001` (`loan_id`),
  KEY `fk_m_loan_officer_assignment_history_0002` (`loan_officer_id`),
  CONSTRAINT `fk_m_loan_officer_assignment_history_0001` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `fk_m_loan_officer_assignment_history_0002` FOREIGN KEY (`loan_officer_id`) REFERENCES `m_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_officer_assignment_history`
--

LOCK TABLES `m_loan_officer_assignment_history` WRITE;
/*!40000 ALTER TABLE `m_loan_officer_assignment_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_officer_assignment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_repayment_schedule`
--

DROP TABLE IF EXISTS `m_loan_repayment_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_repayment_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `fromdate` date DEFAULT NULL,
  `duedate` date NOT NULL,
  `installment` smallint(5) NOT NULL,
  `principal_amount` decimal(19,6) DEFAULT NULL,
  `principal_completed_derived` decimal(19,6) DEFAULT NULL,
  `principal_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `interest_amount` decimal(19,6) DEFAULT NULL,
  `interest_completed_derived` decimal(19,6) DEFAULT NULL,
  `interest_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_amount` decimal(19,6) DEFAULT NULL,
  `fee_charges_completed_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_waived_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_amount` decimal(19,6) DEFAULT NULL,
  `penalty_charges_completed_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_writtenoff_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_waived_derived` decimal(19,6) DEFAULT NULL,
  `completed_derived` bit(1) NOT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `interest_waived_derived` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK488B92AA40BE0710` (`loan_id`),
  CONSTRAINT `FK488B92AA40BE0710` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_repayment_schedule`
--

LOCK TABLES `m_loan_repayment_schedule` WRITE;
/*!40000 ALTER TABLE `m_loan_repayment_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_repayment_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_loan_transaction`
--

DROP TABLE IF EXISTS `m_loan_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_loan_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) NOT NULL,
  `is_reversed` tinyint(1) NOT NULL,
  `transaction_type_enum` smallint(5) NOT NULL,
  `transaction_date` date NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `principal_portion_derived` decimal(19,6) DEFAULT NULL,
  `interest_portion_derived` decimal(19,6) DEFAULT NULL,
  `fee_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  `penalty_charges_portion_derived` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCFCEA42640BE0710` (`loan_id`),
  CONSTRAINT `FKCFCEA42640BE0710` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_loan_transaction`
--

LOCK TABLES `m_loan_transaction` WRITE;
/*!40000 ALTER TABLE `m_loan_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_loan_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_note`
--

DROP TABLE IF EXISTS `m_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL,
  `loan_id` bigint(20) DEFAULT NULL,
  `loan_transaction_id` bigint(20) DEFAULT NULL,
  `deposit_account_id` bigint(20) DEFAULT NULL,
  `saving_account_id` bigint(20) DEFAULT NULL,
  `note_type_enum` smallint(5) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7C9708924D26803` (`loan_transaction_id`),
  KEY `FK7C97089541F0A56` (`createdby_id`),
  KEY `FK7C970897179A0CB` (`client_id`),
  KEY `FK7C970898F889C3F` (`lastmodifiedby_id`),
  KEY `FK7C9708940BE0710` (`loan_id`),
  KEY `FK_m_note_m_deposit_account` (`deposit_account_id`),
  KEY `FK_m_note_m_saving_account` (`saving_account_id`),
  CONSTRAINT `FK_m_note_m_saving_account` FOREIGN KEY (`saving_account_id`) REFERENCES `m_saving_account` (`id`),
  CONSTRAINT `FK7C9708924D26803` FOREIGN KEY (`loan_transaction_id`) REFERENCES `m_loan_transaction` (`id`),
  CONSTRAINT `FK7C9708940BE0710` FOREIGN KEY (`loan_id`) REFERENCES `m_loan` (`id`),
  CONSTRAINT `FK7C97089541F0A56` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK7C970897179A0CB` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FK7C970898F889C3F` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_note_m_deposit_account` FOREIGN KEY (`deposit_account_id`) REFERENCES `m_deposit_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_note`
--

LOCK TABLES `m_note` WRITE;
/*!40000 ALTER TABLE `m_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_office`
--

DROP TABLE IF EXISTS `m_office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_office` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `hierarchy` varchar(100) DEFAULT NULL,
  `external_id` varchar(100) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `opening_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_org` (`name`),
  UNIQUE KEY `externalid_org` (`external_id`),
  KEY `FK2291C477E2551DCC` (`parent_id`),
  CONSTRAINT `FK2291C477E2551DCC` FOREIGN KEY (`parent_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_office`
--

LOCK TABLES `m_office` WRITE;
/*!40000 ALTER TABLE `m_office` DISABLE KEYS */;
INSERT INTO `m_office` VALUES (1,NULL,'.','1','Head Office','2009-01-01');
/*!40000 ALTER TABLE `m_office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_office_transaction`
--

DROP TABLE IF EXISTS `m_office_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_office_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_office_id` bigint(20) DEFAULT NULL,
  `to_office_id` bigint(20) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` int(11) NOT NULL,
  `transaction_amount` decimal(19,6) NOT NULL,
  `transaction_date` date NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1E37728B93C6C1B6` (`to_office_id`),
  KEY `FK1E37728B783C5C25` (`from_office_id`),
  CONSTRAINT `FK1E37728B783C5C25` FOREIGN KEY (`from_office_id`) REFERENCES `m_office` (`id`),
  CONSTRAINT `FK1E37728B93C6C1B6` FOREIGN KEY (`to_office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_office_transaction`
--

LOCK TABLES `m_office_transaction` WRITE;
/*!40000 ALTER TABLE `m_office_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_office_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_organisation_currency`
--

DROP TABLE IF EXISTS `m_organisation_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_organisation_currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) NOT NULL,
  `decimal_places` smallint(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `display_symbol` varchar(10) DEFAULT NULL,
  `internationalized_name_code` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_organisation_currency`
--

LOCK TABLES `m_organisation_currency` WRITE;
/*!40000 ALTER TABLE `m_organisation_currency` DISABLE KEYS */;
INSERT INTO `m_organisation_currency` VALUES (21,'USD',2,'US Dollar','$','currency.USD');
/*!40000 ALTER TABLE `m_organisation_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_permission`
--

DROP TABLE IF EXISTS `m_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `grouping` varchar(45) DEFAULT NULL,
  `code` varchar(100) NOT NULL,
  `entity_name` varchar(100) DEFAULT NULL,
  `action_name` varchar(100) DEFAULT NULL,
  `can_maker_checker` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_permission`
--

LOCK TABLES `m_permission` WRITE;
/*!40000 ALTER TABLE `m_permission` DISABLE KEYS */;
INSERT INTO `m_permission` VALUES (1,'special','ALL_FUNCTIONS',NULL,NULL,0),(2,'special','ALL_FUNCTIONS_READ',NULL,NULL,0),(3,'special','CHECKER_SUPER_USER',NULL,NULL,0),(4,'special','REPORTING_SUPER_USER',NULL,NULL,0),(5,'authorisation','READ_PERMISSION','PERMISSION','READ',0),(6,'authorisation','PERMISSIONS_ROLE','ROLE','PERMISSIONS',1),(7,'authorisation','CREATE_ROLE','ROLE','CREATE',1),(8,'authorisation','CREATE_ROLE_CHECKER','ROLE','CREATE',1),(9,'authorisation','READ_ROLE','ROLE','READ',0),(10,'authorisation','UPDATE_ROLE','ROLE','UPDATE',1),(11,'authorisation','UPDATE_ROLE_CHECKER','ROLE','UPDATE',1),(12,'authorisation','DELETE_ROLE','ROLE','DELETE',1),(13,'authorisation','DELETE_ROLE_CHECKER','ROLE','DELETE',1),(14,'authorisation','CREATE_USER','USER','CREATE',1),(15,'authorisation','CREATE_USER_CHECKER','USER','CREATE',1),(16,'authorisation','READ_USER','USER','READ',0),(17,'authorisation','UPDATE_USER','USER','UPDATE',1),(18,'authorisation','UPDATE_USER_CHECKER','USER','UPDATE',1),(19,'authorisation','DELETE_USER','USER','DELETE',1),(20,'authorisation','DELETE_USER_CHECKER','USER','DELETE',1),(21,'configuration','READ_CONFIGURATION','CONFIGURATION','READ',1),(22,'configuration','UPDATE_CONFIGURATION','CONFIGURATION','UPDATE',1),(23,'configuration','UPDATE_CONFIGURATION_CHECKER','CONFIGURATION','UPDATE',1),(24,'configuration','READ_CODE','CODE','READ',0),(25,'configuration','CREATE_CODE','CODE','CREATE',1),(26,'configuration','CREATE_CODE_CHECKER','CODE','CREATE',1),(27,'configuration','UPDATE_CODE','CODE','UPDATE',1),(28,'configuration','UPDATE_CODE_CHECKER','CODE','UPDATE',1),(29,'configuration','DELETE_CODE','CODE','DELETE',1),(30,'configuration','DELETE_CODE_CHECKER','CODE','DELETE',1),(31,'configuration','READ_CODEVALUE','CODEVALUE','READ',0),(32,'configuration','CREATE_CODEVALUE','CODEVALUE','CREATE',1),(33,'configuration','CREATE_CODEVALUE_CHECKER','CODEVALUE','CREATE',1),(34,'configuration','UPDATE_CODEVALUE','CODEVALUE','UPDATE',1),(35,'configuration','UPDATE_CODEVALUE_CHECKER','CODEVALUE','UPDATE',1),(36,'configuration','DELETE_CODEVALUE','CODEVALUE','DELETE',1),(37,'configuration','DELETE_CODEVALUE_CHECKER','CODEVALUE','DELETE',1),(38,'configuration','READ_CURRENCY','CURRENCY','READ',0),(39,'configuration','UPDATE_CURRENCY','CURRENCY','UPDATE',1),(40,'configuration','UPDATE_CURRENCY_CHECKER','CURRENCY','UPDATE',1),(41,'configuration','UPDATE_PERMISSION','PERMISSION','UPDATE',1),(42,'configuration','UPDATE_PERMISSION_CHECKER','PERMISSION','UPDATE',1),(43,'configuration','READ_DATATABLE','DATATABLE','READ',0),(44,'configuration','REGISTER_DATATABLE','DATATABLE','REGISTER',1),(45,'configuration','REGISTER_DATATABLE_CHECKER','DATATABLE','REGISTER',1),(46,'configuration','DEREGISTER_DATATABLE','DATATABLE','DEREGISTER',1),(47,'configuration','DEREGISTER_DATATABLE_CHECKER','DATATABLE','DEREGISTER',1),(48,'configuration','READ_AUDIT','AUDIT','READ',0),(49,'organisation','READ_MAKERCHECKER','MAKERCHECKER','READ',0),(50,'organisation','READ_CHARGE','CHARGE','READ',0),(51,'organisation','CREATE_CHARGE','CHARGE','CREATE',1),(52,'organisation','CREATE_CHARGE_CHECKER','CHARGE','CREATE',1),(53,'organisation','UPDATE_CHARGE','CHARGE','UPDATE',1),(54,'organisation','UPDATE_CHARGE_CHECKER','CHARGE','UPDATE',1),(55,'organisation','DELETE_CHARGE','CHARGE','DELETE',1),(56,'organisation','DELETE_CHARGE_CHECKER','CHARGE','DELETE',1),(57,'organisation','READ_FUND','FUND','READ',0),(58,'organisation','CREATE_FUND','FUND','CREATE',1),(59,'organisation','CREATE_FUND_CHECKER','FUND','CREATE',1),(60,'organisation','UPDATE_FUND','FUND','UPDATE',1),(61,'organisation','UPDATE_FUND_CHECKER','FUND','UPDATE',1),(62,'organisation','DELETE_FUND','FUND','DELETE',1),(63,'organisation','DELETE_FUND_CHECKER','FUND','DELETE',1),(64,'organisation','READ_LOANPRODUCT','LOANPRODUCT','READ',0),(65,'organisation','CREATE_LOANPRODUCT','LOANPRODUCT','CREATE',1),(66,'organisation','CREATE_LOANPRODUCT_CHECKER','LOANPRODUCT','CREATE',1),(67,'organisation','UPDATE_LOANPRODUCT','LOANPRODUCT','UPDATE',1),(68,'organisation','UPDATE_LOANPRODUCT_CHECKER','LOANPRODUCT','UPDATE',1),(69,'organisation','DELETE_LOANPRODUCT','LOANPRODUCT','DELETE',1),(70,'organisation','DELETE_LOANPRODUCT_CHECKER','LOANPRODUCT','DELETE',1),(71,'organisation','READ_OFFICE','OFFICE','READ',0),(72,'organisation','CREATE_OFFICE','OFFICE','CREATE',1),(73,'organisation','CREATE_OFFICE_CHECKER','OFFICE','CREATE',1),(74,'organisation','UPDATE_OFFICE','OFFICE','UPDATE',1),(75,'organisation','UPDATE_OFFICE_CHECKER','OFFICE','UPDATE',1),(76,'organisation','READ_OFFICETRANSACTION','OFFICETRANSACTION','READ',0),(77,'organisation','DELETE_OFFICE_CHECKER','OFFICE','DELETE',1),(78,'organisation','CREATE_OFFICETRANSACTION','OFFICETRANSACTION','CREATE',1),(79,'organisation','CREATE_OFFICETRANSACTION_CHECKER','OFFICETRANSACTION','CREATE',1),(80,'organisation','DELETE_OFFICETRANSACTION','OFFICETRANSACTION','DELETE',1),(81,'organisation','DELETE_OFFICETRANSACTION_CHECKER','OFFICETRANSACTION','DELETE',1),(82,'organisation','READ_STAFF','STAFF','READ',0),(83,'organisation','CREATE_STAFF','STAFF','CREATE',1),(84,'organisation','CREATE_STAFF_CHECKER','STAFF','CREATE',1),(85,'organisation','UPDATE_STAFF','STAFF','UPDATE',1),(86,'organisation','UPDATE_STAFF_CHECKER','STAFF','UPDATE',1),(87,'organisation','DELETE_STAFF','STAFF','DELETE',1),(88,'organisation','DELETE_STAFF_CHECKER','STAFF','DELETE',1),(89,'organisation','READ_SAVINGSPRODUCT','SAVINGSPRODUCT','READ',0),(90,'organisation','CREATE_SAVINGSPRODUCT','SAVINGSPRODUCT','CREATE',1),(91,'organisation','CREATE_SAVINGSPRODUCT_CHECKER','SAVINGSPRODUCT','CREATE',1),(92,'organisation','UPDATE_SAVINGSPRODUCT','SAVINGSPRODUCT','UPDATE',1),(93,'organisation','UPDATE_SAVINGSPRODUCT_CHECKER','SAVINGSPRODUCT','UPDATE',1),(94,'organisation','DELETE_SAVINGSPRODUCT','SAVINGSPRODUCT','DELETE',1),(95,'organisation','DELETE_SAVINGSPRODUCT_CHECKER','SAVINGSPRODUCT','DELETE',1),(96,'organisation','READ_DEPOSITPRODUCT','DEPOSITPRODUCT','READ',0),(97,'organisation','CREATE_DEPOSITPRODUCT','DEPOSITPRODUCT','CREATE',1),(98,'organisation','CREATE_DEPOSITPRODUCT_CHECKER','DEPOSITPRODUCT','CREATE',1),(99,'organisation','UPDATE_DEPOSITPRODUCT','DEPOSITPRODUCT','UPDATE',1),(100,'organisation','UPDATE_DEPOSITPRODUCT_CHECKER','DEPOSITPRODUCT','UPDATE',1),(101,'organisation','DELETE_DEPOSITPRODUCT','DEPOSITPRODUCT','DELETE',1),(102,'organisation','DELETE_DEPOSITPRODUCT_CHECKER','DEPOSITPRODUCT','DELETE',1),(103,'portfolio','READ_LOAN','LOAN','READ',0),(104,'portfolio','CREATE_LOAN','LOAN','CREATE',1),(105,'portfolio','CREATE_LOAN_CHECKER','LOAN','CREATE',1),(106,'portfolio','UPDATE_LOAN','LOAN','UPDATE',1),(107,'portfolio','UPDATE_LOAN_CHECKER','LOAN','UPDATE',1),(108,'portfolio','DELETE_LOAN','LOAN','DELETE',1),(109,'portfolio','DELETE_LOAN_CHECKER','LOAN','DELETE',1),(110,'portfolio','READ_CLIENT','CLIENT','READ',0),(111,'portfolio','CREATE_CLIENT','CLIENT','CREATE',1),(112,'portfolio','CREATE_CLIENT_CHECKER','CLIENT','CREATE',1),(113,'portfolio','UPDATE_CLIENT','CLIENT','UPDATE',1),(114,'portfolio','UPDATE_CLIENT_CHECKER','CLIENT','UPDATE',1),(115,'portfolio','DELETE_CLIENT','CLIENT','DELETE',1),(116,'portfolio','DELETE_CLIENT_CHECKER','CLIENT','DELETE',1),(117,'portfolio','READ_CLIENTIMAGE','CLIENTIMAGE','READ',0),(118,'portfolio','CREATE_CLIENTIMAGE','CLIENTIMAGE','CREATE',1),(119,'portfolio','CREATE_CLIENTIMAGE_CHECKER','CLIENTIMAGE','CREATE',1),(120,'portfolio','DELETE_CLIENTIMAGE','CLIENTIMAGE','DELETE',1),(121,'portfolio','DELETE_CLIENTIMAGE_CHECKER','CLIENTIMAGE','DELETE',1),(122,'portfolio','READ_CLIENTNOTE','CLIENTNOTE','READ',0),(123,'portfolio','CREATE_CLIENTNOTE','CLIENTNOTE','CREATE',1),(124,'portfolio','CREATE_CLIENTNOTE_CHECKER','CLIENTNOTE','CREATE',1),(125,'portfolio','UPDATE_CLIENTNOTE','CLIENTNOTE','UPDATE',1),(126,'portfolio','UPDATE_CLIENTNOTE_CHECKER','CLIENTNOTE','UPDATE',1),(127,'portfolio','DELETE_CLIENTNOTE','CLIENTNOTE','DELETE',1),(128,'portfolio','DELETE_CLIENTNOTE_CHECKER','CLIENTNOTE','DELETE',1),(129,'portfolio','READ_CLIENTIDENTIFIER','CLIENTIDENTIFIER','READ',0),(130,'portfolio','CREATE_CLIENTIDENTIFIER','CLIENTIDENTIFIER','CREATE',1),(131,'portfolio','CREATE_CLIENTIDENTIFIER_CHECKER','CLIENTIDENTIFIER','CREATE',1),(132,'portfolio','UPDATE_CLIENTIDENTIFIER','CLIENTIDENTIFIER','UPDATE',1),(133,'portfolio','UPDATE_CLIENTIDENTIFIER_CHECKER','CLIENTIDENTIFIER','UPDATE',1),(134,'portfolio','DELETE_CLIENTIDENTIFIER','CLIENTIDENTIFIER','DELETE',1),(135,'portfolio','DELETE_CLIENTIDENTIFIER_CHECKER','CLIENTIDENTIFIER','DELETE',1),(136,'portfolio','READ_DOCUMENT','DOCUMENT','READ',0),(137,'portfolio','CREATE_DOCUMENT','DOCUMENT','CREATE',1),(138,'portfolio','CREATE_DOCUMENT_CHECKER','DOCUMENT','CREATE',1),(139,'portfolio','UPDATE_DOCUMENT','DOCUMENT','UPDATE',1),(140,'portfolio','UPDATE_DOCUMENT_CHECKER','DOCUMENT','UPDATE',1),(141,'portfolio','DELETE_DOCUMENT','DOCUMENT','DELETE',1),(142,'portfolio','DELETE_DOCUMENT_CHECKER','DOCUMENT','DELETE',1),(143,'portfolio','READ_GROUP','GROUP','READ',0),(144,'portfolio','CREATE_GROUP','GROUP','CREATE',1),(145,'portfolio','CREATE_GROUP_CHECKER','GROUP','CREATE',1),(146,'portfolio','UPDATE_GROUP','GROUP','UPDATE',1),(147,'portfolio','UPDATE_GROUP_CHECKER','GROUP','UPDATE',1),(148,'portfolio','DELETE_GROUP','GROUP','DELETE',1),(149,'portfolio','DELETE_GROUP_CHECKER','GROUP','DELETE',1),(150,'portfolio','CREATE_LOANCHARGE','LOANCHARGE','CREATE',1),(151,'portfolio','CREATE_LOANCHARGE_CHECKER','LOANCHARGE','CREATE',1),(152,'portfolio','UPDATE_LOANCHARGE','LOANCHARGE','UPDATE',1),(153,'portfolio','UPDATE_LOANCHARGE_CHECKER','LOANCHARGE','UPDATE',1),(154,'portfolio','DELETE_LOANCHARGE','LOANCHARGE','DELETE',1),(155,'portfolio','DELETE_LOANCHARGE_CHECKER','LOANCHARGE','DELETE',1),(156,'portfolio','WAIVE_LOANCHARGE','LOANCHARGE','WAIVE',1),(157,'portfolio','WAIVE_LOANCHARGE_CHECKER','LOANCHARGE','WAIVE',1),(158,'portfolio','READ_DEPOSITACCOUNT','DEPOSITACCOUNT','READ',0),(159,'portfolio','CREATE_DEPOSITACCOUNT','DEPOSITACCOUNT','CREATE',1),(160,'portfolio','CREATE_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','CREATE',1),(161,'portfolio','UPDATE_DEPOSITACCOUNT','DEPOSITACCOUNT','UPDATE',1),(162,'portfolio','UPDATE_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','UPDATE',1),(163,'portfolio','DELETE_DEPOSITACCOUNT','DEPOSITACCOUNT','DELETE',1),(164,'portfolio','DELETE_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','DELETE',1),(165,'portfolio','READ_SAVINGSACCOUNT','SAVINGSACCOUNT','READ',0),(166,'portfolio','CREATE_SAVINGSACCOUNT','SAVINGSACCOUNT','CREATE',1),(167,'portfolio','CREATE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','CREATE',1),(168,'portfolio','UPDATE_SAVINGSACCOUNT','SAVINGSACCOUNT','UPDATE',1),(169,'portfolio','UPDATE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','UPDATE',1),(170,'portfolio','DELETE_SAVINGSACCOUNT','SAVINGSACCOUNT','DELETE',1),(171,'portfolio','DELETE_SAVINGSACCOUNT_CHECKER','SAVINGSACCOUNT','DELETE',1),(172,'portfolio','READ_GUARANTOR','GUARANTOR','READ',0),(173,'portfolio','CREATE_GUARANTOR','GUARANTOR','CREATE',1),(174,'portfolio','CREATE_GUARANTOR_CHECKER','GUARANTOR','CREATE',1),(175,'portfolio','UPDATE_GUARANTOR','GUARANTOR','UPDATE',1),(176,'portfolio','UPDATE_GUARANTOR_CHECKER','GUARANTOR','UPDATE',1),(177,'portfolio','DELETE_GUARANTOR','GUARANTOR','DELETE',1),(178,'portfolio','DELETE_GUARANTOR_CHECKER','GUARANTOR','DELETE',1),(179,'transaction_loan','APPROVE_LOAN','LOAN','APPROVE',1),(180,'transaction_loan','APPROVEINPAST_LOAN','LOAN','APPROVEINPAST',1),(181,'transaction_loan','REJECT_LOAN','LOAN','REJECT',1),(182,'transaction_loan','REJECTINPAST_LOAN','LOAN','REJECTINPAST',1),(183,'transaction_loan','WITHDRAW_LOAN','LOAN','WITHDRAW',1),(184,'transaction_loan','WITHDRAWINPAST_LOAN','LOAN','WITHDRAWINPAST',1),(185,'transaction_loan','APPROVALUNDO_LOAN','LOAN','APPROVALUNDO',1),(186,'transaction_loan','DISBURSE_LOAN','LOAN','DISBURSE',1),(187,'transaction_loan','DISBURSEINPAST_LOAN','LOAN','DISBURSEINPAST',1),(188,'transaction_loan','DISBURSALUNDO_LOAN','LOAN','DISBURSALUNDO',1),(189,'transaction_loan','REPAYMENT_LOAN','LOAN','REPAYMENT',1),(190,'transaction_loan','REPAYMENTINPAST_LOAN','LOAN','REPAYMENTINPAST',1),(191,'transaction_loan','ADJUST_LOAN','LOAN','ADJUST',1),(192,'transaction_loan','WAIVEINTERESTPORTION_LOAN','LOAN','WAIVEINTERESTPORTION',1),(193,'transaction_loan','WRITEOFF_LOAN','LOAN','WRITEOFF',1),(194,'transaction_loan','CLOSE_LOAN','LOAN','CLOSE',1),(195,'transaction_loan','CLOSEASRESCHEDULED_LOAN','LOAN','CLOSEASRESCHEDULED',1),(196,'transaction_loan','UPDATELOANOFFICER_LOAN','LOAN','UPDATELOANOFFICER',1),(197,'transaction_loan','UPDATELOANOFFICER_LOAN_CHECKER','LOAN','UPDATELOANOFFICER',1),(198,'transaction_loan','REMOVELOANOFFICER_LOAN','LOAN','REMOVELOANOFFICER',1),(199,'transaction_loan','REMOVELOANOFFICER_LOAN_CHECKER','LOAN','REMOVELOANOFFICER',1),(200,'transaction_loan','BULKREASSIGN_LOAN','LOAN','BULKREASSIGN',1),(201,'transaction_loan','BULKREASSIGN_LOAN_CHECKER','LOAN','BULKREASSIGN',1),(202,'transaction_loan','APPROVE_LOAN_CHECKER','LOAN','APPROVE',1),(203,'transaction_loan','APPROVEINPAST_LOAN_CHECKER','LOAN','APPROVEINPAST',1),(204,'transaction_loan','REJECT_LOAN_CHECKER','LOAN','REJECT',1),(205,'transaction_loan','REJECTINPAST_LOAN_CHECKER','LOAN','REJECTINPAST',1),(206,'transaction_loan','WITHDRAW_LOAN_CHECKER','LOAN','WITHDRAW',1),(207,'transaction_loan','WITHDRAWINPAST_LOAN_CHECKER','LOAN','WITHDRAWINPAST',1),(208,'transaction_loan','APPROVALUNDO_LOAN_CHECKER','LOAN','APPROVALUNDO',1),(209,'transaction_loan','DISBURSE_LOAN_CHECKER','LOAN','DISBURSE',1),(210,'transaction_loan','DISBURSEINPAST_LOAN_CHECKER','LOAN','DISBURSEINPAST',1),(211,'transaction_loan','DISBURSALUNDO_LOAN_CHECKER','LOAN','DISBURSALUNDO',1),(212,'transaction_loan','REPAYMENT_LOAN_CHECKER','LOAN','REPAYMENT',1),(213,'transaction_loan','REPAYMENTINPAST_LOAN_CHECKER','LOAN','REPAYMENTINPAST',1),(214,'transaction_loan','ADJUST_LOAN_CHECKER','LOAN','ADJUST',1),(215,'transaction_loan','WAIVEINTERESTPORTION_LOAN_CHECKER','LOAN','WAIVEINTERESTPORTION',1),(216,'transaction_loan','WRITEOFF_LOAN_CHECKER','LOAN','WRITEOFF',1),(217,'transaction_loan','CLOSE_LOAN_CHECKER','LOAN','CLOSE',1),(218,'transaction_loan','CLOSEASRESCHEDULED_LOAN_CHECKER','LOAN','CLOSEASRESCHEDULED',1),(219,'transaction_deposit','APPROVE_DEPOSITACCOUNT','DEPOSITACCOUNT','APPROVE',1),(220,'transaction_deposit','REJECT_DEPOSITACCOUNT','DEPOSITACCOUNT','REJECT',1),(221,'transaction_deposit','WITHDRAW_DEPOSITACCOUNT','DEPOSITACCOUNT','WITHDRAW',1),(222,'transaction_deposit','APPROVALUNDO_DEPOSITACCOUNT','DEPOSITACCOUNT','APPROVALUNDO',1),(223,'transaction_deposit','WITHDRAWAL_DEPOSITACCOUNT','DEPOSITACCOUNT','WITHDRAWAL',1),(224,'transaction_deposit','INTEREST_DEPOSITACCOUNT','DEPOSITACCOUNT','INTEREST',1),(225,'transaction_deposit','RENEW_DEPOSITACCOUNT','DEPOSITACCOUNT','RENEW',1),(226,'transaction_deposit','APPROVE_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','APPROVE',1),(227,'transaction_deposit','REJECT_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','REJECT',1),(228,'transaction_deposit','WITHDRAW_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','WITHDRAW',1),(229,'transaction_deposit','APPROVALUNDO_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','APPROVALUNDO',1),(230,'transaction_deposit','WITHDRAWAL_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','WITHDRAWAL',1),(231,'transaction_deposit','INTEREST_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','INTEREST',1),(232,'transaction_deposit','RENEW_DEPOSITACCOUNT_CHECKER','DEPOSITACCOUNT','RENEW',1),(233,'accounting','CREATE_GLACCOUNT','GLACCOUNT','CREATE',1),(234,'accounting','UPDATE_GLACCOUNT','GLACCOUNT','UPDATE',1),(235,'accounting','DELETE_GLACCOUNT','GLACCOUNT','DELETE',1),(236,'accounting','CREATE_GLCLOSURE','GLCLOSURE','CREATE',1),(237,'accounting','UPDATE_GLCLOSURE','GLCLOSURE','UPDATE',1),(238,'accounting','DELETE_GLCLOSURE','GLCLOSURE','DELETE',1),(239,'accounting','CREATE_JOURNALENTRY','JOURNALENTRY','CREATE',1),(240,'accounting','REVERSE_JOURNALENTRY','JOURNALENTRY','REVERSE',1),(241,'report','READ_Active Loans - Details','Active Loans - Details','READ',1),(242,'report','READ_Active Loans - Summary','Active Loans - Summary','READ',1),(243,'report','READ_Active Loans by Disbursal Period','Active Loans by Disbursal Period','READ',1),(244,'report','READ_Active Loans in last installment','Active Loans in last installment','READ',1),(245,'report','READ_Active Loans in last installment Summary','Active Loans in last installment Summary','READ',1),(246,'report','READ_Active Loans Passed Final Maturity','Active Loans Passed Final Maturity','READ',1),(247,'report','READ_Active Loans Passed Final Maturity Summary','Active Loans Passed Final Maturity Summary','READ',1),(248,'report','READ_Aging Summary (Arrears in weeks) - review','Aging Summary (Arrears in weeks) - review','READ',1),(249,'report','READ_Amount In Arrears','Amount In Arrears','READ',1),(250,'report','READ_Balance Sheet','Balance Sheet','READ',1),(251,'report','READ_Client Listing','Client Listing','READ',1),(252,'report','READ_Client Loans Listing','Client Loans Listing','READ',1),(253,'report','READ_Funds Disbursed Between Dates Summary','Funds Disbursed Between Dates Summary','READ',1),(254,'report','READ_Funds Disbursed Between Dates Summary by Office','Funds Disbursed Between Dates Summary by Office','READ',1),(255,'report','READ_Income Statement','Income Statement','READ',1),(256,'report','READ_Loans Awaiting Disbursal','Loans Awaiting Disbursal','READ',1),(257,'report','READ_Loans Awaiting Disbursal Summary','Loans Awaiting Disbursal Summary','READ',1),(258,'report','READ_Loans Awaiting Disbursal Summary by Month','Loans Awaiting Disbursal Summary by Month','READ',1),(259,'report','READ_Loans Pending Approval','Loans Pending Approval','READ',1),(260,'report','READ_Obligation Met Loans Details','Obligation Met Loans Details','READ',1),(261,'report','READ_Obligation Met Loans Summary','Obligation Met Loans Summary','READ',1),(262,'report','READ_Portfolio at Risk','Portfolio at Risk','READ',1),(263,'report','READ_Portfolio at Risk by Branch','Portfolio at Risk by Branch','READ',1),(264,'report','READ_Rescheduled Loans','Rescheduled Loans','READ',1),(265,'report','READ_Trial Balance','Trial Balance','READ',1),(266,'report','READ_Written-Off Loans','Written-Off Loans','READ',1);
/*!40000 ALTER TABLE `m_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_portfolio_command_source`
--

DROP TABLE IF EXISTS `m_portfolio_command_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_portfolio_command_source` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action_name` varchar(50) NOT NULL,
  `entity_name` varchar(50) NOT NULL,
  `office_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `loan_id` bigint(20) DEFAULT NULL,
  `api_get_url` varchar(100) NOT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `command_as_json` text NOT NULL,
  `maker_id` bigint(20) NOT NULL,
  `made_on_date` datetime NOT NULL,
  `checker_id` bigint(20) DEFAULT NULL,
  `checked_on_date` datetime DEFAULT NULL,
  `processing_result_enum` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_m_maker_m_appuser` (`maker_id`),
  KEY `FK_m_checker_m_appuser` (`checker_id`),
  KEY `action_name` (`action_name`),
  KEY `entity_name` (`entity_name`,`resource_id`),
  KEY `made_on_date` (`made_on_date`),
  KEY `checked_on_date` (`checked_on_date`),
  KEY `processing_result_enum` (`processing_result_enum`),
  KEY `office_id` (`office_id`),
  KEY `group_id` (`office_id`),
  KEY `client_id` (`office_id`),
  KEY `loan_id` (`office_id`),
  CONSTRAINT `FK_m_checker_m_appuser` FOREIGN KEY (`checker_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FK_m_maker_m_appuser` FOREIGN KEY (`maker_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_portfolio_command_source`
--

LOCK TABLES `m_portfolio_command_source` WRITE;
/*!40000 ALTER TABLE `m_portfolio_command_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_portfolio_command_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_deposit`
--

DROP TABLE IF EXISTS `m_product_deposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_deposit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `external_id` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `minimum_balance` decimal(19,6) DEFAULT NULL,
  `maximum_balance` decimal(19,6) DEFAULT NULL,
  `tenure_months` int(11) NOT NULL,
  `interest_compounded_every` smallint(5) NOT NULL DEFAULT '1',
  `interest_compounded_every_period_enum` smallint(5) NOT NULL DEFAULT '2',
  `maturity_default_interest_rate` decimal(19,6) NOT NULL,
  `maturity_min_interest_rate` decimal(19,6) NOT NULL,
  `maturity_max_interest_rate` decimal(19,6) NOT NULL,
  `is_compounding_interest_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `is_renewal_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `is_preclosure_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `pre_closure_interest_rate` decimal(19,6) NOT NULL,
  `is_lock_in_period_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `lock_in_period` bigint(20) DEFAULT NULL,
  `lock_in_period_type` smallint(5) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_deposit_product` (`name`),
  UNIQUE KEY `externalid_deposit_product` (`external_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_deposit`
--

LOCK TABLES `m_product_deposit` WRITE;
/*!40000 ALTER TABLE `m_product_deposit` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_deposit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan`
--

DROP TABLE IF EXISTS `m_product_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `principal_amount` decimal(19,6) NOT NULL,
  `arrearstolerance_amount` decimal(19,6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `fund_id` bigint(20) DEFAULT NULL,
  `nominal_interest_rate_per_period` decimal(19,6) NOT NULL,
  `interest_period_frequency_enum` smallint(5) NOT NULL,
  `annual_nominal_interest_rate` decimal(19,6) NOT NULL,
  `interest_method_enum` smallint(5) NOT NULL,
  `interest_calculated_in_period_enum` smallint(5) NOT NULL DEFAULT '1',
  `repay_every` smallint(5) NOT NULL,
  `repayment_period_frequency_enum` smallint(5) NOT NULL,
  `number_of_repayments` smallint(5) NOT NULL,
  `amortization_method_enum` smallint(5) NOT NULL,
  `accounting_type` smallint(5) NOT NULL,
  `loan_transaction_strategy_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`),
  KEY `FKA6A8A7D77240145` (`fund_id`),
  KEY `FK_ltp_strategy` (`loan_transaction_strategy_id`),
  CONSTRAINT `FKA6A8A7D77240145` FOREIGN KEY (`fund_id`) REFERENCES `m_fund` (`id`),
  CONSTRAINT `FK_ltp_strategy` FOREIGN KEY (`loan_transaction_strategy_id`) REFERENCES `ref_loan_transaction_processing_strategy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan`
--

LOCK TABLES `m_product_loan` WRITE;
/*!40000 ALTER TABLE `m_product_loan` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_loan_charge`
--

DROP TABLE IF EXISTS `m_product_loan_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_loan_charge` (
  `product_loan_id` bigint(20) NOT NULL,
  `charge_id` bigint(20) NOT NULL,
  PRIMARY KEY (`product_loan_id`,`charge_id`),
  KEY `charge_id` (`charge_id`),
  CONSTRAINT `m_product_loan_charge_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `m_charge` (`id`),
  CONSTRAINT `m_product_loan_charge_ibfk_2` FOREIGN KEY (`product_loan_id`) REFERENCES `m_product_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_loan_charge`
--

LOCK TABLES `m_product_loan_charge` WRITE;
/*!40000 ALTER TABLE `m_product_loan_charge` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_loan_charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_product_savings`
--

DROP TABLE IF EXISTS `m_product_savings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_product_savings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `currency_digits` smallint(5) DEFAULT NULL,
  `interest_rate` decimal(19,6) DEFAULT NULL,
  `min_interest_rate` decimal(19,6) DEFAULT NULL,
  `max_interest_rate` decimal(19,6) DEFAULT NULL,
  `savings_deposit_amount` decimal(19,6) NOT NULL,
  `savings_product_type` smallint(5) DEFAULT NULL,
  `tenure_type` smallint(5) DEFAULT NULL,
  `deposit_every` bigint(20) DEFAULT NULL,
  `tenure` int(11) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `interest_type` smallint(5) DEFAULT NULL,
  `interest_calculation_method` smallint(5) DEFAULT NULL,
  `min_bal_for_withdrawal` decimal(19,6) NOT NULL,
  `is_partial_deposit_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `is_lock_in_period_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `lock_in_period` bigint(20) DEFAULT NULL,
  `lock_in_period_type` smallint(5) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKJPW0000000000003` (`createdby_id`),
  KEY `FKJPW0000000000004` (`lastmodifiedby_id`),
  CONSTRAINT `FKJPW0000000000003` FOREIGN KEY (`createdby_id`) REFERENCES `m_appuser` (`id`),
  CONSTRAINT `FKJPW0000000000004` FOREIGN KEY (`lastmodifiedby_id`) REFERENCES `m_appuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_product_savings`
--

LOCK TABLES `m_product_savings` WRITE;
/*!40000 ALTER TABLE `m_product_savings` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_product_savings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_role`
--

DROP TABLE IF EXISTS `m_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_role`
--

LOCK TABLES `m_role` WRITE;
/*!40000 ALTER TABLE `m_role` DISABLE KEYS */;
INSERT INTO `m_role` VALUES (1,'Super user','This role provides all application permissions.');
/*!40000 ALTER TABLE `m_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_role_permission`
--

DROP TABLE IF EXISTS `m_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_role_permission` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `FK8DEDB04815CEC7AB` (`role_id`),
  KEY `FK8DEDB048103B544B` (`permission_id`),
  CONSTRAINT `FK8DEDB048103B544B` FOREIGN KEY (`permission_id`) REFERENCES `m_permission` (`id`),
  CONSTRAINT `FK8DEDB04815CEC7AB` FOREIGN KEY (`role_id`) REFERENCES `m_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_role_permission`
--

LOCK TABLES `m_role_permission` WRITE;
/*!40000 ALTER TABLE `m_role_permission` DISABLE KEYS */;
INSERT INTO `m_role_permission` VALUES (1,1);
/*!40000 ALTER TABLE `m_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_saving_account`
--

DROP TABLE IF EXISTS `m_saving_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_saving_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `status_enum` smallint(5) NOT NULL DEFAULT '0',
  `external_id` varchar(100) DEFAULT NULL,
  `client_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `deposit_amount_per_period` decimal(19,6) NOT NULL,
  `savings_product_type` smallint(5) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_digits` smallint(5) NOT NULL,
  `total_deposit_amount` decimal(19,6) NOT NULL,
  `reccuring_nominal_interest_rate` decimal(19,6) NOT NULL,
  `regular_saving_nominal_interest_rate` decimal(19,6) NOT NULL,
  `tenure` int(11) NOT NULL,
  `tenure_type` smallint(5) DEFAULT NULL,
  `deposit_every` bigint(20) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `interest_posting_every` int(11) DEFAULT NULL,
  `interest_posting_frequency` int(11) DEFAULT NULL,
  `interest_type` smallint(5) DEFAULT NULL,
  `interest_calculation_method` smallint(5) DEFAULT NULL,
  `projected_commencement_date` date NOT NULL,
  `actual_commencement_date` date DEFAULT NULL,
  `matures_on_date` datetime DEFAULT NULL,
  `projected_interest_accrued_on_maturity` decimal(19,6) NOT NULL,
  `actual_interest_accrued` decimal(19,6) DEFAULT NULL,
  `projected_total_maturity_amount` decimal(19,6) NOT NULL,
  `actual_total_amount` decimal(19,6) DEFAULT NULL,
  `is_preclosure_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `pre_closure_interest_rate` decimal(19,6) NOT NULL,
  `outstanding_amount` decimal(19,6) NOT NULL,
  `interest_posted_amount` decimal(19,6) DEFAULT '0.000000',
  `last_interest_posted_date` date DEFAULT NULL,
  `next_interest_posting_date` date DEFAULT NULL,
  `is_lock_in_period_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `lock_in_period` bigint(20) DEFAULT NULL,
  `lock_in_period_type` smallint(5) NOT NULL DEFAULT '1',
  `withdrawnon_date` datetime DEFAULT NULL,
  `rejectedon_date` datetime DEFAULT NULL,
  `closedon_date` datetime DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deposit_acc_external_id` (`external_id`),
  KEY `FKSA0000000000001` (`client_id`),
  KEY `FKSA0000000000002` (`product_id`),
  CONSTRAINT `FKSA0000000000001` FOREIGN KEY (`client_id`) REFERENCES `m_client` (`id`),
  CONSTRAINT `FKSA0000000000002` FOREIGN KEY (`product_id`) REFERENCES `m_product_savings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_saving_account`
--

LOCK TABLES `m_saving_account` WRITE;
/*!40000 ALTER TABLE `m_saving_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_saving_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_saving_account_transaction`
--

DROP TABLE IF EXISTS `m_saving_account_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_saving_account_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `saving_account_id` bigint(20) NOT NULL,
  `transaction_type_enum` smallint(5) NOT NULL,
  `contra_id` bigint(20) DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKSAT0000000001` (`saving_account_id`),
  KEY `FKSAT0000000002` (`contra_id`),
  CONSTRAINT `FKSAT0000000001` FOREIGN KEY (`saving_account_id`) REFERENCES `m_saving_account` (`id`),
  CONSTRAINT `FKSAT0000000002` FOREIGN KEY (`contra_id`) REFERENCES `m_saving_account_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_saving_account_transaction`
--

LOCK TABLES `m_saving_account_transaction` WRITE;
/*!40000 ALTER TABLE `m_saving_account_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_saving_account_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_saving_schedule`
--

DROP TABLE IF EXISTS `m_saving_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_saving_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `saving_account_id` bigint(20) NOT NULL,
  `duedate` date NOT NULL,
  `installment` smallint(5) NOT NULL,
  `deposit` decimal(21,4) NOT NULL,
  `payment_date` date DEFAULT NULL,
  `deposit_paid` decimal(21,4) DEFAULT NULL,
  `interest_accured` decimal(21,4) DEFAULT '0.0000',
  `completed_derived` bit(1) NOT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKSS00000000001` (`saving_account_id`),
  CONSTRAINT `FKSS00000000001` FOREIGN KEY (`saving_account_id`) REFERENCES `m_saving_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_saving_schedule`
--

LOCK TABLES `m_saving_schedule` WRITE;
/*!40000 ALTER TABLE `m_saving_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_saving_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_staff`
--

DROP TABLE IF EXISTS `m_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_staff` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_loan_officer` tinyint(1) NOT NULL DEFAULT '0',
  `office_id` bigint(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `display_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_name` (`display_name`),
  KEY `FK_m_staff_m_office` (`office_id`),
  CONSTRAINT `FK_m_staff_m_office` FOREIGN KEY (`office_id`) REFERENCES `m_office` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_staff`
--

LOCK TABLES `m_staff` WRITE;
/*!40000 ALTER TABLE `m_staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `r_enum_value`
--

DROP TABLE IF EXISTS `r_enum_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `r_enum_value` (
  `enum_name` varchar(100) NOT NULL,
  `enum_id` int(11) NOT NULL,
  `enum_message_property` varchar(100) NOT NULL,
  `enum_value` varchar(100) NOT NULL,
  PRIMARY KEY (`enum_name`,`enum_id`),
  UNIQUE KEY `enum_message_property` (`enum_name`,`enum_message_property`),
  UNIQUE KEY `enum_value` (`enum_name`,`enum_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `r_enum_value`
--

LOCK TABLES `r_enum_value` WRITE;
/*!40000 ALTER TABLE `r_enum_value` DISABLE KEYS */;
INSERT INTO `r_enum_value` VALUES ('amortization_method_enum',0,'Equal principle payments','Equal principle payments'),('amortization_method_enum',1,'Equal installments','Equal installments'),('interest_calculated_in_period_enum',0,'Daily','Daily'),('interest_calculated_in_period_enum',1,'Same as repayment period','Same as repayment period'),('interest_method_enum',0,'Declining Balance','Declining Balance'),('interest_method_enum',1,'Flat','Flat'),('interest_period_frequency_enum',2,'Per month','Per month'),('interest_period_frequency_enum',3,'Per year','Per year'),('loan_status_id',100,'Submitted and awaiting approval','Submitted and awaiting approval'),('loan_status_id',200,'Approved','Approved'),('loan_status_id',300,'Active','Active'),('loan_status_id',400,'Withdrawn by client','Withdrawn by client'),('loan_status_id',500,'Rejected','Rejected'),('loan_status_id',600,'Closed','Closed'),('loan_status_id',601,'Written-Off','Written-Off'),('loan_status_id',602,'Rescheduled','Rescheduled'),('loan_status_id',700,'Overpaid','Overpaid'),('loan_transaction_strategy_id',1,'mifos-standard-strategy','Mifos style'),('loan_transaction_strategy_id',2,'heavensfamily-strategy','Heavensfamily'),('loan_transaction_strategy_id',3,'creocore-strategy','Creocore'),('loan_transaction_strategy_id',4,'rbi-india-strategy','RBI (India)'),('processing_result_enum',0,'invalid','Invalid'),('processing_result_enum',1,'processed','Processed'),('processing_result_enum',2,'awaiting.approval','Awaiting Approval'),('processing_result_enum',3,'rejected','Rejected'),('repayment_period_frequency_enum',0,'Days','Days'),('repayment_period_frequency_enum',1,'Weeks','Weeks'),('repayment_period_frequency_enum',2,'Months','Months'),('term_period_frequency_enum',0,'Days','Days'),('term_period_frequency_enum',1,'Weeks','Weeks'),('term_period_frequency_enum',2,'Months','Months'),('term_period_frequency_enum',3,'Years','Years');
/*!40000 ALTER TABLE `r_enum_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_loan_transaction_processing_strategy`
--

DROP TABLE IF EXISTS `ref_loan_transaction_processing_strategy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ref_loan_transaction_processing_strategy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `createdby_id` bigint(20) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `lastmodifiedby_id` bigint(20) DEFAULT NULL,
  `lastmodified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ltp_strategy_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_loan_transaction_processing_strategy`
--

LOCK TABLES `ref_loan_transaction_processing_strategy` WRITE;
/*!40000 ALTER TABLE `ref_loan_transaction_processing_strategy` DISABLE KEYS */;
INSERT INTO `ref_loan_transaction_processing_strategy` VALUES (1,'mifos-standard-strategy','Mifos style',NULL,NULL,NULL,NULL),(2,'heavensfamily-strategy','Heavensfamily',NULL,NULL,NULL,NULL),(3,'creocore-strategy','Creocore',NULL,NULL,NULL,NULL),(4,'rbi-india-strategy','RBI (India)',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ref_loan_transaction_processing_strategy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rpt_sequence`
--

DROP TABLE IF EXISTS `rpt_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rpt_sequence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rpt_sequence`
--

LOCK TABLES `rpt_sequence` WRITE;
/*!40000 ALTER TABLE `rpt_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `rpt_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stretchy_parameter`
--

DROP TABLE IF EXISTS `stretchy_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stretchy_parameter` (
  `parameter_id` int(11) NOT NULL AUTO_INCREMENT,
  `parameter_name` varchar(45) NOT NULL,
  `parameter_variable` varchar(45) DEFAULT NULL,
  `parameter_label` varchar(45) NOT NULL,
  `parameter_displayType` varchar(45) NOT NULL,
  `parameter_FormatType` varchar(10) NOT NULL,
  `parameter_default` varchar(45) NOT NULL,
  `special` varchar(1) DEFAULT NULL,
  `selectOne` varchar(1) DEFAULT NULL,
  `selectAll` varchar(1) DEFAULT NULL,
  `parameter_sql` text,
  PRIMARY KEY (`parameter_id`),
  UNIQUE KEY `name_UNIQUE` (`parameter_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stretchy_parameter`
--

LOCK TABLES `stretchy_parameter` WRITE;
/*!40000 ALTER TABLE `stretchy_parameter` DISABLE KEYS */;
INSERT INTO `stretchy_parameter` VALUES (1,'startDateSelect','startDate','startDate','date','date','today',NULL,NULL,NULL,NULL),(2,'endDateSelect','endDate','endDate','date','date','today',NULL,NULL,NULL,NULL),(3,'obligDateTypeSelect','obligDateType','obligDateType','select','number','0',NULL,NULL,NULL,'select * from\r\n(select 1 as id, \"Closed\" as `name` union all\r\nselect 2, \"Disbursal\" ) x\r\norder by x.`id`'),(5,'OfficeIdSelectOne','officeId','Office','select','number','0',NULL,'Y',NULL,'select id, \r\nconcat(substring(\"........................................\", 1, \r\n   \n\n((LENGTH(`hierarchy`) - LENGTH(REPLACE(`hierarchy`, \'.\', \'\')) - 1) * 4)), \r\n   `name`) as tc\r\nfrom m_office\r\nwhere hierarchy like concat\n\n(\'${currentUserHierarchy}\', \'%\')\r\norder by hierarchy'),(6,'loanOfficerIdSelectAll','loanOfficerId','Loan Officer','select','number','0',NULL,NULL,'Y','(select id, \n\ndisplay_name as `Name` from m_staff\nwhere is_loan_officer = true)\r\nunion all\r\n(select -10, \'-\')\r\norder by 2'),(10,'currencyIdSelectAll','currencyId','Currency','select','number','0',NULL,NULL,'Y','select `code`, `name`\r\nfrom m_organisation_currency\r\norder by `code`'),(11,'currencyIdSelectOne','currencyId','Currency','select','number','0',NULL,'Y',NULL,'select `code`, `name`\r\nfrom m_organisation_currency\r\norder by `code`'),(20,'fundIdSelectAll','fundId','Fund','select','number','0',NULL,NULL,'Y','(select id, `name`\r\nfrom m_fund)\r\nunion all\r\n(select -10, \'-\')\r\norder by 2'),(25,'loanProductIdSelectAll','loanProductId','Product','select','number','0',NULL,NULL,'Y','select id, `name`\r\nfrom m_product_loan\r\norder by 2'),(26,'loanPurposeIdSelectAll','loanPurposeId','Loan Purpose','select','number','0',NULL,NULL,'Y','select -10 as id, \'-\' as code_value\r\nunion all\r\nselect * from (select v.id, v.code_value\r\nfrom m_code c\r\njoin m_code_value v on v.code_id = c.id\r\nwhere c.code_name = \"loanPurpose\"\r\norder by v.order_position)  x'),(100,'parTypeSelect','parType','parType','select','number','0',NULL,NULL,NULL,'select * from\r\n(select 1 as id, \"Principal Only\" as `name` union all\r\nselect 2, \"Principal + Interest\" union all\r\nselect 3, \"Principal + Interest + Fees\" union all\r\nselect 4, \"Principal + Interest + Fees + Penalties\") x\r\norder by x.`id`'),(1001,'FullReportList',NULL,'n/a','n/a','n/a','n/a','Y',NULL,NULL,'select  r.report_id, r.report_name, r.report_type, r.report_subtype, r.report_category,\r\n  \n\nrp.parameter_id, rp.report_parameter_name, p.parameter_name\r\n  from stretchy_report r\r\n  left join stretchy_report_parameter rp on rp.report_id = r.report_id\r\n  \n\nleft join stretchy_parameter p on p.parameter_id = rp.parameter_id\r\n  where r.use_report is true\r\n  and exists\r\n  (\r\n select \'f\'\r\n  from m_appuser_role ur \n\n\r\n  join m_role r on r.id = ur.role_id\r\n  join m_role_permission rp on rp.role_id = r.id\r\n  join m_permission p on p.id = rp.permission_id\r\n  where \n\nur.appuser_id = ${currentUserId}\r\n  and (p.code in (\'ALL_FUNCTIONS_READ\', \'ALL_FUNCTIONS\') or p.code = concat(\"READ_\", r.report_name))\r\n )\r\n  order by \n\nr.report_category, r.report_name, rp.parameter_id'),(1002,'FullParameterList',NULL,'n/a','n/a','n/a','n/a','Y',NULL,NULL,'select parameter_name, parameter_variable, \n\nparameter_label, parameter_displayType, \r\nparameter_FormatType, parameter_default, selectOne,  selectAll\r\nfrom stretchy_parameter p\r\nwhere special is null\r\n\n\norder by parameter_id'),(1003,'reportCategoryList',NULL,'n/a','n/a','n/a','n/a','Y',NULL,NULL,'select  r.report_id, r.report_name, r.report_type, r.report_subtype, \n\nr.report_category,\r\n  rp.parameter_id, rp.report_parameter_name, p.parameter_name\r\n  from stretchy_report r\r\n  left join stretchy_report_parameter rp on \n\nrp.report_id = r.report_id\r\n  left join stretchy_parameter p on p.parameter_id = rp.parameter_id\r\n  where r.report_category = \'${reportCategory}\'\r\n  and \n\nr.use_report is true\r\n  and exists\r\n  (\r\n select \'f\'\r\n  from m_appuser_role ur \r\n  join m_role r on r.id = ur.role_id\r\n  join m_role_permission rp on \n\nrp.role_id = r.id\r\n  join m_permission p on p.id = rp.permission_id\r\n  where ur.appuser_id = ${currentUserId}\r\n  and (p.code in (\'ALL_FUNCTIONS_READ\', \n\n\'ALL_FUNCTIONS\') or p.code = concat(\"READ_\", r.report_name))\r\n )\r\n  order by r.report_category, r.report_name, rp.parameter_id');
/*!40000 ALTER TABLE `stretchy_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stretchy_report`
--

DROP TABLE IF EXISTS `stretchy_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stretchy_report` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_name` varchar(100) NOT NULL,
  `report_type` varchar(20) NOT NULL,
  `report_subtype` varchar(20) DEFAULT NULL,
  `report_category` varchar(45) DEFAULT NULL,
  `report_sql` text,
  `description` text,
  `core_report` tinyint(1) DEFAULT '0',
  `use_report` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `report_name_UNIQUE` (`report_name`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stretchy_report`
--

LOCK TABLES `stretchy_report` WRITE;
/*!40000 ALTER TABLE `stretchy_report` DISABLE KEYS */;
INSERT INTO `stretchy_report` VALUES (1,'Client Listing','Table',NULL,'Client','select \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\n c.account_no as \"Client Account No.\",  \r\nc.display_name as \"Name\",  \n\nc.joined_date as \"Joined\", c.external_id as \"External Id\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand \n\nounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\nwhere o.id = ${officeId}\r\nand c.is_deleted=0\r\n\n\norder by ounder.hierarchy, c.account_no','Individual Client Report\r\n\r\nLists the small number of defined fields on the client table.  Would expect to copy this \n\nreport and add any \'one to one\' additional data for specific tenant needs.\r\n\r\nCan be run for any size MFI but you\'d expect it only to be run within a branch for \n\nlarger ones.  Depending on how many columns are displayed, there is probably is a limit of about 20/50k clients returned for html display (export to excel doesn\'t \n\nhave that client browser/memory impact).',1,1),(2,'Client Loans Listing','Table',NULL,'Client','select \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nc.account_no as \"Client \n\nAccount No.\", \r\nc.display_name as \"Name\", \r\nlo.display_name as \"Loan Officer\", l.account_no as \"Loan Account No.\", l.external_id as \"External Id\", \r\n\n\np.name as Loan, st.enum_message_property as \"Status\",  \r\nf.`name` as Fund, purp.code_value as \"Loan Purpose\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,  \r\nl.principal_amount,\n\n\r\nl.arrearstolerance_amount as \"Arrears Tolerance Amount\",\r\nl.number_of_repayments as \"Expected No. Repayments\",\r\nl.annual_nominal_interest_rate as \" Annual \n\nNominal Interest Rate\", \r\nl.nominal_interest_rate_per_period as \"Nominal Interest Rate Per Period\",\r\n\r\nipf.enum_message_property as \"Interest Rate Frequency\n\n\",\r\nim.enum_message_property as \"Interest Method\",\r\nicp.enum_message_property as \"Interest Calculated in Period\",\r\nl.term_frequency as \"Term Frequency\",\n\n\r\ntf.enum_message_property as \"Term Frequency Period\",\r\nl.repay_every as \"Repayment Frequency\",\r\nrf.enum_message_property as \"Repayment Frequency Period\",\n\n\r\nam.enum_message_property as \"Amortization\",\r\n\r\nl.total_charges_due_at_disbursement_derived as \"Total Charges Due At Disbursement\",\r\n\r\ndate( \n\nl.submittedon_date) as Submitted, date(l.approvedon_date) Approved, l.expected_disbursedon_date As \"Expected Disbursal\",\r\ndate(l.expected_firstrepaymenton_date) as \n\n\"Expected First Repayment\", date(l.interest_calculated_from_date) as \"Interest Calculated From\" ,\r\ndate(l.disbursedon_date) as Disbursed, date\n\n(l.expected_maturedon_date) \"Expected Maturity\",\r\ndate(l.maturedon_date) as \"Matured On\", date(l.closedon_date) as Closed,\r\ndate(l.rejectedon_date) as \n\nRejected, date(l.rescheduledon_date) as Rescheduled, \r\ndate(l.withdrawnon_date) as Withdrawn, date(l.writtenoffon_date) \"Written Off\"\r\nfrom m_office o \r\njoin \n\nm_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on \n\nc.office_id = ounder.id\r\nleft join m_loan l on l.client_id = c.id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_product_loan p on p.id = \n\nl.product_id\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join r_enum_value st on st.enum_name = \"loan_status_id\" and st.enum_id = l.loan_status_id\r\nleft join \n\nr_enum_value ipf on ipf.enum_name = \"interest_period_frequency_enum\" and ipf.enum_id = l.interest_period_frequency_enum\r\nleft join r_enum_value im on im.enum_name \n\n= \"interest_method_enum\" and im.enum_id = l.interest_method_enum\r\nleft join r_enum_value tf on tf.enum_name = \"term_period_frequency_enum\" and tf.enum_id = \n\nl.term_period_frequency_enum\r\nleft join r_enum_value icp on icp.enum_name = \"interest_calculated_in_period_enum\" and icp.enum_id = \n\nl.interest_calculated_in_period_enum\r\nleft join r_enum_value rf on rf.enum_name = \"repayment_period_frequency_enum\" and rf.enum_id = \n\nl.repayment_period_frequency_enum\r\nleft join r_enum_value am on am.enum_name = \"amortization_method_enum\" and am.enum_id = l.amortization_method_enum\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\n\r\nleft \n\njoin m_currency cur on cur.code = l.currency_code\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand \n\n(l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \n\n\"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\norder by ounder.hierarchy, 2 , l.id','Individual Client Report\r\n\r\nPretty \n\nwide report that lists the basic details of client loans.  \r\n\r\nCan be run for any size MFI but you\'d expect it only to be run within a branch for larger ones.  \n\nThere is probably is a limit of about 20/50k clients returned for html display (export to excel doesn\'t have that client browser/memory impact).',1,1),(5,'Loans Awaiting Disbursal','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nc.account_no as \"Client Account No\", c.display_name as \"Name\", l.account_no as \"Loan Account No.\", pl.`name` as \"Product\", \r\nf.`name` as Fund, ifnull(cur.display_symbol, l.currency_code) as Currency,  \r\nl.principal_amount as Principal,  \r\nl.term_frequency as \"Term Frequency\",\n\n\r\ntf.enum_message_property as \"Term Frequency Period\",\r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\",\r\ndate(l.approvedon_date) \"Approved\",\r\ndatediff(l.expected_disbursedon_date, curdate()) as \"Days to Disbursal\",\r\ndate(l.expected_disbursedon_date) \"Expected Disbursal\",\r\npurp.code_value as \"Loan Purpose\",\r\n lo.display_name as \"Loan Officer\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nleft join r_enum_value tf on tf.enum_name = \"term_period_frequency_enum\" and tf.enum_id = l.term_period_frequency_enum\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 200\r\norder by ounder.hierarchy, datediff(l.expected_disbursedon_date, curdate()),  c.account_no','Individual Client Report',1,1),(6,'Loans Awaiting Disbursal Summary','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\npl.`name` as \"Product\", \r\nifnull(cur.display_symbol, l.currency_code) as Currency,  f.`name` as Fund,\r\nsum(l.principal_amount) as Principal\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 200\r\ngroup by ounder.hierarchy, pl.`name`, l.currency_code,  f.`name`\r\norder by ounder.hierarchy, pl.`name`, l.currency_code,  f.`name`','Individual Client Report',1,1),(7,'Loans Awaiting Disbursal Summary by Month','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\npl.`name` as \"Product\", \r\nifnull(cur.display_symbol, l.currency_code) as Currency,  \r\nyear(l.expected_disbursedon_date) as \"Year\", \r\nmonthname(l.expected_disbursedon_date) as \"Month\",\r\nsum(l.principal_amount) as Principal\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 200\r\ngroup by ounder.hierarchy, pl.`name`, l.currency_code, year(l.expected_disbursedon_date), month(l.expected_disbursedon_date)\r\norder by ounder.hierarchy, pl.`name`, l.currency_code, year(l.expected_disbursedon_date), month(l.expected_disbursedon_date)','Individual Client Report',1,1),(8,'Loans Pending Approval','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nc.account_no as \"Client Account No.\", c.display_name as \"Client Name\", \r\nifnull(cur.display_symbol, l.currency_code) as Currency,  pl.`name` as \"Product\", \r\nl.account_no as \"Loan Account No.\", \r\nl.principal_amount as \"Loan Amount\", \r\nl.term_frequency as \"Term Frequency\",\n\n\r\ntf.enum_message_property as \"Term Frequency Period\",\r\nl.annual_nominal_interest_rate as \" Annual \n\nNominal Interest Rate\", \r\ndatediff(curdate(), l.submittedon_date) \"Days Pending Approval\", \r\npurp.code_value as \"Loan Purpose\",\r\nlo.display_name as \"Loan Officer\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nleft join r_enum_value tf on tf.enum_name = \"term_period_frequency_enum\" and tf.enum_id = l.term_period_frequency_enum\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 100 /*Submitted and awaiting approval */\r\norder by ounder.hierarchy, l.submittedon_date,  l.account_no','Individual Client Report',1,1),(11,'Active Loans - Summary','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(mo.`hierarchy`) - LENGTH(REPLACE(mo.`hierarchy`, \'.\', \'\')) - 1))), mo.`name`) as \"Office/Branch\", x.currency as Currency,\r\n x.client_count as \"No. of Clients\", x.active_loan_count as \"No. Active Loans\", x. principal_arrears_loan_count as \"No. of Loans in Arrears\",\r\nx.principal as \"Total Loans Disbursed\", x.principal_repaid as \"Principal Repaid\", x.principal_outstanding as \"Principal Outstanding\", x.principal_overdue as \"Principal Overdue\",\r\nx.interest as \"Total Interest\", x.interest_repaid as \"Interest Repaid\", x.interest_outstanding as \"Interest Outstanding\", x.interest_overdue as \"Interest Overdue\",\r\nx.fees as \"Total Fees\", x.fees_repaid as \"Fees Repaid\", x.fees_outstanding as \"Fees Outstanding\", x.fees_overdue as \"Fees Overdue\",\r\nx.penalties as \"Total Penalties\", x.penalties_repaid as \"Penalties Repaid\", x.penalties_outstanding as \"Penalties Outstanding\", x.penalties_overdue as \"Penalties Overdue\",\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.principal_overdue * 100) / x.principal_outstanding, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue + x.penalties_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding + x.penalties_overdue), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from m_office mo\r\njoin \r\n(select ounder.id as branch,\r\nifnull(cur.display_symbol, l.currency_code) as currency,\r\ncount(distinct(c.id)) as client_count, \r\ncount(distinct(l.id)) as  active_loan_count,\r\ncount(distinct(if(r.duedate <= curdate(), \r\n		if(ifnull(r.principal_amount,0) -  ifnull(r.principal_completed_derived, 0), l.id, null), null)  )) as principal_arrears_loan_count,\r\n\r\nsum(ifnull(r.principal_amount,0)) as principal,\r\nsum(ifnull(r.principal_completed_derived, 0)) as principal_repaid,\r\nsum(ifnull(r.principal_amount,0) - (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0))) as principal_outstanding,\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.principal_amount,0) -  (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0)))\r\n            , 0)) as principal_overdue,\r\n\r\nsum(ifnull(r.interest_amount,0)) as interest,\r\nsum(ifnull(r.interest_completed_derived, 0)) as interest_repaid,\r\nsum(ifnull(r.interest_amount,0) -  (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0))) as interest_outstanding,\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.interest_amount,0) - (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0)))\r\n            , 0)) as interest_overdue,\r\n\r\nsum(ifnull(r.fee_charges_amount,0)) as fees,\r\nsum(ifnull(r.fee_charges_completed_derived, 0)) as fees_repaid,\r\nsum(ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))  as fees_outstanding,\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))\r\n            , 0)) as fees_overdue,\r\n\r\nsum(ifnull(r.penalty_charges_amount,0)) as penalties,\r\nsum(ifnull(r.penalty_charges_completed_derived, 0)) as penalties_repaid,\r\nsum(ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0))) as penalties_outstanding,\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0)))\r\n            , 0)) as penalties_overdue\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\n\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\ngroup by ounder.id, l.currency_code) x on x.branch = mo.id\r\norder by mo.hierarchy, x.Currency',NULL,1,1),(12,'Active Loans - Details','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nlo.display_name as \"Loan Officer\", \r\nc.display_name as \"Client\", l.account_no as \"Loan Account No.\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  \r\nl.principal_amount as \"Loan Amount\", \r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed Date\", \r\ndate(l.expected_maturedon_date) as \"Expected Matured On\",\r\n\r\nsum(ifnull(r.principal_completed_derived, 0)) as \"Principal Repaid\",\r\nsum(ifnull(r.principal_amount,0) - (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0))) as \"Principal Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.principal_amount,0) -  (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0)))\r\n            , 0)) as \"Principal Overdue\",\r\n\r\nsum(ifnull(r.interest_completed_derived, 0)) as \"Interest Repaid\",\r\nsum(ifnull(r.interest_amount,0) -  (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0))) as \"Interest Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.interest_amount,0) - (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0)))\r\n            , 0)) as \"Interest Overdue\",\r\n\r\nsum(ifnull(r.fee_charges_completed_derived, 0)) as \"Fees Repaid\",\r\nsum(ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))  as \"Fees Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))\r\n            , 0)) as \"Fees Overdue\",\r\n\r\nsum(ifnull(r.penalty_charges_completed_derived, 0)) as \"Penalties Repaid\",\r\nsum(ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0))) as \"Penalties Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0)))\r\n            , 0)) as \"Penalties Overdue\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\ngroup by l.id\r\norder by ounder.hierarchy, l.currency_code, c.account_no, l.account_no','Individual Client \n\nReport',1,1),(13,'Obligation Met Loans Details','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nc.account_no as \"Client Account No.\", c.display_name as \"Client\",\r\nl.account_no as \"Loan Account No.\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  \r\nl.principal_amount as \"Loan Amount\", \r\n(sum(ifnull(r.principal_completed_derived, 0)) + \r\n sum(ifnull(r.interest_completed_derived, 0)) + \r\n sum(ifnull(r.fee_charges_completed_derived, 0)) + \r\n sum(ifnull(r.penalty_charges_completed_derived, 0)))  as \"Total Repaid\", \r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed\", \r\ndate(l.closedon_date) as \"Closed\",\r\n\r\nsum(ifnull(r.principal_completed_derived, 0)) as \"Principal Repaid\",\r\nsum(ifnull(r.interest_completed_derived, 0)) as \"Interest Repaid\",\r\nsum(ifnull(r.fee_charges_completed_derived, 0)) as \"Fees Repaid\",\r\nsum(ifnull(r.penalty_charges_completed_derived, 0)) as \"Penalties Repaid\",\r\nlo.display_name as \"Loan Officer\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand (case\r\n	when ${obligDateType} = 1 then\r\n    l.closedon_date between \'${startDate}\' and \'${endDate}\'\r\n	when ${obligDateType} = 2 then\r\n    l.disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\n	else 1 = 1\r\n	end)\r\nand l.loan_status_id = 600\r\ngroup by l.id\r\norder by ounder.hierarchy, l.currency_code, c.account_no, l.account_no','Individual Client \n\nReport',1,1),(14,'Obligation Met Loans Summary','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\ncount(distinct(c.id)) as \"No. of Clients\",\r\ncount(distinct(l.id)) as \"No. of Loans\",\r\nsum(l.principal_amount) as \"Total Loan Amount\", \r\n\"wait for derived field\" as \"Total Principal Repaid\",\r\n\"wait for derived field\" as \"Total Interest Repaid\",\r\n\"wait for derived field\" as \"Total Fees Repaid\",\r\n\"wait for derived field\" as \"Total Interest Waived\",\r\n\"wait for derived field\" as \"Total Fees Waived\",\r\n\"wait for derived field\" as \"Total Penalties Waived\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand (case\r\n	when ${obligDateType} = 1 then\r\n    l.closedon_date between \'${startDate}\' and \'${endDate}\'\r\n	when ${obligDateType} = 2 then\r\n    l.disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\n	else 1 = 1\r\n	end)\r\nand l.loan_status_id = 600\r\ngroup by o.hierarchy, l.currency_code\r\norder by ounder.hierarchy, l.currency_code','Individual Client \n\nReport',1,1),(15,'Portfolio at Risk','Table',NULL,'Loan','select x.Currency, x.`Principal Outstanding`, x.`Principal Overdue`, x.`Interest Outstanding`, x.`Interest Overdue`, \r\nx.`Fees Outstanding`, x.`Fees Overdue`, x.`Penalties Outstanding`, x.`Penalties Overdue`,\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.`Principal Overdue` * 100) / x.`Principal Outstanding`, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding`), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue` + x.`Fees Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding` + x.`Fees Outstanding`), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue` + x.`Fees Overdue` + x.`Penalties Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding` + x.`Fees Outstanding` + x.`Penalties Overdue`), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from \r\n(select  ifnull(cur.display_symbol, l.currency_code) as Currency,  \r\nsum(ifnull(r.principal_amount,0) - (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0))) as \"Principal Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.principal_amount,0) -  (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0)))\r\n            , 0)) as \"Principal Overdue\",\r\n\r\nsum(ifnull(r.interest_amount,0) -  (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0))) as \"Interest Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.interest_amount,0) - (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0)))\r\n            , 0)) as \"Interest Overdue\",\r\n\r\nsum(ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))  as \"Fees Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))\r\n            , 0)) as \"Fees Overdue\",\r\n\r\nsum(ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0))) as \"Penalties Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0)))\r\n            , 0)) as \"Penalties Overdue\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin  m_loan l on l.client_id = c.id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nleft join m_product_loan p on p.id = l.product_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\n                                        and r.completed_derived is false\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\ngroup by l.currency_code\r\norder by l.currency_code) x','Covers all loans.\r\n\r\nFor larger MFIs … we should add some derived fields on loan (or a 1:1 loan related table like mifos 2.x does)\r\nPrinciple, Interest, Fees, Penalties Outstanding and Overdue (possibly waived and written off too)',1,1),(16,'Portfolio at Risk by Branch','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(mo.`hierarchy`) - LENGTH(REPLACE(mo.`hierarchy`, \'.\', \'\')) - 1))), mo.`name`) as \"Office/Branch\",\r\nx.Currency, x.`Principal Outstanding`, x.`Principal Overdue`, x.`Interest Outstanding`, x.`Interest Overdue`, \r\nx.`Fees Outstanding`, x.`Fees Overdue`, x.`Penalties Outstanding`, x.`Penalties Overdue`,\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.`Principal Overdue` * 100) / x.`Principal Outstanding`, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding`), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue` + x.`Fees Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding` + x.`Fees Outstanding`), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.`Principal Overdue` + x.`Interest Overdue` + x.`Fees Overdue` + x.`Penalties Overdue`) * 100) / (x.`Principal Outstanding` + x.`Interest Outstanding` + x.`Fees Outstanding` + x.`Penalties Overdue`), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from m_office mo\r\njoin \r\n(select  ounder.id as \"branch\", ifnull(cur.display_symbol, l.currency_code) as Currency,  \r\nsum(ifnull(r.principal_amount,0) - (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0))) as \"Principal Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.principal_amount,0) -  (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0)))\r\n            , 0)) as \"Principal Overdue\",\r\n\r\nsum(ifnull(r.interest_amount,0) -  (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0))) as \"Interest Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.interest_amount,0) - (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0)))\r\n            , 0)) as \"Interest Overdue\",\r\n\r\nsum(ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))  as \"Fees Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))\r\n            , 0)) as \"Fees Overdue\",\r\n\r\nsum(ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0))) as \"Penalties Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0)))\r\n            , 0)) as \"Penalties Overdue\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin  m_loan l on l.client_id = c.id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_code_value purp on purp.id = l.loanpurpose_cv_id\r\nleft join m_product_loan p on p.id = l.product_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\n                                        and r.completed_derived is false\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\ngroup by ounder.id, l.currency_code) x on x.branch = mo.id\r\norder by mo.hierarchy, x.Currency','Covers all loans.\r\n\r\nFor larger MFIs … we should add some derived fields on loan (or a 1:1 loan related table like mifos 2.x does)\r\nPrinciple, Interest, Fees, Penalties Outstanding and Overdue (possibly waived and written off too)',1,1),(20,'Funds Disbursed Between Dates Summary','Table',NULL,'Fund','select ifnull(f.`name`, \'-\') as Fund,  ifnull(cur.display_symbol, l.currency_code) as Currency, \r\nround(sum(l.principal_amount), 4) as disbursed_amount\r\nfrom m_office ounder \r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_currency cur on cur.`code` = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nwhere disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (l.currency_code = \'${currencyId}\' or \'-1\' = \'${currencyId}\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\ngroup by ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, l.currency_code)\r\norder by ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, l.currency_code)',NULL,1,1),(21,'Funds Disbursed Between Dates Summary by Office','Table',NULL,'Fund','select \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\n \n\nifnull(f.`name`, \'-\') as Fund,  ifnull(cur.display_symbol, l.currency_code) as Currency, round(sum(l.principal_amount), 4) as disbursed_amount\r\nfrom m_office o\r\n\n\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c \n\non c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_currency cur on cur.`code` = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\n\n\nwhere disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\nand o.id = ${officeId}\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand \n\n(l.currency_code = \'${currencyId}\' or \'-1\' = \'${currencyId}\')\r\ngroup by ounder.`name`,  ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, \n\nl.currency_code)\r\norder by ounder.`name`,  ifnull(f.`name`, \'-\') , ifnull(cur.display_symbol, l.currency_code)',NULL,1,1),(48,'Balance Sheet','Pentaho',NULL,'Accounting',NULL,'Balance Sheet',1,0),(49,'Income Statement','Pentaho',NULL,'Accounting',NULL,'Profit and Loss Statement',1,0),(50,'Trial Balance','Pentaho',NULL,'Accounting',NULL,'Trial Balance Report',1,0),(51,'Written-Off Loans','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, ml.currency_code) as Currency,  \r\nc.account_no as \"Client Account No.\",\r\nc.display_name AS \'Client Name\',\r\nml.account_no AS \'Loan Account No.\',\r\nmpl.name AS \'Product Name\',\r\nml.disbursedon_date AS \'Disbursed Date\',\r\nlt.transaction_date AS \'Written Off date\',\r\nml.principal_amount as \"Loan Amount\",\r\nifnull(lt.principal_portion_derived, 0) AS \'Written-Off Principal\',\r\nifnull(lt.interest_portion_derived, 0) AS \'Written-Off Interest\',\r\nifnull(lt.fee_charges_portion_derived,0) AS \'Written-Off Fees\',\r\nifnull(lt.penalty_charges_portion_derived,0) AS \'Written-Off Penalties\',\r\nn.note AS \'Reason For Write-Off\',\r\nIFNULL(ms.display_name,\'-\') AS \'Loan Officer Name\'\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nAND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_loan ml ON ml.client_id = c.id\r\nJOIN m_product_loan mpl ON mpl.id=ml.product_id\r\nLEFT JOIN m_staff ms ON ms.id=ml.loan_officer_id\r\nJOIN m_loan_transaction lt ON lt.loan_id = ml.id\r\nLEFT JOIN m_note n ON n.loan_transaction_id = lt.id\r\nLEFT JOIN m_currency cur on cur.code = ml.currency_code\r\nWHERE lt.transaction_type_enum = 6 /*write-off */\r\nAND lt.is_reversed is false \r\nAND ml.loan_status_id=601\r\nAND o.id=${officeId}\r\nAND (mpl.id=${loanProductId} OR ${loanProductId}=-1)\r\nAND lt.transaction_date BETWEEN \'${startDate}\' AND \'${endDate}\'\r\nAND (ml.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nORDER BY ounder.hierarchy, ifnull(cur.display_symbol, ml.currency_code), ml.account_no','Individual Lending Report. Written Off Loans',1,1),(52,'Aging Summary (Arrears in weeks) - review','Table',NULL,'Loan','SELECT \r\n arr.clientName AS \"Client Name\",\r\n arr.accNo AS \"Account Number\",\r\n arr.loanAmt AS \"Loan Amount\",\r\n loan.principal AS \"Original Principal\",\r\n loan.interest AS \"Original Interest\",\r\n loan.prinPaid AS \"Principal Paid\",\r\n loan.intPaid AS \"Interest Paid\",\r\n arr.prinOverdue AS \"Principal Overdue\",\r\n arr.intOverdue AS \"Interest Overdue\",\r\n arr.arrWeek AS \"Weeks In Arrears\"\r\nFROM \r\n   (SELECT mr.loan_id loanId,\r\n 	mc.display_name AS clientName,\r\n 	ml.account_no AS accNo,\r\n 	ml.principal_amount AS loanAmt,\r\n     SUM(mr.principal_amount - IFNULL(mr.principal_completed_derived, 0)) AS prinOverdue, \r\n     SUM(mr.interest_amount - IFNULL(mr.interest_completed_derived, 0)) AS intOverdue,\r\n 	IF(DATEDIFF(CURDATE(), MIN(mr.duedate))<7, \'Less than a week in arrears\', \r\n 	IF(DATEDIFF(CURDATE(), MIN(mr.duedate))<8, \'1 Week in Arrears\', \r\n 	IF(DATEDIFF(CURDATE(), MIN(mr.duedate))<15, \'2 Weeks in Arrears\', \r\n 	IF(DATEDIFF(CURDATE(), MIN(mr.duedate))<22, \'3 Weeks in Arrears\', \r\n 	IF(DATEDIFF(CURDATE(), MIN(mr.duedate))<29, \'4 Weeks in Arrears\', \r\n 	IF(DATEDIFF(CURDATE(), MIN(mr.duedate))<36, \'5 Weeks in Arrears\', \r\n 	IF(DATEDIFF(CURDATE(), MIN(mr.duedate))<43, \'6 Weeks in Arrears\', \r\n 	IF(DATEDIFF(CURDATE(), MIN(mr.duedate))<50, \'7 Weeks in Arrears\', \r\n 	IF(DATEDIFF(CURDATE(), MIN(mr.duedate))<57, \'8 Weeks in Arrears\', \r\n 	IF(DATEDIFF(CURDATE(), MIN(mr.duedate))<64, \'9 Weeks in Arrears\', \r\n 	IF(DATEDIFF(CURDATE(), MIN(mr.duedate))<71, \'10 Weeks in Arrears\', \r\n 	IF(DATEDIFF(CURDATE(), MIN(mr.duedate))<78, \'11 Weeks in Arrears\', \r\n 	IF(DATEDIFF(CURDATE(), MIN(mr.duedate))<85, \'12 Weeks in Arrears\', \'12+ Weeks in Arrears\'))))))))))))) AS arrWeek\r\n	FROM m_office mo \r\n    JOIN m_office ounder ON ounder.hierarchy like concat(mo.hierarchy, \'%\')\r\n	AND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n    INNER JOIN m_client mc ON mc.office_id=ounder.id\r\n	INNER JOIN m_loan ml ON ml.client_id = mc.id\r\n	INNER JOIN r_enum_value rev ON rev.enum_id=ml.loan_status_id\r\n    INNER JOIN m_loan_repayment_schedule mr ON mr.loan_id=ml.id\r\n	WHERE mr.completed_derived=0 \r\n	AND mr.duedate <= CURDATE() \r\n	AND ml.loan_status_id=300\r\n    AND mo.id=${officeId}\r\n	GROUP BY mr.loan_id\r\n	ORDER BY mc.display_name) arr\r\nINNER JOIN \r\n	(SELECT mr.loan_id loanId, \r\n      SUM(mr.principal_amount) principal,\r\n      SUM(mr.interest_amount) interest,\r\n      SUM(IFNULL(mr.principal_completed_derived,0)) prinPaid,\r\n      SUM(IFNULL(mr.interest_completed_derived,0)) intPaid\r\n	FROM m_loan_repayment_schedule mr\r\n	GROUP BY mr.loan_id) loan ON arr.loanId=loan.loanId','Loan arrears aging (Weeks)',1,1),(53,'Amount In Arrears','Table',NULL,'Loan','SELECT \r\n  IFNULL(weeks.currencyName, weeks.currency) as currency, \r\n  weeks.week_no \'Weeks In Arrears\', \r\n  IFNULL(ars.loanId, 0) \'No Of Loans\', \r\n  IFNULL(ars.principal,0.0) \'Original Principal\', \r\n  IFNULL(ars.interest,0.0) \'Original Interest\', \r\n  IFNULL(ars.prinPaid,0.0) \'Principal Paid\', \r\n  IFNULL(ars.intPaid,0.0) \'Interest Paid\', \r\n  IFNULL(ars.prinOverdue,0.0) \'Principal Overdue\', \r\n  IFNULL(ars.intOverdue,0.0)\'Interest Overdue\'\r\nFROM \r\n	/* full table of aging weeks/currencies used combo to ensure each line represented */\r\n  (SELECT curs.code as currency, curs.name as currencyName, wks.* from\r\n	(SELECT \'On Schedule\' week_no,0 wid UNION\r\n		SELECT \'0 to 6 days arrears\',1 UNION\r\n		SELECT \'1 Week in Arrears\',2 UNION\r\n		SELECT \'2 Weeks in Arrears\',3 UNION\r\n		SELECT \'3 Weeks in Arrears\',4 UNION\r\n		SELECT \'4 Weeks in Arrears\',5 UNION\r\n		SELECT \'5 Weeks in Arrears\',6 UNION\r\n		SELECT \'6 Weeks in Arrears\',7 UNION\r\n		SELECT \'7 Weeks in Arrears\',8 UNION\r\n		SELECT \'8 Weeks in Arrears\',9 UNION\r\n		SELECT \'9 Weeks in Arrears\',10 UNION\r\n		SELECT \'10 Weeks in Arrears\',11 UNION\r\n		SELECT \'11 Weeks in Arrears\',12 UNION\r\n		SELECT \'12 Weeks in Arrears\',13 UNION\r\n		SELECT \'12+ Weeks in Arrears\',14) wks,\r\n	(SELECT distinctrow moc.code, moc.name\r\n  	FROM m_office mo2\r\n   	INNER JOIN m_office ounder2 ON ounder2.hierarchy \r\n				LIKE CONCAT(mo2.hierarchy, \'%\')\r\nAND ounder2.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n   	INNER JOIN m_client mc2 ON mc2.office_id=ounder2.id\r\n   	INNER JOIN m_loan ml2 ON ml2.client_id = mc2.id\r\n	INNER JOIN m_organisation_currency moc ON moc.code = ml2.currency_code\r\n	WHERE ml2.loan_status_id=300 /* active */\r\n	AND mo2.id=${officeId}) curs) weeks\r\n\r\n\r\nLEFT JOIN /* table of aging weeks per currency with gaps if no applicable loans */\r\n(SELECT \r\n  	z.currency, z.arrWeek, \r\n	COUNT(z.loanId) as loanId, SUM(z.principal) as principal, SUM(z.interest) as interest, \r\n	SUM(z.prinPaid) as prinPaid, SUM(z.intPaid) as intPaid, \r\n	SUM(z.prinOverdue) as prinOverdue, SUM(z.intOverdue) as intOverdue\r\nFROM\r\n	/*derived table just used to get arrWeek value (was much slower to\r\n	duplicate calc of minOverdueDate in inner query) */\r\n	(SELECT x.loanId, x.currency, x.principal, x.interest, x.prinPaid, x.intPaid, x.prinOverdue, x.intOverdue,\r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<0, \'On Schedule\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<7, \'0 to 6 days arrears\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<8, \'1 Week in Arrears\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<15, \'2 Weeks in Arrears\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<22, \'3 Weeks in Arrears\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<29, \'4 Weeks in Arrears\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<36, \'5 Weeks in Arrears\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<43, \'6 Weeks in Arrears\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<50, \'7 Weeks in Arrears\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<57, \'8 Weeks in Arrears\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<64, \'9 Weeks in Arrears\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<71, \'10 Weeks in Arrears\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<78, \'11 Weeks in Arrears\', \r\n		IF(DATEDIFF(CURDATE(), minOverdueDate)<85, \'12 Weeks in Arrears\',\r\n				 \'12+ Weeks in Arrears\')))))))))))))) AS arrWeek\r\n\r\n	FROM /* get the individual loan details */\r\n		(SELECT ml.id AS loanId, ml.currency_code as currency,\r\n   			SUM(mr.principal_amount) principal, \r\n			SUM(mr.interest_amount) interest, \r\n   			SUM(IFNULL(mr.principal_completed_derived,0)) prinPaid, \r\n			SUM(IFNULL(mr.interest_completed_derived,0)) intPaid,\r\n\r\n			SUM(IF((mr.completed_derived is false) AND (mr.duedate <= CURDATE()), \r\n        				(mr.principal_amount - ifnull(mr.principal_completed_derived, 0))\r\n           					 , 0)) as prinOverdue,\r\n			SUM(IF((mr.completed_derived is false) AND (mr.duedate <= CURDATE()), \r\n        				(mr.interest_amount - ifnull(mr.interest_completed_derived, 0))\r\n            				, 0)) as intOverdue,\r\n\r\n			CAST(MIN(\r\n			  IF((mr.completed_derived is false) AND (mr.duedate <= CURDATE()), mr.duedate, CURDATE() + 1)) as date) as minOverdueDate\r\n			  \r\n  		FROM m_office mo\r\n   		INNER JOIN m_office ounder ON ounder.hierarchy \r\n				LIKE CONCAT(mo.hierarchy, \'%\')\r\nAND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\n   		INNER JOIN m_client mc ON mc.office_id=ounder.id\r\n   		INNER JOIN m_loan ml ON ml.client_id = mc.id\r\n		INNER JOIN m_loan_repayment_schedule mr on mr.loan_id = ml.id\r\n		WHERE ml.loan_status_id=300 /* active */\r\n     		AND mo.id=${officeId}\r\n  		GROUP BY ml.id) x\r\n	) z \r\nGROUP BY z.currency, z.arrWeek ) ars ON ars.arrWeek=weeks.week_no and ars.currency = weeks.currency\r\nORDER BY weeks.currency, weeks.wid','Loan amount in arrears by branch',1,1),(54,'Rescheduled Loans','Table',NULL,'Loan','SELECT \r\nconcat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, ml.currency_code) as Currency,  \r\nc.account_no as \"Client Account No.\",\r\nc.display_name AS \'Client Name\',\r\nml.account_no AS \'Loan Account No.\',\r\nmpl.name AS \'Product Name\',\r\nml.disbursedon_date AS \'Disbursed Date\',\r\nlt.transaction_date AS \'Written Off date\',\r\nml.principal_amount as \"Loan Amount\",\r\nifnull(lt.principal_portion_derived, 0) AS \'Rescheduled Principal\',\r\nifnull(lt.interest_portion_derived, 0) AS \'Rescheduled Interest\',\r\nifnull(lt.fee_charges_portion_derived,0) AS \'Rescheduled Fees\',\r\nifnull(lt.penalty_charges_portion_derived,0) AS \'Rescheduled Penalties\',\r\nn.note AS \'Reason For Rescheduling\',\r\nIFNULL(ms.display_name,\'-\') AS \'Loan Officer Name\'\r\nFROM m_office o\r\nJOIN m_office ounder ON ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nAND ounder.hierarchy like CONCAT(\'${currentUserHierarchy}\', \'%\')\r\nJOIN m_client c ON c.office_id = ounder.id\r\nJOIN m_loan ml ON ml.client_id = c.id\r\nJOIN m_product_loan mpl ON mpl.id=ml.product_id\r\nLEFT JOIN m_staff ms ON ms.id=ml.loan_officer_id\r\nJOIN m_loan_transaction lt ON lt.loan_id = ml.id\r\nLEFT JOIN m_note n ON n.loan_transaction_id = lt.id\r\nLEFT JOIN m_currency cur on cur.code = ml.currency_code\r\nWHERE lt.transaction_type_enum = 7 /*marked for rescheduling */\r\nAND lt.is_reversed is false \r\nAND ml.loan_status_id=602\r\nAND o.id=${officeId}\r\nAND (mpl.id=${loanProductId} OR ${loanProductId}=-1)\r\nAND lt.transaction_date BETWEEN \'${startDate}\' AND \'${endDate}\'\r\nAND (ml.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nORDER BY ounder.hierarchy, ifnull(cur.display_symbol, ml.currency_code), ml.account_no','Individual Lending Report. Rescheduled Loans.  The ability to reschedule (or mark that you have rescheduled the loan elsewhere) is a legacy of the older Mifos product.  Needed for migration.',1,1),(55,'Active Loans Passed Final Maturity','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nlo.display_name as \"Loan Officer\", \r\nc.display_name as \"Client\", l.account_no as \"Loan Account No.\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  \r\nl.principal_amount as \"Loan Amount\", \r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed Date\", \r\ndate(l.expected_maturedon_date) as \"Expected Matured On\",\r\n\r\nsum(ifnull(r.principal_completed_derived, 0)) as \"Principal Repaid\",\r\nsum(ifnull(r.principal_amount,0) - (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0))) as \"Principal Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.principal_amount,0) -  (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0)))\r\n            , 0)) as \"Principal Overdue\",\r\n\r\nsum(ifnull(r.interest_completed_derived, 0)) as \"Interest Repaid\",\r\nsum(ifnull(r.interest_amount,0) -  (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0))) as \"Interest Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.interest_amount,0) - (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0)))\r\n            , 0)) as \"Interest Overdue\",\r\n\r\nsum(ifnull(r.fee_charges_completed_derived, 0)) as \"Fees Repaid\",\r\nsum(ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))  as \"Fees Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))\r\n            , 0)) as \"Fees Overdue\",\r\n\r\nsum(ifnull(r.penalty_charges_completed_derived, 0)) as \"Penalties Repaid\",\r\nsum(ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0))) as \"Penalties Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0)))\r\n            , 0)) as \"Penalties Overdue\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\nand l.expected_maturedon_date < curdate()\r\ngroup by l.id\r\norder by ounder.hierarchy, l.currency_code, c.account_no, l.account_no','Individual Client \n\nReport',1,1),(56,'Active Loans Passed Final Maturity Summary','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(mo.`hierarchy`) - LENGTH(REPLACE(mo.`hierarchy`, \'.\', \'\')) - 1))), mo.`name`) as \"Office/Branch\", x.currency as Currency,\r\n x.client_count as \"No. of Clients\", x.active_loan_count as \"No. Active Loans\", x. principal_arrears_loan_count as \"No. of Loans in Arrears\",\r\nx.principal as \"Total Loans Disbursed\", x.principal_repaid as \"Principal Repaid\", x.principal_outstanding as \"Principal Outstanding\", x.principal_overdue as \"Principal Overdue\",\r\nx.interest as \"Total Interest\", x.interest_repaid as \"Interest Repaid\", x.interest_outstanding as \"Interest Outstanding\", x.interest_overdue as \"Interest Overdue\",\r\nx.fees as \"Total Fees\", x.fees_repaid as \"Fees Repaid\", x.fees_outstanding as \"Fees Outstanding\", x.fees_overdue as \"Fees Overdue\",\r\nx.penalties as \"Total Penalties\", x.penalties_repaid as \"Penalties Repaid\", x.penalties_outstanding as \"Penalties Outstanding\", x.penalties_overdue as \"Penalties Overdue\",\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.principal_overdue * 100) / x.principal_outstanding, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue + x.penalties_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding + x.penalties_overdue), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from m_office mo\r\njoin \r\n(select ounder.id as branch,\r\nifnull(cur.display_symbol, l.currency_code) as currency,\r\ncount(distinct(c.id)) as client_count, \r\ncount(distinct(l.id)) as  active_loan_count,\r\ncount(distinct(if(r.duedate <= curdate(), \r\n		if(ifnull(r.principal_amount,0) -  ifnull(r.principal_completed_derived, 0), l.id, null), null)  )) as principal_arrears_loan_count,\r\n\r\nsum(ifnull(r.principal_amount,0)) as principal,\r\nsum(ifnull(r.principal_completed_derived, 0)) as principal_repaid,\r\nsum(ifnull(r.principal_amount,0) - (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0))) as principal_outstanding,\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.principal_amount,0) -  (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0)))\r\n            , 0)) as principal_overdue,\r\n\r\nsum(ifnull(r.interest_amount,0)) as interest,\r\nsum(ifnull(r.interest_completed_derived, 0)) as interest_repaid,\r\nsum(ifnull(r.interest_amount,0) -  (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0))) as interest_outstanding,\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.interest_amount,0) - (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0)))\r\n            , 0)) as interest_overdue,\r\n\r\nsum(ifnull(r.fee_charges_amount,0)) as fees,\r\nsum(ifnull(r.fee_charges_completed_derived, 0)) as fees_repaid,\r\nsum(ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))  as fees_outstanding,\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))\r\n            , 0)) as fees_overdue,\r\n\r\nsum(ifnull(r.penalty_charges_amount,0)) as penalties,\r\nsum(ifnull(r.penalty_charges_completed_derived, 0)) as penalties_repaid,\r\nsum(ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0))) as penalties_outstanding,\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0)))\r\n            , 0)) as penalties_overdue\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\n\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\nand l.expected_maturedon_date < curdate()\r\ngroup by ounder.id, l.currency_code) x on x.branch = mo.id\r\norder by mo.hierarchy, x.Currency',NULL,1,1),(57,'Active Loans in last installment','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(lastInstallment.`hierarchy`) - LENGTH(REPLACE(lastInstallment.`hierarchy`, \'.\', \'\')) - 1))), lastInstallment.branch) as \"Office/Branch\",\r\nlastInstallment.Currency,\r\nlastInstallment.`Loan Officer`, \r\nlastInstallment.`Client Account No`, lastInstallment.`Client`, \r\nlastInstallment.`Loan Account No`, lastInstallment.`Product`, \r\nlastInstallment.`Fund`,  lastInstallment.`Loan Amount`, \r\nlastInstallment.`Annual Nominal Interest Rate`, \r\nlastInstallment.`Disbursed`, lastInstallment.`Expected Matured On` ,\r\n\r\nsum(ifnull(r.principal_completed_derived, 0)) as \"Principal Repaid\",\r\nsum(ifnull(r.principal_amount,0) - (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0))) as \"Principal Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.principal_amount,0) -  (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0)))\r\n            , 0)) as \"Principal Overdue\",\r\n\r\nsum(ifnull(r.interest_completed_derived, 0)) as \"Interest Repaid\",\r\nsum(ifnull(r.interest_amount,0) -  (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0))) as \"Interest Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.interest_amount,0) - (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0)))\r\n            , 0)) as \"Interest Overdue\",\r\n\r\nsum(ifnull(r.fee_charges_completed_derived, 0)) as \"Fees Repaid\",\r\nsum(ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))  as \"Fees Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))\r\n            , 0)) as \"Fees Overdue\",\r\n\r\nsum(ifnull(r.penalty_charges_completed_derived, 0)) as \"Penalties Repaid\",\r\nsum(ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0))) as \"Penalties Outstanding\",\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0)))\r\n            , 0)) as \"Penalties Overdue\"\r\n\r\nfrom \r\n(select l.id as loanId, l.number_of_repayments, min(r.installment), \r\nounder.id, ounder.hierarchy, ounder.`name` as branch, \r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nlo.display_name as \"Loan Officer\", c.account_no as \"Client Account No\",\r\nc.display_name as \"Client\", l.account_no as \"Loan Account No\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  l.principal_amount as \"Loan Amount\", \r\nl.annual_nominal_interest_rate as \"Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed\", date(l.expected_maturedon_date) as \"Expected Matured On\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\nand r.completed_derived is false\r\nand r.duedate >= curdate()\r\ngroup by l.id\r\nhaving l.number_of_repayments = min(r.installment)) lastInstallment\r\njoin m_loan_repayment_schedule r on r.loan_id = lastInstallment.loanId\r\ngroup by lastInstallment.loanId\r\norder by lastInstallment.hierarchy, lastInstallment.Currency, lastInstallment.`Client Account No`, lastInstallment.`Loan Account No`','Individual Client \n\nReport',1,1),(58,'Active Loans in last installment Summary','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(mo.`hierarchy`) - LENGTH(REPLACE(mo.`hierarchy`, \'.\', \'\')) - 1))), mo.`name`) as \"Office/Branch\", x.currency as Currency,\r\n x.client_count as \"No. of Clients\", x.active_loan_count as \"No. Active Loans\", x. principal_arrears_loan_count as \"No. of Loans in Arrears\",\r\nx.principal as \"Total Loans Disbursed\", x.principal_repaid as \"Principal Repaid\", x.principal_outstanding as \"Principal Outstanding\", x.principal_overdue as \"Principal Overdue\",\r\nx.interest as \"Total Interest\", x.interest_repaid as \"Interest Repaid\", x.interest_outstanding as \"Interest Outstanding\", x.interest_overdue as \"Interest Overdue\",\r\nx.fees as \"Total Fees\", x.fees_repaid as \"Fees Repaid\", x.fees_outstanding as \"Fees Outstanding\", x.fees_overdue as \"Fees Overdue\",\r\nx.penalties as \"Total Penalties\", x.penalties_repaid as \"Penalties Repaid\", x.penalties_outstanding as \"Penalties Outstanding\", x.penalties_overdue as \"Penalties Overdue\",\r\n\r\n	(case\r\n	when ${parType} = 1 then\r\n    cast(round((x.principal_overdue * 100) / x.principal_outstanding, 2) as char)\r\n	when ${parType} = 2 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding), 2) as char)\r\n	when ${parType} = 3 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding), 2) as char)\r\n	when ${parType} = 4 then\r\n    cast(round(((x.principal_overdue + x.interest_overdue + x.fees_overdue + x.penalties_overdue) * 100) / (x.principal_outstanding + x.interest_outstanding + x.fees_outstanding + x.penalties_overdue), 2) as char)\r\n	else \"invalid PAR Type\"\r\n	end) as \"Portfolio at Risk %\"\r\n from m_office mo\r\njoin \r\n(select lastInstallment.branchId as branchId,\r\nlastInstallment.Currency,\r\ncount(distinct(lastInstallment.clientId)) as client_count, \r\ncount(distinct(lastInstallment.loanId)) as  active_loan_count,\r\ncount(distinct(if(r.duedate <= curdate(), \r\n		if(ifnull(r.principal_amount,0) -  ifnull(r.principal_completed_derived, 0),lastInstallment.loanId, null), null)  )) as principal_arrears_loan_count,\r\n\r\nsum(ifnull(r.principal_amount,0)) as principal,\r\nsum(ifnull(r.principal_completed_derived, 0)) as principal_repaid,\r\nsum(ifnull(r.principal_amount,0) - (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0))) as principal_outstanding,\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.principal_amount,0) -  (ifnull(r.principal_completed_derived, 0) + ifnull(r.principal_writtenoff_derived, 0)))\r\n            , 0)) as principal_overdue,\r\n\r\nsum(ifnull(r.interest_amount,0)) as interest,\r\nsum(ifnull(r.interest_completed_derived, 0)) as interest_repaid,\r\nsum(ifnull(r.interest_amount,0) -  (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0))) as interest_outstanding,\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.interest_amount,0) - (ifnull(r.interest_completed_derived, 0) + ifnull(r.interest_waived_derived, 0) + ifnull(r.interest_writtenoff_derived, 0)))\r\n            , 0)) as interest_overdue,\r\n\r\nsum(ifnull(r.fee_charges_amount,0)) as fees,\r\nsum(ifnull(r.fee_charges_completed_derived, 0)) as fees_repaid,\r\nsum(ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))  as fees_outstanding,\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.fee_charges_amount,0) - (ifnull(r.fee_charges_completed_derived, 0) + ifnull(r.fee_charges_waived_derived, 0) + ifnull(r.fee_charges_writtenoff_derived, 0)))\r\n            , 0)) as fees_overdue,\r\n\r\nsum(ifnull(r.penalty_charges_amount,0)) as penalties,\r\nsum(ifnull(r.penalty_charges_completed_derived, 0)) as penalties_repaid,\r\nsum(ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0))) as penalties_outstanding,\r\nsum(if(r.duedate <= curdate(), \r\n        (ifnull(r.penalty_charges_amount,0) - (ifnull(r.penalty_charges_completed_derived, 0) + ifnull(r.penalty_charges_waived_derived, 0) + ifnull(r.penalty_charges_writtenoff_derived, 0)))\r\n            , 0)) as penalties_overdue\r\n\r\nfrom \r\n(select l.id as loanId, l.number_of_repayments, min(r.installment), \r\nounder.id as branchId, ounder.hierarchy, ounder.`name` as branch, \r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nlo.display_name as \"Loan Officer\", c.id as clientId, c.account_no as \"Client Account No\",\r\nc.display_name as \"Client\", l.account_no as \"Loan Account No\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  l.principal_amount as \"Loan Amount\", \r\nl.annual_nominal_interest_rate as \"Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed\", date(l.expected_maturedon_date) as \"Expected Matured On\"\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.loan_status_id = 300\r\nand r.completed_derived is false\r\nand r.duedate >= curdate()\r\ngroup by l.id\r\nhaving l.number_of_repayments = min(r.installment)) lastInstallment\r\njoin m_loan_repayment_schedule r on r.loan_id = lastInstallment.loanId\r\ngroup by lastInstallment.branchId) x on x.branchId = mo.id\r\norder by mo.hierarchy, x.Currency','Individual Client \n\nReport',1,1),(59,'Active Loans by Disbursal Period','Table',NULL,'Loan','select concat(repeat(\"..\",   \r\n   ((LENGTH(ounder.`hierarchy`) - LENGTH(REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) as \"Office/Branch\",\r\nifnull(cur.display_symbol, l.currency_code) as Currency,\r\nc.account_no as \"Client Account No\", c.display_name as \"Client\", l.account_no as \"Loan Account No\", pl.`name` as \"Product\", \r\nf.`name` as Fund,  \r\nl.principal_amount as \"Loan Principal Amount\", \r\nl.annual_nominal_interest_rate as \" Annual Nominal Interest Rate\", \r\ndate(l.disbursedon_date) as \"Disbursed Date\", \r\n(sum(ifnull(r.principal_amount, 0))  + sum(ifnull(r.interest_amount, 0)) + \r\nsum(ifnull(r.fee_charges_amount, 0)) + sum(ifnull(r.penalty_charges_amount, 0))) as \"Total Loan (P+I+F+Pen)\",\r\n\r\n(sum(ifnull(r.principal_completed_derived, 0)) + sum(ifnull(r.interest_completed_derived, 0)) +\r\nsum(ifnull(r.fee_charges_completed_derived, 0)) + sum(ifnull(r.penalty_charges_completed_derived, 0))) as \"Total Repaid (P+I+F+Pen)\",\r\nlo.display_name as \"Loan Officer\"\r\n\r\nfrom m_office o \r\njoin m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r\nand ounder.hierarchy like concat(\'${currentUserHierarchy}\', \'%\')\r\njoin m_client c on c.office_id = ounder.id\r\njoin m_loan l on l.client_id = c.id\r\njoin m_product_loan pl on pl.id = l.product_id\r\nleft join m_staff lo on lo.id = l.loan_officer_id\r\nleft join m_currency cur on cur.code = l.currency_code\r\nleft join m_fund f on f.id = l.fund_id\r\nleft join m_loan_repayment_schedule r on r.loan_id = l.id\r\nwhere o.id = ${officeId}\r\nand (l.currency_code = \"${currencyId}\" or \"-1\" = \"${currencyId}\")\r\nand (l.product_id = \"${loanProductId}\" or \"-1\" = \"${loanProductId}\")\r\nand (ifnull(l.loan_officer_id, -10) = \"${loanOfficerId}\" or \"-1\" = \"${loanOfficerId}\")\r\nand (ifnull(l.fund_id, -10) = ${fundId} or -1 = ${fundId})\r\nand (ifnull(l.loanpurpose_cv_id, -10) = ${loanPurposeId} or -1 = ${loanPurposeId})\r\nand l.disbursedon_date between \'${startDate}\' and \'${endDate}\'\r\nand l.loan_status_id = 300\r\ngroup by l.id\r\norder by ounder.hierarchy, l.currency_code, c.account_no, l.account_no','Individual Client \n\nReport',1,1);
/*!40000 ALTER TABLE `stretchy_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stretchy_report_parameter`
--

DROP TABLE IF EXISTS `stretchy_report_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stretchy_report_parameter` (
  `report_id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `report_parameter_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`report_id`,`parameter_id`),
  UNIQUE KEY `report_id_name_UNIQUE` (`report_id`,`report_parameter_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stretchy_report_parameter`
--

LOCK TABLES `stretchy_report_parameter` WRITE;
/*!40000 ALTER TABLE `stretchy_report_parameter` DISABLE KEYS */;
INSERT INTO `stretchy_report_parameter` VALUES (1,5,NULL),(2,5,NULL),(2,6,NULL),(2,10,NULL),(2,20,NULL),(2,25,NULL),(2,26,NULL),(5,5,NULL),(5,6,NULL),(5,10,NULL),(5,20,NULL),(5,25,NULL),(5,26,NULL),(6,5,NULL),(6,6,NULL),(6,10,NULL),(6,20,NULL),(6,25,NULL),(6,26,NULL),(7,5,NULL),(7,6,NULL),(7,10,NULL),(7,20,NULL),(7,25,NULL),(7,26,NULL),(8,5,NULL),(8,6,NULL),(8,10,NULL),(8,25,NULL),(8,26,NULL),(11,5,NULL),(11,6,NULL),(11,10,NULL),(11,20,NULL),(11,25,NULL),(11,26,NULL),(11,100,NULL),(12,5,NULL),(12,6,NULL),(12,10,NULL),(12,20,NULL),(12,25,NULL),(12,26,NULL),(13,1,NULL),(13,2,NULL),(13,3,NULL),(13,5,NULL),(13,6,NULL),(13,10,NULL),(13,20,NULL),(13,25,NULL),(13,26,NULL),(14,1,NULL),(14,2,NULL),(14,3,NULL),(14,5,NULL),(14,6,NULL),(14,10,NULL),(14,20,NULL),(14,25,NULL),(14,26,NULL),(15,5,NULL),(15,6,NULL),(15,10,NULL),(15,20,NULL),(15,25,NULL),(15,26,NULL),(15,100,NULL),(16,5,NULL),(16,6,NULL),(16,10,NULL),(16,20,NULL),(16,25,NULL),(16,26,NULL),(16,100,NULL),(20,1,NULL),(20,2,NULL),(20,10,NULL),(20,20,NULL),(21,1,NULL),(21,2,NULL),(21,5,NULL),(21,10,NULL),(21,20,NULL),(48,5,'branch'),(48,2,'date'),(49,5,'branch'),(49,1,'fromDate'),(49,2,'toDate'),(50,5,'branch'),(50,1,'fromDate'),(50,2,'toDate'),(51,1,NULL),(51,2,NULL),(51,5,NULL),(51,10,NULL),(51,25,NULL),(52,5,NULL),(53,5,NULL),(54,1,NULL),(54,2,NULL),(54,5,NULL),(54,10,NULL),(54,25,NULL),(55,5,NULL),(55,6,NULL),(55,10,NULL),(55,20,NULL),(55,25,NULL),(55,26,NULL),(56,5,NULL),(56,6,NULL),(56,10,NULL),(56,20,NULL),(56,25,NULL),(56,26,NULL),(56,100,NULL),(57,5,NULL),(57,6,NULL),(57,10,NULL),(57,20,NULL),(57,25,NULL),(57,26,NULL),(58,5,NULL),(58,6,NULL),(58,10,NULL),(58,20,NULL),(58,25,NULL),(58,26,NULL),(58,100,NULL),(59,1,NULL),(59,2,NULL),(59,5,NULL),(59,6,NULL),(59,10,NULL),(59,20,NULL),(59,25,NULL),(59,26,NULL);
/*!40000 ALTER TABLE `stretchy_report_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_registered_table`
--

DROP TABLE IF EXISTS `x_registered_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_registered_table` (
  `registered_table_name` varchar(50) NOT NULL,
  `application_table_name` varchar(50) NOT NULL,
  PRIMARY KEY (`registered_table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_registered_table`
--

LOCK TABLES `x_registered_table` WRITE;
/*!40000 ALTER TABLE `x_registered_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `x_registered_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-02-27 23:27:19
