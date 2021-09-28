<?php

use Tygh\Helpdesk;
use Tygh\Navigation\LastView;
use Tygh\Registry;
use Tygh\Settings;
use Tygh\BlockManager\Layout;
use Tygh\Themes\Styles;
use Tygh\Common\Robots;
use Tygh\Tools\DateTimeHelper;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	
	if ($mode == 'reply') {        
	    $result = db_query("UPDATE ?:product_enquiry_form_details SET price=".$_REQUEST['price'].", comment='".addslashes($_REQUEST['comment'])."' WHERE id = ?i", $_REQUEST['id']);
	    fn_set_notification('N', __('notice'),__('price_updated'));
	    return array(CONTROLLER_STATUS_REDIRECT, 'quotes.manage');
	}
}

if ($mode == 'manage') {
    $params['user_type'] =  $auth['user_type'];
    $params['company_id'] =  $auth['company_id'];
    list($record,$search) = fn_get_all_quote_request($params);
    if(!empty($auth['company_id']) && $auth['user_type'] == 'V'){
        Tygh::$app['view']->assign('user_type', 'v');
    }
    Tygh::$app['view']->assign('result', $record);
    Tygh::$app['view']->assign('search', $search);
}

if ($mode == 'delete') {        
    $result = db_query("DELETE FROM ?:product_enquiry_form_details WHERE id = ?i", $_REQUEST['id']);
    fn_set_notification('N', __('notice'),__('record_deleted'));

    return array(CONTROLLER_STATUS_REDIRECT, 'quotes.manage');
}

if ($mode == 'assign_vendor') {        
    $result = db_query("UPDATE ?:product_enquiry_form_details SET assigned=1, assigned_date='".date("Y-m-d H:i:s")."' WHERE id = ?i", $_REQUEST['id']);
    fn_set_notification('N', __('notice'),__('quote_assigned'));

    return array(CONTROLLER_STATUS_REDIRECT, 'quotes.manage');
}

if ($mode == 'assign_tocustomer') {        
    $result = db_query("UPDATE ?:product_enquiry_form_details SET assign_tocustomer=1, assign_tocustomer_date='".date("Y-m-d H:i:s")."' WHERE id = ?i", $_REQUEST['id']);
    fn_set_notification('N', __('notice'),__('quote_assigned'));

    return array(CONTROLLER_STATUS_REDIRECT, 'quotes.manage');
}

