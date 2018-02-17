<?php
/**
 * 处理用户信息的api.
 * User: wangjf
 * Date: 18-2-16
 * Time: 上午8:58
 */


class Api_SignIn extends PhalApi_Api
{

    public function getRules() {
        return array(
            'signIn' => array(
                'account' => array('name' => 'account',),
                'passwd'  => array('name' => 'passwd',),
            ),
        );
    }

    /*
     * @desc 注册接口
        第一个注册的用户（id=0），为管理员
        先检查参数正确性，然后填充数组。

     */
    public function signIn() {

        /*
    user表
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `account` char(20) NOT NULL DEFAULT '' COMMENT '用户帐号',
    `passwd` char(128) NOT NULL DEFAULT '' COMMENT '用户密码的md5',
    `regis_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
    `lock` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否锁定（0不锁定、1锁定）',
    `vemail` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '邮箱验证(0未验证，1已验证)',
         */

        if(!isset($_POST['account'])) {
            DI()->response->setRet(201)->setMsg("用户名不能为空");
            return "";
        }
        $account = $_POST['account'];
        if(strlen($account) < 4) {
            DI()->response->setRet(201)->setMsg("用户名长度必须>=4");
            return "";
        }
        if(strlen($account) > 16) {
            DI()->response->setRet(201)->setMsg("用户名长度必须<=16");
            return "";
        }

        if(!isset($_POST['passwd'])) {
            DI()->response->setRet(201)->setMsg("密码不能为空");
            return "";
        }
        $passwd = $_POST['passwd'];
        if(strlen($passwd) < 6) {
            DI()->response->setRet(201)->setMsg("密码长度必须>=6");
            return "";
        }
        if(strlen($passwd) > 16) {
            DI()->response->setRet(201)->setMsg("密码长度必须<=16");
            return "";
        }

        $user = array();
        $user['account'] = $account;
        $user['passwd']  = hash('sha512',$passwd);
        $user['regis_time'] = time();
        $user['lock'] = 0;
        $user['vemail'] = 1;

        /*
  user_info表
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `truename` varchar(32) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `location` varchar(64) NOT NULL DEFAULT '' COMMENT '居住地',
  `birthday` date NOT NULL COMMENT '生日(日期时间型)',
  `sex` enum('男','女','未知') NOT NULL DEFAULT '男' COMMENT '性别',
  `intro` varchar(128) NOT NULL DEFAULT '' COMMENT '一句话介绍自己',
  `avatar` varchar(128) NOT NULL DEFAULT '' COMMENT '头像(有180，50,30三个，图片名字相同，路径不同)',
  `domain` varchar(128) DEFAULT NULL COMMENT '个性域名',
  `style` varchar(64) NOT NULL DEFAULT '' COMMENT '模板风格',
  `follow` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关注数',
  `fans` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '粉丝数',
  `weibo` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发表微博数',
  `uid` int(10) unsigned NOT NULL,
        */

        $user_info = array();

        $user_info['username'] = '小白';
        $user_info['truename'] = '贵姓';
        $user_info['location'] = '保密';
        $user_info['birthday'] = date("Y/m/d");
        $user_info['sex']      = '未知';
        $user_info['intro']    = '一句话介绍自己';
        $user_info['avatar']   = '';
        $user_info['domain']   = '';
        $user_info['style']    = '';
        $user_info['follow']   = 0;
        $user_info['fans']     = 0;
        $user_info['weibo']    = 0;
        $user_info['uid']      = 0;

        $dmSignIn = new Domain_SignIn();
        //检查帐号是否重复
        $ret = $dmSignIn->checkRepeat($user['account'],$user_info['username']);
        if(strlen($ret) != 0) {
            DI()->response->setRet(201)->setMsg("$ret");
            return "";
        }

        return $dmSignIn->signIn($user,$user_info);

    }


}