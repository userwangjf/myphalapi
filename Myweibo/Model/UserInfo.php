<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 18-2-17
 * Time: 上午9:55
 */


class Model_UserInfo extends PhalApi_Model_NotORM {

    public function getTableName($id)
    {
        return "user_info";
    }

    /*
     * 查找昵称是否有相同的
     */
    public function checkRepeat($username) {
        $rs = $this->getORM()
            ->select('*')
            ->where('username',$username)
            ->fetchAll();

        if(count($rs) == 0)
            return false;
        else
            return true;
    }

    public function signIn($user_info) {
        $tbl = $this->getORM();
        if($tbl->insert($user_info))
            return $tbl->insert_id();
        else
            return -1;
    }


}