
-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2018-03-01 00:29:25
-- 服务器版本： 10.1.13-MariaDB
-- PHP Version: 5.6.23

--
-- Database: `mypic`
--

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

-- 
-- 收藏表 `mypic_favorites`
-- 

CREATE TABLE IF NOT EXISTS `mypic_favorites` (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `image_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`, `image_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='收藏表';

-- 
-- 图片分类 `mypic_category`
-- 

CREATE TABLE IF NOT EXISTS `mypic_category` (
  `id` smallint(8) UNSIGNED NOT NULL COMMENT 'id',
  `name` varchar(127) NOT NULL DEFAULT '' COMMENT '分类名称',
  `parent` smallint(5) UNSIGNED DEFAULT NULL COMMENT '父类型',
  `description` varchar(255) COMMENT '描述',
  `status` enum('public','private') NOT NULL DEFAULT 'public' COMMENT '公共/私有',
  `visible` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '是否可见,是否删除',
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='图片分类表' AUTO_INCREMENT=1;

-- 
-- 图片表 `mypic_images`
-- 

CREATE TABLE IF NOT EXISTS `mypic_images` (
  `id` mediumint(8) UNSIGNED NOT NULL COMMENT '图片id',
  `md5sum` char(32) DEFAULT NULL COMMENT '图片唯一性检查',
  `uid` mediumint(8) UNSIGNED NOT NULL COMMENT '作者id',
  `author` varchar(127) DEFAULT NULL COMMENT '作者名字',
  `url` varchar(127) DEFAULT NULL COMMENT '原图的路径',
  `thumb` varchar(127) DEFAULT NULL COMMENT '缩略图的路径',
  `filesize` mediumint(9) UNSIGNED DEFAULT NULL,
  `width` smallint(9) UNSIGNED DEFAULT NULL,
  `height` smallint(9) UNSIGNED DEFAULT NULL,
  `postion` varchar(127) DEFAULT NULL COMMENT '地点',
  `extension` varchar(255) DEFAULT NULL COMMENT '扩展信息',
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='图片表' AUTO_INCREMENT=1;



-- 
-- 图片和目录绑定关系 `mypic_image_category`
-- 

CREATE TABLE IF NOT EXISTS `mypic_image_category` (
  `image_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `category_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`image_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='目录绑定表';

-- 
-- image和tag的绑定关系 `mypic_image_tag`
-- 

CREATE TABLE IF NOT EXISTS `mypic_image_tag` (
  `image_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `tag_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`image_id`,`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='标签绑定表';

-- 
-- 标签表 `mypic_tags`
-- 

CREATE TABLE IF NOT EXISTS `mypic_tags` (
  `id` smallint(5) UNSIGNED NOT NULL COMMENT 'tag的编号',
  `end` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '是否可选择，非end节点不可选择',
  `name` varchar(127) NOT NULL DEFAULT '' COMMENT 'tag名称',
  `parent` smallint(5) UNSIGNED NOT NULL COMMENT '父类别，支持分类',
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`parent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='标签表' AUTO_INCREMENT=1;

-- 
-- 评论表,对图片进行评论 `mypic_comments`
-- 

CREATE TABLE IF NOT EXISTS `mypic_comments` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '评论id',
  `image_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '评论的图片id',
  `author` varchar(255) DEFAULT NULL COMMENT '作者名字',
  `author_id` mediumint(8) UNSIGNED DEFAULT NULL COMMENT '作者id',
  `content` longtext COMMENT '评论内容',
  `visible` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '是否可见',
  `date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '评论的日期',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='评论表' AUTO_INCREMENT=1;

-- --------------------------------------------------------
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

