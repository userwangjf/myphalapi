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
            'build' => array(

            ),

        );
    }


    function build() {

        $dm_build = new Domain_Build();
        return $dm_build->build();

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
                        if($this->checkFileType($fname)) {
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