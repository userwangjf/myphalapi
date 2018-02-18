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
        if(!isset($_POST['userKey'])) {
            //返回错误信息
            DI()->response->setRet(220)->setMsg("无正确的参数");
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


}