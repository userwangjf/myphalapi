<?php
/**
 * 图片目录
 * User: wangjf
 * Date: 18-3-6
 * Time: 下午7:33
 */


class Model_ImgCategory extends PhalApi_Model_NotORM
{

    public function getTableName($id)
    {
        return "img_category";
    }

    public function getChildCategory($parent) {

    }



}