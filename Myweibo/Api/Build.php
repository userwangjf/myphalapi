<?php
/**
 * 手动将历史图片加入数据库
 * User: wangjf
 * Date: 18-3-6
 * Time: 下午8:02
 */

class Api_Build extends PhalApi_Api {


    public function getRules() {
        return array(
            'getTotal' => array(

            ),

            'getRatio' => array(

            ),

            'buildData' => array(

            ),

        );
    }


    private $total = 0;
    private $myfile = null;
    private $src_path = "/home/wangjf/backup/camera";

    //搜索原始目录的图片，建立数据库
    public function getTotal() {

        session_start();

        $this->scanDir($this->src_path);

        $_SESSION['build_total'] = $this->total;
        $_SESSION['build_count'] = 0;

        return "Find File: ".$this->total;
    }

    /**
     * 获取当前处理的进展
     * @desc 返回0表示停止，返回-1表示错误。
     * @return int
     */
    public function getRatio()
    {
        session_start();
        if (isset($_SESSION['build_count'])) {
            $end = $_SESSION['build_count'];
            $build_total = $_SESSION['build_total'];
            if($end == $build_total) {
                unset($_SESSION['build_total']);
                unset($_SESSION['build_count']);
                return "$end/$build_total";
            } else {
                return "$end/$build_total";
            }
        } else {
            return -1;
        }

    }

    public function buildData() {

        session_start();

        if(!isset($_SESSION['build_total'])) {
            return "Please run Build.getTotal at first";
        }

        if(!isset($_SESSION['build_count'])) {
            return "Please run Build.getTotal at first";
        }

        if($_SESSION['build_count'] == $_SESSION['build_total']) {
            $build_total = $_SESSION['build_total'];
            $build_count = $_SESSION['build_count'];

            unset($_SESSION['build_total']);
            unset($_SESSION['build_count']);

            return "$build_count/$build_total";
        }
        session_write_close();

        $this->findDir($this->src_path);

        session_start();
        $build_total = $_SESSION['build_total'];
        $build_count = $_SESSION['build_count'];

        unset($_SESSION['build_total']);
        unset($_SESSION['build_count']);
        session_write_close();

        return "$build_count/$build_total";
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
        //$imgThumbs->resizeImage($srcFile,$dst_path,1080,1080);

        $imgThumbs = null;
        $checkDir = null;

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
                        $this->scanDir($dir."/".$file);
                    } else {
                        $this->total += 1;
                    }
                }
            }
            closedir($handle);
        }
    }

    private function findDir($dir) {
        //注意这里要加一个@，不然会有warning错误提示：）
        if(@$handle = opendir($dir)) {
            while(($file = readdir($handle)) !== false) {
                //排除根目录；
                if($file != ".." && $file != ".") {
                    //如果是子文件夹，就进行递归
                    if(is_dir($dir."/".$file)) {
                        $this->scanDir($dir."/".$file);
                    } else {
                        session_start();
                        $build_count = $_SESSION['build_count'];
                        $build_count++;
                        $_SESSION['build_count'] = $build_count;
                        session_write_close();
                        sleep(1);
                        $this->moveFile($dir."/".$file);
                    }
                }
            }
            closedir($handle);
        }
    }
}