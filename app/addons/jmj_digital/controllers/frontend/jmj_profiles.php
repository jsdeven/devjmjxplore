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
use Tygh\Enum\VendorStatuses;
use Tygh\Enum\NotificationSeverity;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    if($mode == 'add'){
        
        if(!isset($_REQUEST['step']) || $_REQUEST['step'] == '1'){
           
            $is_valid_customer_data = true;
            
            if (empty($_REQUEST['customer_data']['email'])) {
                fn_set_notification('W', __('warning'), __('error_validator_required', array('[field]' => __('email'))));
                $is_valid_customer_data = false;

            } elseif (!fn_validate_email($_REQUEST['customer_data']['email'])) {
                fn_set_notification('W', __('error'), __('text_not_valid_email', array('[email]' => $_REQUEST['customer_data']['email'])));
                $is_valid_customer_data = false;
            }
            
            $email_exist = db_get_field("SELECT user_id FROM ?:users WHERE email = ?s AND user_type = ?s", $_REQUEST['customer_data']['email'], 'C');
            
            if($email_exist){
                fn_set_notification('W', __('error'), __('email_aleady_exist', array('[email]' => $_REQUEST['customer_data']['email'])));
                $is_valid_customer_data = false;
            }
            
            if (!$is_valid_customer_data) {
                return array(CONTROLLER_STATUS_REDIRECT, 'jmj_profiles.add');
            }

            $customer_data = $_REQUEST['customer_data'];
            $customer_data['register_last_step'] = $_REQUEST['step'];
           
            $customer_register_form_id = isset($_REQUEST['customer_register_form_id']) ? $_REQUEST['customer_register_form_id'] : 0;
            db_query("UPDATE ?:customer_additional_data SET ?u WHERE id = ?i", $customer_data, $customer_register_form_id);

            fn_set_notification('N',__('successful'),__('basic_information_saved'));
            return array(CONTROLLER_STATUS_OK, 'jmj_profiles.add&step=2');


        }
        if(isset($_REQUEST['step']) && $_REQUEST['step'] == '2'){
            $is_valid = true;
            $customer_data = $_REQUEST['customer_data'];
            $customer_data['register_last_step'] = $_REQUEST['step'];
            $customer_register_form_id = isset($_REQUEST['customer_register_form_id']) ? $_REQUEST['customer_register_form_id'] : 0;
            
            $gstin_number_exist = db_get_field("SELECT user_id FROM ?:users WHERE gstin_number = ?s AND user_type = ?s", $customer_data['gstin_number'], 'C');
            
            if($email_exist){
                fn_set_notification('W', __('error'), __('gstin_number_aleady_exist'));
                $is_valid = false;
            }
            
            if(!empty($customer_data) && $is_valid){
                
                $ship_to_another = $_REQUEST['ship_to_another'];
                $customer_data['ship_to_another'] = $ship_to_another;
                
                if(!$ship_to_another){
                   
                    $customer_data['s_name']    = $customer_data['b_name'];
                    $customer_data['s_address'] = $customer_data['b_address'];
                    $customer_data['s_address_2']   = $customer_data['b_address_2'];
                    $customer_data['s_city']    = $customer_data['b_city'];
                    $customer_data['s_state']   = $customer_data['b_state'];
                    $customer_data['s_country'] = $customer_data['b_country'];
                    $customer_data['s_zipcode'] = $customer_data['b_zipcode'];
                }
                
                $_SESSION['gstn_verified'] = true;
                
                db_query("UPDATE ?:customer_additional_data SET ?u WHERE id = ?i", $customer_data, $customer_register_form_id);
                fn_set_notification('N',__('successful'),__('business_information_saved'));
                return array(CONTROLLER_STATUS_OK, 'jmj_profiles.add&step=3');

            }else{
                return array(CONTROLLER_STATUS_OK, 'jmj_profiles.add&step=2');
            }
            
        }
        if(isset($_REQUEST['step']) && $_REQUEST['step'] == '3'){ 

            $customer_data = $_REQUEST['customer_data'];
            $customer_data['register_last_step'] = $_REQUEST['step'];
            $customer_register_form_id = isset($_REQUEST['customer_register_form_id']) ? $_REQUEST['customer_register_form_id'] : 0;
            if(!empty($customer_data)){
                
                if (!file_exists('images/customer-additional-data/'.$customer_register_form_id)) {
                    mkdir('images/customer-additional-data/'.$customer_register_form_id, 0777, true);
                } 
               
                if(!empty($_FILES["bank_document"]['name'])){
                    $bank_document_name = $_FILES["bank_document"]['name'];
                    $bank_document = explode('.' , $bank_document_name);
                    $bank_document_name = base64_encode($bank_document[0]).'.'.$bank_document[1];
                    $bank_document_temp_name = $_FILES["bank_document"]['tmp_name'];
                    move_uploaded_file($bank_document_temp_name,'images/customer-additional-data/'.$customer_register_form_id.'/'.$bank_document_name);
                    
                    $customer_data['bank_document'] = $bank_document_name;
                }
                
                if(isset($customer_data['location']) && !empty($customer_data['location'])){
                    $customer_data['location'] = implode(',', $customer_data['location']);
                }
                
                db_query("UPDATE ?:customer_additional_data SET ?u WHERE id = ?i", $customer_data, $customer_register_form_id);
                fn_set_notification('N',__('successful'),__('brand_and_category_information_saved'));
                return array(CONTROLLER_STATUS_OK, 'jmj_profiles.add&step=4');

            }else{
                return array(CONTROLLER_STATUS_OK, 'jmj_profiles.add&step=3');
            }
            
        }
        if(isset($_REQUEST['step']) && $_REQUEST['step'] == '4'){ 

            $customer_data = $_REQUEST['customer_data'];
            $customer_data['register_last_step'] = 4;
            $customer_register_form_id = isset($_REQUEST['customer_register_form_id']) ? $_REQUEST['customer_register_form_id'] : 0;

            if(!empty($customer_data)){
               
                if (!file_exists('images/customer-additional-data/'.$customer_register_form_id)) {
                    mkdir('images/customer-additional-data/'.$customer_register_form_id, 0777, true);
                } 
                
                if(!empty($_FILES["cancel_cheque_copy_image"]['name'])){
                    $cancel_cheque_copy_image_name = $_FILES["cancel_cheque_copy_image"]['name'];
                    $cancel_cheque = explode('.' , $cancel_cheque_copy_image_name);
                    $cancel_cheque_copy_image_name = base64_encode($cancel_cheque[0]).'.'.$cancel_cheque[1];
                    $cancel_cheque_copy_image_temp_name = $_FILES["cancel_cheque_copy_image"]['tmp_name'];
                    move_uploaded_file($cancel_cheque_copy_image_temp_name,'images/customer-additional-data/'.$customer_register_form_id.'/'.$cancel_cheque_copy_image_name);
                    
                    $customer_data['cancel_cheque_copy_image'] = $cancel_cheque_copy_image_name;
                }

                if(!empty($_FILES["company_profile_image"]['name'])){
                    $company_profile_image_name = $_FILES["company_profile_image"]['name'];
                    $company_profile = explode('.' , $company_profile_image_name);
                    $company_profile_image_name = base64_encode($company_profile[0]).'.'.$company_profile[1];
                    $company_profile_image_temp_name = $_FILES["company_profile_image"]['tmp_name'];
                    move_uploaded_file($company_profile_image_temp_name,'images/customer-additional-data/'.$customer_register_form_id.'/'.$company_profile_image_name);
                    
                    $customer_data['company_profile_image'] = $company_profile_image_name;
                }
        
                if(!empty($_FILES["product_catalogue_image"]['name'])){
                    $product_catalogue_image_name = $_FILES["product_catalogue_image"]['name'];
                    $product_catalogue = explode('.' , $product_catalogue_image_name);
                    $product_catalogue_image_name = base64_encode($product_catalogue[0]).'.'.$product_catalogue[1];
                    $product_catalogue_image_temp_name = $_FILES["product_catalogue_image"]['tmp_name'];
                    move_uploaded_file($product_catalogue_image_temp_name,'images/customer-additional-data/'.$customer_register_form_id.'/'.$product_catalogue_image_name);
                     
                    $customer_data['product_catalogue_image'] = $product_catalogue_image_name;
                }

                if(!empty($_FILES["office_front_image"]['name'])){
                    $office_front_image_name = $_FILES["office_front_image"]['name'];
                    $office_front = explode('.' , $office_front_image_name);
                    $office_front_image_name = base64_encode($office_front[0]).'.'.$office_front[1];
                    $office_front_image_temp_name = $_FILES["office_front_image"]['tmp_name'];
                    move_uploaded_file($cancel_cheque_copy_image_temp_name,'images/customer-additional-data/'.$customer_register_form_id.'/'.$office_front_image_name);
                    
                    $customer_data['office_front_image'] = $office_front_image_name;
                }

                if(!empty($_FILES["office_inside_image"]['name'])){
                    $office_inside_image_name = $_FILES["office_inside_image"]['name'];
                    $office_inside = explode('.' , $office_inside_image_name);
                    $office_inside_image_name = base64_encode($office_inside[0]).'.'.$office_inside[1];
                    $office_inside_image_temp_name = $_FILES["office_inside_image"]['tmp_name'];
                    move_uploaded_file($office_inside_image_temp_name,'images/customer-additional-data/'.$customer_register_form_id.'/'.$office_inside_image_name);
                    
                    $customer_data['office_inside_image'] = $office_inside_image_name;
                }

                if(!empty($_FILES["gstin_certificate_image"]['name'])){
                    $gstin_certificate_image_name = $_FILES["gstin_certificate_image"]['name'];
                    $gstin_certificate = explode('.' , $gstin_certificate_image_name);
                    $gstin_certificate_image_name = base64_encode($gstin_certificate[0]).'.'.$gstin_certificate[1];
                    $gstin_certificate_image_temp_name = $_FILES["gstin_certificate_image"]['tmp_name'];
                    move_uploaded_file($gstin_certificate_image_temp_name,'images/customer-additional-data/'.$customer_register_form_id.'/'.$gstin_certificate_image_name);
                    
                    $customer_data['gstin_certificate_image'] = $gstin_certificate_image_name;
                }

                if(!empty($_FILES["owners_pancard_image"]['name'])){
                    $owners_pancard_image_name = $_FILES["owners_pancard_image"]['name'];
                    $owners_pancard = explode('.' , $owners_pancard_image_name);
                    $owners_pancard_image_name = base64_encode($owners_pancard[0]).'.'.$owners_pancard[1];
                    $owners_pancard_image_temp_name = $_FILES["owners_pancard_image"]['tmp_name'];
                    move_uploaded_file($owners_pancard_image_temp_name,'images/customer-additional-data/'.$customer_register_form_id.'/'.$owners_pancard_image_name);
                    
                    $customer_data['owners_pancard_image'] = $owners_pancard_image_name;
                }
                
                db_query("UPDATE ?:customer_additional_data SET ?u WHERE id = ?i", $customer_data, $customer_register_form_id);
                fn_set_notification('N',__('successful'),__('bank_information_saved'));
                return array(CONTROLLER_STATUS_OK, 'jmj_profiles.add&step=5');

            }else{
                return array(CONTROLLER_STATUS_OK, 'jmj_profiles.add&step=4');
            }    
        }
    }    
   
   
}

