/*
-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2014 年 02 月 17 日 10:39
-- 服务器版本: 5.5.35
-- PHP 版本: 5.3.10-1ubuntu3.9
*/

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `weibo`
--

-- --------------------------------------------------------
--
-- 表的结构 `t_atme`
--

CREATE TABLE IF NOT EXISTS `t_atme` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `wid` INT(10) UNSIGNED NOT NULL COMMENT '提到我的微博id',
  `uid` INT(10) UNSIGNED NOT NULL COMMENT '所属用户id',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `wid` (`wid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='at表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------
--
-- 表的结构 `t_collect`
--

CREATE TABLE IF NOT EXISTS `t_collect` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` INT(10) UNSIGNED NOT NULL COMMENT '收藏用户id',
  `time` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '收藏时间',
  `wid` INT(10) UNSIGNED NOT NULL COMMENT '收藏微博的id',
  PRIMARY KEY (`id`),
  KEY `wid` (`wid`),
  KEY `uid` (`uid`),
  KEY `time` (`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='收藏表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------
--
-- 表的结构 `t_comment`
--

CREATE TABLE IF NOT EXISTS `t_comment` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` INT(10) UNSIGNED NOT NULL COMMENT '评论用户uid',
  `content` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '评论内容',
  `time` INT(10) UNSIGNED NOT NULL COMMENT '评论时间',
  `wid` INT(10) UNSIGNED NOT NULL COMMENT '所属微博id',
  PRIMARY KEY (`id`),
  KEY `wid` (`wid`),
  KEY `uid` (`uid`),
  KEY `time` (`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='评论表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------
--
-- 表的结构 `t_follow`
--

CREATE TABLE IF NOT EXISTS `t_follow` (
  `follow` INT(10) UNSIGNED NOT NULL COMMENT '关注者ID',
  `fans` INT(10) UNSIGNED NOT NULL COMMENT '粉丝ID',
  `time` INT(10) UNSIGNED NOT NULL COMMENT '添加关注的时间',
  `source` CHAR(30) NOT NULL COMMENT '关注来源',
  `gid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '所属分组id',
  KEY `follow` (`follow`),
  KEY `fans` (`fans`),
  KEY `gid` (`gid`),
  KEY `time` (`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='关注和粉丝表';

-- --------------------------------------------------------
--
-- 表的结构 `t_group`
--

CREATE TABLE IF NOT EXISTS `t_group` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(63) NOT NULL DEFAULT '' COMMENT '分组名称',
  `uid` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='关注分组表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------
--
-- 表的结构 `t_letter`
--

CREATE TABLE IF NOT EXISTS `t_letter` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `from` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '发信用户id',
  `content` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '私信内容',
  `time` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '发件时间',
  `uid` INT(10) UNSIGNED NOT NULL COMMENT '收件人',
  PRIMARY KEY (`id`,`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='私信表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------
--
-- 表的结构 `t_picture`
--

-- CREATE TABLE IF NOT EXISTS `t_picture` (
--   `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
--   `picture` VARCHAR(128) NOT NULL DEFAULT '' COMMENT '微博配图的地址',
--   `visible` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '是否可见,用作删除',
--   `ctime` INT(10) UNSIGNED NOT NULL COMMENT '图片的原始创建时间',
--   `wid` INT(10) UNSIGNED NOT NULL COMMENT '所属微博wid',
--   `uid` INT(10) UNSIGNED NOT NULL COMMENT '所属用户的uid',
--   `md5` VARCHAR(40) NOT NULL COMMENT '图片的md5值，用于文件完整性检查',
--   `loc` VARCHAR(64) NOT NULL DEFAULT 'default' COMMENT '图片存储位置，用于扩展',
--   PRIMARY KEY (`id`),
--   KEY `wid` (`wid`),
--   KEY `uid` (`uid`)
-- ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='微博配图' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------
--
-- 表的结构 `t_praise`
--

CREATE TABLE IF NOT EXISTS `t_praise` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `uid` INT(10) UNSIGNED NOT NULL COMMENT '赞的用户id',
  `time` INT(10) UNSIGNED NOT NULL COMMENT '赞的时间戳',
  `wid` INT(10) UNSIGNED NOT NULL COMMENT '被赞的微博id',
  PRIMARY KEY (`id`),
  KEY `wid` (`wid`),
  KEY `uid` (`uid`),
  KEY `time` (`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='赞表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------
--
-- 表的结构 `t_routes`
-- 暂时未用

CREATE TABLE IF NOT EXISTS `t_routes` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug` VARCHAR(255) NOT NULL,
  `route` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='路由表' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------
--
-- 表的结构 `t_sessions`
--

CREATE TABLE IF NOT EXISTS `t_sessions` (
  `uid` INT(10) UNSIGNED NOT NULL COMMENT '用户的id',
  `last_activity` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上次登录时间',
  `session_id` CHAR(32) NOT NULL DEFAULT '0' COMMENT '计算用户的MD5',
  `imsi` VARCHAR(32) NOT NULL COMMENT '用户的手机imsi',
  `ip_address` VARCHAR(63) NOT NULL DEFAULT '0',
  `user_agent` VARCHAR(127) NOT NULL,
  `user_data` text NOT NULL COMMENT '按json格式，存储用户的数据信息',
  PRIMARY KEY (`session_id`),
  KEY `last_activity` (`last_activity`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登录信息表';

-- --------------------------------------------------------
--
-- 表的结构 `t_skin`
--

CREATE TABLE IF NOT EXISTS `t_skin` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `suit` INT(10) UNSIGNED DEFAULT '0' COMMENT '套装',
  `bg` INT(10) UNSIGNED DEFAULT '0' COMMENT '背景图',
  `cover` INT(10) UNSIGNED DEFAULT '0' COMMENT '顶部封面图',
  `style` INT(10) UNSIGNED DEFAULT '0' COMMENT 'css样式',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='皮肤表';

-- --------------------------------------------------------
--
-- 表的结构 `t_user`
-- 如果要合并user表，建议AUTO_INCREMENT=100配置为不同的

CREATE TABLE IF NOT EXISTS `t_user` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `regis_time` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '注册时间',
  `account` CHAR(32) NOT NULL DEFAULT '' COMMENT '用户帐号',
  `passwd` CHAR(128) NOT NULL DEFAULT '' COMMENT '用户密码',
  `lock` tinyINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否锁定（0不锁定、1锁定）',
  `vemail` tinyINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '邮箱验证(0未验证，1已验证)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户帐号表\n' AUTO_INCREMENT=100 ;

-- --------------------------------------------------------

--
-- 表的结构 `t_user_info`
--

CREATE TABLE IF NOT EXISTS `t_user_info` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `follow` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '关注数',
  `fans` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '粉丝数',
  `weibo` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '发表微博数',
  `uid` INT(10) UNSIGNED NOT NULL COMMENT 'user表的id',
  `username` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `truename` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `location` VARCHAR(63) NOT NULL DEFAULT '' COMMENT '居住地',
  `birthday` date NOT NULL COMMENT '生日(日期时间型)',
  `sex` enum('男','女','未知') NOT NULL DEFAULT '男' COMMENT '性别',
  `intro` VARCHAR(127) DEFAULT NULL COMMENT '一句话介绍自己',
  `avatar` VARCHAR(127) DEFAULT NULL COMMENT '头像(有180，50,30三个，图片名字相同，路径不同)',
  `extinfo` VARCHAR(255) DEFAULT NULL COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户信息表' AUTO_INCREMENT=100 ;

-- --------------------------------------------------------
--
-- 表的结构 `t_weibo`
--

CREATE TABLE IF NOT EXISTS `t_weibo` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `isturn` INT(10) NOT NULL DEFAULT '0' COMMENT '是否转发(0原创，否则记录转发的ID)',
  `iscomment` INT(10) NOT NULL DEFAULT '0' COMMENT '是否转发(0原创，否则记录评论的ID)',
  `time` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '发表时间',
  `praise` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '赞次数',
  `turn` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '转发次数',
  `collect` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '收藏次数',
  `comment` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '评论条数',
  `uid` INT(10) UNSIGNED NOT NULL COMMENT '所属用户id',
  `type` VARCHAR(16) NOT NULL DEFAULT '公开' COMMENT '微博类别',
  `content` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '微博内容',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `time` (`time`),
  KEY `prise` (`praise`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='微博表' AUTO_INCREMENT=100 ;

-- --------------------------------------------------------
-- 下面处理相册的数据表
--

-- --------------------------------------------------------
--
-- 收藏图片表 `t_favorites`
--

CREATE TABLE IF NOT EXISTS `t_img_favorites` (
  `uid` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `image_id` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `time` INT(10) UNSIGNED NOT NULL COMMENT '本记录创建时间',
  PRIMARY KEY (`uid`, `image_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='收藏表';

-- --------------------------------------------------------
--
-- 图片分类 `image_category`
--

CREATE TABLE IF NOT EXISTS `t_img_category` (
  `id` INT(10) UNSIGNED NOT NULL COMMENT 'id',
  `uid` INT(10) UNSIGNED NOT NULL COMMENT 'uid',
  `level` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '层级，最顶层为0',
  `parent` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '父id',
  `time` INT(10) UNSIGNED NOT NULL COMMENT '本记录创建时间',
  `activity` INT(10) UNSIGNED NOT NULL COMMENT '上次使用的时间，用来分类图片',
  `status` enum('public','private') NOT NULL DEFAULT 'public' COMMENT '公共/私有',
  `visible` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '是否可见,是否删除',
  `name` VARCHAR(127) NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` VARCHAR(255) COMMENT '描述',
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='图片分类表' AUTO_INCREMENT=1;


-- --------------------------------------------------------
--
-- 用户uid和图片image_id的对应关系
--

CREATE TABLE IF NOT EXISTS `t_image_uid` (
  `image_id` INT(10) UNSIGNED NOT NULL COMMENT '图片id',
  `uid` INT(10) UNSIGNED NOT NULL COMMENT '作者id',
  PRIMARY KEY (`image_id`,`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户图片绑定表' AUTO_INCREMENT=1;

-- --------------------------------------------------------
--
-- 图片表 `mypic_images`
-- 通过图片的md5来保证唯一性，
-- 创建默认的相册weibo

CREATE TABLE IF NOT EXISTS `t_images` (
  `id` INT(10) UNSIGNED NOT NULL COMMENT '图片id',
  `uid` INT(10) UNSIGNED NOT NULL COMMENT '创建人',
  `wid` INT(10) UNSINGED NOT NULL DEFAULT '0' COMMENT '关联的微搏id，没有则记录0',
  `filesize` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文件字节大小',
  `width` INT(10) UNSIGNED DEFAULT NULL COMMENT '原始图片宽度',
  `height` INT(10) UNSIGNED DEFAULT NULL COMMENT '原始图片高度',
  `twidth` INT(10) UNSIGNED DEFAULT NULL COMMENT '缩略图宽度',
  `theight` INT(10) UNSIGNED DEFAULT NULL COMMENT '缩略图高度',
  `ctime` INT(10) UNSIGNED NOT NULL COMMENT '图片的原始创建时间',
  `time` INT(10) UNSIGNED NOT NULL COMMENT '记录创建时间',
  `visible` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '是否可见,是否删除',
  `md5sum` CHAR(32) DEFAULT NULL COMMENT '图片唯一性检查',
  `save` VARCHAR(63) DEFAULT NULL COMMENT '原图的路径',
  `thumb` VARCHAR(63) DEFAULT NULL COMMENT '缩略图的路径',
  `postion` VARCHAR(63) DEFAULT NULL COMMENT '拍摄地址',
  `expand` VARCHAR(63) DEFAULT NULL COMMENT '存储扩展位置',
  `extension` VARCHAR(255) DEFAULT NULL COMMENT '扩展信息',
  PRIMARY KEY (`id`),
  KEY `ctime` (`ctime`),
  KEY `time` (`time`),
  KEY `wid` (`wid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='图片表' AUTO_INCREMENT=1;

-- --------------------------------------------------------
--
-- 图片和目录绑定关系 `t_image_category`
--

CREATE TABLE IF NOT EXISTS `t_image_category` (
  `image_id` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `category_id` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `uid` INT(10) UNSIGNED NOT NULL COMMENT '创建人',
  `time` INT(10) UNSIGNED NOT NULL COMMENT '创建或修改时间',
  PRIMARY KEY (`image_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='目录绑定表';

-- --------------------------------------------------------
--
-- image和tag的绑定关系 `t_image_tag`
--

CREATE TABLE IF NOT EXISTS `t_image_tag` (
  `image_id` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `tag_id` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `uid` INT(10) UNSIGNED NOT NULL COMMENT '创建人',
  `time` INT(10) UNSIGNED NOT NULL COMMENT '创建或修改时间',
  PRIMARY KEY (`image_id`,`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='标签绑定表';

-- --------------------------------------------------------
--
-- 标签表 `t_img_tags`
--

CREATE TABLE IF NOT EXISTS `t_img_tags` (
  `id` INT(10) UNSIGNED NOT NULL COMMENT 'tag的编号',
  `uid` INT(10) UNSIGNED NOT NULL COMMENT '创建人',
  `parent` INT(10) UNSIGNED NOT NULL COMMENT '父类别，支持分类',
  `time` INT(10) UNSIGNED NOT NULL COMMENT '创建或修改时间',
  `activity` INT(10) UNSIGNED NOT NULL COMMENT '上次使用的时间',
  `end` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '是否可选择，非end节点不可选择',
  `name` VARCHAR(127) NOT NULL DEFAULT '' COMMENT 'tag名称',
  PRIMARY KEY (`id`,`parent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='标签表' AUTO_INCREMENT=1;

-- --------------------------------------------------------
--
-- 评论表,对图片进行评论 `t_img_comments`
--

CREATE TABLE IF NOT EXISTS `t_img_comments` (
  `id` INT(10) UNSIGNED NOT NULL COMMENT '评论id',
  `image_id` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '评论的图片id',
  `time` INT(10) UNSIGNED NOT NULL COMMENT '评论的日期',
  `uid` INT(10) UNSIGNED DEFAULT NULL COMMENT '作者id',
  `visible` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '是否可见',
  `author` VARCHAR(64) DEFAULT NULL COMMENT '作者名字',
  `content` text COMMENT '评论内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='评论表' AUTO_INCREMENT=1;

-- --------------------------------------------------------
--
-- 足迹表
--

CREATE TABLE IF NOT EXISTS `t_footprint` (
  `id` INT(10) UNSIGNED NOT NULL COMMENT '评论id',
  `time` INT(10) UNSIGNED NOT NULL COMMENT '评论的日期',
  `uid` INT(10) UNSIGNED DEFAULT NULL COMMENT '作者id',
  `visible` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '是否可见',
  `author` VARCHAR(64) DEFAULT NULL COMMENT '作者名字',
  `content` text COMMENT '评论内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='评论表' AUTO_INCREMENT=1;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
