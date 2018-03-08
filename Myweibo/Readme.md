

## 数据存储：

1. 原始图片、视频存放在硬盘上，采用双备份方式存储，平时不访问，在需要时才载入。
2. 硬盘会使用继电器控制电源，不访问时自动关闭。
3. 图片、视频的缩略图，存放在U盘上。用于频繁访问。
4. 缩略图可以不用多份存储，如果丢失，可以用原图重建。



## U盘容量计算

1. 按一个压缩图500KB计算，1TB的原始数据，5MB的原始文件大小，需要产生的缩略图个数为：1TB/5MB = 20W.
2. 20W*500KB = 100GB。





## API 返回值

```
* 正确执行，返回200,此时不带msg，不用显示msg
* 正确执行，返回210,此时带msg/data，需要显示提示信息msg
* 错误执行，返回220,此时带msg，需要显示错误信息msg
```



# 数据库设计

## 图片表

```sql
CREATE TABLE IF NOT EXISTS `t_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture` varchar(128) NOT NULL DEFAULT '' COMMENT '微博配图的地址',
  `ctime` int(10) unsigned NOT NULL COMMENT '图片的原始创建时间',
  `wid` int(10) unsigned NOT NULL COMMENT '所属微博wid',
  `uid` int(10) unsigned NOT NULL COMMENT '所属用户的uid',
  `md5` varchar(40) NOT NULL COMMENT '图片的md5值，用于文件完整性检查',
  `loc` varchar(128) NOT NULL DEFAULT 'default' COMMENT '图片存储位置，用于扩展',
  PRIMARY KEY (`id`),
  KEY `wid` (`wid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='微博配图' AUTO_INCREMENT=1 ;
```









