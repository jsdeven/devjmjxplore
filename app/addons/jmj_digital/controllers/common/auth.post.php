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

    if($mode == 'seller_register'){
        
        if(!isset($_REQUEST['step']) || $_REQUEST['step'] == '1')
        {
           
            $is_valid_company_data = true;
            
            if (empty($_REQUEST['company_data']['email'])) {
                fn_set_notification('W', __('warning'), __('error_validator_required', array('[field]' => __('email'))));
                $is_valid_company_data = false;

            } elseif (!fn_validate_email($_REQUEST['company_data']['email'])) {
                fn_set_notification('W', __('error'), __('text_not_valid_email', array('[email]' => $_REQUEST['company_data']['email'])));
                $is_valid_company_data = false;
            }
            
            $email_exist = db_get_field("SELECT user_id FROM ?:users WHERE email = ?s AND user_type = ?s", $_REQUEST['company_data']['email'], 'V');
            
            if($email_exist){
                fn_set_notification('W', __('error'), __('email_aleady_exist', array('[email]' => $_REQUEST['company_data']['email'])));
                $is_valid_company_data = false;
            }
            
            if (!$is_valid_company_data) {
                return array(CONTROLLER_STATUS_REDIRECT, 'auth.seller_register');
            }

            $company_data = $_REQUEST['company_data'];
            $company_data['register_last_step'] = $_REQUEST['step'];
           
            $vendor_register_form_id = isset($_REQUEST['vendor_register_form_id']) ? $_REQUEST['vendor_register_form_id'] : 0;
            db_query("UPDATE ?:company_additional_data SET ?u WHERE id = ?i", $company_data, $vendor_register_form_id);

            fn_set_notification('N',__('successful'),__('basic_information_saved'));
            return array(CONTROLLER_STATUS_OK, 'auth.seller_register&step=2');


        }
        if(isset($_REQUEST['step']) && $_REQUEST['step'] == '2')
        {
            $is_valid = true;
            $company_data = $_REQUEST['company_data'];
            $company_data['register_last_step'] = $_REQUEST['step'];
            $vendor_register_form_id = isset($_REQUEST['vendor_register_form_id']) ? $_REQUEST['vendor_register_form_id'] : 0;
            
            $gstin_number_exist = db_get_field("SELECT user_id FROM ?:users WHERE gstin_number = ?s AND user_type = ?s", $company_data['gstin_number'], 'V');
            
            if($email_exist){
                fn_set_notification('W', __('error'), __('gstin_number_aleady_exist'));
                $is_valid = false;
            }
            
            if(!empty($company_data) && $is_valid){
                
                $ship_to_another = $_REQUEST['ship_to_another'];
                if(!$ship_to_another){
                   
                    $company_data['s_name']    = $company_data['b_name'];
                    $company_data['s_address'] = $company_data['b_address'];
                    $company_data['s_address_2']   = $company_data['b_address_2'];
                    $company_data['s_city']    = $company_data['b_city'];
                    $company_data['s_state']   = $company_data['b_state'];
                    $company_data['s_country'] = $company_data['b_country'];
                    $company_data['s_pincode'] = $company_data['b_pincode'];
                }
                
                $_SESSION['gstn_verified'] = true;
                
                db_query("UPDATE ?:company_additional_data SET ?u WHERE id = ?i", $company_data, $vendor_register_form_id);
                fn_set_notification('N',__('successful'),__('business_information_saved'));
                return array(CONTROLLER_STATUS_OK, 'auth.seller_register&step=3');

            }else{
                return array(CONTROLLER_STATUS_OK, 'auth.seller_register&step=2');
            }
            
        }
        if(isset($_REQUEST['step']) && $_REQUEST['step'] == '3'){ 

            $company_data = $_REQUEST['company_data'];
            $company_data['register_last_step'] = $_REQUEST['step'];
            $vendor_register_form_id = isset($_REQUEST['vendor_register_form_id']) ? $_REQUEST['vendor_register_form_id'] : 0;
            if(!empty($company_data)){

                if(isset($company_data['categories']) && !empty($company_data['categories'])){
                    $new_categories = array();
                    foreach($company_data['categories'] as $categories){
                        if(isset($categories['sub_sub_category_id']) && !empty($categories['sub_sub_category_id'])){
                            $new_categories[] = $categories;
                        }
                    }
                    $company_data['categories'] = serialize($new_categories);
                }
                if(isset($company_data['states']) && !empty($company_data['states'])){
                    $company_data['main_market_coverage'] = implode(',', $company_data['states']);
                }
                
                db_query("UPDATE ?:company_additional_data SET ?u WHERE id = ?i", $company_data, $vendor_register_form_id);
                fn_set_notification('N',__('successful'),__('brand_and_category_information_saved'));
                return array(CONTROLLER_STATUS_OK, 'auth.seller_register&step=4');

            }else{
                return array(CONTROLLER_STATUS_OK, 'auth.seller_register&step=3');
            }
            
        }
        if(isset($_REQUEST['step']) && $_REQUEST['step'] == '4')
        { 

            $company_data = $_REQUEST['company_data'];
            $company_data['register_last_step'] = 4;
            $vendor_register_form_id = isset($_REQUEST['vendor_register_form_id']) ? $_REQUEST['vendor_register_form_id'] : 0;

            
            if(!empty($company_data)){
               
                if (!file_exists('images/sellers-additional-data/'.$vendor_register_form_id)) {
                    mkdir('images/sellers-additional-data/'.$vendor_register_form_id, 0777, true);
                } 
                
                if(!empty($_FILES["cancel_cheque_copy_image"]['name'])){
                    $cancel_cheque_copy_image_name = $_FILES["cancel_cheque_copy_image"]['name'];
                    $cancel_cheque = explode('.' , $cancel_cheque_copy_image_name);
                    $cancel_cheque_copy_image_name = base64_encode($cancel_cheque[0]).'.'.$cancel_cheque[1];
                    $cancel_cheque_copy_image_temp_name = $_FILES["cancel_cheque_copy_image"]['tmp_name'];
                    move_uploaded_file($cancel_cheque_copy_image_temp_name,'images/sellers-additional-data/'.$vendor_register_form_id.'/'.$cancel_cheque_copy_image_name);
                    
                    $company_data['cancel_cheque_copy_image'] = $cancel_cheque_copy_image_name;
                }

                if(!empty($_FILES["company_profile_image"]['name'])){
                    $company_profile_image_name = $_FILES["company_profile_image"]['name'];
                    $company_profile = explode('.' , $company_profile_image_name);
                    $company_profile_image_name = base64_encode($company_profile[0]).'.'.$company_profile[1];
                    $company_profile_image_temp_name = $_FILES["company_profile_image"]['tmp_name'];
                    move_uploaded_file($company_profile_image_temp_name,'images/sellers-additional-data/'.$vendor_register_form_id.'/'.$company_profile_image_name);
                    
                    $company_data['company_profile_image'] = $company_profile_image_name;
                }
        
                if(!empty($_FILES["product_catalogue_image"]['name'])){
                    $product_catalogue_image_name = $_FILES["product_catalogue_image"]['name'];
                    $product_catalogue = explode('.' , $product_catalogue_image_name);
                    $product_catalogue_image_name = base64_encode($product_catalogue[0]).'.'.$product_catalogue[1];
                    $product_catalogue_image_temp_name = $_FILES["product_catalogue_image"]['tmp_name'];
                    move_uploaded_file($product_catalogue_image_temp_name,'images/sellers-additional-data/'.$vendor_register_form_id.'/'.$product_catalogue_image_name);
                    
                    $company_data['product_catalogue_image'] = $product_catalogue_image_name;
                }

                if(!empty($_FILES["office_front_image"]['name'])){
                    $office_front_image_name = $_FILES["office_front_image"]['name'];
                    $office_front = explode('.' , $office_front_image_name);
                    $office_front_image_name = base64_encode($office_front[0]).'.'.$office_front[1];
                    $office_front_image_temp_name = $_FILES["office_front_image"]['tmp_name'];
                    move_uploaded_file($office_front_image_temp_name,'images/sellers-additional-data/'.$vendor_register_form_id.'/'.$office_front_image_name);
                    
                    $company_data['office_front_image'] = $office_front_image_name;
                }

                if(!empty($_FILES["office_inside_image"]['name'])){
                    $office_inside_image_name = $_FILES["office_inside_image"]['name'];
                    $office_inside = explode('.' , $office_inside_image_name);
                    $office_inside_image_name = base64_encode($office_inside[0]).'.'.$office_inside[1];
                    $office_inside_image_temp_name = $_FILES["office_inside_image"]['tmp_name'];
                    move_uploaded_file($office_inside_image_temp_name,'images/sellers-additional-data/'.$vendor_register_form_id.'/'.$office_inside_image_name);
                    
                    $company_data['office_inside_image'] = $office_inside_image_name;
                }

                if(!empty($_FILES["gstin_certificate_image"]['name'])){
                    $gstin_certificate_image_name = $_FILES["gstin_certificate_image"]['name'];
                    $gstin_certificate = explode('.' , $gstin_certificate_image_name);
                    $gstin_certificate_image_name = base64_encode($gstin_certificate[0]).'.'.$gstin_certificate[1];
                    $gstin_certificate_image_temp_name = $_FILES["gstin_certificate_image"]['tmp_name'];
                    move_uploaded_file($gstin_certificate_image_temp_name,'images/sellers-additional-data/'.$vendor_register_form_id.'/'.$gstin_certificate_image_name);
                    
                    $company_data['gstin_certificate_image'] = $gstin_certificate_image_name;
                }

                if(!empty($_FILES["owners_pancard_image"]['name'])){
                    $owners_pancard_image_name = $_FILES["owners_pancard_image"]['name'];
                    $owners_pancard = explode('.' , $owners_pancard_image_name);
                    $owners_pancard_image_name = base64_encode($owners_pancard[0]).'.'.$owners_pancard[1];
                    $owners_pancard_image_temp_name = $_FILES["owners_pancard_image"]['tmp_name'];
                    move_uploaded_file($owners_pancard_image_temp_name,'images/sellers-additional-data/'.$vendor_register_form_id.'/'.$owners_pancard_image_name);
                    
                    $company_data['owners_pancard_image'] = $owners_pancard_image_name;
                }
                
                if(!empty($_FILES["owners_logo_image"]['name'])){
                    $owners_logo_image_name = $_FILES["owners_logo_image"]['name'];
                    $owners_logo = explode('.' , $owners_logo_image_name);
                    $owners_logo_image_name = base64_encode($owners_logo[0]).'.'.$owners_logo[1];
                    $owners_logo_image_temp_name = $_FILES["owners_logo_image"]['tmp_name'];
                    move_uploaded_file($owners_logo_image_temp_name,'images/sellers-additional-data/'.$vendor_register_form_id.'/'.$owners_logo_image_name);
                    
                    $company_data['owners_logo_image'] = $owners_logo_image_name;
                }
                
                db_query("UPDATE ?:company_additional_data SET ?u WHERE id = ?i", $company_data, $vendor_register_form_id);
                fn_set_notification('N',__('successful'),__('bank_information_saved'));
                return array(CONTROLLER_STATUS_OK, 'auth.seller_register&step=5');

            }else{
                return array(CONTROLLER_STATUS_OK, 'auth.seller_register&step=4');
            }    
        }
    }    
    // Login mode
    //
    if ($mode == 'jmj_otp_login') {
        
        if (defined('AJAX_REQUEST')) {
           
            $redirect_url = (isset($_REQUEST['return_url']) && !empty($_REQUEST['return_url'])) ? $_REQUEST['return_url'] : fn_url();
            
            list($status, $user_data, $user_login, $password, $salt) = fn_jmj_auth_routines($_REQUEST, $auth);
        
            if ($status === false) {
                fn_save_post_data('user_login');
                return array(CONTROLLER_STATUS_REDIRECT, $redirect_url);
            }
            
            // Success login
            //
           
            if(!empty($user_data)){

                $otp_valid = false;
                if(isset($user_data['otp_insert_time']) && $_REQUEST['otp_login']== $user_data['otp']){
                    $time1 = strtotime($user_data['otp_insert_time']);
                    $time2 = strtotime(date('H:i:s'));
                    $timediff = round(($time2-$time1)/60, 2);
                    
                    if($timediff <= OTP_TIMEOUT_TIME_IN_MINUTE){
                        $otp_valid = true;
                    }
                }

                if (!empty($_REQUEST['otp_login']) && $otp_valid && ($user_data['verified']== 0)) {
                   
                    // Regenerate session ID for security reasons
                    Tygh::$app['session']->regenerateID();

                    fn_login_user($user_data['user_id'], true);

                    //update otp verified field
                    $data = array(
                        'verified'=> 1
                    );
                    db_query('UPDATE ?:users SET ?u WHERE email = ?s', $data, $user_data['email']);
                    
                    //code by onj for get user email for send email end///
                    $auth = fn_fill_auth($user_data, $auth);
                
                    Helpdesk::auth();
                    fn_set_notification('N', __('notice'), __('login_success'));
                    Tygh::$app['ajax']->assign('force_redirection', fn_url($redirect_url)); 

                }
                else{
                    fn_set_notification('E', __('error'), __('incorrect_otp'));
                    exit;
                }
            }else{
                fn_set_notification('E', __('error'), __('not_register_with_this_email_or_phone'), true, 'insecure_password'); 
                exit;
            }    
        }   
    }
   
}

