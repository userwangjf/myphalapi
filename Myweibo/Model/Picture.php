<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 17-11-2
 * Time: 下午9:06
 */

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