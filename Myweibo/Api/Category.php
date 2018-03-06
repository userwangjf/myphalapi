<?php
/**
 * 获取相册目录
 * User: wangjf
 * Date: 18-3-2
 * Time: 下午6:26
 */


class Api_Category extends  PhalApi_Api {

    public function getRules() {
        return array(
            'get' => array(
                'page'     => array('name' => 'page'      , 'desc' => '帐号'),
                'count'    => array('name' => 'count'     , 'desc' => '密码'),
            ),

            'get'
        );
    }



}




