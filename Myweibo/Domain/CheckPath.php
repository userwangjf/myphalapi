<?php
/**
 * 根据日期创建需要的上传目录
 * User: wangjf
 * Date: 18-3-6
 * Time: 下午8:11
 */


class Domain_CheckPath {


    /**
     * @param $type
     * @param $time
     * @return null|string
     */
    private function checkDir($type,$time) {
        $top = null;
        if(strcmp($type,'thumb') == 0) {
            $top = DI()->config->get('app.THUMB_DIR');
        } else if(strcmp($type,'upload') == 0) {
            $top = DI()->config->get('app.THUMB_DIR');
        } else if(strcmp($type,'backup') == 0) {
            $top = DI()->config->get('app.THUMB_DIR');
        }

        if($top == null) {
            DI()->response->setRet(220)->setMsg("没有配置: $type");
            return null;
        }

        if(!is_dir($top)) {
            DI()->response->setRet(220)->setMsg("目录不存在: $top");
            return null;
        }

        //创建根目录
        $top = sprintf('%s/%s', $top,$type);
        if(!is_dir($top)) {
            $res = mkdir($top,0777,true);
            if($res) {
                //chmod($uploadDir,0777);
            } else {
                //返回错误信息
                DI()->response->setRet(220)->setMsg("创建上传目录失败: $top");
                return null;
            }
        }

        //按日期创建目录，每月一个
        $stime = date("Y-m",$time);
        $top = sprintf('%s/%s/', $top, $stime);
        //如果目录不存在，则创建
        if(!is_dir($top)) {
            $res = mkdir($top,0777,true);
            if($res) {
                //chmod($uploadDir,0777);
            } else {
                //返回错误信息
                DI()->response->setRet(220)->setMsg("创建上传目录失败: $top");
                return null;
            }
        }

        return "$top";
    }

    public function checkThumb($time) {
        return checkDir('thumb',$time);
    }

    public function checkUpload($time) {
        return checkDir('upload',$time);
    }

    public function checkBackup($time) {
        return checkDir('backup',$time);
    }
}