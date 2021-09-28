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

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }


if (!empty($dispatch_extra)) {
    if (!empty($_REQUEST['approval_data'][$dispatch_extra])) {
        $_REQUEST['approval_data'] = $_REQUEST['approval_data'][$dispatch_extra];
    }
}
unset($_REQUEST['redirect_url']);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if ($mode == 'update_last_complete_vendor_status') {
     
        if(isset($_REQUEST['last_status_first'])){
            $status_id = $_REQUEST['last_status_first'];
        }else if(isset($_REQUEST['last_status_secound'])){
            $status_id = $_REQUEST['last_status_secound'];
        }else{
            $status_id = 0;
        }
        
        $order_id  = isset($_REQUEST['order_id']) ? trim($_REQUEST['order_id']) : 0;
        $check_order  = isset($_REQUEST['order_checked']) ? ($_REQUEST['order_checked']) : 'N';
       
        if (!$order_id) {
            fn_set_notification('E', __('error'), __('status_not_save_successfully'));
        }else{
            $data = array(
                'last_complete_vendor_status' => $status_id
            );
            //update status
            db_query("UPDATE ?:orders SET ?u WHERE order_id = ?i", $data, $order_id);
            
        }
    
        return array(CONTROLLER_STATUS_REDIRECT, fn_url("orders.details&order_id=$order_id"));
    
    }
    
    if ($mode == 'update_check_complete_order') {
     
        $order_id  = isset($_REQUEST['order_id']) ? trim($_REQUEST['order_id']) : 0;
        $check_order  = isset($_REQUEST['order_checked']) ? ($_REQUEST['order_checked']) : 'N';
       
        if (!$order_id) {
            fn_set_notification('E', __('error'), __('status_not_save_successfully'));
        }else{
            $data = array(
                'check_order'               => $check_order
            );
            //update status
            db_query("UPDATE ?:orders SET ?u WHERE order_id = ?i", $data, $order_id);
            
        }
    
        return array(CONTROLLER_STATUS_REDIRECT, fn_url("orders.details&order_id=$order_id"));
    
    
    }

    if ($mode == 'order_disapproval' && !empty($_REQUEST['approval_data'])) {
        $status = 'N';
        if(fn_jmj_digital_change_approval_status($_REQUEST['approval_data']['order_id'], $status, $_REQUEST['approval_data']['reason'])){
            fn_change_order_status($_REQUEST['approval_data']['order_id'], 'E');
        }
        fn_set_notification('N', __('notice'), __('status_changed'));

        if (
            isset($_REQUEST['approval_data']['notify_user_' . $status])
            && $_REQUEST['approval_data']['notify_user_' . $status] == 'Y'
        ) {
            $order_id = $_REQUEST['approval_data']['order_id'];
            $template = "Your order with order id- $order_id is rejected";

            $customer_phone = fn_jmj_digital_get_customer_phone($order_id);
            //send sms to customer
            fn_jmj_digital_send_sms($customer_phone, $template);
        }

        return array(CONTROLLER_STATUS_REDIRECT, fn_url('orders.manage&status=E'));

    } elseif (($mode == 'm_approve' || $mode == 'm_decline') && !empty($_REQUEST['order_ids'])) {
        
        if ($mode == 'm_approve') {
            $status = 'A';
            $send_notification = '';
            $redirect_url = 'orders.manage&status=A';

        } else {
            $status = 'E';
            $reason = $_REQUEST['action_reason_declined'];
            $redirect_url = 'orders.manage&status=E';
            $send_notification =
                isset($_REQUEST['action_notification_declined']) && $_REQUEST['action_notification_declined'] == 'Y';
        }

        $order_ids = $_REQUEST['order_ids'];
        
        if ($order_ids) {
            foreach ($order_ids as $order_id) {
                fn_jmj_digital_change_approval_status($order_id, $status, $reason);

                //change order status
                fn_change_order_status($order_id, $status);

                if($send_notification){
                    
                    $template = "Your order with order id- $order_id is rejected";
                    $customer_phone = fn_jmj_digital_get_customer_phone($order_id);
                    //send sms to customer
                    fn_jmj_digital_send_sms($customer_phone, $template);
                }
            }
        }

        fn_set_notification('N', __('notice'), __('status_changed'));

        return array(CONTROLLER_STATUS_REDIRECT, fn_url($redirect_url));
    }

    if($mode = 'process_approved_order'){
        unset($_REQUEST['redirect_url']);
        $order_ids = !empty($_REQUEST['order_ids']) ? $_REQUEST['order_ids'] : '';
        if($order_ids){
            foreach($order_ids as $order_id){
                //Change order status to process
                fn_change_order_status($order_id, 'G');
                //send order to SAP
                fn_jmj_digital_send_order_tp_sap($order_id);
            }
        }
        
        return array(CONTROLLER_STATUS_REDIRECT, fn_url('orders.manage&status=G'));
    }
}

if ($mode == 'order_approval') {
    $status = 'Y';
    $page = !empty($_REQUEST['page']) ? $_REQUEST['page'] : '';
    $dispatch_extra = !empty($dispatch_extra) ? $dispatch_extra : 0;

    //Change order status
    fn_change_order_status($dispatch_extra, 'A');
    fn_set_notification('N', __('notice'), __('status_changed'));
   
    return array(CONTROLLER_STATUS_REDIRECT, fn_url('orders.manage&status=A'));

}
if ($mode == 'manage') {
   
    Tygh::$app['view']->assign('approve_order_permission', fn_check_permissions('orders','order_approval', 'admin', '', array(), AREA, $auth['user_id']));
    Tygh::$app['view']->assign('process_approved_order_permission', fn_check_permissions('orders','process_approved_order', 'admin', '', array(), AREA, $auth['user_id']));
}
if ($mode == 'details') {
    
    Tygh::$app['view']->assign('check_order_permission', fn_check_permissions('orders','manage_check_order', 'admin', '', array(), AREA, $auth['user_id']));
    Tygh::$app['view']->assign('approve_order_permission', fn_check_permissions('orders','order_approval', 'admin', '', array(), AREA, $auth['user_id']));
    Tygh::$app['view']->assign('process_approved_order_permission', fn_check_permissions('orders','process_approved_order', 'admin', '', array(), AREA, $auth['user_id']));
}
