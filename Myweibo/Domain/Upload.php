<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 18-2-14
 * Time: 上午7:24
 */


class Domain_Upload {

    public function uploadPic() {

        //检测是否有上传文件
        if(!isset($_FILES['uploadfile']))
            return true;

        //读入上传目录配置
        $uploadDir = DI()->config->get('app.UPLOAD_DIR');
        if(!is_dir($uploadDir)) {
            DI()->response->setRet(220)->setMsg("目录不存在：".$uploadDir);
            return null;
        }

        //创建根目录
        $uploadDir = sprintf('%s/uploads', $uploadDir);
        if(!is_dir($uploadDir)) {
            $res = mkdir($uploadDir,0777,true);
            if($res) {
                chmod($uploadDir,0777);
            } else {
                //返回错误信息
                DI()->response->setRet(220)->setMsg("创建上传目录失败");
                return null;
            }
        }

        //按日期创建目录，每月一个
        $stime = date("Y-m",time());
        $uploadDir = sprintf('%s/%s/', $uploadDir, $stime);
        //如果目录不存在，则创建
        if(!is_dir($uploadDir)) {
            $res = mkdir($uploadDir,0777,true);
            if($res) {
                chmod($uploadDir,0777);
            } else {
                //返回错误信息
                DI()->response->setRet(220)->setMsg("创建上传目录失败");
                return null;
            }
        }

        //创建backup目录

        //读入备份目录配置
        $backupDir = DI()->config->get('app.BACKUP_DIR');
        if(is_dir($backupDir)) {

            //创建根目录
            $backupDir = sprintf('%s/uploads', $backupDir);
            if(!is_dir($backupDir)) {
                $res = mkdir($backupDir,0777,true);
                if($res) {
                    chmod($backupDir,0777);
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
                    chmod($backupDir,0777);
                } else {
                    //返回错误信息
                    DI()->response->setRet(220)->setMsg("创建备份目录失败"."$backupDir");
                    return null;
                }
            }
        }

        //拷贝文件到目标
        $picFile = $_FILES['uploadfile'];
        $picInfo = json_decode($_POST['pics'],true);
        $picInfo = $picInfo['picInfos'];

        $picture = array();
        for($i=0;$i<count($picFile['name']);$i++)
        {
            //获取图片的拍摄时间
            if(isset($picInfo[$i]['ctime']))
                $ctime = strtotime($picInfo[$i]['ctime']);
            else
            {
                DI()->response->setRet(220)->setMsg("上传文件的ctime不完整: ".$i);
                return null;
            }

            if($picFile['size'][$i] == 0)continue;

            //获取源文件的扩展名
            $extName = strrchr($picFile['name'][$i], '.');

            //使用源文件名和当前时间计算新的文件名
            $dstName = $ctime."-".substr(md5($picFile['name'][$i].time()),0,16);
            $dstName = $dstName . $extName;

            $srcPath = $picFile['tmp_name'][$i];
            $dstPath = $uploadDir . $dstName;

            if (move_uploaded_file($srcPath, $dstPath)) {
                $urlPath = sprintf("%s/%s/%s",'uploads',$stime,$dstName);

                $fileMD5 = md5_file($dstPath);
                array_push($picture,array('picture'=>$urlPath,'ctime'=>$ctime,'md5'=>$fileMD5));

            } else {
                //返回错误信息
                DI()->response->setRet(220)->setMsg("拷贝文件失败");
                return null;
            }

            if(is_dir($backupDir)) {
                //拷贝文件到backup目录
                $bakPath = sprintf("%s/%s",$backupDir,$dstName);
                if(!copy($dstPath, $bakPath)) {
                    //返回错误信息
                    DI()->response->setRet(220)->setMsg("备份文件失败");
                    return null;
                }
            }

        }

        return $picture;
    }

    /**
     * 生成磁盘空间的告警信息
     * @return string
     */
    public function checkFree() {

        $upload = 5*1024*1024*1024;
        $path = DI()->config->get('app.UPLOAD_DIR');
        if($path) {
            if(is_dir($path)) {
                $upload = disk_free_space($path);
            }
        }

        $backup = 5*1024*1024*1024;
        $path = DI()->config->get('app.UPLOAD_BAK');
        if($path) {
            if(is_dir($path)) {
                $backup = disk_free_space($path);
            }
        }

        //小于1GB，则返回告警信息
        if($upload < $backup) {
            if($upload < (1*1024*1024*1024)) {
                return "警告：upload目录小于1GB";
            }
        } else {
            if($backup < (1*1024*1024*1024)) {
                return "警告：backup目录小于1GB";
            }
        }

        return "upload目录：".$upload;
    }

}