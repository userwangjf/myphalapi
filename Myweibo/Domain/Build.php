<?php
/**
 * 手动将历史图片加入数据库
 * User: wangjf
 * Date: 18-3-6
 * Time: 下午8:02
 */

class Domain_Build {

    private $total = 0;

    //搜索原始目录的图片，建立数据库
    public function addManual($src_path) {


        $myfile = fopen(__DIR__."/lock.build","a");
        fputs($myfile,"lock");
        fclose($myfile);

        $src_path = "/home/wangjf/backup/camera";
        $this->total = 0;
        $this->scanDir($src_path);
        return $this->total;
    }

    private function moveFile($srcFile) {

        //获取图片的创建时间
        $src_time = filectime($srcFile);
        $src_md5 = md5_file($srcFile);
        $ext_name = strrchr($srcFile, '.');
        $dst_name = $src_time.'-'.substr($src_md5,16).$ext_name;

        //建立目录
        $checkDir = new Domain_CheckPath();

        //拷贝upload
        $dst_path = $checkDir->checkUpload($src_time);
        if($dst_path == null) return null;
        $dst_path = $dst_path.'/'.$dst_name;
        if(!copy($srcFile, $dst_path)) {
            //返回错误信息
            DI()->response->setRet(220)->setMsg("拷贝upload文件失败");
            return null;
        }

        //拷贝backup
        $dst_path = $checkDir->checkBackup($src_time);
        if($dst_path == null) return null;
        $dst_path = $dst_path.'/'.$dst_name;
        if(!copy($srcFile, $dst_path)) {
            //返回错误信息
            DI()->response->setRet(220)->setMsg("拷贝backup文件失败");
            return null;
        }


        //创建缩略图
        $dst_path = $checkDir->checkThumb($src_time);
        if($dst_path == null) return null;
        $dst_path = $dst_path.'/'.$dst_name;
        $imgThumbs = new Domain_ImgThumb();
        $imgThumbs->resizeImage($srcFile,$dst_path,1080,1080);

        return "";

    }

    private function scanDir($dir) {
        //注意这里要加一个@，不然会有warning错误提示：）
        if(@$handle = opendir($dir)) {
            while(($file = readdir($handle)) !== false) {
                //排除根目录；
                if($file != ".." && $file != ".") {
                    //如果是子文件夹，就进行递归
                    if(is_dir($dir."/".$file)) {
                        scanDir($dir."/".$file);
                    } else {
                        $this->total += 1;
                        $this->moveFile($dir."/".$file);
                    }
                }
            }
            closedir($handle);
        }
    }
}