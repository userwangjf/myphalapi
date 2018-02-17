<?php
/**
 * 用于权限检查.
 * User: wangjf
 * Date: 18-2-17
 * Time: 下午7:05
 */


class Domain_Admin {

    /**
     * 检查是否具有管理员权限
     * @desc 默认情况下，第一个注册的用户为管理员
     * @param $tokenid 用户标识符
     */
    public function isAdmin($tokenid) {

        $tblModel = new Model_Sessions();
        $ret = $tblModel->getUid($tokenid);

        if(count($ret) == 0) {
            return false;
        }

        //uid == 100的用户为管理员
        if(strcmp($ret[0]['uid'],"100") != 0) {
            return false;
        }

        $diff = time() - $ret[0]['last_activity'];

        //管理员的session失效时间为1个小时。
        if($diff > (1 * 60 * 60)) {
            return false;
        }

        return true;
    }

}