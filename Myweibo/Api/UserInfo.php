<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 18-2-10
 * Time: 上午11:07
 */



class Api_UserInfo extends PhalApi_Api
{

    public function getRules() {
        return array(
            'regCode' => array(

            ),
            'makeWeibo' => array(

            ),
            'getWeibo' => array(

            ),
        );
    }

    /*
     * 生成新的注册码，每个小时生成一个
     */
    public function regCode() {
        $path = dirname(__FILE__);
        $filename = $path . "/regcode.php";
        $mydate = date("Y-m-d");
        //如果文件已经存在，则检查
        if(file_exists($filename)) {
            $myfile = fopen($filename, "r");
            fgets($myfile);
        }

        return "邀请码申请成功，请联系管理员";
    }

    public function regUser() {

    }

}