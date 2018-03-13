

<?php
$towidth = '500';
$toheight = '700'; //设置图片调整大小时允许的最大宽度和高度
$sourcefile = __DIR__.'/aaa.JPG'; //定义一个图像文件路径
//$image->writeImage('./b.jpg.bak'); //可以备份这个图片
$myimage = new Imagick($sourcefile); //读入该图像文件
$exifobject = my_exif($myimage); //自写函数，读取exif信息（拍摄数据），按自己的要求排列exif信息，返回对象
//$myimage->setImageFormat('jpeg'); //把图片转为jpg格式
$myimage->setCompressionQuality(100); //设置jpg压缩质量，1 - 100
$myimage->enhanceImage(); //去噪点
$sourcewidth = $myimage->getImageWidth(); //获取读入图像原始大小
if ($sourcewidth > $towidth) {
    $myimage->scaleImage($towidth, $toheight, true); //调整图片大小
}
$myimage->raiseImage(8, 8, 0, 0, 1); //加半透明边框
$resizewidth = $myimage->getImageWidth(); //读出调整之后的图片大小
$resizeheight = $myimage->getImageHeight();
$drawback = new ImagickDraw(); //实例化一个绘画对象，绘制半透明黑色背景给exif信息用
$drawback->setFillColor(new ImagickPixel('#000000')); //设置填充颜色为黑色
$drawback->setFillOpacity(0.6); //填充透明度为0.6，参数0.1-1，1为不透明
$drawback->rectangle($resizewidth / 2 - 190, $resizeheight - 50, 
$resizewidth / 2 + 190, $resizeheight - 12); //绘制矩形参数，分别为左上角x、y，右下角x、y
$myimage->drawImage($drawback); //确认到image中绘制该矩形框
$draw = new ImagickDraw(); //实例化一个绘画对象，绘制exif文本信息嵌入图片中
$draw->setFont('./xianhei.ttf'); //设置文本字体，要求ttf或者ttc字体，可以绝对或者相对路径
$draw->setFontSize(11); //设置字号
$draw->setTextAlignment(2); //文字对齐方式，2为居中
$draw->setFillColor('#FFFFFF'); //文字填充颜色
$myimage->annotateImage($draw, $resizewidth / 2, $resizeheight - 39, 0, 
$exifobject->row1); //绘制第一行文本，居中
$myimage->annotateImage($draw, $resizewidth / 2, $resizeheight - 27, 0, 
$exifobject->row2); //绘制第二行文本，居中
$myimage->annotateImage($draw, $resizewidth / 2, $resizeheight - 15, 0, 
$exifobject->row3); //绘制第三行文本，居中
/* Output the image with headers */
header('Content-type: image/jpeg'); //php文件输出mime类型为jpeg图片
echo $myimage; //在当前php页面输出图片
//$image->writeImage('./b.new.jpg'); //如果图片不需要在当前php程序中输出，使用写入图片到磁盘函数，上面的设置header也可以去除
$myimage->clear();
$myimage->destroy(); //释放资源
//自写函数，读取exif信息，返回对象
function my_exif ($myimage)
{
    $exifArray = array('exif:Model' => '未知', 'exif:DateTimeOriginal' => '未知', 
    'exif:ExposureProgram' => '未知', 'exif:FNumber' => '0/10', 
    'exif:ExposureTime' => '0/10', 'exif:ISOSpeedRatings' => '未知', 
    'exif:MeteringMode' => '未知', 'exif:Flash' => '关闭闪光灯', 
    'exif:FocalLength' => '未知', 'exif:ExifImageWidth' => '未知', 
    'exif:ExifImageLength' => '未知'); //初始化部分信息，防止无法读取照片exif信息时运算发生错误
    $exifArray = $myimage->getImageProperties("exif:*"); //读取图片的exif信息，存入$exifArray数组
    //如果需要显示原数组可以使用print_r($exifArray);
    //$r->row1 = '相机:' . $exifArray['exif:Model'];
    //$r->row1 = $r->row1 . ' 拍摄时间:' . $exifArray['exif:DateTimeOriginal'];
    switch ($exifArray['exif:ExposureProgram']) {
        case 1:
            $exifArray['exif:ExposureProgram'] = "手动(M)";
            break; //Manual Control
        case 2:
            $exifArray['exif:ExposureProgram'] = "程序自动(P)";
            break; //Program Normal
        case 3:
            $exifArray['exif:ExposureProgram'] = "光圈优先(A,Av)";
            break; //Aperture Priority
        case 4:
            $exifArray['exif:ExposureProgram'] = "快门优先(S,Tv)";
            break; //Shutter Priority
        case 5:
            $exifArray['exif:ExposureProgram'] = "慢速快门";
            break; //Program Creative (Slow Program)
        case 6:
            $exifArray['exif:ExposureProgram'] = "运动模式";
            break; //Program Action(High-Speed Program)
        case 7:
            $exifArray['exif:ExposureProgram'] = "人像";
            break; //Portrait
        case 8:
            $exifArray['exif:ExposureProgram'] = "风景";
            break; //Landscape
        default:
            $exifArray['exif:ExposureProgram'] = "其它";
    }
    $r->row1 = $r->row1 . ' 模式:' . $exifArray['exif:ExposureProgram'];
    $exifArray['exif:FNumber'] = explode('/', $exifArray['exif:FNumber']);
    $exifArray['exif:FNumber'] = $exifArray['exif:FNumber'][0] /
     $exifArray['exif:FNumber'][1];
    $r->row2 = '光圈:F/' . $exifArray['exif:FNumber'];
    $exifArray['exif:ExposureTime'] = explode('/', 
    $exifArray['exif:ExposureTime']);
    if (($exifArray['exif:ExposureTime'][0] / $exifArray['exif:ExposureTime'][1]) >=
     1) {
        $exifArray['exif:ExposureTime'] = sprintf("%.1fs", 
        (float) $exifArray['exif:ExposureTime'][0] /
         $exifArray['exif:ExposureTime'][1]);
    } else {
        $exifArray['exif:ExposureTime'] = sprintf("1/%ds", 
        $exifArray['exif:ExposureTime'][1] / $exifArray['exif:ExposureTime'][0]);
    }
    $r->row2 = $r->row2 . ' 快门:' . $exifArray['exif:ExposureTime'];
    $r->row2 = $r->row2 . ' ISO:' . $exifArray['exif:ISOSpeedRatings'];
    $exifArray['exif:ExposureBiasValue'] = explode("/", 
    $exifArray['exif:ExposureBiasValue']);
    $exifArray['exif:ExposureBiasValue'] = sprintf("%1.1feV", 
    ((float) $exifArray['exif:ExposureBiasValue'][0] /
     $exifArray['exif:ExposureBiasValue'][1] * 100) / 100);
    if ((float) $exifArray['exif:ExposureBiasValue'] > 0) {
        $exifArray['exif:ExposureBiasValue'] = "+" .
         $exifArray['exif:ExposureBiasValue'];
    }
    $r->row2 = $r->row2 . ' 补偿:' . $exifArray['exif:ExposureBiasValue'];
    switch ($exifArray['exif:MeteringMode']) {
        case 0:
            $exifArray['exif:MeteringMode'] = "未知";
            break;
        case 1:
            $exifArray['exif:MeteringMode'] = "矩阵";
            break;
        case 2:
            $exifArray['exif:MeteringMode'] = "中央重点平均";
            break;
        case 3:
            $exifArray['exif:MeteringMode'] = "点测光";
            break;
        case 4:
            $exifArray['exif:MeteringMode'] = "多点测光";
            break;
        default:
            $exifArray['exif:MeteringMode'] = "其它";
    }
    $r->row2 = $r->row2 . ' 测光:' . $exifArray['exif:MeteringMode'];
    switch ($exifArray['exif:Flash']) {
        case 1:
            $exifArray['exif:Flash'] = "开启闪光灯";
            break;
    }
    $r->row2 = $r->row2 . '' . $exifArray['exif:Flash'];
    if ($exifArray['exif:FocalLengthIn35mmFilm']) {
        $r->row3 = '等效焦距:' . $exifArray['exif:FocalLengthIn35mmFilm'] . "mm";
    } else {
        $exifArray['exif:FocalLength'] = explode("/", 
        $exifArray['exif:FocalLength']);
        $exifArray['exif:FocalLength'] = sprintf("%4.1fmm", 
        (double) $exifArray['exif:FocalLength'][0] /
         $exifArray['exif:FocalLength'][1]);
        $r->row3 = '焦距:' . $exifArray['exif:FocalLength'];
    }
    $r->row3 = $r->row3 . ' 原始像素:' . $exifArray['exif:ExifImageWidth'] . 'x' .
     $exifArray['exif:ExifImageLength'] . 'px';
    if ($exifArray['exif:Software']) {
        $r->row3 = $r->row3 . ' 后期:' . $exifArray['exif:Software'];
    }
    return $r;
}
?>


