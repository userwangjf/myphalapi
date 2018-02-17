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

        if($repeat)
            return "帐号重复";

        $infoModel = new Model_UserInfo();
        $repeat = $infoModel->checkRepeat($username);

        if($repeat)
            return "昵称重复";

    }

    public function signIn($user,$user_info) {

        $userModel = new Model_UserTbl();

        //插入数据到user表
        $uid = $userModel->signIn($user);
        if(-1 == $uid) {
            return "数据库失败";
        }

        //插入数据到user_info表
        $user_info['uid'] = $uid;
        $infoModel = new Model_UserInfo();
        $infoModel->signIn($user_info);

        return "注册成功，请登录";
    }


}