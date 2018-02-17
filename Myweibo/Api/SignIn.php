<?php
/**
 * 用户注册接口
 * User: wangjf
 * Date: 18-2-16
 * Time: 上午8:58
 */


class Api_SignIn extends PhalApi_Api
{

    public function getRules() {
        return array(
            'signIn' => array(
                'account'   => array('name' => 'account'    , 'desc' => '帐号'),
                'passwd'    => array('name' => 'passwd'     , 'desc' => '密码'),
                'username'  => array('name' => 'username'   , 'desc' => '昵称'),
                'signcode'  => array('name' => 'signcode'   , 'desc' => '邀请码'),
            ),
            'signCode' => array(
                'tokenid'   => array('name' => 'tokenid'    , 'desc' => '登录信息'),
            ),
        );
    }

    /**
     * 生成新的邀请码
     * @desc 只有管理员有权限生成新的邀请码，新生成的邀请码写在本目录的signcode.php文件末尾
     * @desc 默认情况下，邀请码10分钟失效
     */
    public function signCode() {

        //检查权限

        if(!isset($_POST['tokenid'])) {
            DI()->response->setRet(201)->setMsg("tokenid错误");
            return "";
        }
        $tokenid = $_POST['tokenid'];

        $dmAdmin = new Domain_Admin();
        $ret = $dmAdmin->isAdmin($tokenid);

        if(!($ret)) {
            DI()->response->setRet(201)->setMsg("非管理员，无此权限");
            return "";
        }

        //生成新的邀请码
        $randCode = "";
        for($i=0;$i<6;$i++) {
            $number = rand(0,9);
            $randCode = "$randCode"."$number";
        }

        $signcode = "\n//".time().","."$randCode";
        $this->setSignCode($signcode);
        return $randCode;
    }

    /**
     * 注册接口
     * @desc 需要提供帐号、密码、昵称、邀请码
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

        //检查帐号是否满足要求
        if(!isset($_POST['account'])) {
            DI()->response->setRet(201)->setMsg("用户帐号不能为空");
            return "";
        }
        $account = $_POST['account'];
        if(strlen($account) < 4) {
            DI()->response->setRet(201)->setMsg("用户帐号长度必须>=4");
            return "";
        }
        if(strlen($account) > 16) {
            DI()->response->setRet(201)->setMsg("用户帐号长度必须<=16");
            return "";
        }

        //检查密码是否满足要求
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

        //检查昵称是否满足要求
        if(!isset($_POST['username'])) {
            DI()->response->setRet(201)->setMsg("昵称不能为空");
            return "";
        }
        $username = $_POST['username'];
        if(strlen($username) < 4) {
            DI()->response->setRet(201)->setMsg("昵称长度必须>=4");
            return "";
        }
        if(strlen($username) > 32) {
            DI()->response->setRet(201)->setMsg("昵称长度必须<=32");
            return "";
        }

        //检查邀请码是否满足要求
        if(!isset($_POST['signcode'])) {
            DI()->response->setRet(201)->setMsg("邀请码不能为空");
            return "";
        }
        $signcode = $_POST['signcode'];

        if(!$this->checkSignCode($signcode)) {
            DI()->response->setRet(201)->setMsg("邀请码错误，请联系管理员获取邀请码");
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

        $user_info['username'] = $username;
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

        if($dmSignIn->signIn($user,$user_info)) {
            //邀请码仅使用1次
            $this->setSignCode("\n//======");
            return "注册成功，请登录";
        } else {
            return "注册失败，请联系管理员";
        }

    }

    /*
     * 从文件中获取邀请码
     */
    private function getSignCode() {
        $myfile = fopen(__DIR__."/signcode.php","r");
        while($line = fgets($myfile)) {
            $last = $line;
        }
        fclose($myfile);

        return trim($last);
    }

    private function checkSignCode($signCode) {

        $line = $this->getSignCode();

        if(strcmp($line,"//======") == 0) {
            return false;
        }

        $line = substr($line,2);
        $code = explode(",",$line);
        $oldTime = $code[0];
        $oldCode = $code[1];

        $diff = time() - $oldTime;
        if($diff > (10 * 60)) { //邀请码10分钟失效
            return false;
        }

        if(strcmp($oldCode,$signCode) == 0) {
            return true;
        }

        return false;

    }

    /*
     * 注册成功，清除邀请码，确保邀请码只使用一次
     */
    private function setSignCode($code) {
        $myfile = fopen(__DIR__."/signcode.php","a");
        fputs($myfile,$code);
        fclose($myfile);
    }




}