if ($mode == 'request_otp') {
    
    if (defined('AJAX_REQUEST')) {
        $status = true;
        $user_code = isset($_REQUEST['user_code']) ? trim($_REQUEST['user_code']) : null;
        
        $customer_type = isset($_REQUEST['customer_type']) ? $_REQUEST['customer_type'] : 'C';
        
        if (empty($user_code)) {
            $status = false;
            fn_set_notification('E', __('error'), __('invalid_email'));
        }

        $user_data = fn_jmj_is_user_exists($user_code, $customer_type);

        if ((empty($user_data) || $user_data['status'] != 'A') && $status == true) {
            $status = false;
            fn_set_notification('E', __('error'), __('user_not_found'));
        }

        if (empty($user_data['phone']) && $status == true) {
            $status = false;
            fn_set_notification('E', __('error'), __('phone_not_found'));
        }
        if($status == true){
      
            if (!empty($user_data)
                && !empty($_REQUEST['password'])
                && fn_user_password_verify((int) $user_data['user_id'], $_REQUEST['password'], (string) $user_data['password'], (string) $user_data['salt'])
                && $status == true
            ) {

                if (!fn_jmj_user_send_otp($user_data)) {
                    $status = false;
                    fn_set_notification('E', __('error'), __('error_occurred'));
                } else{
                    fn_set_notification('N', __('success'), __('otp_sent'));
                }

            }else{
                $status = false;
                fn_set_notification('E', __('error'), __('username_password_incorrect'));
            }  
        }      

        $redirect_url_params = [
            'user_code' => $user_data['email'],
            'password'  => $user_data['password'],
            'status'    => $status
        ];

        echo json_encode($redirect_url_params);

        exit;
    }    

}if ($mode == 'login_form') {
    
    $basename = basename($_SERVER['REQUEST_URI'], '?' . $_SERVER['QUERY_STRING']);
    $vendor_register_url = Registry::get('config.current_location').'/'.Registry::get('config.customer_index').'?dispatch=auth.seller_register';
    Tygh::$app['view']->assign('basename', $basename);
    Tygh::$app['view']->assign('vendor_register_url', $vendor_register_url);
   
} 

