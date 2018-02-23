<?php
/**
 * 常用工具接口
 * User: wangjf
 * Date: 18-2-10
 * Time: 上午11:07
 */



class Api_Misc extends PhalApi_Api
{

    public function getRules() {
        return array(
            'diskFree' => array(

            ),
            'getConnect' => array(
                'userkey' => array('name' => 'userkey', 'desc' => '用户输入的参数'),
            ),
            'checkIp' => array(
                'clientip' => array('name' => 'clientip', 'desc' => '用户输入的IP'),
            ),
            'getTable' => array(

            ),
            'testDir' => array(

            ),

        );
    }
    /**
     * 检查磁盘的剩余空间
     * @desc 获取磁盘的剩余空间
     * @return int      goods_id    商品ID
     * @exception 406 签名失败
     */
    public function diskFree() {

        //返回以字节为单位的剩余空间

        $ret = array();

        $ret['UPLOAD_DIR'] = 0;
        $ret['BACKUP_DIR'] = 0;

        $path = DI()->config->get('app.UPLOAD_DIR');
        if($path) {
            if(is_dir($path)) {
                $free = disk_free_space($path);
                $ret['UPLOAD_DIR'] = $free;
            }
        }

        $path = DI()->config->get('app.BACKUP_DIR');
        if($path) {
            if(is_dir($path)) {
                $free = disk_free_space($path);
                $ret['BACKUP_DIR'] = $free;
            }
        }

        return $ret;

    }

    /**
     * 检查服务器连接
     * @desc 对服务器进行验证，确保服务器是可连接的，并且服务是正确的
     * @param $_POST['userKey']
     * @return 转换为byte后，每个byte全部加1，然后返回
     */
    public function getConnect() {
        if(!isset($_POST['userkey'])) {
            //返回错误信息
            DI()->response->setRet(220)->setMsg("无正确的参数");
            return "";
        }

        $userKey = $_POST['userkey'];
        //转换为byte数组
        $byte = str_split($userKey);
        for($i=0;$i<count($byte);$i++) {
            $byte[$i]++;
        }
        $encode = join($byte);

        return $encode;
    }

    public function checkIp() {

        if(!isset($_POST['clientip'])) {
            DI()->response->setRet(220)->setMsg("请输入正确的ip");
            return "";
        }
        $clientIP = $_POST['clientip'];

        $dmMisc = new Domain_Misc();
        if($dmMisc->checkIP($clientIP)) {
            DI()->response->setRet(210)->setMsg("IP在同一个网段");
            return "";
        } else {
            DI()->response->setRet(220)->setMsg("IP不在同一个网段");
            return "";
        }


    }

    public function getTable() {

        $arr = array();

        $tblUser = new Model_UserTbl();
        $ret = $tblUser->userMinId();
        $arr['userMinId'] = $ret;

        return $arr;
    }

    public function testDir() {

        $stime = time();
        //读入备份目录配置
        $backupDir = DI()->config->get('app.BACKUP_DIR');
        if(is_dir($backupDir)) {

            //创建根目录
            $backupDir = sprintf('%s/uploads', $backupDir);
            if(!is_dir($backupDir)) {
                $res = mkdir($backupDir,0777,true);
                if($res) {
                    //chmod($backupDir,0777);
                } else {
                    //返回错误信息
                    DI()->response->setRet(220)->setMsg("创建备份目录失败"."$backupDir");
                    return null;
                }
            }

            //按日期创建目录，每月一个，和upload的日期一致
            //$stime = date("Y/m",time());
            $backupDir = sprintf('%s/%s/', $backupDir, $stime);
            //如果目录不存在，则创建
            if(!is_dir($backupDir)) {
                $res = mkdir($backupDir,0777,true);
                if($res) {
                    //chmod($backupDir,0777);
                } else {
                    //返回错误信息
                    DI()->response->setRet(220)->setMsg("创建备份目录失败"."$backupDir");
                    return null;
                }
            }
        }

        return "$stime";
    }


}