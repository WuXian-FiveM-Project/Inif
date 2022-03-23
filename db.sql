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

-- 导出  表 wxs.garage 结构
CREATE TABLE IF NOT EXISTS `garage` (
  `GID` int(11) NOT NULL AUTO_INCREMENT,
  `GarageBlipName` text,
  `GarageBlipPosition` text COMMENT ' position = json.encode(vec3())',
  `GarageBlipSprite` int(11) DEFAULT NULL,
  `GarageBlipColour` int(11) DEFAULT NULL,
  `GarageGetVehicleMarkerPosition` text,
  `GarageGetVehicleMarkerType` int(11) DEFAULT NULL,
  `GarageGetVehicleMarkerColor` text,
  `GarageDisplayName` text,
  `GarageMaxVehicleCanStore` int(11) DEFAULT NULL,
  `GarageCostPerHours` float DEFAULT NULL,
  `GarageStoreVehicleMarkerPosition` text,
  `GarageStoreVehicleMarkerType` int(11) DEFAULT NULL,
  `GarageStoreVehicleMarkerColor` text,
  PRIMARY KEY (`GID`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.garage 的数据：1 rows
DELETE FROM `garage`;
/*!40000 ALTER TABLE `garage` DISABLE KEYS */;
INSERT INTO `garage` (`GID`, `GarageBlipName`, `GarageBlipPosition`, `GarageBlipSprite`, `GarageBlipColour`, `GarageGetVehicleMarkerPosition`, `GarageGetVehicleMarkerType`, `GarageGetVehicleMarkerColor`, `GarageDisplayName`, `GarageMaxVehicleCanStore`, `GarageCostPerHours`, `GarageStoreVehicleMarkerPosition`, `GarageStoreVehicleMarkerType`, `GarageStoreVehicleMarkerColor`) VALUES
	(1, '市中心停车场', '{"x":224.0,"y":-788.0,"z":31.0}', 524, 3, '{"x":214.2,"y":-808.75,"z":30}', 1, '{"r":255,"g":255,"b":255}', '市中心停车场', 12, 5, '{"x":209.94,"y":-805.2,"z":29.5}', 1, '{"r":255,"g":2,"b":2}');
/*!40000 ALTER TABLE `garage` ENABLE KEYS */;

-- 导出  表 wxs.garage_vehicle 结构
CREATE TABLE IF NOT EXISTS `garage_vehicle` (
  `VID` int(11) NOT NULL AUTO_INCREMENT,
  `VehicleGID` int(11) NOT NULL DEFAULT '0' COMMENT '车辆所在的Gid',
  `VehicleOwner` text COMMENT '玩家的steamId',
  `VehicleNickname` text,
  `VehicleModule` text,
  `VehicleParms` text,
  `VehiclePlate` text,
  `VehiclePosition` text COMMENT 'json.encode(vec3())',
  `VehicleHeading` double DEFAULT NULL,
  `StoreDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '存放日',
  PRIMARY KEY (`VID`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.garage_vehicle 的数据：1 rows
DELETE FROM `garage_vehicle`;
/*!40000 ALTER TABLE `garage_vehicle` DISABLE KEYS */;
INSERT INTO `garage_vehicle` (`VID`, `VehicleGID`, `VehicleOwner`, `VehicleNickname`, `VehicleModule`, `VehicleParms`, `VehiclePlate`, `VehiclePosition`, `VehicleHeading`, `StoreDate`) VALUES
	(18, 1, 'steam:11000013604b55c', 'vid71', 'BLISTA', '{"modOrnaments":-1,"modSpeakers":-1,"modFrame":-1,"color1":7,"wheelColor":156,"xenonColor":255,"modRearBumper":-1,"modStruts":-1,"tankHealth":999.7850952148438,"modGrille":-1,"modDial":-1,"tyreSmokeColor":[255,255,255],"neonEnabled":[false,false,false,false],"modAirFilter":-1,"modBrakes":-1,"modSideSkirt":-1,"modDoorSpeaker":-1,"modFender":-1,"fuelLevel":65.0,"modHorns":-1,"modVanityPlate":-1,"modLivery":-1,"modFrontBumper":-1,"modTrimA":-1,"modHydrolic":-1,"modSpoilers":-1,"modTransmission":-1,"modArchCover":-1,"pearlescentColor":5,"windowTint":-1,"modAerials":-1,"plateIndex":0,"wheels":0,"modDashboard":-1,"engineHealth":997.75,"modTurbo":false,"model":-344943009,"modTrimB":-1,"modFrontWheels":-1,"modAPlate":-1,"neonColor":[255,0,255],"modWindows":-1,"modHood":-1,"modBackWheels":-1,"modSeats":-1,"modSuspension":-1,"modSmokeEnabled":false,"modTrunk":-1,"modEngineBlock":-1,"plate":"29RSO271","modRoof":-1,"modPlateHolder":-1,"modEngine":-1,"modArmor":-1,"color2":0,"bodyHealth":998.0,"dirtLevel":6.0061912536621,"modSteeringWheel":-1,"extras":{"10":true,"12":false},"modTank":-1,"modExhaust":-1,"modShifterLeavers":-1,"modXenon":false,"modRightFender":-1}', '29RSO271', '{"x":219.5208740234375,"y":-795.7604370117188,"z":30.5941162109375}', 312.36700439453125, '2022-03-19 18:49:17'),
	(45, 1, 'steam:11000013604b55c', 'BLISTA', 'BLISTA', '{"modShifterLeavers":-1,"modDial":-1,"modRearBumper":-1,"modSuspension":-1,"modWindows":-1,"wheels":0,"modAirFilter":-1,"modStruts":-1,"modBackWheels":-1,"fuelLevel":65.0,"modSeats":-1,"modRoof":-1,"engineHealth":997.375,"modTrunk":-1,"bodyHealth":996.75,"dirtLevel":11.02772140502929,"modEngine":-1,"modRightFender":-1,"modHorns":-1,"modTurbo":false,"color2":0,"xenonColor":255,"modTrimA":-1,"modAPlate":-1,"modTrimB":-1,"modFrontWheels":-1,"modEngineBlock":-1,"modDoorSpeaker":-1,"neonColor":[255,0,255],"modArchCover":-1,"pearlescentColor":111,"wheelColor":156,"modFrame":-1,"modExhaust":-1,"modHydrolic":-1,"tankHealth":999.6746826171875,"modSteeringWheel":-1,"neonEnabled":[false,false,false,false],"modTank":-1,"modVanityPlate":-1,"modFender":-1,"modAerials":-1,"modDashboard":-1,"modXenon":false,"modBrakes":-1,"tyreSmokeColor":[255,255,255],"modFrontBumper":-1,"color1":6,"modLivery":-1,"modSpoilers":-1,"modHood":-1,"modSmokeEnabled":false,"plate":"83HNI872","model":-344943009,"modArmor":-1,"modOrnaments":-1,"modSpeakers":-1,"modPlateHolder":-1,"modGrille":-1,"extras":{"12":true,"10":false},"modTransmission":-1,"plateIndex":0,"modSideSkirt":-1,"windowTint":-1}', '83HNI872', '{"x":216.2356719970703,"y":-800.7844848632813,"z":30.61996078491211}', 62.362205505371094, '2022-03-23 16:28:35');
/*!40000 ALTER TABLE `garage_vehicle` ENABLE KEYS */;

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
  `Urine` float DEFAULT NULL,
  `Shit` float DEFAULT NULL,
  PRIMARY KEY (`PID`)
) ENGINE=MyISAM AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.player 的数据：1 rows
DELETE FROM `player`;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` (`PID`, `SteamID`, `Name`, `RegisterDate`, `MaxDensityCanHold`, `MaxItemCanHold`, `Satiety`, `Thirst`, `Tiredness`, `Urine`, `Shit`) VALUES
	(1000, 'steam:11000013604b55c', '10000', '2022-01-27 08:02:43', 10000000000, 100000000000, 995681, 992524, -2079.31, -996.71, -998.25);
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
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.player_items 的数据：3 rows
DELETE FROM `player_items`;
/*!40000 ALTER TABLE `player_items` DISABLE KEYS */;
INSERT INTO `player_items` (`IID`, `SteamID`, `ItemName`, `ItemAmount`, `ItemDensity`, `ItemAttachData`, `ItemPickUpDate`) VALUES
	(1, 'steam:11000013604b55c', 'water', 9927, 7941.6, 'null', '2022-01-28 17:15:53'),
	(2, 'steam:11000013604b55c', 'bread', 86, 8.6, '{"owner":"wdw"}', '2022-01-28 17:15:53'),
	(21, 'steam:11000013604b55c', 'money', 946839, 9468.39, '{"owner":"wdw"}', '2022-01-28 17:15:53');
/*!40000 ALTER TABLE `player_items` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
