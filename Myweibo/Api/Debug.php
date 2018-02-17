<?php
/**
 * 调试接口
 * User: wangjf
 * Date: 18-2-15
 * Time: 上午7:46
 */


class Api_Debug extends PhalApi_Api {

    public function getRules() {
        return array(
            'getTable' => array(
                'tblname' 	=> array('name' => 'tblname' ),
            ),
        );
    }




}