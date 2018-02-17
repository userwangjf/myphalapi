<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 18-2-17
 * Time: 下午9:38
 */


class Domain_LoginIn {

    public function loginIn($account,$passwd) {

        //查找user表
        $tblUser = new Model_UserTbl();
        $passwd = hash('sha512',$passwd);
        $ret = $tblUser->loginIn($account,$passwd);

        return $ret;
    }
}