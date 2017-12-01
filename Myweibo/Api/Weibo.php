<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 17-10-25
 * Time: 下午9:16
 */


define("URL_UPLOAD","http://192.168.1.101/phalapi/myweibo/uploads");


class Api_Weibo extends PhalApi_Api
{


    public function getRules() {
        return array(
            'addWeibo' => array(
                'username' 	=> array('name' => 'username', 'default' => 'PHPer', ),
            ),
            'makeWeibo' => array(

            ),
            'getWeibo' => array(
                'page' 	=> array('name' => 'page', 'type' => 'int', 'min' => 0, 'max' => 10),
                'count' => array('name' => 'count', 'type' => 'int', 'min' => 5, 'max' => 50),
            ),
        );
    }

    /*
     * 从服务器获取新的微博
     *
     */
    public function getWeibo(){

        $dm_weibo = new Domain_Weibo();
        //return array('page'=>$this->page,'count'=>$this->count);
        return $dm_weibo->getWeibo($this->page,$this->count);
    }

    //使用json格式上传微博
    //包括2个参数weibo/pics
    public function makeWeibo() {

        $picture = null;
        $weibo = null;

        if(!isset($_POST['weibo'])) {
            DI()->response->setRet(202)->setMsg("未找到正确的微博");
            return "";
        }

        //$weibo = array();
        $weibo = json_decode($_POST['weibo'],true);
        $weibo['id'] = 0;
        $weibo['isturn'] = 0;
        $weibo['iscomment'] = 0;
        $weibo['time'] = time();
        $weibo['praise'] = 0;
        $weibo['turn'] = 0;
        $weibo['collect'] = 0;
        $weibo['comment'] = 0;
        $weibo['uid'] = 0;
        //return $weibo;

        //如果没有图片，则开始更新数据库
        if(!isset($_POST['pics'])) {
            goto _make_weibo_db;
        }

        //按上传日期，准备上传目录
        $stime = date("Y/m",time());
        $uploadDir = sprintf('%s/Public/myweibo/uploads/%s/', API_ROOT,$stime);
        //如果目录不存在，则创建
        if(!is_dir($uploadDir)) {
            $res = mkdir($uploadDir,0777,true);
            if($res) {
                chmod($uploadDir,0777);
            } else {
                //返回错误信息
                DI()->response->setRet(201)->setMsg("创建上传目录失败");
                return "";
            }
        }

        //拷贝文件到目标
        $picFile = $_FILES['uploadfile'];
        $picInfo = json_decode($_POST['pics'],true);
        $picInfo = $picInfo['picInfos'];
        //return $picInfo;

        $picture = array();
        for($i=0;$i<count($picFile['name']);$i++)
        {
            //获取图片的拍摄时间
            if(isset($picInfo[$i]['ctime']))
                $ctime = strtotime($picInfo[$i]['ctime']);
            else
            {
                DI()->response->setRet(201)->setMsg("上传文件的ctime不完整: ".$i);
                return "";
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

                array_push($picture,array('picture' => "$urlPath",'ctime' => $ctime));
            } else {
                //返回错误信息
                DI()->response->setRet(201)->setMsg("拷贝文件失败");
                return "";
            }
        }
        //return array("weibo"=>$weibo,"pic"=>$picture);

        _make_weibo_db:

        //将新的微博写入数据库，并获取微博ID
        $dm_weibo = new Domain_Weibo();

        //weibo和picture是分开的表项
        $id = $dm_weibo->addWeibo($weibo,$picture);

        //返回完整的信息。
        $weibo['id'] = $id;
        $weibo['pic'] = $picture;

        return $weibo;

    }


    public function addWeibo()
    {

        $weibo = array();
        $picture = array();

        $weibo['id'] = '0';

        //微博类别
        if(isset($_POST['type'])) {
            $weibo['type'] = $_POST['type'];
        } else {
            $weibo['type'] = '公开';
        }

        //微博内容
        if(isset($_POST['content'])) {
            $weibo['content'] = $_POST['content'];
        } else {
            $weibo['content'] = '';
        }

        //是否转发(0原创，否则记录转发的ID)
        if(isset($_POST['isturn'])) {
            $weibo['isturn'] = $_POST['isturn'];
        } else {
            $weibo['isturn'] = 0;
        }

        //是否转发(0原创，否则记录评论的ID)
        if(isset($_POST['iscomment'])) {
            $weibo['iscomment'] = $_POST['iscomment'];
        } else {
            $weibo['iscomment'] = 0;
        }

        //发表时间
        $weibo['time'] = time();

        //赞次数
        $weibo['praise'] = 0;

        //转发次数
        $weibo['turn'] = 0;

        //收藏次数
        $weibo['collect'] = 0;

        //评论条数
        $weibo['comment'] = 0;

        //所属用户id
        if(isset($_POST['uid'])) {
            $weibo['uid'] = $_POST['uid'];
        } else {
            $weibo['uid'] = 0;
        }

        //$dm_weibo = new Domain_Weibo();


        //处理图片

        //处理图片和图片的时间
        $ctime = $_POST['ctime'];
        $pic = $_FILES['uploadfile'];

        //按上传日期，准备上传目录
        $stime = date("Y/m",time());
        $uploadDir = sprintf('%s/Public/myweibo/uploads/%s/', API_ROOT,$stime);
        //如果目录不存在，则创建
        if(!is_dir($uploadDir)) {
            $res = mkdir($uploadDir,0777,true);
            if($res) {
                chmod($uploadDir,0777);
            } else {
                //返回错误信息
                DI()->response->setRet(201)->setMsg("创建上传目录失败");
            }
        }

        //拷贝文件到目标
        for($i=0;$i<count($pic['name']);$i++)
        {

            if($pic['size'][$i] == 0)continue;

            //获取源文件的扩展名
            $extName = strrchr($pic['name'][$i], '.');

            //使用源文件名和当前时间计算新的文件名
            $dstName = md5($pic['name'][$i].time());
            $dstName = $dstName . $extName;

            $srcPath = $pic['tmp_name'][$i];
            $dstPath = $uploadDir . $dstName;

            if (move_uploaded_file($srcPath, $dstPath)) {
                $urlPath = sprintf("%s/%s/%s",'uploads',$stime,$dstName);
                array_push($picture,array('picture' => "$urlPath",'ctime' => "$ctime[$i]"));
            } else {
                //返回错误信息
                DI()->response->setRet(201)->setMsg("拷贝文件失败");
            }
        }


        //将新的微博写入数据库，并获取微博ID
        $dm_weibo = new Domain_Weibo();

        //weibo和picture是分开的表项
        $id = $dm_weibo->addWeibo($weibo,$picture);

        //返回完整的信息。
        $weibo['id'] = $id;
        $weibo['pic'] = $picture;

        return $weibo;
    }

}

