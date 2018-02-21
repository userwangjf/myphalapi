<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 17-11-2
 * Time: 下午9:06
 */


//CREATE TABLE IF NOT EXISTS `t_picture` (
//`id` int(11) NOT NULL AUTO_INCREMENT,
//  `picture` varchar(128) NOT NULL DEFAULT '' COMMENT '微博配图的地址',
//  `ctime` int(10) unsigned NOT NULL COMMENT '图片的原始创建时间',
//  `wid` int(10) unsigned NOT NULL COMMENT '所属微博wid',
//  `uid` int(10) unsigned NOT NULL COMMENT '所属用户的uid',
//  `md5` varchar(40) NOT NULL COMMENT '图片的md5值，用于文件完整性检查',
//  `loc` varchar(128) NOT NULL DEFAULT 'default' COMMENT '图片存储位置，用于扩展',
//  PRIMARY KEY (`id`),
//  KEY `wid` (`wid`)
//) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='微博配图' AUTO_INCREMENT=1 ;

class Model_Picture extends PhalApi_Model_NotORM {

    public function addPicture($picture) {
        $t_picture = $this->getORM();
        $t_picture->insert($picture);
    }

    //查找wid[]对应的所有图片地址
    public function getPicture($wid) {
        $rs = $this->getORM()
            ->select('*')
            ->where('wid',$wid)
            ->order('wid desc')
            ->fetchAll();

        return $rs;
    }

    //内置函数，用于获取table name
    protected function getTableName($id)
    {
        return 'picture';
    }

}