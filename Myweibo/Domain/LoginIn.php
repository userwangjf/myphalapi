<?php
/**
 * 登录处理
 * User: wangjf
 * Date: 18-2-17
 * Time: 下午9:38
 */


class Domain_LoginIn {

    /**
     * 登录处理逻辑，
     * @desc 不允许一个用户多个登录
     * @param $account 帐号
     * @param $passwd  密码
     * @return null|string 失败返回null，成功返回tokenid。
     */
    public function loginIn($account,$passwd) {

        //查找user表，获取uid
        $tblUser = new Model_UserTbl();
        $passwd = hash('sha512',$passwd);
        //return $passwd;
        $user = $tblUser->loginIn($account,$passwd);

        if(count($user) == 0) {
            DI()->response->setRet(201)->setMsg("无此用户");
            return null;
        }

        //写入session表
        /*
        `session_id` varchar(40) NOT NULL DEFAULT '0' COMMENT '计算用户的MD5',
        `uid` int(10) unsigned NOT NULL COMMENT '用户的id',
        `ip_address` varchar(40) NOT NULL DEFAULT '0',
        `user_agent` varchar(120) NOT NULL,
        `last_activity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上次登录时间',
        `user_data` text NOT NULL COMMENT '按json格式，存储用户的数据信息',
        */

        $session['uid']             = $user[0]['id'];
        $session['ip_address']      = $_SERVER['REMOTE_ADDR'];
        $session['user_agent']      = "";
        $session['last_activity']   = time();
        $session['user_data']       = "";
        $session['session_id']      = md5($session['ip_address'].$session['last_activity']."$passwd");

        $mdSessions = new Model_Sessions();
        //先删除旧的session
        $mdSessions->delSession($user[0]['id']);
        $ret = $mdSessions->addSession($session);
        if($ret == null) {
            DI()->response->setRet(201)->setMsg("登录数据库失败");;
            return null;
        } else {
            return array('tokenid' => $session['session_id']);
        }

    }
}