-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.26 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 导出 wxs 的数据库结构
CREATE DATABASE IF NOT EXISTS `wxs` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `wxs`;

-- 导出  表 wxs.bank_card 结构
CREATE TABLE IF NOT EXISTS `bank_card` (
  `CID` int(11) NOT NULL AUTO_INCREMENT,
  `OwnerSteamID` varchar(50) DEFAULT NULL,
  `CardID` text,
  `Password` text,
  `Money` double DEFAULT NULL,
  `RegisterDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`CID`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.bank_card 的数据：2 rows
DELETE FROM `bank_card`;
/*!40000 ALTER TABLE `bank_card` DISABLE KEYS */;
INSERT INTO `bank_card` (`CID`, `OwnerSteamID`, `CardID`, `Password`, `Money`, `RegisterDate`) VALUES
	(1, 'steam:11000013604b55c', '1234 5678 9101', '123', 999, '2022-03-10 12:30:16'),
	(2, 'steam:11000013604b55cd', '1234 5678 91011', '123', 1000, '2022-03-10 12:30:16');
/*!40000 ALTER TABLE `bank_card` ENABLE KEYS */;

-- 导出  表 wxs.player 结构
CREATE TABLE IF NOT EXISTS `player` (
  `PID` int(11) NOT NULL AUTO_INCREMENT,
  `SteamID` varchar(50) DEFAULT NULL,
  `Name` text,
  `RegisterDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `MaxDensityCanHold` float DEFAULT NULL COMMENT '背包最大重量',
  `MaxItemCanHold` float DEFAULT NULL COMMENT '背包最大物品數量',
  `Satiety` float DEFAULT NULL,
  `Thirst` float DEFAULT NULL,
  `Tiredness` float DEFAULT NULL,
  PRIMARY KEY (`PID`)
) ENGINE=MyISAM AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.player 的数据：1 rows
DELETE FROM `player`;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` (`PID`, `SteamID`, `Name`, `RegisterDate`, `MaxDensityCanHold`, `MaxItemCanHold`, `Satiety`, `Thirst`, `Tiredness`) VALUES
	(1, 'steam:11000013604b55c', '10000', '2022-01-27 08:02:43', 10000000000, 100000000000, 984.82, 973.7, 995.71);
/*!40000 ALTER TABLE `player` ENABLE KEYS */;

-- 导出  表 wxs.player_config 结构
CREATE TABLE IF NOT EXISTS `player_config` (
  `CID` int(11) NOT NULL AUTO_INCREMENT,
  `SteamID` varchar(50) DEFAULT NULL,
  `KeyName` text,
  `Value` text,
  PRIMARY KEY (`CID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.player_config 的数据：2 rows
DELETE FROM `player_config`;
/*!40000 ALTER TABLE `player_config` DISABLE KEYS */;
INSERT INTO `player_config` (`CID`, `SteamID`, `KeyName`, `Value`) VALUES
	(4, 'steam:11000013604b55c', 'test', '1'),
	(-5, 'steam:11000013604b55c', 'teset', 'daw');
/*!40000 ALTER TABLE `player_config` ENABLE KEYS */;

-- 导出  表 wxs.player_items 结构
CREATE TABLE IF NOT EXISTS `player_items` (
  `IID` int(11) NOT NULL AUTO_INCREMENT,
  `SteamID` varchar(50) DEFAULT NULL,
  `ItemName` text,
  `ItemAmount` int(11) DEFAULT NULL,
  `ItemDensity` float DEFAULT NULL COMMENT '單位：克',
  `ItemAttachData` text,
  `ItemPickUpDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.player_items 的数据：4 rows
DELETE FROM `player_items`;
/*!40000 ALTER TABLE `player_items` DISABLE KEYS */;
INSERT INTO `player_items` (`IID`, `SteamID`, `ItemName`, `ItemAmount`, `ItemDensity`, `ItemAttachData`, `ItemPickUpDate`) VALUES
	(1, 'steam:11000013604b55c', 'water', 9937, 993700, 'null', '2022-01-28 17:15:53'),
	(2, 'steam:11000013604b55c', 'bread', 10, 100, '{"owner":"wdw"}', '2022-01-28 17:15:53'),
	(23, 'steam:11000013604b55c', 'bank_card', 1, 0.01, '{"cardID":"1234 5678 9101"}', '2022-03-09 11:18:46'),
	(21, 'steam:11000013604b55c', 'money', 949564, 9495.64, '{"owner":"wdw"}', '2022-01-28 17:15:53');
/*!40000 ALTER TABLE `player_items` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
