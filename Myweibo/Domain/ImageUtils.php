<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 18-3-6
 * Time: 下午6:59
 */


Class Domain_ImageUtils {

    /**
     * description: 图像等比例压缩
     * @param $path 输出路径
     * @param null $out_path 输出路径
     * @param int $max_width 最大宽度
     * @param int $max_height 最大高度
     * @return bool
     */
    public function resizeImage($path, $out_path = null, $max_width = 800, $max_height = 800)
    {
        try {
            $im = imagecreatefromjpeg($path);
            $width = imagesx($im);
            $height = imagesy($im);
            $resize_width_tag = false;
            $resize_height_tag = false;
            $width_ratio = 1;
            $height_ratio = 1;
            if (!is_dir(dirname($out_path))) {
                mkdir(dirname($out_path), 0755, true);
            }
            if (($max_width && $width > $max_width) || ($max_height && $height > $max_height)) {
                if ($max_width && $width > $max_width) {
                    $width_ratio = $max_width / $width;
                    $resize_width_tag = true;
                }
                if ($max_height && $height > $max_height) {
                    $height_ratio = $max_height / $height;
                    $resize_height_tag = true;
                }
                if ($resize_width_tag && $resize_height_tag) {
                    if ($width_ratio < $height_ratio)
                        $ratio = $width_ratio;
                    else
                        $ratio = $height_ratio;
                }
                if ($resize_width_tag && !$resize_height_tag)
                    $ratio = $width_ratio;
                if ($resize_height_tag && !$resize_width_tag)
                    $ratio = $height_ratio;
                $new_width = $width * $ratio;
                $new_height = $height * $ratio;
                if (function_exists("imagecopyresampled")) {
                    $new_im = imagecreatetruecolor($new_width, $new_height);
                    imagecopyresampled($new_im, $im, 0, 0, 0, 0, $new_width, $new_height, $width, $height);
                } else {
                    $new_im = imagecreate($new_width, $new_height);
                    imagecopyresized($new_im, $im, 0, 0, 0, 0, $new_width, $new_height, $width, $height);
                }
                $res = imagejpeg($new_im, !empty($out_path) ? $out_path : $path);
                imagedestroy($new_im);
            } else {
                $res = imagejpeg($im, !empty($out_path) ? $out_path : $path);
            }
            return true;
        } catch (\Exception $e) {
            return false;
        }
    }


    /**
     * 取拍照日期
     * @desc 默认获取拍摄时间，如果找不到，则返回文件的修改时间
     * @param string $filePathName 照片完整路径
     * @return  int 返回时间戳
     *
     */
    public function  getDateTimeOriginal($filePathName) {

        if(IMAGETYPE_JPEG != exif_imagetype($filePathName)) {
            return filemtime($filePathName);
        }

        $exif = exif_read_data($filePathName, 'EXIF', true);
        if(empty($exif['EXIF']) || empty($exif['EXIF']['DateTimeOriginal']))
        {
            return filemtime($filePathName);
        }
        else
            $date_time_original = $exif['EXIF']['DateTimeOriginal'];//string(19) "2011:03:13 10:23:09"

        $tmp_timestamp  = strtotime($date_time_original);
        return $tmp_timestamp;
    }

    public function getAllExif($fname) {
        //$exif = exif_read_data($fname, 'IFD0');

        $exif = exif_read_data($fname, 0, true);

        $ret = "";
        foreach ($exif as $key => $section) {
            foreach ($section as $name => $val) {
                $ret = $ret . "$key.$name:\n";
            }
        }

        return $ret;
    }


}