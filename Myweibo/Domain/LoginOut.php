<?php
/**
 * 用户退出登录接口
 * User: wangjf
 * Date: 18-2-18
 * Time: 上午8:46
 */


class Domain_LoginOut {


    public function loginOut($tokenid) {

        $mdSession = new Model_Sessions();
        $ret = $mdSession->delSession($tokenid);

        if($ret == true) {
            DI()->response->setRet(210)->setMsg("成功退出登录");
            return "";
        } else {
            return null;
        }

    }

}