if($mode == 'add'){
  
    $customer_data = array();
    $customer_register_form_id = isset($_SESSION['customer_register_form_id']) ? $_SESSION['customer_register_form_id'] : 0;
    
    if($customer_register_form_id){
        $customer_data = db_get_row("SELECT * FROM ?:customer_additional_data WHERE id= ?i", $customer_register_form_id);
        if(isset($customer_data['register_last_step'])){
            $current_step = $customer_data['register_last_step'] + 1;
            if($_REQUEST['step'] != $current_step && $current_step == 1){
                return array(CONTROLLER_STATUS_OK, 'jmj_profiles.add&step='.$current_step);
            }
        }
    }elseif(isset($_REQUEST['step']) && $_REQUEST['step'] != 1){
        return array(CONTROLLER_STATUS_OK, 'jmj_profiles.add');
    }

    Tygh::$app['view']->assign('phone_verified', $_SESSION['phone_verified']);

    if(isset($_REQUEST['step']) && $_REQUEST['step'] == 2){
        
        $gstn_verified = isset($_SESSION['gstn_verified']) ? $_SESSION['gstn_verified'] : false;
        
        list($states, ) = fn_get_states(array('country_code' => 'IN'));
        Tygh::$app['view']->assign('gst_types', GST_TYPES);
        Tygh::$app['view']->assign('india_zones', INDIA_ZONES);
        Tygh::$app['view']->assign('states', $states);
        Tygh::$app['view']->assign('gstn_verified', $gstn_verified);
    }
    if(isset($_REQUEST['step']) && $_REQUEST['step'] == 3){

        if($customer_register_form_id){

            if(isset($customer_data['location']) && !empty($customer_data['location'])){
                $customer_data['location'] = explode(',', $customer_data['location']);
            }
        }
        list($locations, ) = fn_get_all_cities($_REQUEST, $auth);
        Tygh::$app['view']->assign('locations', $locations);
        Tygh::$app['view']->assign('monthly_turn_over', MONTHLY_TURN_OVER);
        

    }

    if(isset($_REQUEST['step']) && $_REQUEST['step'] == 5){

        $user_id = isset($customer_data['user_id']) ? $customer_data['user_id'] : 0;
        $res = fn_update_user($user_id, $customer_data, $auth, !empty($customer_data['ship_to_another']), true);

        if ($res) {
            list($user_id, $profile_id) = $res;
        
            $customer_data_update = array(
                'user_id' => $user_id
            );

            db_query("UPDATE ?:customer_additional_data SET ?u WHERE id = ?i", $customer_data_update, $customer_register_form_id);
            
            if($customer_data['payment_option'] == 'online'){
                $usergroup_id = CC_USERGROUP_ID;
            }else{
                $usergroup_id = CL_USERGROUP_ID;
            }
            //echo "<pre>";print_r($usergroup_id);die;
            fn_change_usergroup_status('A', $user_id, $usergroup_id, array());
            
            unset($_SESSION['customer_register_form_id']);
            unset($_SESSION['phone_verified']);
        }
    }

    Tygh::$app['view']->assign('customer_data', $customer_data);

} 
if ($mode == 'otp_for_customer_register') {
    if (defined('AJAX_REQUEST')) {
        $status = true;
        $phone = isset($_REQUEST['phone']) ? trim($_REQUEST['phone']) : null;
        
        if (empty($phone)) {
            $status = false;
            fn_set_notification('E', __('error'), __('phone_required'));
        }
        
        $phone_exist = db_get_field("SELECT user_id FROM ?:users WHERE phone = ?s AND user_type = ?s AND status NOT IN('D')", $phone, 'C');
            
        if($phone_exist){
            fn_set_notification('W', __('error'), __('phone_aleady_exist'));
            $status = false;
        }
    
    
        if($status == true){
            if (!fn_jmj_send_otp_for_customer_register($phone)) {
                $status = false;
                fn_set_notification('E', __('error'), __('error_occurred'));
            } else{
                fn_set_notification('N', __('success'), __('otp_sent'));
            }

        }      

        $redirect_url_params = [
            'status'    => $status
        ];

        echo json_encode($redirect_url_params);
        exit;
    }    
}

