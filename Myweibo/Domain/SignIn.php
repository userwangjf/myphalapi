<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 18-2-16
 * Time: 上午9:15
 */

class Domain_SignIn {

    //检查$user->account是否有重复
    //

    public function checkRepeat($account,$username) {
        $userModel = new Model_UserTbl();
        $repeat = $userModel->checkRepeat($account);

        if($repeat) {
            DI()->response->setRet(210)->setMsg("帐号重复");
            return "";
        }

        $infoModel = new Model_UserInfo();
        $repeat = $infoModel->checkRepeat($username);

        if($repeat) {
            DI()->response->setRet(210)->setMsg("昵称重复");
            return "";
        }
    }

    /**
     * @param $user
     * @param $user_info
     * @return null|string 返回用户注册的uid
     */
    public function signIn($user,$user_info) {

        $userModel = new Model_UserTbl();

        //插入数据到user表
        $uid = $userModel->signIn($user);
        if(null == $uid) {
            DI()->response->setRet(210)->setMsg("注册数据库失败");
            return null;
        }

        //插入数据到user_info表
        $user_info['uid'] = $uid;
        $infoModel = new Model_UserInfo();
        $ret = $infoModel->signIn($user_info);
        if($ret == null) {
            DI()->response->setRet(210)->setMsg("注册数据库失败");
            return null;
        }

        return array('value' => $uid);
    }

    public function userSum() {

        $tblUser = new Model_UserTbl();
        return $tblUser->userSum();
    }


}