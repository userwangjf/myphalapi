<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 17-11-2
 * Time: 下午9:02
 */


class Model_Weibo extends PhalApi_Model_NotORM {

    public function addWeibo($weibo) {
        $t_weibo = $this->getORM();
        $t_weibo->insert($weibo);
        return $t_weibo->insert_id();
    }

    //获取最新的微博列表
    public function getWeibo($id){
        $rs = $this->getORM()
            ->select('*')
            ->where('id',$id)
            ->order('id desc')
            ->fetchAll();

        return $rs;
    }

    //获取最新发表的微搏ID列表
    public function getIdNew($page,$count) {
        $rs = $this->getORM()
            ->select('id')
            ->limit($page*$count,$count)
            ->order('id desc')
            ->fetchAll();

        return $rs;
    }


    //内置方法，用于获取table name，不带前缀
    protected function getTableName($id)
    {
        return 'weibo';
    }

}