if ($mode == 'verify_otp_for_customer_register') {
    
    if (defined('AJAX_REQUEST')) {
        $status = true;
        $phone = isset($_REQUEST['phone']) ? trim($_REQUEST['phone']) : null;
        $otp = isset($_REQUEST['otp']) ? trim($_REQUEST['otp']) : null;
        
        if (empty($phone)) {
            $status = false;
            fn_set_notification('E', __('error'), __('phone_required'));
        }
        if (empty($otp)) {
            $status = false;
            fn_set_notification('E', __('error'), __('otp_required'));
        }
    
        if($status == true){
            $data = fn_jmj_verify_otp_for_customer_register($phone, $otp);
            
            if (empty($data)) {
                $status = false;
                fn_set_notification('E', __('error'), __('error_occurred'));
            } else{
                $_SESSION['phone_verified'] = true;
                $_SESSION['customer_register_form_id'] = $data['id'];
                $register_last_step = $data['register_last_step'];
                fn_set_notification('N', __('success'), __('verified_success'));
                
                if($register_last_step){
                    Tygh::$app['ajax']->assign('force_redirection', fn_url('jmj_profiles.add&step='.$register_last_step)); 
                }else{
                    Tygh::$app['ajax']->assign('force_redirection', fn_url('jmj_profiles.add')); 
                }
            }

        }      

        $redirect_url_params = [
            'status'    => $status
        ];

        echo json_encode($redirect_url_params);
        exit;
    }    
}

    

