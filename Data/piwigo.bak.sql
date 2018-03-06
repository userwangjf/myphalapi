
-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2018-03-01 00:29:25
-- 服务器版本： 10.1.13-MariaDB
-- PHP Version: 5.6.23

--
-- Database: `grally`
--

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 收藏表 `_favorites`
--

CREATE TABLE `piwigo_favorites` (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `image_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`, `image_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 图片分类 `_categories`
--

CREATE TABLE `piwigo_categories` (
  `id` smallint(8) UNSIGNED NOT NULL COMMENT 'id',
  `name` varchar(127) NOT NULL DEFAULT '' COMMENT '分类名称',
  `parent` smallint(5) UNSIGNED DEFAULT NULL COMMENT '父类型',
  `description` varchar(255) COMMENT '描述',
  `status` enum('public','private') NOT NULL DEFAULT 'public' COMMENT '公共/私有',
  `visible` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '是否可见,是否删除',
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- 图片和tag id的绑定关系
-- 

CREATE TABLE `piwigo_image_tag` (
  `image_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `tag_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0'
  PRIMARY KEY (`image_id`,`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 图片表 `_images`
-- 

CREATE TABLE `piwigo_images` (
  `id` mediumint(8) UNSIGNED NOT NULL COMMENT '图片id',
  `md5sum` char(32) DEFAULT NULL COMMENT '图片唯一性检查',
  `type` char(32) DEFAULT NULL COMMENT '图片特殊标记,比如：位置:xxx,',
  `uid` mediumint(8) UNSIGNED NOT NULL COMMENT '作者id',
  `author` varchar(127) DEFAULT NULL COMMENT '作者名字',
  `url` varchar(127) DEFAULT NULL COMMENT '原图的路径',
  `thumb` varchar(127) DEFAULT NULL COMMENT '缩略图的路径',
  `lastaccessed` COMMENT '访问时间',
  `filesize` mediumint(9) UNSIGNED DEFAULT NULL,
  `width` smallint(9) UNSIGNED DEFAULT NULL,
  `height` smallint(9) UNSIGNED DEFAULT NULL,
  `postion` varchar(127) DEFAULT NULL COMMENT '地点',
  `extension` longtext COMMENT '扩展信息',
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 图片和目录绑定关系 `piwigo_image_category`
--

CREATE TABLE `piwigo_image_category` (
  `image_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `category_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0'
  PRIMARY KEY (`image_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- image和tag的绑定关系 `piwigo_image_tag`
--

CREATE TABLE `piwigo_image_tag` (
  `image_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `tag_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0'
  PRIMARY KEY (`image_id`,`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 
-- tag表 `_tags`
-- 

CREATE TABLE `piwigo_tags` (
  `id` smallint(5) UNSIGNED NOT NULL COMMENT 'tag的编号',
  `end` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '是否可选择，非end节点不可选择',
  `name` varchar(127) NOT NULL DEFAULT '' COMMENT 'tag名称',
  `parent` smallint(5) UNSIGNED NOT NULL COMMENT '父类别，支持分类',
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  PRIMARY KEY (`id`,`parent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 评论表,对图片进行评论 `piwigo_comments`
-- 

CREATE TABLE `piwigo_comments` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '评论id',
  `image_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '评论的图片id',
  `author` varchar(255) DEFAULT NULL COMMENT '作者名字',
  `author_id` mediumint(8) UNSIGNED DEFAULT NULL COMMENT '作者id',
  `content` longtext COMMENT '评论内容',
  `visible` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '是否可见',
  `date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '评论的日期'
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


-- --------------------------------------------------------

-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2018-03-01 00:29:25
-- 服务器版本： 10.1.13-MariaDB
-- PHP Version: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `piwigo`
--

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_caddie`
--

CREATE TABLE `piwigo_caddie` (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `element_id` mediumint(8) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_caddie`
--

INSERT INTO `piwigo_caddie` (`user_id`, `element_id`) VALUES
(1, 13);

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_categories`
--
-- 图片分类
-- my design
CREATE TABLE `piwigo_categories` (
  `id` smallint(8) UNSIGNED NOT NULL COMMENT 'id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '分类名称',
  `id_uppercat` smallint(5) UNSIGNED DEFAULT NULL COMMENT '父类型',
  `description` text COMMENT '描述',
  `status` enum('public','private') NOT NULL DEFAULT 'public' COMMENT '公共/私有',
  `visible` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '是否可见,是否删除',
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `piwigo_categories` (
  `id` smallint(5) UNSIGNED NOT NULL COMMENT 'id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '分类名称',
  `id_uppercat` smallint(5) UNSIGNED DEFAULT NULL COMMENT '父类型',
  `comment` text COMMENT '描述',
  `dir` varchar(255) DEFAULT NULL,
  `rank` smallint(5) UNSIGNED DEFAULT NULL,
  `status` enum('public','private') NOT NULL DEFAULT 'public',
  `site_id` tinyint(4) UNSIGNED DEFAULT NULL,
  `visible` enum('true','false') NOT NULL DEFAULT 'true',
  `representative_picture_id` mediumint(8) UNSIGNED DEFAULT NULL,
  `uppercats` varchar(255) NOT NULL DEFAULT '',
  `commentable` enum('true','false') NOT NULL DEFAULT 'true',
  `global_rank` varchar(255) DEFAULT NULL,
  `image_order` varchar(128) DEFAULT NULL,
  `permalink` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_categories`
--

INSERT INTO `piwigo_categories` (`id`, `name`, `id_uppercat`, `comment`, `dir`, `rank`, `status`, `site_id`, `visible`, `representative_picture_id`, `uppercats`, `commentable`, `global_rank`, `image_order`, `permalink`, `lastmodified`) VALUES
(1, '测试', NULL, NULL, NULL, 2, 'public', NULL, 'true', 1, '1', 'true', '2', NULL, NULL, '2018-02-28 23:26:09'),
(2, '测试2', NULL, NULL, NULL, 1, 'public', NULL, 'true', 13, '2', 'true', '1', NULL, NULL, '2018-02-28 23:26:12');

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_comments`
--
-- 评论表

CREATE TABLE `piwigo_comments` (
  `id` int(11) UNSIGNED NOT NULL,
  `image_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `author` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `author_id` mediumint(8) UNSIGNED DEFAULT NULL,
  `anonymous_id` varchar(45) NOT NULL,
  `website_url` varchar(255) DEFAULT NULL,
  `content` longtext,
  `validated` enum('true','false') NOT NULL DEFAULT 'false',
  `validation_date` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_config`
--

CREATE TABLE `piwigo_config` (
  `param` varchar(40) NOT NULL DEFAULT '',
  `value` text,
  `comment` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='configuration table';

--
-- 转存表中的数据 `piwigo_config`
--

INSERT INTO `piwigo_config` (`param`, `value`, `comment`) VALUES
('activate_comments', 'true', 'Global parameter for usage of comments system'),
('nb_comment_page', '10', 'number of comments to display on each page'),
('log', 'true', 'keep an history of visits on your website'),
('comments_validation', 'false', 'administrators validate users comments before becoming visible'),
('comments_forall', 'false', 'even guest not registered can post comments'),
('comments_order', 'ASC', 'comments order on picture page and cie'),
('comments_author_mandatory', 'false', 'Comment author is mandatory'),
('comments_email_mandatory', 'false', 'Comment email is mandatory'),
('comments_enable_website', 'true', 'Enable "website" field on add comment form'),
('user_can_delete_comment', 'false', 'administrators can allow user delete their own comments'),
('user_can_edit_comment', 'false', 'administrators can allow user edit their own comments'),
('email_admin_on_comment_edition', 'false', 'Send an email to the administrators when a comment is modified'),
('email_admin_on_comment_deletion', 'false', 'Send an email to the administrators when a comment is deleted'),
('gallery_locked', 'false', 'Lock your gallery temporary for non admin users'),
('gallery_title', '另一个崭新的Piwigo图库', 'Title at top of each page and for RSS feed'),
('rate', 'false', 'Rating pictures feature is enabled'),
('rate_anonymous', 'true', 'Rating pictures feature is also enabled for visitors'),
('page_banner', '<h1>%gallery_title%</h1>\n\n<p>欢迎来到我的相册</p>', 'html displayed on the top each page of your gallery'),
('history_admin', 'false', 'keep a history of administrator visits on your website'),
('history_guest', 'true', 'keep a history of guest visits on your website'),
('allow_user_registration', 'true', 'allow visitors to register?'),
('allow_user_customization', 'true', 'allow users to customize their gallery?'),
('nb_categories_page', '12', 'Param for categories pagination'),
('nbm_send_html_mail', 'true', 'Send mail on HTML format for notification by mail'),
('nbm_send_mail_as', '', 'Send mail as param value for notification by mail'),
('nbm_send_detailed_content', 'true', 'Send detailed content for notification by mail'),
('nbm_complementary_mail_content', '', 'Complementary mail content for notification by mail'),
('nbm_send_recent_post_dates', 'true', 'Send recent post by dates for notification by mail'),
('email_admin_on_new_user', 'false', 'Send an email to theadministrators when a user registers'),
('email_admin_on_comment', 'false', 'Send an email to the administrators when a valid comment is entered'),
('email_admin_on_comment_validation', 'true', 'Send an email to the administrators when a comment requires validation'),
('obligatory_user_mail_address', 'false', 'Mail address is obligatory for users'),
('c13y_ignore', 'a:2:{s:7:"version";s:5:"2.9.3";s:4:"list";a:0:{}}', 'List of ignored anomalies'),
('extents_for_templates', 'a:0:{}', 'Actived template-extension(s)'),
('blk_menubar', '', 'Menubar options'),
('menubar_filter_icon', 'false', 'Display filter icon'),
('index_sort_order_input', 'true', 'Display image order selection list'),
('index_flat_icon', 'false', 'Display flat icon'),
('index_posted_date_icon', 'true', 'Display calendar by posted date'),
('index_created_date_icon', 'true', 'Display calendar by creation date icon'),
('index_slideshow_icon', 'true', 'Display slideshow icon'),
('index_new_icon', 'true', 'Display new icons next albums and pictures'),
('picture_metadata_icon', 'true', 'Display metadata icon on picture page'),
('picture_slideshow_icon', 'true', 'Display slideshow icon on picture page'),
('picture_favorite_icon', 'true', 'Display favorite icon on picture page'),
('picture_download_icon', 'true', 'Display download icon on picture page'),
('picture_navigation_icons', 'true', 'Display navigation icons on picture page'),
('picture_navigation_thumb', 'true', 'Display navigation thumbnails on picture page'),
('picture_menu', 'false', 'Show menubar on picture page'),
('picture_informations', 'a:11:{s:6:"author";b:1;s:10:"created_on";b:1;s:9:"posted_on";b:1;s:10:"dimensions";b:0;s:4:"file";b:0;s:8:"filesize";b:0;s:4:"tags";b:1;s:10:"categories";b:1;s:6:"visits";b:1;s:12:"rating_score";b:1;s:13:"privacy_level";b:1;}', 'Information displayed on picture page'),
('week_starts_on', 'monday', 'Monday may not be the first day of the week'),
('updates_ignored', 'a:3:{s:7:"plugins";a:0:{}s:6:"themes";a:0:{}s:9:"languages";a:0:{}}', 'Extensions ignored for update'),
('order_by', 'ORDER BY date_available DESC, file ASC, id ASC', 'default photo order'),
('order_by_inside_category', 'ORDER BY date_available DESC, file ASC, id ASC', 'default photo order inside category'),
('original_resize', 'false', NULL),
('original_resize_maxwidth', '2016', NULL),
('original_resize_maxheight', '2016', NULL),
('original_resize_quality', '95', NULL),
('mobile_theme', 'smartpocket', NULL),
('mail_theme', 'clear', NULL),
('picture_sizes_icon', 'true', NULL),
('index_sizes_icon', 'true', NULL),
('index_edit_icon', 'true', NULL),
('index_caddie_icon', 'true', NULL),
('picture_edit_icon', 'true', NULL),
('picture_caddie_icon', 'true', NULL),
('picture_representative_icon', 'true', NULL),
('secret_key', 'c5005dc0aafd80c08d4850d66f6018c3', 'a secret key specific to the gallery for internal use'),
('piwigo_db_version', '2.9', NULL),
('smartpocket', 'a:2:{s:4:"loop";b:1;s:8:"autohide";i:5000;}', NULL),
('data_dir_checked', '1', NULL),
('derivatives', 'a:4:{s:1:"d";a:9:{s:6:"square";O:16:"DerivativeParams":3:{s:13:"last_mod_time";i:1519859816;s:6:"sizing";O:12:"SizingParams":3:{s:10:"ideal_size";a:2:{i:0;i:120;i:1;i:120;}s:8:"max_crop";i:1;s:8:"min_size";a:2:{i:0;i:120;i:1;i:120;}}s:7:"sharpen";i:0;}s:5:"thumb";O:16:"DerivativeParams":3:{s:13:"last_mod_time";i:1519859816;s:6:"sizing";O:12:"SizingParams":3:{s:10:"ideal_size";a:2:{i:0;i:144;i:1;i:144;}s:8:"max_crop";i:0;s:8:"min_size";N;}s:7:"sharpen";i:0;}s:6:"2small";O:16:"DerivativeParams":3:{s:13:"last_mod_time";i:1519859816;s:6:"sizing";O:12:"SizingParams":3:{s:10:"ideal_size";a:2:{i:0;i:240;i:1;i:240;}s:8:"max_crop";i:0;s:8:"min_size";N;}s:7:"sharpen";i:0;}s:6:"xsmall";O:16:"DerivativeParams":3:{s:13:"last_mod_time";i:1519859816;s:6:"sizing";O:12:"SizingParams":3:{s:10:"ideal_size";a:2:{i:0;i:432;i:1;i:324;}s:8:"max_crop";i:0;s:8:"min_size";N;}s:7:"sharpen";i:0;}s:5:"small";O:16:"DerivativeParams":3:{s:13:"last_mod_time";i:1519859816;s:6:"sizing";O:12:"SizingParams":3:{s:10:"ideal_size";a:2:{i:0;i:576;i:1;i:432;}s:8:"max_crop";i:0;s:8:"min_size";N;}s:7:"sharpen";i:0;}s:6:"medium";O:16:"DerivativeParams":3:{s:13:"last_mod_time";i:1519859816;s:6:"sizing";O:12:"SizingParams":3:{s:10:"ideal_size";a:2:{i:0;i:792;i:1;i:594;}s:8:"max_crop";i:0;s:8:"min_size";N;}s:7:"sharpen";i:0;}s:5:"large";O:16:"DerivativeParams":3:{s:13:"last_mod_time";i:1519859816;s:6:"sizing";O:12:"SizingParams":3:{s:10:"ideal_size";a:2:{i:0;i:1008;i:1;i:756;}s:8:"max_crop";i:0;s:8:"min_size";N;}s:7:"sharpen";i:0;}s:6:"xlarge";O:16:"DerivativeParams":3:{s:13:"last_mod_time";i:1519859816;s:6:"sizing";O:12:"SizingParams":3:{s:10:"ideal_size";a:2:{i:0;i:1224;i:1;i:918;}s:8:"max_crop";i:0;s:8:"min_size";N;}s:7:"sharpen";i:0;}s:7:"xxlarge";O:16:"DerivativeParams":3:{s:13:"last_mod_time";i:1519859816;s:6:"sizing";O:12:"SizingParams":3:{s:10:"ideal_size";a:2:{i:0;i:1656;i:1;i:1242;}s:8:"max_crop";i:0;s:8:"min_size";N;}s:7:"sharpen";i:0;}}s:1:"q";i:95;s:1:"w";O:15:"WatermarkParams":7:{s:4:"file";s:0:"";s:8:"min_size";a:2:{i:0;i:500;i:1;i:500;}s:4:"xpos";i:50;s:4:"ypos";i:50;s:7:"xrepeat";i:0;s:7:"yrepeat";i:0;s:7:"opacity";i:100;}s:1:"c";a:0:{}}', NULL),
('elegant', 'a:3:{s:11:"p_main_menu";s:2:"on";s:12:"p_pict_descr";s:2:"on";s:14:"p_pict_comment";s:3:"off";}', NULL),
('update_notify_last_check', '2018-03-01T00:17:00+01:00', NULL),
('no_photo_yet', 'false', NULL);

-- --------------------------------------------------------

--

--
-- 表的结构 `piwigo_groups`
--

CREATE TABLE `piwigo_groups` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `is_default` enum('true','false') NOT NULL DEFAULT 'false',
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_group_access`
--

CREATE TABLE `piwigo_group_access` (
  `group_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `cat_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_history`
--

CREATE TABLE `piwigo_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL DEFAULT '1970-01-01',
  `time` time NOT NULL DEFAULT '00:00:00',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `IP` varchar(15) NOT NULL DEFAULT '',
  `section` enum('categories','tags','search','list','favorites','most_visited','best_rated','recent_pics','recent_cats') DEFAULT NULL,
  `category_id` smallint(5) DEFAULT NULL,
  `tag_ids` varchar(50) DEFAULT NULL,
  `image_id` mediumint(8) DEFAULT NULL,
  `image_type` enum('picture','high','other') DEFAULT NULL,
  `format_id` int(11) UNSIGNED DEFAULT NULL,
  `auth_key_id` int(11) UNSIGNED DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_history_summary`
--

CREATE TABLE `piwigo_history_summary` (
  `year` smallint(4) NOT NULL DEFAULT '0',
  `month` tinyint(2) DEFAULT NULL,
  `day` tinyint(2) DEFAULT NULL,
  `hour` tinyint(2) DEFAULT NULL,
  `nb_pages` int(11) DEFAULT NULL,
  `history_id_from` int(10) UNSIGNED DEFAULT NULL,
  `history_id_to` int(10) UNSIGNED DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_images`
-- 图片表
-- 

CREATE TABLE `piwigo_images` (
  `id` mediumint(8) UNSIGNED NOT NULL COMMENT '图片id',
  `md5sum` char(32) DEFAULT NULL COMMENT '图片唯一性检查',
  `type` char(32) DEFAULT NULL COMMENT '图片特殊标记,比如：位置:xxx,',
  `uid` mediumint(8) UNSIGNED NOT NULL COMMENT '作者id',
  `author` varchar(127) DEFAULT NULL COMMENT '作者名字',
  `url` varchar(127) DEFAULT NULL COMMENT '原图的路径',
  `thumb` varchar(1270 DEFAULT NULL COMMENT '缩略图的路径',
  `lastaccessed` COMMENT '访问时间',
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `piwigo_images` (
  `id` mediumint(8) UNSIGNED NOT NULL COMMENT '图片id',
  `file` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_available` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `date_creation` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `comment` text,
  `author` varchar(255) DEFAULT NULL,
  `hit` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `filesize` mediumint(9) UNSIGNED DEFAULT NULL,
  `width` smallint(9) UNSIGNED DEFAULT NULL,
  `height` smallint(9) UNSIGNED DEFAULT NULL,
  `coi` char(4) DEFAULT NULL COMMENT 'center of interest',
  `representative_ext` varchar(4) DEFAULT NULL,
  `date_metadata_update` date DEFAULT NULL,
  `rating_score` float(5,2) UNSIGNED DEFAULT NULL,
  `path` varchar(255) NOT NULL DEFAULT '',
  `storage_category_id` smallint(5) UNSIGNED DEFAULT NULL,
  `level` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `md5sum` char(32) DEFAULT NULL,
  `added_by` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `rotation` tinyint(3) UNSIGNED DEFAULT NULL,
  `latitude` double(8,6) DEFAULT NULL,
  `longitude` double(9,6) DEFAULT NULL,
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_images`
--

INSERT INTO `piwigo_images` (`id`, `file`, `date_available`, `date_creation`, `name`, `comment`, `author`, `hit`, `filesize`, `width`, `height`, `coi`, `representative_ext`, `date_metadata_update`, `rating_score`, `path`, `storage_category_id`, `level`, `md5sum`, `added_by`, `rotation`, `latitude`, `longitude`, `lastmodified`) VALUES
(1, '1F524114R6-13.jpg', '2018-03-01 07:23:50', NULL, '1F524114R6-13', NULL, NULL, 0, 2314, 3840, 2160, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072350-2fec345b.jpg', NULL, 0, '2fec345b0d3fac657bc566da822773aa', 1, 0, NULL, NULL, '2018-02-28 23:23:50'),
(2, '13179846_1345796441965.jpg', '2018-03-01 07:23:52', NULL, '13179846 1345796441965', NULL, NULL, 0, 627, 1920, 1080, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072352-aebb5a31.jpg', NULL, 0, 'aebb5a313749ac1d7d31cd39d62f30fa', 1, 0, NULL, NULL, '2018-02-28 23:23:52'),
(3, 'Picture_01_Shark.jpg', '2018-03-01 07:23:52', '2014-11-04 14:35:29', 'Picture 01 Shark', NULL, NULL, 0, 448, 720, 1280, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072352-d0702c40.jpg', NULL, 0, 'd0702c40f2a744e7b60294e76be04630', 1, 0, NULL, NULL, '2018-02-28 23:23:52'),
(4, 'Picture_02_Imagination.jpg', '2018-03-01 07:23:53', '2014-11-03 14:35:29', 'Picture 02 Imagination', NULL, NULL, 0, 628, 720, 1280, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072353-a901a7cc.jpg', NULL, 0, 'a901a7cc7007a8c3c632e0cf6086fa92', 1, 0, NULL, NULL, '2018-02-28 23:23:53'),
(5, 'Picture_03_Eiffel.jpg', '2018-03-01 07:23:53', '2014-11-02 14:35:29', 'Picture 03 Eiffel', NULL, NULL, 0, 379, 720, 1280, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072353-cf2a3cac.jpg', NULL, 0, 'cf2a3cacdd4c8f5cc8e85d1e972164ea', 1, 0, NULL, NULL, '2018-02-28 23:23:53'),
(6, 'Picture_04_Lake.jpg', '2018-03-01 07:23:54', '2014-10-31 14:35:29', 'Picture 04 Lake', NULL, NULL, 0, 712, 720, 1280, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072354-880a1563.jpg', NULL, 0, '880a1563a74763f7490a132f124b0355', 1, 0, NULL, NULL, '2018-02-28 23:23:54'),
(7, 'Picture_05_Structure.jpg', '2018-03-01 07:23:55', '2014-10-29 14:35:29', 'Picture 05 Structure', NULL, NULL, 0, 598, 720, 1280, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072355-dc5e2bcf.jpg', NULL, 0, 'dc5e2bcfc14cf4a3bddb235346437f0f', 1, 0, NULL, NULL, '2018-02-28 23:23:55'),
(8, 'Picture_06_Space.jpg', '2018-03-01 07:23:55', '2014-10-28 14:35:29', 'Picture 06 Space', NULL, NULL, 0, 1177, 720, 1280, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072355-393b6194.jpg', NULL, 0, '393b6194367c3656cdd73cafaf7e410f', 1, 0, NULL, NULL, '2018-02-28 23:23:55'),
(9, 'Picture_07_Quiet.jpg', '2018-03-01 07:23:56', '2014-10-27 14:35:29', 'Picture 07 Quiet', NULL, NULL, 0, 685, 720, 1280, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072356-8ce19e6b.jpg', NULL, 0, '8ce19e6bcfef5fc9515a1dfca030976a', 1, 0, NULL, NULL, '2018-02-28 23:23:56'),
(10, 'Picture_08_Meadow.jpg', '2018-03-01 07:23:57', '2014-10-26 14:35:29', 'Picture 08 Meadow', NULL, NULL, 0, 901, 720, 1280, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072357-c9e12b9a.jpg', NULL, 0, 'c9e12b9a2f7ed5b9921b2bd4a7404ab6', 1, 0, NULL, NULL, '2018-02-28 23:23:57'),
(11, 'Picture_09_Stone.jpg', '2018-03-01 07:23:57', '2014-10-24 14:35:29', 'Picture 09 Stone', NULL, NULL, 0, 499, 720, 1280, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072357-c93774a9.jpg', NULL, 0, 'c93774a9c03211f21e54910a24e29f0a', 1, 0, NULL, NULL, '2018-02-28 23:23:57'),
(12, 'Picture_10_Camera.jpg', '2018-03-01 07:23:57', '2014-10-20 14:35:29', 'Picture 10 Camera', NULL, NULL, 0, 424, 720, 1280, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072357-3164193d.jpg', NULL, 0, '3164193de040f384e570fd6c26e6d79b', 1, 0, NULL, NULL, '2018-02-28 23:23:57'),
(13, 'Picture_11_Taste.jpg', '2018-03-01 07:23:58', '2014-10-19 14:35:29', 'Picture 11 Taste', NULL, NULL, 2, 771, 720, 1280, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072358-c525eae4.jpg', NULL, 0, 'c525eae44e160956399767550fec45f0', 1, 0, NULL, NULL, '2018-02-28 23:23:58'),
(14, 'Picture_12_Leopard.jpg', '2018-03-01 07:23:58', '2014-10-16 14:35:29', 'Picture 12 Leopard', NULL, NULL, 1, 253, 720, 1280, NULL, NULL, '2018-03-01', NULL, './upload/2018/03/01/20180301072358-cb6c8eaf.jpg', NULL, 0, 'cb6c8eafe1643e7eb0ccf47780450201', 1, 0, NULL, NULL, '2018-02-28 23:23:59');

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_image_category`
--

CREATE TABLE `piwigo_image_category` (
  `image_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `category_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `rank` mediumint(8) UNSIGNED DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_image_category`
--

INSERT INTO `piwigo_image_category` (`image_id`, `category_id`, `rank`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 1, 11),
(12, 1, 12),
(13, 1, 13),
(14, 1, 14),
(13, 2, 1);

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_image_format`
--

CREATE TABLE `piwigo_image_format` (
  `format_id` int(11) UNSIGNED NOT NULL,
  `image_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `ext` varchar(255) NOT NULL,
  `filesize` mediumint(9) UNSIGNED DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_image_tag`
--

CREATE TABLE `piwigo_image_tag` (
  `image_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `tag_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_languages`
--

CREATE TABLE `piwigo_languages` (
  `id` varchar(64) NOT NULL DEFAULT '',
  `version` varchar(64) NOT NULL DEFAULT '0',
  `name` varchar(64) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_languages`
--

INSERT INTO `piwigo_languages` (`id`, `version`, `name`) VALUES
('af_ZA', '2.9.3', 'Afrikaans [ZA]'),
('es_AR', '2.9.3', 'Argentina [AR]'),
('az_AZ', '2.9.3', 'Azərbaycanca [AZ]'),
('id_ID', '2.9.3', 'Bahasa Indonesia [ID]'),
('pt_BR', '2.9.3', 'Brasil [BR]'),
('br_FR', '2.9.3', 'Brezhoneg [FR]'),
('ca_ES', '2.9.3', 'Català [CA]'),
('da_DK', '2.9.3', 'Dansk [DK]'),
('de_DE', '2.9.3', 'Deutsch [DE]'),
('dv_MV', '2.9.3', 'Dhivehi [MV]'),
('en_GB', '2.9.3', 'English [GB]'),
('en_UK', '2.9.3', 'English [UK]'),
('en_US', '2.9.3', 'English [US]'),
('es_ES', '2.9.3', 'Español [ES]'),
('eo_EO', '2.9.3', 'Esperanto [EO]'),
('et_EE', '2.9.3', 'Estonian [EE]'),
('eu_ES', '2.9.3', 'Euskara [ES]'),
('fi_FI', '2.9.3', 'Finnish [FI]'),
('fr_FR', '2.9.3', 'Français [FR]'),
('fr_CA', '2.9.3', 'Français [QC]'),
('ga_IE', '2.9.3', 'Gaeilge [IE]'),
('gl_ES', '2.9.3', 'Galego [ES]'),
('hr_HR', '2.9.3', 'Hrvatski [HR]'),
('it_IT', '2.9.3', 'Italiano [IT]'),
('lv_LV', '2.9.3', 'Latviešu [LV]'),
('lt_LT', '2.9.3', 'Lietuviu [LT]'),
('lb_LU', '2.9.3', 'Lëtzebuergesch [LU]'),
('hu_HU', '2.9.3', 'Magyar [HU]'),
('ms_MY', '2.9.3', 'Malay [MY]'),
('es_MX', '2.9.3', 'México [MX]'),
('nl_NL', '2.9.3', 'Nederlands [NL]'),
('nb_NO', '2.9.3', 'Norsk bokmål [NO]'),
('nn_NO', '2.9.3', 'Norwegian nynorsk [NO]'),
('pl_PL', '2.9.3', 'Polski [PL]'),
('pt_PT', '2.9.3', 'Português [PT]'),
('ro_RO', '2.9.3', 'Română [RO]'),
('sk_SK', '2.9.3', 'Slovensky [SK]'),
('sl_SI', '2.9.3', 'Slovenšcina [SI]'),
('sh_RS', '2.9.3', 'Srpski [SR]'),
('sv_SE', '2.9.3', 'Svenska [SE]'),
('vi_VN', '2.9.3', 'Tiếng Việt [VN]'),
('tr_TR', '2.9.3', 'Türkçe [TR]'),
('wo_SN', '2.9.3', 'Wolof [SN]'),
('is_IS', '2.9.3', 'Íslenska [IS]'),
('cs_CZ', '2.9.3', 'Česky [CZ]'),
('el_GR', '2.9.3', 'Ελληνικά [GR]'),
('bg_BG', '2.9.3', 'Български [BG]'),
('mk_MK', '2.9.3', 'Македонски [MK]'),
('mn_MN', '2.9.3', 'Монгол [MN]'),
('ru_RU', '2.9.3', 'Русский [RU]'),
('sr_RS', '2.9.3', 'Српски [SR]'),
('uk_UA', '2.9.3', 'Українська [UA]'),
('he_IL', '2.9.3', 'עברית [IL]'),
('ar_EG', '2.9.3', 'العربية (مصر) [EG]'),
('ar_SA', '2.9.3', 'العربية [AR]'),
('ar_MA', '2.9.3', 'العربية [MA]'),
('fa_IR', '2.9.3', 'پارسی [IR]'),
('kok_IN', '2.9.3', 'कोंकणी [IN]'),
('bn_IN', '2.9.3', 'বাংলা[IN]'),
('gu_IN', '2.9.3', 'ગુજરાતી[IN]'),
('ta_IN', '2.9.3', 'தமிழ் [IN]'),
('kn_IN', '2.9.3', 'ಕನ್ನಡ [IN]'),
('th_TH', '2.9.3', 'ภาษาไทย [TH]'),
('ka_GE', '2.9.3', 'ქართული [GE]'),
('km_KH', '2.9.3', 'ខ្មែរ [KH]'),
('zh_TW', '2.9.3', '中文 (繁體) [TW]'),
('zh_HK', '2.9.3', '中文 (香港) [HK]'),
('ja_JP', '2.9.3', '日本語 [JP]'),
('zh_CN', '2.9.3', '简体中文 [CN]'),
('ko_KR', '2.9.3', '한국어 [KR]');

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_old_permalinks`
--

CREATE TABLE `piwigo_old_permalinks` (
  `cat_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `permalink` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_deleted` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `last_hit` datetime DEFAULT NULL,
  `hit` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_plugins`
--

CREATE TABLE `piwigo_plugins` (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `state` enum('inactive','active') NOT NULL DEFAULT 'inactive',
  `version` varchar(64) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_plugins`
--

INSERT INTO `piwigo_plugins` (`id`, `state`, `version`) VALUES
('TakeATour', 'active', '2.9.3');

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_rate`
--

CREATE TABLE `piwigo_rate` (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `element_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `anonymous_id` varchar(45) NOT NULL DEFAULT '',
  `rate` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  `date` date NOT NULL DEFAULT '1970-01-01'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_search`
--

CREATE TABLE `piwigo_search` (
  `id` int(10) UNSIGNED NOT NULL,
  `last_seen` date DEFAULT NULL,
  `rules` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_sessions`
--

CREATE TABLE `piwigo_sessions` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `data` mediumtext NOT NULL,
  `expiration` datetime NOT NULL DEFAULT '1970-01-01 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_sessions`
--

INSERT INTO `piwigo_sessions` (`id`, `data`, `expiration`) VALUES
('7F00uotmf9djoi2bqjhslnk7mdvtq5', 'pwg_uid|i:1;pwg_device|s:7:"desktop";pwg_mobile_theme|b:0;need_update2.9.3|b:0;extensions_need_update|a:0:{}bulk_manager_filter|a:1:{s:9:"prefilter";s:6:"caddie";}incompatible_plugins|a:1:{s:10:"~~expire~~";i:1519860429;}pwg_referer_image_id|s:2:"13";pwg_show_metadata|i:1;', '2018-03-01 07:27:12');

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_sites`
--

CREATE TABLE `piwigo_sites` (
  `id` tinyint(4) NOT NULL,
  `galleries_url` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_sites`
--

INSERT INTO `piwigo_sites` (`id`, `galleries_url`) VALUES
(1, './galleries/');

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_tags`
--

-- tag id
CREATE TABLE `piwigo_tags` (
  `id` smallint(5) UNSIGNED NOT NULL COMMENT 'tag的编号',
  `name` varchar(127) NOT NULL DEFAULT '' COMMENT 'tag名称',
  `parent` smallint(5) UNSIGNED NOT NULL COMMENT '父类别，支持分类',
  `url_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `piwigo_tags` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `url_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_tags`
--

INSERT INTO `piwigo_tags` (`id`, `name`, `url_name`, `lastmodified`) VALUES
(1, '人物', '人物', '2018-02-28 23:26:48'),
(2, '地点', '地点', '2018-02-28 23:27:12');

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_themes`
--

CREATE TABLE `piwigo_themes` (
  `id` varchar(64) NOT NULL DEFAULT '',
  `version` varchar(64) NOT NULL DEFAULT '0',
  `name` varchar(64) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_themes`
--

INSERT INTO `piwigo_themes` (`id`, `version`, `name`) VALUES
('elegant', '2.9.3', 'elegant'),
('smartpocket', '2.9.3', 'Smart Pocket');

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_upgrade`
--

CREATE TABLE `piwigo_upgrade` (
  `id` varchar(20) NOT NULL DEFAULT '',
  `applied` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `description` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_upgrade`
--

INSERT INTO `piwigo_upgrade` (`id`, `applied`, `description`) VALUES
('61', '2018-03-01 07:16:51', 'upgrade included in installation'),
('62', '2018-03-01 07:16:51', 'upgrade included in installation'),
('63', '2018-03-01 07:16:51', 'upgrade included in installation'),
('64', '2018-03-01 07:16:51', 'upgrade included in installation'),
('65', '2018-03-01 07:16:51', 'upgrade included in installation'),
('66', '2018-03-01 07:16:51', 'upgrade included in installation'),
('67', '2018-03-01 07:16:51', 'upgrade included in installation'),
('68', '2018-03-01 07:16:51', 'upgrade included in installation'),
('69', '2018-03-01 07:16:51', 'upgrade included in installation'),
('70', '2018-03-01 07:16:51', 'upgrade included in installation'),
('71', '2018-03-01 07:16:51', 'upgrade included in installation'),
('72', '2018-03-01 07:16:51', 'upgrade included in installation'),
('73', '2018-03-01 07:16:51', 'upgrade included in installation'),
('74', '2018-03-01 07:16:51', 'upgrade included in installation'),
('75', '2018-03-01 07:16:51', 'upgrade included in installation'),
('76', '2018-03-01 07:16:51', 'upgrade included in installation'),
('77', '2018-03-01 07:16:51', 'upgrade included in installation'),
('78', '2018-03-01 07:16:51', 'upgrade included in installation'),
('79', '2018-03-01 07:16:51', 'upgrade included in installation'),
('80', '2018-03-01 07:16:51', 'upgrade included in installation'),
('81', '2018-03-01 07:16:51', 'upgrade included in installation'),
('82', '2018-03-01 07:16:51', 'upgrade included in installation'),
('83', '2018-03-01 07:16:51', 'upgrade included in installation'),
('84', '2018-03-01 07:16:51', 'upgrade included in installation'),
('85', '2018-03-01 07:16:51', 'upgrade included in installation'),
('86', '2018-03-01 07:16:51', 'upgrade included in installation'),
('87', '2018-03-01 07:16:51', 'upgrade included in installation'),
('88', '2018-03-01 07:16:51', 'upgrade included in installation'),
('89', '2018-03-01 07:16:51', 'upgrade included in installation'),
('90', '2018-03-01 07:16:51', 'upgrade included in installation'),
('91', '2018-03-01 07:16:51', 'upgrade included in installation'),
('92', '2018-03-01 07:16:51', 'upgrade included in installation'),
('93', '2018-03-01 07:16:51', 'upgrade included in installation'),
('94', '2018-03-01 07:16:51', 'upgrade included in installation'),
('95', '2018-03-01 07:16:51', 'upgrade included in installation'),
('96', '2018-03-01 07:16:51', 'upgrade included in installation'),
('97', '2018-03-01 07:16:51', 'upgrade included in installation'),
('98', '2018-03-01 07:16:51', 'upgrade included in installation'),
('99', '2018-03-01 07:16:51', 'upgrade included in installation'),
('100', '2018-03-01 07:16:51', 'upgrade included in installation'),
('101', '2018-03-01 07:16:51', 'upgrade included in installation'),
('102', '2018-03-01 07:16:51', 'upgrade included in installation'),
('103', '2018-03-01 07:16:51', 'upgrade included in installation'),
('104', '2018-03-01 07:16:51', 'upgrade included in installation'),
('105', '2018-03-01 07:16:51', 'upgrade included in installation'),
('106', '2018-03-01 07:16:51', 'upgrade included in installation'),
('107', '2018-03-01 07:16:51', 'upgrade included in installation'),
('108', '2018-03-01 07:16:51', 'upgrade included in installation'),
('109', '2018-03-01 07:16:51', 'upgrade included in installation'),
('110', '2018-03-01 07:16:51', 'upgrade included in installation'),
('111', '2018-03-01 07:16:51', 'upgrade included in installation'),
('112', '2018-03-01 07:16:51', 'upgrade included in installation'),
('113', '2018-03-01 07:16:51', 'upgrade included in installation'),
('114', '2018-03-01 07:16:51', 'upgrade included in installation'),
('115', '2018-03-01 07:16:51', 'upgrade included in installation'),
('116', '2018-03-01 07:16:51', 'upgrade included in installation'),
('117', '2018-03-01 07:16:51', 'upgrade included in installation'),
('118', '2018-03-01 07:16:51', 'upgrade included in installation'),
('119', '2018-03-01 07:16:51', 'upgrade included in installation'),
('120', '2018-03-01 07:16:51', 'upgrade included in installation'),
('121', '2018-03-01 07:16:51', 'upgrade included in installation'),
('122', '2018-03-01 07:16:51', 'upgrade included in installation'),
('123', '2018-03-01 07:16:51', 'upgrade included in installation'),
('124', '2018-03-01 07:16:51', 'upgrade included in installation'),
('125', '2018-03-01 07:16:51', 'upgrade included in installation'),
('126', '2018-03-01 07:16:51', 'upgrade included in installation'),
('127', '2018-03-01 07:16:51', 'upgrade included in installation'),
('128', '2018-03-01 07:16:51', 'upgrade included in installation'),
('129', '2018-03-01 07:16:51', 'upgrade included in installation'),
('130', '2018-03-01 07:16:51', 'upgrade included in installation'),
('131', '2018-03-01 07:16:51', 'upgrade included in installation'),
('132', '2018-03-01 07:16:51', 'upgrade included in installation'),
('133', '2018-03-01 07:16:51', 'upgrade included in installation'),
('134', '2018-03-01 07:16:51', 'upgrade included in installation'),
('135', '2018-03-01 07:16:51', 'upgrade included in installation'),
('136', '2018-03-01 07:16:51', 'upgrade included in installation'),
('137', '2018-03-01 07:16:51', 'upgrade included in installation'),
('138', '2018-03-01 07:16:51', 'upgrade included in installation'),
('139', '2018-03-01 07:16:51', 'upgrade included in installation'),
('140', '2018-03-01 07:16:51', 'upgrade included in installation'),
('141', '2018-03-01 07:16:51', 'upgrade included in installation'),
('142', '2018-03-01 07:16:51', 'upgrade included in installation'),
('143', '2018-03-01 07:16:51', 'upgrade included in installation'),
('144', '2018-03-01 07:16:51', 'upgrade included in installation'),
('145', '2018-03-01 07:16:51', 'upgrade included in installation'),
('146', '2018-03-01 07:16:51', 'upgrade included in installation'),
('147', '2018-03-01 07:16:51', 'upgrade included in installation'),
('148', '2018-03-01 07:16:51', 'upgrade included in installation'),
('149', '2018-03-01 07:16:51', 'upgrade included in installation'),
('150', '2018-03-01 07:16:51', 'upgrade included in installation'),
('151', '2018-03-01 07:16:51', 'upgrade included in installation'),
('152', '2018-03-01 07:16:51', 'upgrade included in installation');

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_users`
--

CREATE TABLE `piwigo_users` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `password` varchar(255) DEFAULT NULL,
  `mail_address` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_users`
--

INSERT INTO `piwigo_users` (`id`, `username`, `password`, `mail_address`) VALUES
(1, 'admin', '8ad18b52a91dfa35957a88a61a4ebdf5', 'userwangjf@163.com'),
(2, 'guest', NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_user_access`
--

CREATE TABLE `piwigo_user_access` (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `cat_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_user_auth_keys`
--

CREATE TABLE `piwigo_user_auth_keys` (
  `auth_key_id` int(11) UNSIGNED NOT NULL,
  `auth_key` varchar(255) NOT NULL,
  `user_id` mediumint(8) UNSIGNED NOT NULL,
  `created_on` datetime NOT NULL,
  `duration` int(11) UNSIGNED DEFAULT NULL,
  `expired_on` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_user_cache`
--

CREATE TABLE `piwigo_user_cache` (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `need_update` enum('true','false') NOT NULL DEFAULT 'true',
  `cache_update_time` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `forbidden_categories` mediumtext,
  `nb_total_images` mediumint(8) UNSIGNED DEFAULT NULL,
  `last_photo_date` datetime DEFAULT NULL,
  `nb_available_tags` int(5) DEFAULT NULL,
  `nb_available_comments` int(5) DEFAULT NULL,
  `image_access_type` enum('NOT IN','IN') NOT NULL DEFAULT 'NOT IN',
  `image_access_list` mediumtext
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_user_cache`
--

INSERT INTO `piwigo_user_cache` (`user_id`, `need_update`, `cache_update_time`, `forbidden_categories`, `nb_total_images`, `last_photo_date`, `nb_available_tags`, `nb_available_comments`, `image_access_type`, `image_access_list`) VALUES
(1, 'false', 1519860373, '0', 14, '2018-03-01 07:23:58', NULL, NULL, 'NOT IN', '0');

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_user_cache_categories`
--

CREATE TABLE `piwigo_user_cache_categories` (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `cat_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `date_last` datetime DEFAULT NULL,
  `max_date_last` datetime DEFAULT NULL,
  `nb_images` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `count_images` mediumint(8) UNSIGNED DEFAULT '0',
  `nb_categories` mediumint(8) UNSIGNED DEFAULT '0',
  `count_categories` mediumint(8) UNSIGNED DEFAULT '0',
  `user_representative_picture_id` mediumint(8) UNSIGNED DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_user_cache_categories`
--

INSERT INTO `piwigo_user_cache_categories` (`user_id`, `cat_id`, `date_last`, `max_date_last`, `nb_images`, `count_images`, `nb_categories`, `count_categories`, `user_representative_picture_id`) VALUES
(1, 2, '2018-03-01 07:23:58', '2018-03-01 07:23:58', 1, 1, 0, 0, NULL),
(1, 1, '2018-03-01 07:23:58', '2018-03-01 07:23:58', 14, 14, 0, 0, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_user_feed`
--

CREATE TABLE `piwigo_user_feed` (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `last_check` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_user_group`
--

CREATE TABLE `piwigo_user_group` (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `group_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_user_infos`
--

CREATE TABLE `piwigo_user_infos` (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `nb_image_page` smallint(3) UNSIGNED NOT NULL DEFAULT '15',
  `status` enum('webmaster','admin','normal','generic','guest') NOT NULL DEFAULT 'guest',
  `language` varchar(50) NOT NULL DEFAULT 'en_UK',
  `expand` enum('true','false') NOT NULL DEFAULT 'false',
  `show_nb_comments` enum('true','false') NOT NULL DEFAULT 'false',
  `show_nb_hits` enum('true','false') NOT NULL DEFAULT 'false',
  `recent_period` tinyint(3) UNSIGNED NOT NULL DEFAULT '7',
  `theme` varchar(255) NOT NULL DEFAULT 'elegant',
  `registration_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `enabled_high` enum('true','false') NOT NULL DEFAULT 'true',
  `level` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `activation_key` varchar(255) DEFAULT NULL,
  `activation_key_expire` datetime DEFAULT NULL,
  `last_visit` datetime DEFAULT NULL,
  `last_visit_from_history` enum('true','false') NOT NULL DEFAULT 'false',
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `piwigo_user_infos`
--

INSERT INTO `piwigo_user_infos` (`user_id`, `nb_image_page`, `status`, `language`, `expand`, `show_nb_comments`, `show_nb_hits`, `recent_period`, `theme`, `registration_date`, `enabled_high`, `level`, `activation_key`, `activation_key_expire`, `last_visit`, `last_visit_from_history`, `lastmodified`) VALUES
(1, 15, 'webmaster', 'zh_CN', 'false', 'false', 'false', 7, 'elegant', '2018-03-01 07:16:51', 'true', 8, NULL, NULL, '2018-03-01 07:24:08', 'false', '2018-02-28 23:16:51'),
(2, 15, 'guest', 'zh_CN', 'false', 'false', 'false', 7, 'elegant', '2018-03-01 07:16:51', 'true', 0, NULL, NULL, NULL, 'false', '2018-02-28 23:16:51');

-- --------------------------------------------------------

--
-- 表的结构 `piwigo_user_mail_notification`
--

CREATE TABLE `piwigo_user_mail_notification` (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `check_key` varchar(16) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `enabled` enum('true','false') NOT NULL DEFAULT 'false',
  `last_send` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `piwigo_caddie`
--
ALTER TABLE `piwigo_caddie`
  ADD PRIMARY KEY (`user_id`,`element_id`);

--
-- Indexes for table `piwigo_categories`
--
ALTER TABLE `piwigo_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_i3` (`permalink`),
  ADD KEY `categories_i2` (`id_uppercat`),
  ADD KEY `lastmodified` (`lastmodified`);

--
-- Indexes for table `piwigo_comments`
--
ALTER TABLE `piwigo_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_i2` (`validation_date`),
  ADD KEY `comments_i1` (`image_id`);

--
-- Indexes for table `piwigo_config`
--
ALTER TABLE `piwigo_config`
  ADD PRIMARY KEY (`param`);

--
-- Indexes for table `piwigo_favorites`
--
ALTER TABLE `piwigo_favorites`
  ADD PRIMARY KEY (`user_id`,`image_id`);

--
-- Indexes for table `piwigo_groups`
--
ALTER TABLE `piwigo_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `groups_ui1` (`name`),
  ADD KEY `lastmodified` (`lastmodified`);

--
-- Indexes for table `piwigo_group_access`
--
ALTER TABLE `piwigo_group_access`
  ADD PRIMARY KEY (`group_id`,`cat_id`);

--
-- Indexes for table `piwigo_history`
--
ALTER TABLE `piwigo_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `piwigo_history_summary`
--
ALTER TABLE `piwigo_history_summary`
  ADD UNIQUE KEY `history_summary_ymdh` (`year`,`month`,`day`,`hour`);

--
-- Indexes for table `piwigo_images`
--
ALTER TABLE `piwigo_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `images_i2` (`date_available`),
  ADD KEY `images_i3` (`rating_score`),
  ADD KEY `images_i4` (`hit`),
  ADD KEY `images_i5` (`date_creation`),
  ADD KEY `images_i1` (`storage_category_id`),
  ADD KEY `images_i6` (`latitude`),
  ADD KEY `lastmodified` (`lastmodified`);

--
-- Indexes for table `piwigo_image_category`
--
ALTER TABLE `piwigo_image_category`
  ADD PRIMARY KEY (`image_id`,`category_id`),
  ADD KEY `image_category_i1` (`category_id`);

--
-- Indexes for table `piwigo_image_format`
--
ALTER TABLE `piwigo_image_format`
  ADD PRIMARY KEY (`format_id`);

--
-- Indexes for table `piwigo_image_tag`
--
ALTER TABLE `piwigo_image_tag`
  ADD PRIMARY KEY (`image_id`,`tag_id`),
  ADD KEY `image_tag_i1` (`tag_id`);

--
-- Indexes for table `piwigo_languages`
--
ALTER TABLE `piwigo_languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `piwigo_old_permalinks`
--
ALTER TABLE `piwigo_old_permalinks`
  ADD PRIMARY KEY (`permalink`);

--
-- Indexes for table `piwigo_plugins`
--
ALTER TABLE `piwigo_plugins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `piwigo_rate`
--
ALTER TABLE `piwigo_rate`
  ADD PRIMARY KEY (`element_id`,`user_id`,`anonymous_id`);

--
-- Indexes for table `piwigo_search`
--
ALTER TABLE `piwigo_search`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `piwigo_sessions`
--
ALTER TABLE `piwigo_sessions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `piwigo_sites`
--
ALTER TABLE `piwigo_sites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sites_ui1` (`galleries_url`);

--
-- Indexes for table `piwigo_tags`
--
ALTER TABLE `piwigo_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tags_i1` (`url_name`),
  ADD KEY `lastmodified` (`lastmodified`);

--
-- Indexes for table `piwigo_themes`
--
ALTER TABLE `piwigo_themes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `piwigo_upgrade`
--
ALTER TABLE `piwigo_upgrade`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `piwigo_users`
--
ALTER TABLE `piwigo_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_ui1` (`username`);

--
-- Indexes for table `piwigo_user_access`
--
ALTER TABLE `piwigo_user_access`
  ADD PRIMARY KEY (`user_id`,`cat_id`);

--
-- Indexes for table `piwigo_user_auth_keys`
--
ALTER TABLE `piwigo_user_auth_keys`
  ADD PRIMARY KEY (`auth_key_id`);

--
-- Indexes for table `piwigo_user_cache`
--
ALTER TABLE `piwigo_user_cache`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `piwigo_user_cache_categories`
--
ALTER TABLE `piwigo_user_cache_categories`
  ADD PRIMARY KEY (`user_id`,`cat_id`);

--
-- Indexes for table `piwigo_user_feed`
--
ALTER TABLE `piwigo_user_feed`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `piwigo_user_group`
--
ALTER TABLE `piwigo_user_group`
  ADD PRIMARY KEY (`group_id`,`user_id`);

--
-- Indexes for table `piwigo_user_infos`
--
ALTER TABLE `piwigo_user_infos`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `lastmodified` (`lastmodified`);

--
-- Indexes for table `piwigo_user_mail_notification`
--
ALTER TABLE `piwigo_user_mail_notification`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_mail_notification_ui1` (`check_key`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `piwigo_categories`
--
ALTER TABLE `piwigo_categories`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `piwigo_comments`
--
ALTER TABLE `piwigo_comments`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `piwigo_groups`
--
ALTER TABLE `piwigo_groups`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `piwigo_history`
--
ALTER TABLE `piwigo_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `piwigo_images`
--
ALTER TABLE `piwigo_images`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- 使用表AUTO_INCREMENT `piwigo_image_format`
--
ALTER TABLE `piwigo_image_format`
  MODIFY `format_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `piwigo_search`
--
ALTER TABLE `piwigo_search`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `piwigo_sites`
--
ALTER TABLE `piwigo_sites`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `piwigo_tags`
--
ALTER TABLE `piwigo_tags`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `piwigo_users`
--
ALTER TABLE `piwigo_users`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `piwigo_user_auth_keys`
--
ALTER TABLE `piwigo_user_auth_keys`
  MODIFY `auth_key_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
