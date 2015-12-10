USE `ltb_api`;
-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server versie:                5.5.27 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Versie:              9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Structuur van  tabel ltb_dev.debug_record wordt geschreven
CREATE TABLE IF NOT EXISTS `debug_record` (
  `record_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` tinytext NOT NULL,
  `verify_code` tinytext NOT NULL,
  `time` int(11) NOT NULL,
  `message` text NOT NULL,
  `val1` text NOT NULL,
  `val2` text NOT NULL,
  `val3` text NOT NULL,
  KEY `record_id` (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporteren was gedeselecteerd


-- Structuur van  tabel ltb_dev.debug_session wordt geschreven
CREATE TABLE IF NOT EXISTS `debug_session` (
  `session_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `debug_code` tinytext NOT NULL,
  `verify_code` tinytext NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `user_id` tinytext NOT NULL,
  `version` tinytext NOT NULL,
  `app` tinyint(1) DEFAULT NULL,
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporteren was gedeselecteerd


-- Structuur van  tabel ltb_dev.debug_verify wordt geschreven
CREATE TABLE IF NOT EXISTS `debug_verify` (
  `verify_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `verify_code` tinytext NOT NULL,
  `start` int(11) DEFAULT NULL,
  `end` int(11) DEFAULT NULL,
  KEY `verify_id` (`verify_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporteren was gedeselecteerd


-- Structuur van  tabel ltb_dev.favourite wordt geschreven
CREATE TABLE IF NOT EXISTS `favourite` (
  `favourite_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fav_type` enum('stack') NOT NULL DEFAULT 'stack',
  `entity_code` varchar(10) NOT NULL,
  `entity_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`favourite_id`),
  UNIQUE KEY `Index 2` (`entity_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Keeping favourites of stacks for a certain user';

-- Data exporteren was gedeselecteerd


-- Structuur van  tabel ltb_dev.message wordt geschreven
CREATE TABLE IF NOT EXISTS `message` (
  `mess_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mess_code` varchar(10) DEFAULT NULL,
  `mess_type` enum('stack','user') NOT NULL,
  `subject` tinytext NOT NULL,
  `content` varchar(512) NOT NULL,
  `entity_code` varchar(10) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `user_code` varchar(10) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `owner_id` int(10) unsigned NOT NULL,
  `start` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`mess_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Keeping Messages for a stack or a specific user for a period of time';

-- Data exporteren was gedeselecteerd


-- Structuur van  tabel ltb_dev.message_read wordt geschreven
CREATE TABLE IF NOT EXISTS `message_read` (
  `read_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mess_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  KEY `main index` (`read_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Whether the message is read for example. This is data per user.';

-- Data exporteren was gedeselecteerd


-- Structuur van  tabel ltb_dev.profile wordt geschreven
CREATE TABLE IF NOT EXISTS `profile` (
  `profid` int(11) NOT NULL AUTO_INCREMENT,
  `profile_code` varchar(10) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `user_code` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `birthday` varchar(50) NOT NULL,
  `prof_nr` smallint(6) NOT NULL,
  `prof_nr_sub` smallint(6) DEFAULT '0',
  `partic_nr` int(11) DEFAULT NULL,
  `course_nr` smallint(6) DEFAULT NULL,
  `start_date` varchar(50) DEFAULT NULL,
  `end_date` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `stack_code` varchar(10) DEFAULT NULL,
  UNIQUE KEY `UniqueUserProfile` (`user_id`),
  KEY `autoincrement` (`profid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporteren was gedeselecteerd


-- Structuur van  tabel ltb_dev.stack wordt geschreven
CREATE TABLE IF NOT EXISTS `stack` (
  `stack_id` int(11) NOT NULL AUTO_INCREMENT,
  `stack_code` varchar(10) DEFAULT NULL,
  `name` text NOT NULL,
  `description` text,
  `owner_id` int(11) NOT NULL,
  `owner_code` varchar(10) DEFAULT NULL,
  `public` tinyint(4) NOT NULL DEFAULT '1',
  `details` text NOT NULL,
  `version` tinytext NOT NULL,
  `create_ts` int(10) NOT NULL,
  `update_ts` int(10) NOT NULL,
  PRIMARY KEY (`stack_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ALTER TABLE `stack`\r\n	ADD COLUMN `owner_code` VARCHAR(10) NULL AFTER `owner_id`;';

-- Data exporteren was gedeselecteerd


-- Structuur van  tabel ltb_dev.tag wordt geschreven
CREATE TABLE IF NOT EXISTS `tag` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag_type` enum('stack','tile') NOT NULL DEFAULT 'stack',
  `tag_txt` tinytext NOT NULL,
  `entity_id` int(10) unsigned NOT NULL,
  `owner_id` int(10) unsigned NOT NULL,
  `owner_code` varchar(10) DEFAULT NULL,
  `timestamp` int(10) unsigned NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `uniquetag` (`tag_type`,`tag_txt`(20),`entity_id`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tagging a stack or tile';

-- Data exporteren was gedeselecteerd


-- Structuur van  tabel ltb_dev.user wordt geschreven
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_code` varchar(10) DEFAULT '0',
  `oid_id` varchar(50) NOT NULL,
  `role` varchar(10) NOT NULL DEFAULT 'user',
  `name` text,
  `email` text NOT NULL,
  `username` tinytext NOT NULL,
  `expire` int(11) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The table to store user specific information';

-- Data exporteren was gedeselecteerd


-- Structuur van  tabel ltb_dev.user_session wordt geschreven
CREATE TABLE IF NOT EXISTS `user_session` (
  `oid_token` text NOT NULL,
  `oid_code` text NOT NULL,
  `refresh_token` text,
  `session_token` text NOT NULL,
  `user_id` text NOT NULL,
  `expire` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Storing logged in users to prevent too much traffic to OpenID server';

-- Data exporteren was gedeselecteerd
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
