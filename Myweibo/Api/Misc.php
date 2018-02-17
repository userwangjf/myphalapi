<?php
/**
 * 常用工具接口.
 * User: wangjf
 * Date: 18-2-10
 * Time: 上午11:07
 */



class Api_Misc extends PhalApi_Api
{

    public function getRules() {
        return array(
            'regCode' => array(

            ),
            'getConnect' => array(

            ),
            'getWeibo' => array(

            ),
        );
    }

    /*
     * 对服务器进行验证，确保服务器是可连接的，并且服务是正确的
     * 对输入的参数$_POST['userKey']
     * 转换为byte后，每个byte全部加1，然后返回
     */
    public function getConnect() {
        if(!isset($_POST['userKey'])) {
            //返回错误信息
            DI()->response->setRet(201)->setMsg("无正确的参数");
            return "";
        }

        $userKey = $_POST['userKey'];
        //转换为byte数组
        $byte = str_split($userKey);
        for($i=0;$i<count($byte);$i++) {
            $byte[$i]++;
        }
        $encode = join($byte);

        return $encode;
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