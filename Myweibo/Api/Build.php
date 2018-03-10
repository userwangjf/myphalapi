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

            'makeThumb' => array(

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

        //获取图片的创建时间
        $src_time = filectime($srcFile);
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

    public function shellMovieThumb($movie,$thumb) {
        $cmd = "/usr/bin/ffmpeg -ss 2 -i $movie -y -f image2  -vframes 1 $thumb";
        shell_exec("$cmd");
    }

    //单独处理，避免超时
    public function makeThumb() {

        $movie = "/home/wangjf/backup/movie/test_mp4.mp4";
        $pic = $movie.".jpg";
        $this->shellMovieThumb($movie,$pic);

        $movie = "/home/wangjf/backup/movie/test_flv.flv";
        $pic = $movie.".jpg";
        $this->shellMovieThumb($movie,$pic);

        $movie = "/home/wangjf/backup/movie/test_mkv.mkv";
        $pic = $movie.".jpg";
        $this->shellMovieThumb($movie,$pic);

        $movie = "/home/wangjf/backup/movie/test_mov.mov";
        $pic = $movie.".jpg";
        $this->shellMovieThumb($movie,$pic);

        $movie = "/home/wangjf/backup/movie/test_wmv.wmv";
        $pic = $movie.".jpg";
        $this->shellMovieThumb($movie,$pic);

        $movie = "/home/wangjf/backup/movie/test_mpg.mpg";
        $pic = $movie.".jpg";
        $this->shellMovieThumb($movie,$pic);

        $movie = "/home/wangjf/backup/movie/test_mpeg.mpeg";
        $pic = $movie.".jpg";
        $this->shellMovieThumb($movie,$pic);


        if(function_exists('read_exif_data')) {
            return "read_exif_data ok";
        } else {
            return "read_exif_data fail";
        }

        //创建缩略图
        /*
        $dst_path = $checkDir->checkThumb($src_time);
        if($dst_path == null) return null;
        $dst_path = $dst_path.'/'.$dst_name;
        $imgThumbs = new Domain_ImgThumb();
        $imgThumbs->resizeImage($srcFile,$dst_path,1080,1080);
        unset($imgThumbs);
        */
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
                        if(checkFileType($fname)) {
                            $this->total += 1;
                        }
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
                    $fname = $dir."/".$file;
                    if(is_dir($fname)) {
                        $this->scanDir($fname);
                    } else {
                        if(checkFileType($fname)) {
                            session_start();
                            $build_count = $_SESSION['build_count'];
                            $build_count++;
                            $_SESSION['build_count'] = $build_count;
                            session_write_close();
                            sleep(1);
                            $this->moveFile($fname);
                        }
                    }
                }
            }
            closedir($handle);
        }
    }


    public function ffmpegThumb() {

        extension_loaded('ffmpeg');

        $movie = "/home/wangjf/backup/movie/test_avi.avi";
        $mov = new ffmpeg_movie($movie);
        $arr = array();
        array_push($arr,sprintf("file name = %s\n", $mov->getFileName()));
        array_push($arr,sprintf("duration = %s seconds\n", $mov->getDuration()));
        array_push($arr,sprintf("frame count = %s\n", $mov->getFrameCount()));
        array_push($arr,sprintf("frame rate = %0.3f fps\n", $mov->getFrameRate()));
        array_push($arr,sprintf("comment = %s\n", $mov->getComment()));
        array_push($arr,sprintf("title = %s\n", $mov->getTitle()));
        array_push($arr,sprintf("author = %s\n", $mov->getAuthor()));
        array_push($arr,sprintf("copyright = %s\n", $mov->getCopyright()));
        array_push($arr,sprintf("get bit rate = %d\n", $mov->getBitRate()));
        array_push($arr,sprintf("has audio = %s\n", $mov->hasAudio() == 0 ? 'No' : 'Yes'));


        if ($mov->hasVideo()) {
            array_push($arr,sprintf("frame height = %d pixels\n", $mov->getFrameHeight()));
            array_push($arr,sprintf("frame width = %d pixels\n", $mov->getFrameWidth()));
            array_push($arr,sprintf("get video stream id= %s\n", $mov->getVideoStreamId()));
            array_push($arr,sprintf("get video codec = %s\n", $mov->getVideoCodec()));
            array_push($arr,sprintf("get video bit rate = %d\n", $mov->getVideoBitRate()));
            array_push($arr,sprintf("get pixel format = %s\n", $mov->getPixelFormat()));
            array_push($arr,sprintf("get pixel aspect ratio = %s\n", $mov->getPixelAspectRatio()));
            //下一行不能工作。
            //$frame = $mov->getFrame(10);
            //array_push($arr,sprintf("get frame = %s\n", is_object($frame) ? 'true' : 'false'));
            //array_push($arr,sprintf("  get frame number = %d\n", $mov->getFrameNumber()));
            //array_push($arr,sprintf("  get frame width = %d\n", $frame->getWidth()));
            //array_push($arr,sprintf("  get frame height = %d\n", $frame->getHeight()));
        }
    }

}