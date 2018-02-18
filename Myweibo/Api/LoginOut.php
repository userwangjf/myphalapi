<?php
/**
 * 用户退出接口
 * User: wangjf
 * Date: 18-2-18
 * Time: 上午8:43
 */


class Api_LoginOut extends PhalApi_Api {

    public function getRules() {
        return array(
            'loginOut' => array(
                'tokenid'   => array('name' => 'tokenid'    , 'desc' => 'tokenid'),
            ),
        );
    }

    /**
     * 退出登录接口
     * @desc 使用tokenid作为参数，退出登录
     * @param string tokenid 上次登录的tokenid
     * @return string
     */
    public function loginOut() {

        //检查tokenid是否满足要求
        if(!isset($_POST['tokenid'])) {
            DI()->response->setRet(220)->setMsg("tokenid不能为空");
            return "";
        }
        $tokenid = $_POST['tokenid'];
        if(strlen($tokenid) != 32) {
            DI()->response->setRet(220)->setMsg("tokenid长度错误");
            return "";
        }

        $dmLoginOut = new Domain_LoginOut();
        $ret = $dmLoginOut->loginOut($tokenid);

        if($ret == null) {
            return "";
        } else {
            return $ret;
        }

    }

}