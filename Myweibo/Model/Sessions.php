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

    public function addSession($session) {
        $tbl = $this->getORM();
        if($tbl->insert($session))
            return $tbl->insert_id();
        else
            return null;
    }

    /**
     * 根据uid删除session，避免一个用户多次登录
     * @param $uid
     * @return bool|int
     * @throws Exception
     */
    public function delSession($uid) {
        $rs = $this->getORM()
            ->where('uid',$uid)
            ->delete();

        return $rs;
    }
}