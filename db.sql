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

-- 导出  表 wxs.bank_account 结构
CREATE TABLE IF NOT EXISTS `bank_account` (
  `BID` int(11) NOT NULL AUTO_INCREMENT,
  `CardID` text,
  `CardBankName` text,
  `CardType` text,
  `CardOwnerSteamID` text,
  `CardHolderFirstName` text,
  `CardHolderSecondName` text,
  `CardHolderTelephoneNumber` text,
  `CardBalance` double DEFAULT NULL,
  `CardPassword` text,
  `CardExpiryDate` timestamp NULL DEFAULT NULL,
  `CardRegisterDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`BID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.bank_account 的数据：2 rows
DELETE FROM `bank_account`;
/*!40000 ALTER TABLE `bank_account` DISABLE KEYS */;
INSERT INTO `bank_account` (`BID`, `CardID`, `CardBankName`, `CardType`, `CardOwnerSteamID`, `CardHolderFirstName`, `CardHolderSecondName`, `CardHolderTelephoneNumber`, `CardBalance`, `CardPassword`, `CardExpiryDate`, `CardRegisterDate`) VALUES
	(1, '1234 5678 9101 1112', '无限银行⫗', '储蓄卡', 'steam:11000013604b55c', 'Luo', 'Rui Long', '51014215', 996, 'sacps', '2027-03-24 21:58:00', '2022-03-24 21:57:26'),
	(3, '1234 5678 9101 1113', '无限银行⫗', '储蓄卡', 'steam:110000118bb2e96', 'E', 'VO', '10', 504, '123', '2027-03-26 21:58:00', '2022-03-26 21:57:26');
/*!40000 ALTER TABLE `bank_account` ENABLE KEYS */;

-- 导出  表 wxs.bank_log 结构
CREATE TABLE IF NOT EXISTS `bank_log` (
  `TID` int(11) NOT NULL AUTO_INCREMENT,
  `Source` text COMMENT '交易发起人',
  `Commit` tinytext COMMENT '注释',
  `Amount` double DEFAULT NULL,
  `Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`TID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.bank_log 的数据：0 rows
DELETE FROM `bank_log`;
/*!40000 ALTER TABLE `bank_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_log` ENABLE KEYS */;

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
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.garage_vehicle 的数据：2 rows
DELETE FROM `garage_vehicle`;
/*!40000 ALTER TABLE `garage_vehicle` DISABLE KEYS */;
INSERT INTO `garage_vehicle` (`VID`, `VehicleGID`, `VehicleOwner`, `VehicleNickname`, `VehicleModule`, `VehicleParms`, `VehiclePlate`, `VehiclePosition`, `VehicleHeading`, `StoreDate`) VALUES
	(67, 1, 'steam:11000013604b55c', 'SURGE', 'SURGE', '{"modBrakes":-1,"modEngineBlock":-1,"modTank":-1,"windowTint":-1,"modDoorSpeaker":-1,"modGrille":-1,"modAirFilter":-1,"modArchCover":-1,"modRearBumper":-1,"modStruts":-1,"color2":0,"modFrame":-1,"wheels":0,"modHorns":-1,"plateIndex":0,"modVanityPlate":-1,"modTrunk":-1,"engineHealth":999.3112182617188,"modSmokeEnabled":false,"modTurbo":false,"color1":0,"plate":"00TYP073","modArmor":-1,"modSpoilers":-1,"modTransmission":-1,"modXenon":false,"modWindows":-1,"modShifterLeavers":-1,"modSteeringWheel":-1,"modFrontBumper":-1,"neonColor":[255,0,255],"modPlateHolder":-1,"modAPlate":-1,"modHydrolic":-1,"pearlescentColor":74,"modSpeakers":-1,"fuelLevel":0.0,"modExhaust":-1,"xenonColor":255,"modSideSkirt":-1,"dirtLevel":5.04960680007934,"tyreSmokeColor":[255,255,255],"modRoof":-1,"bodyHealth":999.5408325195313,"modFrontWheels":-1,"wheelColor":156,"modSuspension":-1,"neonEnabled":[false,false,false,false],"modSeats":-1,"modRightFender":-1,"modAerials":-1,"modTrimA":-1,"modBackWheels":-1,"modHood":-1,"modFender":-1,"modEngine":-1,"modDashboard":-1,"modTrimB":-1,"modOrnaments":-1,"extras":{"11":true,"10":false},"modLivery":-1,"tankHealth":999.9541015625,"modDial":-1,"model":-1894894188}', '00TYP073', '{"x":214.16542053222657,"y":-784.0848999023438,"z":30.56171989440918}', 68.031494140625, '2022-03-24 13:15:54'),
	(69, 1, 'steam:11000013604b55c', 'BRIOSO', 'BRIOSO', '{"modTrunk":-1,"modDoorSpeaker":-1,"model":1549126457,"wheels":5,"modTank":-1,"modHorns":-1,"modRightFender":-1,"plate":"61WSL441","modSmokeEnabled":false,"extras":[],"modAerials":-1,"modShifterLeavers":-1,"modHood":-1,"modHydrolic":-1,"modStruts":-1,"modVanityPlate":-1,"modRoof":-1,"modAirFilter":-1,"modDial":-1,"neonEnabled":[false,false,false,false],"modSuspension":-1,"modAPlate":-1,"modFender":-1,"modLivery":-1,"wheelColor":92,"modFrontBumper":-1,"xenonColor":255,"modArmor":-1,"modRearBumper":-1,"modFrontWheels":-1,"modBrakes":-1,"modTrimA":-1,"modEngine":-1,"modWindows":-1,"tankHealth":999.7820434570313,"modEngineBlock":-1,"windowTint":-1,"modGrille":-1,"modSideSkirt":-1,"modTrimB":-1,"modXenon":false,"plateIndex":0,"dirtLevel":4.0411696434021,"engineHealth":998.5,"modExhaust":-1,"color2":0,"modFrame":-1,"modDashboard":-1,"modSteeringWheel":-1,"modSeats":-1,"modPlateHolder":-1,"modOrnaments":-1,"modArchCover":-1,"neonColor":[255,0,255],"modTurbo":false,"modTransmission":-1,"fuelLevel":65.0,"modSpoilers":-1,"tyreSmokeColor":[255,255,255],"bodyHealth":998.6265869140625,"modBackWheels":-1,"pearlescentColor":55,"color1":50,"modSpeakers":-1}', '61WSL441', '{"x":219.4604949951172,"y":-766.2594604492188,"z":30.0228271484375}', 65.19685363769531, '2022-03-29 14:22:21');
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
  `LastPosition` text,
  PRIMARY KEY (`PID`)
) ENGINE=MyISAM AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.player 的数据：2 rows
DELETE FROM `player`;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` (`PID`, `SteamID`, `Name`, `RegisterDate`, `MaxDensityCanHold`, `MaxItemCanHold`, `Satiety`, `Thirst`, `Tiredness`, `Urine`, `Shit`, `LastPosition`) VALUES
	(1000, 'steam:11000013604b55c', '10000', '2022-01-27 08:02:43', 10000000000, 100000000000, 986683, 976936, -5854.99, 92.74, 54.83, '{"x":19.04175949096679,"y":-1113.204345703125,"z":29.819091796875}'),
	(1001, 'steam:110000118bb2e96', '10000', '2022-01-27 08:02:43', 10000000000, 100000000000, 995244, 991797, -2257.33, -254.47, -557.77, NULL);
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
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.player_items 的数据：7 rows
DELETE FROM `player_items`;
/*!40000 ALTER TABLE `player_items` DISABLE KEYS */;
INSERT INTO `player_items` (`IID`, `SteamID`, `ItemName`, `ItemAmount`, `ItemDensity`, `ItemAttachData`, `ItemPickUpDate`) VALUES
	(1, 'steam:11000013604b55c', 'water', 9928, 7942.4, 'null', '2022-01-28 17:15:53'),
	(2, 'steam:11000013604b55c', 'bread', 79, 7.9, 'null', '2022-01-28 17:15:53'),
	(36, 'steam:11000013604b55c', '1_phone', 1, 100, 'null', '2022-04-09 18:15:30'),
	(30, 'steam:110000118bb2e96', '3_bank_card', 1, 1, '{}', '2022-03-30 14:01:32'),
	(32, 'steam:11000013604b55c', '1_bank_card', 1, 1, 'null', '2022-04-03 17:09:38'),
	(26, 'steam:11000013604b55c', 'money', 49890, 498.9, 'null', '2022-01-28 17:15:53'),
	(21, 'steam:110000118bb2e96', 'money', 944384, 9443.84, 'null', '2022-01-28 17:15:53');
/*!40000 ALTER TABLE `player_items` ENABLE KEYS */;

-- 导出  表 wxs.player_phone 结构
CREATE TABLE IF NOT EXISTS `player_phone` (
  `PID` int(11) NOT NULL AUTO_INCREMENT,
  `PhonePassword` text,
  `PhoneModule` text,
  `PhoneSetting` text COMMENT 'json of setting',
  `PhoneApps` text COMMENT 'json of app array',
  `PhoneData` text,
  `PhoneRegisterDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PhoneMaxCapacity` bigint(20) DEFAULT NULL COMMENT '手机最大存储（kb',
  `PhoneCurrentCapacity` bigint(20) DEFAULT NULL COMMENT '当前存储使用量',
  PRIMARY KEY (`PID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.player_phone 的数据：1 rows
DELETE FROM `player_phone`;
/*!40000 ALTER TABLE `player_phone` DISABLE KEYS */;
INSERT INTO `player_phone` (`PID`, `PhonePassword`, `PhoneModule`, `PhoneSetting`, `PhoneApps`, `PhoneData`, `PhoneRegisterDate`, `PhoneMaxCapacity`, `PhoneCurrentCapacity`) VALUES
	(1, '123', 'iPhone X', '{"PhoneSetting":{"DarkMode":true}}', '[\r\n    {\r\n        "IsSystemApp":true,\r\n        "IsAppOverride":true,\r\n        "AppName":"应用商店",\r\n        "AppPackageName":"com.system.store",\r\n        "IsUploadToGooglePlay":true,\r\n        "IsPaySoftware":false,\r\n        "AppVersion":"1.0.0",\r\n        "AppUrl":"nui://wx_appstore/index.html",\r\n        "AppAuthor":"服主",\r\n        "IsUploadToAppStore":true,\r\n        "AppAuthorAuthor":"",\r\n        "AppIcon":"https://upload.wikimedia.org/wikipedia/commons/5/55/Google_Play_2016_icon.svg",\r\n        "AppSize":113000,\r\n        "AppPrice":0,\r\n        "AppDescription":"应用商店"\r\n    }\r\n]', '{}', '2022-04-13 09:49:50', 128000000, 226000);
/*!40000 ALTER TABLE `player_phone` ENABLE KEYS */;

-- 导出  表 wxs.shop_item 结构
CREATE TABLE IF NOT EXISTS `shop_item` (
  `IID` int(11) NOT NULL AUTO_INCREMENT,
  `ItemDisplayName` text,
  `ItemName` text,
  `ItemPrice` double DEFAULT NULL,
  `ItemDiscountPrice` double DEFAULT NULL,
  `ItemOnSale` tinyint(4) DEFAULT NULL COMMENT '1=true,0=false',
  `ItemType` text,
  `ItemCanSale` tinyint(4) DEFAULT NULL COMMENT '1=true,0=false',
  `ItemInStock` int(11) DEFAULT NULL,
  `ItemImage` longtext COMMENT 'html src',
  PRIMARY KEY (`IID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- 正在导出表  wxs.shop_item 的数据：3 rows
DELETE FROM `shop_item`;
/*!40000 ALTER TABLE `shop_item` DISABLE KEYS */;
INSERT INTO `shop_item` (`IID`, `ItemDisplayName`, `ItemName`, `ItemPrice`, `ItemDiscountPrice`, `ItemOnSale`, `ItemType`, `ItemCanSale`, `ItemInStock`, `ItemImage`) VALUES
	(1, '测试物品(仅测试时使用，如果在正式服发现请告诉我（其实就是我忘了XDD）', '1_bank_card', 1000, 50000, 1, '测试', 1, 100, 'https://i.ytimg.com/vi/ubnLs5A5KFc/maxresdefault.jpg'),
	(2, '面包', 'bread', 1000, 10, 1, '食品', 1, 100, 'https://i.ytimg.com/vi/ubnLs5A5KFc/maxresdefault.jpg'),
	(3, '水', 'water', 1000, 50000, 1, '食品', 1, 100, 'https://i.ytimg.com/vi/ubnLs5A5KFc/maxresdefault.jpg');
/*!40000 ALTER TABLE `shop_item` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
