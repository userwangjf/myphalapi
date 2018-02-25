<?php
/**
 * 请在下面放置任何您需要的应用配置
 */

return array(

    /**
     * 应用接口层的统一参数
     */
    'apiCommonRules' => array(
        //'sign' => array('name' => 'sign', 'require' => true),
    ),

    /**
     * 接口服务白名单，格式：接口服务类名.接口服务方法名
     *
     * 示例：
     * - *.*            通配，全部接口服务，慎用！
     * - Default.*      Api_Default接口类的全部方法
     * - *.Index        全部接口类的Index方法
     * - Default.Index  指定某个接口服务，即Api_Default::Index()
     */
    'service_whitelist' => array(
        'Default.Index',
    ),

    'UPLOAD_DIR' => '/storage/sdcard1/myphalapi/Public/myweibo',
    'BACKUP_DIR' => '/storage/emulated/0/myweibo',
    //'UPLOAD_DIR' => '/home/wangjf/web/myphalapi/Public/myweibo',
    //'BACKUP_DIR' => '/home/wangjf/backup',

);
