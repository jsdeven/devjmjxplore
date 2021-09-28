<?php
/***************************************************************************
*                                                                          *
*   (c) 2004 Vladimir V. Kalynyak, Alexey V. Vinokurov, Ilya M. Shalnev    *
*                                                                          *
* This  is  commercial  software,  only  users  who have purchased a valid *
* license  and  accept  to the terms of the  License Agreement can install *
* and use this program.                                                    *
*                                                                          *
****************************************************************************
* PLEASE READ THE FULL TEXT  OF THE SOFTWARE  LICENSE   AGREEMENT  IN  THE *
* "copyright.txt" FILE PROVIDED WITH THIS DISTRIBUTION PACKAGE.            *
****************************************************************************/

use Tygh\Development;
use Tygh\Registry;
use Tygh\Helpdesk;
use Tygh\Tools\Url;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

}

if ($mode == 'update' || $mode == 'add' ) {
     
    $params = array(
        'status' => 'A'
    );
    
    if(isset($_REQUEST['user_id'])){
        $customer_additional_data = db_get_row("SELECT * FROM ?:customer_additional_data WHERE user_id = ?i", $_REQUEST['user_id']);
        Tygh::$app['view']->assign('customer_additional_data', $customer_additional_data);
    }
    
    list($cities, $search) = fn_get_all_cities($params, $auth);
    Tygh::$app['view']->assign('approve_order_permission', fn_check_permissions('orders','order_approval', 'admin', '', array(), AREA, $_REQUEST['user_id']));
    Tygh::$app['view']->assign('cities', $cities);
}


