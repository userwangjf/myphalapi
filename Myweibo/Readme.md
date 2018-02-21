

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









