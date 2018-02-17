<?php
/**
 * 数据库.
 * User: wangjf
 * Date: 18-2-17
 * Time: 下午7:11
 */


class Model_Sessions extends PhalApi_Model_NotORM
{

    public function getTableName($id)
    {
        return "sessions";
    }

    public function getUid($session_id) {
        $rs = $this->getORM()
            ->select('uid, last_activity')
            ->where('session_id',$session_id)
            ->fetchAll();

        return $rs;
    }


}