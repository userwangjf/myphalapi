<?php
/**
 * Created by PhpStorm.
 * User: wangjf
 * Date: 17-11-2
 * Time: 下午8:47
 */


class Domain_Weibo {

    public function getWeibo($page,$count) {

        $weiboModel = new Model_Weibo();
        $pictureModel = new Model_Picture();

        //先查找微搏的id
        $id = $weiboModel->getIdNew($page,$count);
        //然后使用id查询微搏和图片
        $weibo = $weiboModel->getWeibo($id);
        $pic = $pictureModel->getPicture($id);

        //将图片拼接到微博数组里
        for($i=0;$i<count($weibo);$i++)
        {
            $arr = array();
            for($j=0;$j<count($pic);$j++)
            {
                //$weibo[$i]['pic'] = "";
                if($pic[$j]['wid'] == $weibo[$i]['id'])
                {
                    array_push($arr, array('url'=>$pic[$j]['picture'], 'ctime'=>$pic[$j]['ctime']));
                }
            }
            if(count($arr))
                $weibo[$i]['pic'] = $arr;
            else
                $weibo[$i]['pic'] = array();
        }

        return array('weibo' => $weibo);
    }





    //返回新创建的微博信息
    public function addWeibo($weibo, $picture)
    {
        //添加新微博，并获取微博ID
        $model = new Model_Weibo();
        $id = $model->addWeibo($weibo);

        //添加图片
        $model = new Model_Picture();
        for($i=0;$i<count($picture);$i++) {
            $pic['wid'] = $id;
            $pic['picture'] = $picture[$i]['picture'];
            $pic['ctime'] = $picture[$i]['ctime'];
            $model->addPicture($pic);
        }

        return $id;
    }

}
