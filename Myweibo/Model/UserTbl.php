<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 18-2-16
 * Time: 上午9:14
 */

class Model_UserTbl extends PhalApi_Model_NotORM {

    public function getTableName($id)
    {
        return "user";
    }

    /*
     * 查找帐号是否有相同的
     */
    public function checkRepeat($account) {
        $rs = $this->getORM()
            ->select('*')
            ->where('account',$account)
            ->fetchAll();

        if(count($rs) == 0)
            return false;
        else
            return true;
    }

    /**
     * @param $user
     * @return null|string
     */
    public function signIn($user) {
        $t_user = $this->getORM();
        if($t_user->insert($user))
            return $t_user->insert_id();
        else
            return null;
    }

    public function loginIn($account,$passwd) {
        $rs = $this->getORM()
            ->select('id')
            ->where('account',$account)
            ->where('passwd = ?',$passwd)
            ->fetchAll();

        return $rs;
    }

    /**
     * 获取user表的总用户数
     */
    public function userSum() {
        $rs = $this->getORM()
            ->select('id')
            ->fetchAll();

        return count($rs);
    }

    /**
     * @return int
     */
    public function userMinId() {
        $rs = $this->getORM()
            ->select('id')
            ->order('id asc')
            ->limit(0,1)
            ->fetchAll();

        if(count($rs) == 0)
            return 0;
        else
            return $rs[0]['id'];
    }

}