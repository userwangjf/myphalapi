<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 18-2-18
 * Time: 上午9:27
 */


class Domain_Misc {

    /**
     * 比较IP是否在同一个网段
     * @desc 比较IP的前3段是否相等，来识别是否是同一个网段
     * @param $clientIP 客户端的IP
     * @return bool
     */
    public function checkIp($clientIP) {

        $serverIP = $_SERVER['SERVER_ADDR'];

        $client = explode(".",$clientIP);
        $server = explode(".",$serverIP);

        for($i=0;$i<3;$i++) {
            if($client[$i] != $server[$i]) {
                return false;
            }
        }

        return true;

    }


}