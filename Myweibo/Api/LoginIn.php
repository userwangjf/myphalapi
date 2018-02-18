<?php
/**
 * 用户登录接口
 * User: wangjf
 * Date: 18-2-17
 * Time: 下午8:54
 * 正确执行，返回200,此时不带msg，不用显示msg
 * 正确执行，返回210,此时带msg/data，需要显示提示信息msg
 * 错误执行，返回220,此时带msg，需要显示错误信息msg
 */


class Api_LoginIn extends PhalApi_Api {

    public function getRules() {
        return array(
            'loginIn' => array(
                'account'   => array('name' => 'account'    , 'desc' => '帐号'),
                'passwd'    => array('name' => 'passwd'     , 'desc' => '密码'),
            ),
        );
    }

    /**
     * 登录接口
     * @desc 登录接口，需要帐号/密码
     * @param 帐号/密码
     * @return tokenid 登录成功，返回用户的tokenid
     */
    public function loginIn() {

        //检查IP地址是否在同一个网段
        $dmMisc = new Domain_Misc();
        $ret = $dmMisc->checkIp($_SERVER['REMOTE_ADDR']);
        if($ret == false) {
            DI()->response->setRet(220)->setMsg("IP地址错误");
            return "";
        }

        //检查帐号是否满足要求
        if(!isset($_POST['account'])) {
            DI()->response->setRet(220)->setMsg("用户帐号不能为空");
            return "";
        }
        $account = $_POST['account'];
        if(strlen($account) < 4) {
            DI()->response->setRet(220)->setMsg("用户帐号长度必须>=4");
            return "";
        }
        if(strlen($account) > 16) {
            DI()->response->setRet(220)->setMsg("用户帐号长度必须<=16");
            return "";
        }

        //检查密码是否满足要求
        if(!isset($_POST['passwd'])) {
            DI()->response->setRet(220)->setMsg("密码不能为空");
            return "";
        }
        $passwd = $_POST['passwd'];
        if(strlen($passwd) < 6) {
            DI()->response->setRet(220)->setMsg("密码长度必须>=6");
            return "";
        }
        if(strlen($passwd) > 16) {
            DI()->response->setRet(220)->setMsg("密码长度必须<=16");
            return "";
        }

        $dmLoginIn = new Domain_LoginIn();
        $ret = $dmLoginIn->loginIn($account,$passwd);
        if($ret == null) {
            return "";
        } else {
            return $ret;
        }
    }


}