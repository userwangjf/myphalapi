<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 18-3-10
 * Time: 下午6:36
 */

class Domain_Build {

    private $total = 0;
    private $flist = null;
    private $src_path = "/home/wangjf/backup/camera";

    //搜索原始目录的图片，建立数据库
    public function build() {

        if($this->src_path == null) {
            return "no file";
        }

        //检查任务是否正在运行
        if($this->isRuning()) {
            $build_total = $this->getSession('build_total');
            $build_count = $this->getSession('build_count');
            return "runing: $build_count/$build_total";
        }

        $fname = __DIR__."/build.lst";

        if($this->getSession('build_total') == null) {
            //搜索目录，建立文件列表文件
            if(is_file($fname)) {
                if (!unlink($fname)) {
                    return ("Error deleting $fname");
                }
            }

            $this->flist = fopen($fname,"a");

            $this->scanDir($this->src_path);

            fclose($this->flist);

            $this->setSession('build_total',$this->total);
            $this->setSession('build_count','0');

            $build_total = $this->getSession('build_total');
            $build_count = $this->getSession('build_count');
            return "find file: $build_count/$build_total";
        } else {


            $flist = fopen("$fname","r");
            $build_total = $this->getSession('build_total');
            $build_count = (int)$this->getSession('build_count');
            //return "start : $build_count/$build_total";
            //跳过已经处理过的
            if($build_count > 0) {
                for($i=0;$i<$build_count;$i++) {
                    if(!fgets($flist))
                        return "read file error";
                }
            }
            //return "start : $build_count/$build_total";

            /*
            $line=fgets($flist);
            $this->moveFile(trim($line));
            $build_count = (int)$this->getSession('build_count');
            $build_count++;
            $this->setSession('build_count',$build_count);
            fclose($flist);
            return "$build_count:".trim($line);
            */

            while($line=fgets($flist)) {
                $this->moveFile(trim($line));
                $build_count = (int)$this->getSession('build_count');
                $build_count++;
                $this->setSession('build_count',$build_count);
                sleep(1);//for test
            }

            fclose($flist);

            $this->setSession('build_total',null);
            $this->setSession('build_count',null);

            return "All File Copy";
        }

    }

    /**
     * 检查前一次的处理是否正在运行中
     * @return bool
     */
    public function isRuning()
    {
        $start = $this->getSession('build_count');
        if($start == null) return false;
        sleep(2);
        $end = $this->getSession('build_count');
        if($start != $end) {
            return true;
        } else {
            return false;
        }

    }

    public function getSession($name) {
        session_start();
        if(isset($_SESSION[$name])) {
            $ret = $_SESSION[$name];
        } else {
            session_write_close();
            return null;
        }
        session_write_close();
        return $ret;
    }

    /**
     * 设置session。
     * @param $name session名字
     * @param $value 为null，则unset
     */
    public function setSession($name,$value) {
        session_start();
        if($value == null) {
            if(isset($_SESSION[$name]))
                unset($_SESSION[$name]);
        } else {
            $_SESSION[$name] = $value;
        }
        session_write_close();
    }

    /*
 *   `id` INT(10) UNSIGNED NOT NULL COMMENT '图片id',
`uid` INT(10) UNSIGNED NOT NULL COMMENT '创建人',
`filesize` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文件字节大小',
`width` INT(10) UNSIGNED DEFAULT NULL COMMENT '原始图片宽度',
`height` INT(10) UNSIGNED DEFAULT NULL COMMENT '原始图片高度',
`twidth` INT(10) UNSIGNED DEFAULT NULL COMMENT '缩略图宽度',
`theight` INT(10) UNSIGNED DEFAULT NULL COMMENT '缩略图高度',
`ctime` INT(10) UNSIGNED NOT NULL COMMENT '图片的原始创建时间',
`time` INT(10) UNSIGNED NOT NULL COMMENT '记录创建时间',
`visible` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '是否可见,是否删除',
`md5sum` CHAR(32) DEFAULT NULL COMMENT '图片唯一性检查',
`save` VARCHAR(63) DEFAULT NULL COMMENT '原图的路径',
`thumb` VARCHAR(63) DEFAULT NULL COMMENT '缩略图的路径',
`postion` VARCHAR(63) DEFAULT NULL COMMENT '拍摄地址',
`expand` VARCHAR(63) DEFAULT NULL COMMENT '存储扩展位置',
`extension` VARCHAR(255) DEFAULT NULL COMMENT '扩展信息',
 */
    private function moveFile($srcFile) {

        $imageUtils = new ImageUtils();

        //获取图片的创建时间
        $src_time = $imageUtils->getDateTimeOriginal($srcFile);
        $src_md5 = md5_file($srcFile);
        $ext_name = strrchr($srcFile, '.');
        $dst_name = $src_time.'-'.substr($src_md5,16).$ext_name;

        $picInfo = array();
        $picInfo['uid'] = 0;
        $picInfo['filesize'] = filesize($srcFile);
        $picInfo['width'] = 0;
        $picInfo['height'] = 0;
        $picInfo['twidth'] = 0;
        $picInfo['theight'] = 0;
        $picInfo['ctime'] = $src_time;
        $picInfo['time'] = time();
        $picInfo['visible'] = 'true';
        $picInfo['md5sum'] = $src_md5;

        //建立目录
        $checkDir = new Domain_CheckPath();

        //拷贝upload
        $dst_path = $checkDir->checkUpload($src_time);
        $picInfo['save'] = $dst_path;
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


        return "";

    }

    /**
     * 从视频文件获取截图
     * @desc 使用命令行模式来处理
     * @param $movie
     * @param $thumb
     */
    public function shellMovieThumb($movie,$thumb) {
        $cmd = "/usr/bin/ffmpeg -ss 2 -i $movie -y -f image2  -vframes 1 $thumb";
        shell_exec("$cmd");
    }


    private function scanDir($dir) {
        //注意这里要加一个@，不然会有warning错误提示：）
        if(@$handle = opendir($dir)) {
            while(($file = readdir($handle)) !== false) {
                //排除根目录；
                if($file != ".." && $file != ".") {
                    //如果是子文件夹，就进行递归
                    $fname = $dir."/".$file;
                    if(is_dir($fname)) {
                        $this->scanDir($fname);
                    } else {
                        if($this->checkFileType($fname)) {
                            $this->total += 1;
                            fputs($this->flist,$fname."\n");
                        }
                    }
                }
            }
            closedir($handle);
        }
    }


    /**
     * 检查文件类型是否满足要求
     * @param $filename
     * @return bool
     */
    public function checkFileType($filename) {
        $ext = strtolower(strrchr($filename, '.'));

        if(strcmp($ext,".jpg") == 0) {
            return true;
        } else if(strcmp($ext,".mp4") == 0) {
            return true;
        }

        return false;

    }


}