if($mode == 'seller_register'){
    
    $company_data = array();
    $vendor_register_form_id = isset($_SESSION['vendor_register_form_id']) ? $_SESSION['vendor_register_form_id'] : 0;
    
    if($vendor_register_form_id){
        $company_data = db_get_row("SELECT * FROM ?:company_additional_data WHERE id= ?i", $vendor_register_form_id);
        if(isset($company_data['register_last_step'])){
            $current_step = $company_data['register_last_step'] + 1;
            if($_REQUEST['step'] != $current_step && $current_step == 1){
                return array(CONTROLLER_STATUS_OK, 'auth.seller_register&step='.$current_step);
            }
        }else{
            if(isset($_SESSION['vendor_register_form_id'])){
                unset($_SESSION['vendor_register_form_id']);
            }
            if(isset($_SESSION['phone_verified'])){
                unset($_SESSION['phone_verified']);
            }
            if(isset($_SESSION['vendor_register_form_id'])){
                unset($_SESSION['vendor_register_form_id']);
            }
        }
    }elseif(isset($_REQUEST['step']) && $_REQUEST['step'] != 1){

        return array(CONTROLLER_STATUS_OK, 'auth.seller_register');
    }
    
    Tygh::$app['view']->assign('phone_verified', $_SESSION['phone_verified']);

    if(isset($_REQUEST['step']) && $_REQUEST['step'] == 2)
    {
       
        $gstn_verified = !empty($company_data['gstin_number']) ? true : false;
        list($countries, )=fn_get_countries(array('only_avail'=>'A'));
        list($states, ) = fn_get_states(array('country_code' => 'IN'));
        
        Tygh::$app['view']->assign('gst_types', GST_TYPES);
        Tygh::$app['view']->assign('india_zones', INDIA_ZONES);
        Tygh::$app['view']->assign('states', $states);
        Tygh::$app['view']->assign('countries', $countries);
        Tygh::$app['view']->assign('gstn_verified', $gstn_verified);
       
    }
    if(isset($_REQUEST['step']) && $_REQUEST['step'] == 3 ){
        //Category Steps

        $params['max_nesting_level'] = 1;
        list($main_categories, ) = fn_get_categories($params);

        if($vendor_register_form_id){
            
            if(isset($company_data['categories']) && !empty($company_data['categories'])){
                $selected_categories = unserialize($company_data['categories']);
            }
            
            if(isset($company_data['main_market_coverage']) && !empty($company_data['main_market_coverage'])){
                $company_data['main_market_coverage'] = explode(',', $company_data['main_market_coverage']);
            }
        }
        
        if(isset($selected_categories) && !empty($selected_categories)){
            $categories = array();
    
            foreach($selected_categories as $category){
    
                $categories[$category['sub_sub_category_id']]['sub_sub_category_id']    = $category['sub_sub_category_id'];
                $categories[$category['sub_sub_category_id']]['sub_category_id']        = $category['sub_category_id'];
                $categories[$category['sub_sub_category_id']]['product_range']          = $category['product_range'];
                $categories[$category['sub_sub_category_id']]['main_category_id']       = $category['main_category_id'];
                $categories[$category['sub_sub_category_id']]['sub_categories']         = fn_get_subcategories($category['main_category_id']);
                $categories[$category['sub_sub_category_id']]['sub_sub_categories']     = fn_get_subcategories($category['sub_category_id']);
            }
            
            Tygh::$app['view']->assign('categories', $categories);
        }

        list($states, ) = fn_get_states(array('country_code' => 'IN'));
        Tygh::$app['view']->assign('states', $states);
        Tygh::$app['view']->assign('total_emp', TOTAL_EMP);
        Tygh::$app['view']->assign('annual_turn_over', ANNUAL_TURN_OVER);
        Tygh::$app['view']->assign('main_categories', $main_categories);

    }
    if(isset($_REQUEST['step']) && $_REQUEST['step'] == 4)
    {
        Tygh::$app['view']->assign('bank_name_list', BANK_NAME_LIST);
    }
    if(isset($_REQUEST['step']) && $_REQUEST['step'] == 5){

        $company_data_create = array();
        $company_data_create['status'] = VendorStatuses::NEW_ACCOUNT;
        $company_data_create['phone'] = db_get_field("SELECT phone FROM ?:company_additional_data WHERE id = ?i", $id);
        $company_data_create['admin_firstname'] = $company_data['firstname'];
        $company_data_create['admin_lastname'] = $company_data['lastname'];
        $company_data_create['company'] = $company_data['company'];
        $company_data_create['email'] = $company_data['email'];
        $company_data_create['phone'] = $company_data['phone'];
        $company_data_create['address'] = $company_data['b_address'];
        $company_data_create['city'] = $company_data['b_city'];
        $company_data_create['state'] = $company_data['b_state'];
        $company_data_create['country'] = $company_data['b_country'];
        $company_data_create['zipcode'] = $company_data['b_pincode'];
        $company_data_create['tax_number'] = $company_data['gstin_number'];
        $company_data_create['b_firstname'] = $company_data['b_name'];
        $company_data_create['s_firstname'] = $company_data['s_name'];
        $company_data_create['plan_id'] = 1;
      
        $_REQUEST['logotypes_image_data'] = array(
            'theme' => array(
                'type'      => 'M',
                'object_id' => '',
                'image_alt' => ''
            ),
            'mail' => array(
                'type'      => 'M',
                'object_id' => '',
                'image_alt' => ''
            ),
        );
        
        $image_url = 'https://'.Registry::get('config.https_host').'/images/sellers-additional-data/'.$vendor_register_form_id.'/'.$company_data['owners_logo_image'];
        $_REQUEST['file_logotypes_image_icon'] = array(
            'theme' => $image_url,
            'mail'  => $image_url
        );
        $_REQUEST['type_logotypes_image_icon'] = array(
            'theme' => 'url',
            'mail'  => 'url'
        );
        $_REQUEST['is_high_res_logotypes_image_icon'] = array(
            'theme' => 'N',
            'mail'  => 'N'
        );
        //echo "<pre>";print_r($_REQUEST);die;
        $company_id = fn_update_company($company_data_create);

        //brand request
        // if($company_id){
        //     fn_update_brands(array('brand' => $company_data['brand_1'], 'company_id' => $company_id, 'status' => 'P'));
        //     fn_update_brands(array('brand' => $company_data['brand_2'], 'company_id' => $company_id, 'status' => 'P'));
        //     fn_update_brands(array('brand' => $company_data['brand_3'], 'company_id' => $company_id, 'status' => 'P'));
        // }    

        $company_data_update = array(
            'company_id' => $company_id
        );
        db_query("UPDATE ?:company_additional_data SET ?u WHERE id = ?i", $company_data_update, $vendor_register_form_id);

        unset($_SESSION['vendor_register_form_id']);
        unset($_SESSION['phone_verified']);
        $_SESSION['gstn_verified'] = false;
    }

    Tygh::$app['view']->assign('company_data', $company_data);
  

} 
if ($mode == 'otp_for_company_register') {
    if (defined('AJAX_REQUEST')) {
        $status = true;
        $phone = isset($_REQUEST['phone']) ? trim($_REQUEST['phone']) : null;
        
        if (empty($phone)) {
            $status = false;
            fn_set_notification('E', __('error'), __('phone_required'));
        }
        
        $phone_exist = db_get_field("SELECT user_id FROM ?:users WHERE phone = ?s AND user_type = ?s", $phone, 'V');
            
        if($phone_exist){
            fn_set_notification('W', __('error'), __('phone_aleady_exist'));
            $status = false;
        }
    
        if($status == true){
            if (!fn_jmj_send_otp_for_company_register($phone)) {
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

if ($mode == 'verify_otp_for_company_register') {
    
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
            $data = fn_jmj_verify_otp_for_company_register($phone, $otp);
            if (empty($data)) {
                $status = false;
                fn_set_notification('E', __('error'), __('error_occurred'));
            } else{
                $_SESSION['phone_verified'] = true;
                $_SESSION['vendor_register_form_id'] = $data['id'];
                $register_last_step = $data['register_last_step'];
                fn_set_notification('N', __('success'), __('verified_success'));
                
                if($register_last_step){
                    Tygh::$app['ajax']->assign('force_redirection', fn_url('auth.seller_register&step='.$register_last_step)); 
                }else{
                    Tygh::$app['ajax']->assign('force_redirection', fn_url('auth.seller_register')); 
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
if ($mode == 'get_sub_categories') {

    if (defined('AJAX_REQUEST')) {

        $category_id = $_REQUEST['category_id'];
        $sub_categories = fn_get_subcategories($category_id);
        $response = array();
        $str = "";

        if(!empty($sub_categories)){
            $msg = __('choose_category');
            $str .=" <option value='0'>$msg</option> <br>";
            foreach($sub_categories as $sub_category){
                $str .=" <option value='$sub_category[category_id]'>$sub_category[category]</option> <br>";
            }
            $response['status'] = true;
            
        }else{
            $msg = __('no_sub_category_found');
            $str .=" <option value='0'>$msg</option> <br>";
        }

        // Get category allowed not allowed image
        $imageUrl = fn_get_image_pairs($category_id, 'cat_allowed_not_allowed', 'M', true, true, $lang_code);
        if($imageUrl){
            $response['image'] = $imageUrl['icon']['image_path'];
        }else{
            $response['image'] = false;
        }

        $response['str'] = $str;
        echo json_encode($response);
    
        exit;
    }    
}

if ($mode == 'verify_gstin') {
    $res = array();
    if (defined('AJAX_REQUEST')) {
        $status = true;
        $gstin = isset($_REQUEST['gstin']) ? trim($_REQUEST['gstin']) : null;
        $vendor_register_form_id = isset($_SESSION['vendor_register_form_id']) ? $_SESSION['vendor_register_form_id'] : 0;
        
        if (empty($gstin) || empty($vendor_register_form_id)) {
            $status = false;
            fn_set_notification('E', __('error'), __('gstin_required'));
        }
    
        if($status == true){
            $data = fn_jmj_verify_gstin($gstin);
           
            if ($data->error) {
                $status = false;
                fn_set_notification('E', __('error'), __('gst_detail_not_found'));
            } else{
                
                $update_data = array(
                    'gstin_number' => $gstin,
                    'pan_number'   => substr($gstin, 2, -3)
                );
                    
                db_query("UPDATE ?:company_additional_data SET ?u WHERE id = ?i", $update_data, $vendor_register_form_id);
            
                $res = (array)$data->data->pradr->addr;
                $res['b_name'] = $data->data->lgnm;
                fn_set_notification('N', __('success'), __('verified_success'));
            }

        }      

        $redirect_url_params = [
            'status'    => $status,
            'gstin'      => $gstin,
            'data'      => $res
        ];

        echo json_encode($redirect_url_params);
        exit;
    }    
}
    

