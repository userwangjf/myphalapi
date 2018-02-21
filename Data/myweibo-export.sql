-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2018-02-22 00:35:35
-- 服务器版本： 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `myweibo`
--

-- --------------------------------------------------------

--
-- 表的结构 `t_atme`
--

CREATE TABLE IF NOT EXISTS `t_atme` (
`id` int(11) NOT NULL,
  `wid` int(10) unsigned NOT NULL COMMENT '提到我的微博id',
  `uid` int(10) unsigned NOT NULL COMMENT '所属用户id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='at表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `t_collect`
--

CREATE TABLE IF NOT EXISTS `t_collect` (
`id` int(11) NOT NULL,
  `uid` int(10) unsigned NOT NULL COMMENT '收藏用户id',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  `wid` int(10) unsigned NOT NULL COMMENT '收藏微博的id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='收藏表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `t_comment`
--

CREATE TABLE IF NOT EXISTS `t_comment` (
`id` int(11) NOT NULL,
  `uid` int(10) unsigned NOT NULL COMMENT '评论用户uid',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '评论内容',
  `time` int(10) unsigned NOT NULL COMMENT 'i评论时间',
  `wid` int(10) unsigned NOT NULL COMMENT '所属微博id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='评论表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `t_follow`
--

CREATE TABLE IF NOT EXISTS `t_follow` (
  `follow` int(10) unsigned NOT NULL COMMENT '关注者ID',
  `fans` int(10) unsigned NOT NULL COMMENT '粉丝ID',
  `time` int(10) unsigned NOT NULL COMMENT '添加关注的时间',
  `source` char(30) NOT NULL COMMENT '关注来源',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属分组id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='关注和粉丝表';

-- --------------------------------------------------------

--
-- 表的结构 `t_group`
--

CREATE TABLE IF NOT EXISTS `t_group` (
`id` int(10) unsigned NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '' COMMENT '分组名称',
  `uid` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='关注分组表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `t_letter`
--

CREATE TABLE IF NOT EXISTS `t_letter` (
`id` int(10) unsigned NOT NULL,
  `from` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发信用户id',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '私信内容',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发件时间',
  `uid` int(10) unsigned NOT NULL COMMENT '收件人'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='私信表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `t_picture`
--

CREATE TABLE IF NOT EXISTS `t_picture` (
`id` int(11) NOT NULL,
  `picture` varchar(128) NOT NULL DEFAULT '' COMMENT '微博配图的地址',
  `ctime` int(10) unsigned NOT NULL COMMENT '图片的原始创建时间',
  `wid` int(10) unsigned NOT NULL COMMENT '所属微博wid',
  `uid` int(10) unsigned NOT NULL COMMENT '所属用户的uid',
  `md5` varchar(40) NOT NULL COMMENT '图片的md5值，用于文件完整性检查',
  `loc` varchar(128) NOT NULL DEFAULT 'default' COMMENT '图片主存储位置，用于扩展'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='微博配图' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `t_picture`
--

INSERT INTO `t_picture` (`id`, `picture`, `ctime`, `wid`, `uid`, `md5`, `loc`) VALUES
(1, 'uploads/2018-02/1511703644-2aa4f03f22c95ed5.jpg', 1511703644, 1519255304, 101, 'd5e93acfe63ce6656d6e8bc90f9b2012', 'default'),
(2, 'uploads/2018-02/1511703645-74c741b50025573c.jpg', 1511703645, 1519255304, 101, '1fdaedd37b19fe95d7da409ba51bfbb4', 'default'),
(3, 'uploads/2018-02/1511703648-8012a6d825f17dec.jpg', 1511703648, 1519255304, 101, '7e7f78d7b36fdcaa4a9a815dc16f6e4f', 'default'),
(4, 'uploads/2018-02/1511703648-5037316623bd7f1e.jpg', 1511703648, 1519255304, 101, '2876fd2aca2422320ab39a1c81102519', 'default');

-- --------------------------------------------------------

--
-- 表的结构 `t_praise`
--

CREATE TABLE IF NOT EXISTS `t_praise` (
  `id` int(11) NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL,
  `wid` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='赞 表';

-- --------------------------------------------------------

--
-- 表的结构 `t_routes`
--

CREATE TABLE IF NOT EXISTS `t_routes` (
`id` int(9) unsigned NOT NULL,
  `slug` varchar(255) NOT NULL,
  `route` varchar(32) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- 表的结构 `t_sessions`
--

CREATE TABLE IF NOT EXISTS `t_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0' COMMENT '计算用户的MD5',
  `uid` int(10) unsigned NOT NULL COMMENT '用户的id',
  `imsi` varchar(32) NOT NULL COMMENT '用户的手机imsi',
  `ip_address` varchar(40) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上次登录时间',
  `user_data` text NOT NULL COMMENT '按json格式，存储用户的数据信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `t_sessions`
--

INSERT INTO `t_sessions` (`session_id`, `uid`, `imsi`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('0afe3594f9a8d2985b9a3239e9a99749', 100, '', '192.168.1.101', '', 1519255196, ''),
('5584245f43075740d3dec90b4472c729', 101, '', '192.168.1.101', '', 1519255231, '');

-- --------------------------------------------------------

--
-- 表的结构 `t_skin`
--

CREATE TABLE IF NOT EXISTS `t_skin` (
  `id` int(11) NOT NULL,
  `suit` tinyint(3) unsigned DEFAULT '0' COMMENT '套装',
  `bg` tinyint(3) unsigned DEFAULT '0' COMMENT '背景图',
  `cover` tinyint(3) unsigned DEFAULT '0' COMMENT '顶部封面图',
  `style` tinyint(3) unsigned DEFAULT '0' COMMENT 'css样式'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='皮肤表';

-- --------------------------------------------------------

--
-- 表的结构 `t_user`
--

CREATE TABLE IF NOT EXISTS `t_user` (
`id` int(10) unsigned NOT NULL,
  `account` char(20) NOT NULL DEFAULT '' COMMENT '用户帐号',
  `passwd` char(128) NOT NULL DEFAULT '' COMMENT '用户密码',
  `regis_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `lock` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否锁定（0不锁定、1锁定）',
  `vemail` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '邮箱验证(0未验证，1已验证)'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户帐号表\n' AUTO_INCREMENT=102 ;

--
-- 转存表中的数据 `t_user`
--

INSERT INTO `t_user` (`id`, `account`, `passwd`, `regis_time`, `lock`, `vemail`) VALUES
(100, 'admin', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 1519255179, 0, 1),
(101, 'wangjf', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 1519255214, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `t_user_info`
--

CREATE TABLE IF NOT EXISTS `t_user_info` (
`id` int(10) unsigned NOT NULL,
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `truename` varchar(32) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `location` varchar(64) NOT NULL DEFAULT '' COMMENT '居住地',
  `birthday` date NOT NULL COMMENT '生日(日期时间型)',
  `sex` enum('男','女','未知') NOT NULL DEFAULT '男' COMMENT '性别',
  `intro` varchar(128) NOT NULL DEFAULT '' COMMENT '一句话介绍自己',
  `avatar` varchar(128) NOT NULL DEFAULT '' COMMENT '头像(有180，50,30三个，图片名字相同，路径不同)',
  `domain` varchar(128) DEFAULT NULL COMMENT '个性域名',
  `style` varchar(64) NOT NULL DEFAULT '' COMMENT '模板风格',
  `follow` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关注数',
  `fans` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '粉丝数',
  `weibo` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发表微博数',
  `uid` int(10) unsigned NOT NULL COMMENT 'user表的id'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户信息表' AUTO_INCREMENT=102 ;

--
-- 转存表中的数据 `t_user_info`
--

INSERT INTO `t_user_info` (`id`, `username`, `truename`, `location`, `birthday`, `sex`, `intro`, `avatar`, `domain`, `style`, `follow`, `fans`, `weibo`, `uid`) VALUES
(100, 'admin', '贵姓', '保密', '2018-02-22', '未知', '一句话介绍自己', '', '', '', 0, 0, 0, 100),
(101, 'wangjf', '贵姓', '保密', '2018-02-22', '未知', '一句话介绍自己', '', '', '', 0, 0, 0, 101);

-- --------------------------------------------------------

--
-- 表的结构 `t_weibo`
--

CREATE TABLE IF NOT EXISTS `t_weibo` (
`id` int(10) unsigned NOT NULL,
  `wid` int(10) unsigned NOT NULL COMMENT '创建时间，用作多个表关联的id，避免表项时原id重复',
  `type` varchar(16) NOT NULL DEFAULT '公开' COMMENT '微博类别',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '微博内容',
  `isturn` int(11) NOT NULL DEFAULT '0' COMMENT '是否转发(0原创，否则记录转发的ID)',
  `iscomment` int(11) NOT NULL DEFAULT '0' COMMENT '是否转发(0原创，否则记录评论的ID)',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发表时间',
  `praise` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '赞次数',
  `turn` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '转发次数',
  `collect` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏次数',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论条数',
  `uid` int(10) unsigned NOT NULL COMMENT '所属用户id'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='微博表' AUTO_INCREMENT=2000 ;

--
-- 转存表中的数据 `t_weibo`
--

INSERT INTO `t_weibo` (`id`, `wid`, `type`, `content`, `isturn`, `iscomment`, `time`, `praise`, `turn`, `collect`, `comment`, `uid`) VALUES
(1000, 1519255304, '公开', '这个是图片帖子', 0, 0, 1519255304, 0, 0, 0, 0, 101),
(1001, 1519255571, '公开', '这个是空白帖子', 0, 0, 1519255571, 0, 0, 0, 0, 101);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `t_atme`
--
ALTER TABLE `t_atme`
 ADD PRIMARY KEY (`id`), ADD KEY `uid` (`uid`), ADD KEY `index3` (`wid`);

--
-- Indexes for table `t_collect`
--
ALTER TABLE `t_collect`
 ADD PRIMARY KEY (`id`), ADD KEY `wid` (`wid`), ADD KEY `uid` (`uid`);

--
-- Indexes for table `t_comment`
--
ALTER TABLE `t_comment`
 ADD PRIMARY KEY (`id`), ADD KEY `wid` (`wid`), ADD KEY `uid` (`uid`);

--
-- Indexes for table `t_follow`
--
ALTER TABLE `t_follow`
 ADD KEY `follow` (`follow`), ADD KEY `fans` (`fans`), ADD KEY `gid` (`gid`);

--
-- Indexes for table `t_group`
--
ALTER TABLE `t_group`
 ADD PRIMARY KEY (`id`), ADD KEY `uid` (`uid`);

--
-- Indexes for table `t_letter`
--
ALTER TABLE `t_letter`
 ADD PRIMARY KEY (`id`,`uid`), ADD KEY `uid` (`uid`);

--
-- Indexes for table `t_picture`
--
ALTER TABLE `t_picture`
 ADD PRIMARY KEY (`id`), ADD KEY `wid` (`wid`);

--
-- Indexes for table `t_praise`
--
ALTER TABLE `t_praise`
 ADD PRIMARY KEY (`id`), ADD KEY `wid` (`wid`), ADD KEY `index3` (`uid`);

--
-- Indexes for table `t_routes`
--
ALTER TABLE `t_routes`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_sessions`
--
ALTER TABLE `t_sessions`
 ADD PRIMARY KEY (`session_id`), ADD KEY `last_activity` (`last_activity`), ADD KEY `uid` (`uid`);

--
-- Indexes for table `t_skin`
--
ALTER TABLE `t_skin`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_user`
--
ALTER TABLE `t_user`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `account` (`account`);

--
-- Indexes for table `t_user_info`
--
ALTER TABLE `t_user_info`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `username` (`username`), ADD KEY `uid` (`uid`);

--
-- Indexes for table `t_weibo`
--
ALTER TABLE `t_weibo`
 ADD PRIMARY KEY (`id`), ADD KEY `uid` (`uid`), ADD KEY `wid` (`wid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `t_atme`
--
ALTER TABLE `t_atme`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `t_collect`
--
ALTER TABLE `t_collect`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `t_comment`
--
ALTER TABLE `t_comment`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `t_group`
--
ALTER TABLE `t_group`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `t_letter`
--
ALTER TABLE `t_letter`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `t_picture`
--
ALTER TABLE `t_picture`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `t_routes`
--
ALTER TABLE `t_routes`
MODIFY `id` int(9) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `t_user`
--
ALTER TABLE `t_user`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=102;
--
-- AUTO_INCREMENT for table `t_user_info`
--
ALTER TABLE `t_user_info`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=102;
--
-- AUTO_INCREMENT for table `t_weibo`
--
ALTER TABLE `t_weibo`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=102;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
