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

defined('BOOTSTRAP') or die('Access denied');

use Tygh\BlockManager\Block;
use Tygh\BlockManager\ProductTabs;
use Tygh\Enum\SiteArea;
use Tygh\Enum\VendorStatuses;
use Tygh\Enum\YesNo;
use Tygh\Languages\Languages;
use Tygh\Registry;
use Tygh\Storefront\Storefront;

function fn_jmj_digital_update_category_pre(&$category_data, $category_id, $lang_code)
{
    if(isset($category_data['product_image_type']) && !empty($category_data['product_image_type']) && is_array($category_data['product_image_type'])){
        $category_data['product_image_type'] = implode(',', $category_data['product_image_type']);
    }

}
function fn_get_fabricvalue($product_id, $featureid, $variantid){
    return db_get_field("SELECT variant_value FROM ?:custom_variant_total WHERE product_id = ?i AND featureid=?i AND variantid= ?i", $product_id, $featureid, $variantid);
}
function fn_jmj_digital_update_category_post($category_data, $category_id, $lang_code)
{
    // Update allowed not allowed image
    fn_attach_image_pairs('cat_allowed_not_allowed', 'cat_allowed_not_allowed', $category_id);
    
    // Update guideline image
    fn_attach_image_pairs('cat_guideline_image', 'cat_guideline_image', $category_id);

}

function fn_jmj_digital_get_category_data_post($category_id, $field_list, $get_main_pair, $skip_company_condition, $lang_code, &$category_data)
{
    if(isset($category_data['product_image_type']) && !empty($category_data['product_image_type']) && !is_array($category_data['product_image_type'])){
        $category_data['product_image_type'] = explode(',', $category_data['product_image_type']);
    }else{
        $category_data['product_image_type'] = array();
    }

    // get allowed not allowed image
    $category_data['cat_allowed_not_allowed'] = fn_get_image_pairs($category_id, 'cat_allowed_not_allowed', 'M', true, true, $lang_code);
    
    // get guideline image
    $category_data['cat_guideline_image'] = fn_get_image_pairs($category_id, 'cat_guideline_image', 'M', true, true, $lang_code);

}

function fn_jmj_digital_update_product_feature_post($feature_data, $feature_id, $deleted_variants, $lang_code)
{
    // Update all variants hint image
    fn_attach_image_pairs('all_variants_hint_image', 'variants_hint_image', $feature_id);

}

function fn_jmj_digital_get_product_feature_data_post(&$feature_data)
{
    // get all variants hint image
    $feature_data['variants_hint_image'] = fn_get_image_pairs($feature_data['feature_id'], 'variants_hint_image', 'M', true, true, $feature_data['lang_code']);
    $col_data =  db_get_row("SELECT feature_variant_design, multi_colors_filter FROM ?:product_features WHERE feature_id = ?i", $feature_data['feature_id']);
    $feature_data['feature_variant_design'] = $col_data['feature_variant_design'];
    $feature_data['multi_colors_filter'] = $col_data['multi_colors_filter'];

}

function fn_jmj_digital_get_product_features_post(&$data, $params, $has_ungroupped)
{
  
    // get all variants hint image for all features
    if(!empty($data)){
        foreach($data as $da){
            $subfeatures = $da['subfeatures'];
            if(!empty($subfeatures)){
                foreach($subfeatures as $features){
                    $features['variants_hint_image'] = fn_get_image_pairs($features['feature_id'], 'variants_hint_image', 'M', true, true, $features['lang_code']);
                        $col_data =  db_get_row("SELECT feature_variant_design, multi_colors_filter FROM ?:product_features WHERE feature_id = ?i", $features['feature_id']);
                        $features['feature_variant_design'] = $col_data['feature_variant_design'];
                        $features['multi_colors_filter'] = $col_data['multi_colors_filter'];
                    $subfeatures[$features['feature_id']] = $features;
                }

                $da['subfeatures'] = $subfeatures;

            }else{
                
                $col_data =  db_get_row("SELECT feature_variant_design, multi_colors_filter FROM ?:product_features WHERE feature_id = ?i", $da['feature_id']);
                $da['feature_variant_design'] = $col_data['feature_variant_design'];
                $da['multi_colors_filter'] = $col_data['multi_colors_filter'];
            }
            
            $data_new[$da['feature_id']] = $da;
        }
        $data = $data_new;
    }

}

function fn_jmj_digital_update_user_pre($user_id, &$user_data, $auth, $ship_to_another, $notify_user, $can_update)
{
    if(!$user_id){
        $user_code = fn_generateRandomStrings(10);
        $user_data['user_code'] = $user_code;
    }

    //AREA A
    if(!empty($user_data['locations']) && AREA == 'A'){
        if(!empty($user_data['marketing_user'])){
            $location_marketing_users_data = array();
            foreach($user_data['marketing_user'] as $location_id => $marketing_user_id){
                $lmud = array();
                if(in_array($location_id, $user_data['locations'])){
                    $lmud['location_id'] = $location_id;
                    $lmud['marketing_user_id'] = $marketing_user_id;
                }
                if(!empty($lmud)){
                    $location_marketing_users_data[] = $lmud;
                }
            }
            $user_data['location_marketing_users_data'] = serialize($location_marketing_users_data);
        }
        $user_data['location'] = implode(',', $user_data['locations']);
    }

    //AREA C
    if(!empty($user_data['location']) && AREA == 'C'){
        if(!empty($user_data['location_marketing_users_data'])){
            $user_data['location_marketing_users_data'] = serialize($user_data['location_marketing_users_data']);
        }
        if(is_array($user_data['location'])){
            $user_data['location'] = implode(',', $user_data['location']);
        }    
    }
    
}
function fn_jmj_digital_get_user_info($user_id, $get_profile, $profile_id, &$user_data){

    if(!empty($user_data['location'])){
        $user_data['location'] = explode(',', $user_data['location']);
    }
    if(!empty($user_data['location_marketing_users_data'])){
        $user_data['location_marketing_users_data'] = unserialize($user_data['location_marketing_users_data']);
    }
}

function fn_get_location_marketing_users($location_id){
    $location_marketing_users = db_get_array("SELECT user_id, firstname, lastname FROM `?:users` WHERE location = ?i AND user_type = ?s", $location_id, 'A');
    return $location_marketing_users;
}

function fn_check_location_marketing_user_id($marketing_user_id, $location_marketing_users_data){
    if(array_search($marketing_user_id, array_column($location_marketing_users_data, 'marketing_user_id')) !== False) {
        return true;
    } else {
        return false;
    }
}
//Generate random alphanumric string
function fn_generateRandomStrings($length_of_string) 
{ 
    $str_result = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'; 
    return substr(str_shuffle($str_result), 0, $length_of_string); 
} 

function fn_jmj_is_user_exists($user_code, $customer_type){
    return db_get_row("SELECT * FROM ?:users WHERE email = ?s AND user_type = ?s", $user_code, $customer_type);
}

function fn_jmj_user_send_otp($params){
    
    $otp = fn_generate_otp(4);
    
    $data = array(
        'otp' => $otp,
        'verified' => 0,
        'otp_insert_time' => date('H:i:s')
    );
   
    //update otp by registered phone
    db_query('UPDATE ?:users SET ?u WHERE user_id = ?i', $data, $params['user_id']);

    //sent otp by registered phone
    $phone = $params['phone'];  
    $expire_time = OTP_TIMEOUT_TIME_IN_MINUTE;
    $template = urlencode("OTP is $otp to login JMJ. Valid till $expire_time minute. Do not share OTP for security reasons.");
    
    $url = "http://nimbusit.co.in/api/swsend.asp?username=t1hrghotia&password=jsk@6506&sender=JMJAIN&sendto=$phone&message=$template&rpt=1%27&entityID=1701159541566588374&templateID=1707162581220253900";
  
    $curl = curl_init();

    curl_setopt_array($curl, array(
        CURLOPT_URL => "$url",
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "GET",
        CURLOPT_HTTPHEADER => array(
            "Cookie: ASPSESSIONIDAACSACAD=OOBGNLPDJNNGDAJADECDGGGI"
        ),
    ));

    $response = curl_exec($curl);
    curl_close($curl);

    if($response){
        return $otp;
    }else{
        return false;
    } 

}
function fn_generate_otp($length) {
    $characters = '0123456789';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}
function fn_jmj_auth_routines($request, $auth)
{
    $status = true;

    $user_login = (!empty($request['user_code'])) ? trim($request['user_code']) : '';
    $password = (!empty($request['password'])) ? $request['password']: '';
    $field = 'email';

    $condition = '';

    if (fn_allowed_for('ULTIMATE')) {
        if (Registry::get('settings.Stores.share_users') == 'N' && AREA != 'A') {
            $condition = fn_get_company_condition('?:users.company_id');
        }
    }

    /**
     * Selects user data
     *
     * @param array $request Query parameters
     * @param array $auth Authentication data
     * @param string $field SQL field to select user by
     * @param string $condition String containing SQL-query condition possibly prepended with a logical operator (AND or OR)
     * @param string $user_login Value to select user by
     */
    fn_set_hook('jmj_auth_routines', $request, $auth, $field, $condition, $user_login);

    $user_data = db_get_row("SELECT * FROM ?:users WHERE $field = ?s" . $condition, $user_login);

    if (empty($user_data)) {
        $user_data = db_get_row("SELECT * FROM ?:users WHERE $field = ?s AND user_type IN ('A', 'V', 'P')", $user_login);
    }

    if (!empty($user_data)) {
        $user_data['usergroups'] = fn_get_user_usergroups($user_data['user_id']);
    }

    if (
        !empty($user_data)
        && (!fn_check_user_type_admin_area($user_data) && AREA == 'A' || !fn_check_user_type_access_rules($user_data))
    ) {
        fn_set_notification('E', __('error'), __('error_area_access_denied'));
        $status = false;
    }

    if (!empty($user_data['status']) && $user_data['status'] == 'D') {
        fn_set_notification('E', __('error'), __('error_account_disabled'));
        $status = false;
    }

    $salt = isset($user_data['salt']) ? $user_data['salt'] : '';

    return array($status, $user_data, $user_login, $password, $salt);
}
function fn_update_cities($city_data, $city_id = 0, $lang_code = CART_LANGUAGE)
{
    $can_update = true;

    fn_set_hook('update_city_pre', $city_data, $city_id, $lang_code, $can_update);

    if ($can_update == false) {
        return false;
    }
    // add new city
    if (empty($city_id)) {

        if (empty($city_data['city'])) {
            fn_set_notification('E', __('error'), 'empty city name');

            return false;
        }
        
        $city_id = db_query("INSERT INTO ?:cities ?e", $city_data);

        if (empty($city_id)) {
            return false;
        }

        $city_data['id'] = $city_id;

        $action = 'add';
      
    // update city information
    } else {
      
        if (!empty($city_data['status'])) {
            $status_from = db_get_field("SELECT status FROM ?:cities WHERE id = ?i", $city_id);
        }
        
        db_query("UPDATE ?:cities SET ?u WHERE id = ?i", $city_data, $city_id);

        if (isset($status_from) && $status_from != $city_data['status']) {
            fn_change_city_status($city_id, $city_data['status'], '', $status_from, true);
        }

        $action = 'update';
    }

   
    fn_set_hook('update_city', $city_data, $city_id, $lang_code, $action);

    return $city_id;
}
function fn_change_city_status($city_id, $status_to, $reason = '', &$status_from = '', $skip_query = false, $notify = true)
{
    
    fn_set_hook('change_city_status_pre', $city_id, $status_to, $reason, $status_from, $skip_query, $notify);

    if (empty($status_from)) {
        $status_from = db_get_field("SELECT status FROM ?:cities WHERE id = ?i", $city_id);
    }

    if (!in_array($status_to, array('A', 'P', 'D')) || $status_from == $status_to) {
        return false;
    }

    $result = $skip_query ? true : db_query("UPDATE ?:cities SET status = ?s WHERE id = ?i", $status_to, $city_id);

    if (!$result) {
        return false;
    }

    $city_data = fn_get_city_data($city_id);
    return $city_data;
}
function fn_get_city_data($city_id, $lang_code = DESCR_SL, $extra = array())
{
    static $city_data_cache = array();

    if (empty($city_id)) {
        return false;
    }

    $cache_key = md5($city_id . $lang_code . serialize($extra));

    if (empty($extra['skip_cache']) && isset($city_data_cache[$cache_key])) {
        return $city_data_cache[$cache_key];
    }

    fn_set_hook('get_city_data_pre', $city_id, $lang_code, $extra);

    $fields = array(
        'cities.*',
    );

    $join = '';

    $condition = '';

    fn_set_hook('get_city_data', $city_id, $lang_code, $extra, $fields, $join, $condition);

    $city_data = db_get_row(
        'SELECT ' . implode(', ', $fields) . ' FROM ?:cities AS cities ?p'
        . ' WHERE cities.id = ?i ?p',
        $join,
        $city_id,
        $condition
    );

    fn_set_hook('get_city_data_post', $city_id, $lang_code, $extra, $city_data);

    if (empty($extra['skip_cache'])) {
        $city_data_cache[$cache_key] = $city_data;
    }

    return $city_data;
}
function fn_delete_cities($city_id)
{
    if (empty($city_id)) {
        return false;
    }

    $can_delete = true;

    fn_set_hook('delete_city_pre', $city_id, $can_delete);


    $result = db_query("DELETE FROM ?:cities WHERE id = ?i", $city_id);

    fn_set_hook('delete_city', $city_id, $result);

    return $result;
}
function fn_get_all_cities($params = array(), &$auth, $items_per_page = 0, $lang_code = CART_LANGUAGE)
{
    // Init filter
    $_view = 'cities';
    
    // Set default values to input params
    $default_params = array (
        'page' => 1,
        'items_per_page' => $items_per_page
    );

    $params = array_merge($default_params, $params);

    // Define fields that should be retrieved
    $fields = array (
        '?:cities.id',
        '?:cities.city',
        '?:cities.created_at',
        '?:cities.status',
    );


    // Define sort fields
    $sortings = array (
        'id' => '?:cities.id',
        'city' => '?:cities.city',
        'date' => '?:cities.created_at',
        'status' => '?:cities.status',
    );

    $condition = $join = $group = '';

    $group .= " GROUP BY ?:cities.id";

    if (isset($params['city']) && fn_string_not_empty($params['city'])) {
        $condition .= db_quote(" AND ?:cities.city LIKE ?l", "%".trim($params['city'])."%");
    }

    if (!empty($params['status'])) {
        if (is_array($params['status'])) {
            $condition .= db_quote(" AND ?:cities.status IN (?a)", $params['status']);
        } else {
            $condition .= db_quote(" AND ?:cities.status = ?s", $params['status']);
        }
    }
    
    if (!empty($params['ids'])) {
        if (is_array($params['ids'])) {
            $condition .= db_quote(" AND ?:cities.id IN (?a)", $params['ids']);
        } else {
            $condition .= db_quote(" AND ?:cities.id = ?s", $params['ids']);
        }
    }
    
    fn_set_hook('get_cities', $params, $fields, $sortings, $condition, $join, $auth, $lang_code, $group);

    //$sorting = db_sort($params, $sortings, 'id', 'desc');

    // Paginate search results
    $limit = '';
    if (!empty($params['items_per_page'])) {
        $params['total_items'] = db_get_field("SELECT COUNT(DISTINCT(?:cities.id)) FROM ?:cities $join WHERE 1 $condition");
        $limit = db_paginate($params['page'], $params['items_per_page'], $params['total_items']);
    }
    
    $cities = db_get_array("SELECT " . implode(', ', $fields) . " FROM ?:cities $join WHERE 1 $condition $group $sorting $limit");
   
    fn_set_hook('get_cities_post', $params, $auth, $items_per_page, $lang_code, $cities);

    return array($cities, $params);
}

function fn_jmj_digital_get_products($params, &$fields, $sortings, &$condition, &$join, $sorting, $group_by, $lang_code, $having){
    
    $user_id = (isset($params['user_id']) && !empty($params['user_id'])) ? $params['user_id'] : $_SESSION['auth']['user_id'];
    $user_type = (isset($params['user_type']) && !empty($params['user_type'])) ? $params['user_type'] : $_SESSION['auth']['user_type'];
    $location_ids = db_get_field("SELECT location FROM ?:users WHERE user_id = ?i", $user_id);
    $fields['net_price'] = 'products.net_price as net_price';
    $fields['integer_in_full_description'] = 'products.integer_in_full_description';
    if($user_id && $user_type == 'C' && $location_ids){
        $companies_join = db_quote(" LEFT JOIN ?:companies AS companies ON companies.company_id = products.company_id ");
        if (!in_array('companies', $params['extend'])) {
            $join .= $companies_join;
        }
        
        if(isset($_SESSION['location_id']) && $_SESSION['location_id']){
            $condition .= db_quote(' AND companies.location = ?i', $_SESSION['location_id']);
        }else{
            $location_ids = explode(',', $location_ids);
            $condition .= db_quote(' AND companies.location IN(?a)', $location_ids);
        }
    }
    if(isset($params['error_in_full_desc']) && !empty($params['error_in_full_desc'])){
        $condition .= db_quote(' AND products.integer_in_full_description = ?s', $params['error_in_full_desc']);
    }    
}

function fn_jmj_digital_get_product_data($product_id, $field_list, $join, $auth, $lang_code, &$condition, $price_usergroup){

    $location_ids = db_get_field("SELECT location FROM ?:users WHERE user_id = ?i", $_SESSION['auth']['user_id']);
    if($_SESSION['auth']['user_id'] && AREA == 'C' && $location_ids){
        $location_ids = explode(',', $location_ids);
        $condition .= db_quote(' AND companies.location IN(?a)', $location_ids);
    }
}
function fn_jmj_digital_get_cart_product_data($product_id, &$_pdata, $product, $auth, $cart, $hash){

    // if($_SESSION['auth']['user_id'] && AREA == 'C' && $_SESSION['location_id']){
    //     $company_location_id = db_get_field("SELECT location FROM ?:companies WHERE company_id = ?i", $_pdata['company_id']);
    //     if($company_location_id != $_SESSION['location_id']){
    //         unset($_pdata['product_id']);
    //     }
    // }
    
}

function fn_jmj_digital_pre_place_order(&$cart, $allow, $productgroup){

    // if($_SESSION['auth']['user_id'] && AREA == 'C'){
    //     //$marketing_user_id = 13;
    //     $location_marketing_users_data = $cart['user_data']['location_marketing_users_data'];
    //     foreach($location_marketing_users_data as $lmud){
    //         if($lmud['location_id'] == $_SESSION['location_id']){
    //             $marketing_user_id = $lmud['marketing_user_id'];
    //         }
    //     }
    //     $cart['marketing_user_id'] = $marketing_user_id;
    // }
    
}

function fn_jmj_digital_update_product_prices($product_id, &$_product_data, $company_id, $skip_price_delete, $table_name, $condition){

    // Update product prices
    
    $_price = array (
        'price' => abs($_product_data['price']),
        'lower_limit' => 1,
        'usergroup_id' => 0,
    );

    if (isset($_product_data['price']) && $_product_data['net_price'] == '0.00') {
    
        $net_price = array (
            'price' => abs($_product_data['price']),
            'lower_limit' => 1,
            'usergroup_id' => CC_USERGROUP_ID,
            'type'         => 'A'
        );

    }else if(isset($_product_data['price']) && $_product_data['net_price']){
       
        $net_price = array (
            'price' => abs($_product_data['net_price']),
            'lower_limit' => 1,
            'usergroup_id' => CC_USERGROUP_ID,
            'type'         => 'A'
        );   
    }
       
   
    if (!isset($_product_data['prices'])) {
        $_product_data['prices'][0] = $_price;
        $_product_data['prices'][1] = $net_price;
        $skip_price_delete = true;

    } else {

        $new_product_prices = array();
        $next_index = 2;
        $skip_index = 0;
        $new_product_prices[0] = $_price;
        $new_product_prices[1] = $net_price;
       
        foreach($_product_data['prices'] as $p_price){
            
            if($skip_index > 0){
                if(isset($p_price['cl_price']) && !empty($p_price['lower_limit'])){
                    $new_product_prices[$next_index]['usergroup_id'] = CL_USERGROUP_ID;
                    $new_product_prices[$next_index]['price'] = $p_price['cl_price'];
                    $new_product_prices[$next_index]['lower_limit'] = $p_price['lower_limit'];
                    $new_product_prices[$next_index]['type'] = 'A'; 
                    $new_product_prices[$next_index]['percentage_discount'] = 0;
                }
                
                $next_index += 1;
                if(isset($p_price['cc_price']) && !empty($p_price['lower_limit'])){
                    
                    $new_product_prices[$next_index]['usergroup_id'] = CC_USERGROUP_ID;
                    $new_product_prices[$next_index]['price'] = $p_price['cc_price'];
                    $new_product_prices[$next_index]['lower_limit'] = $p_price['lower_limit'];
                    $new_product_prices[$next_index]['type'] = 'A'; 
                    $new_product_prices[$next_index]['percentage_discount'] = 0;
                }
                $next_index += 1;
    
            }
            
            $skip_index += 1;
        }

        $_product_data['prices'] = $new_product_prices;
    }
   
}

function fn_jmj_digital_get_product_data_post(&$product_data, $auth, $preview, $lang_code){
    //calculate discount percentage
    $product_prices_new = array();
    foreach($product_data['prices'] as $pkey => $pvalue){
        $product_prices_new[$pvalue['lower_limit']][$pvalue['usergroup_id']] = $pvalue['price'];
    }
    $product_data['prices_new'] = $product_prices_new;
   
}

function fn_get_customer_locations($user_id){
    $locations = array();
    $location_ids = db_get_field("SELECT location FROM ?:users WHERE user_id = ?i", $user_id);
    if($location_ids){
        $location_ids = explode(',' , $location_ids);
        $locations = db_get_array("SELECT id, city FROM ?:cities WHERE id IN (?a)", $location_ids);
    }
    return $locations;
}

function fn_jmj_digital_get_orders($params, &$fields, $sortings, &$condition, $join, $group){

    if(Registry::get('runtime.company_id')){
        $condition .= db_quote(" AND ?:orders.sap_id != ?i AND ?:orders.status NOT IN ('A', 'E', 'O')", 0);
    }
    // if($_SESSION['auth']['user_type'] == 'A' && AREA == 'A'){
    //     $location = db_get_field("SELECT location FROM ?:users WHERE user_id = ?i", $_SESSION['auth']['user_id']);
    //     if($location){
    //         $condition .= db_quote(" AND ?:orders.marketing_user_id = ?i", $_SESSION['auth']['user_id']);
    //     }
    // }
    
}

function fn_jmj_digital_change_approval_status($order_id, $status, $reason=''){

    if($status == 'N' && !empty($reason)){
        $data = array(
            'order_id' => $order_id,
            'reason' => $reason

        );
        db_query("REPLACE INTO ?:order_disapproved_reason ?e", $data);
    }

    return true;
}

function fn_jmj_digital_send_order_tp_sap($order_id){
    $data = array(
        'sap_id' => $order_id
    );
    db_query("UPDATE ?:orders SET ?u WHERE order_id = ?i", $data, $order_id);

    return true;
}

function fn_jmj_digital_get_customer_phone($order_id){

    $phone = db_get_field("SELECT phone FROM ?:orders WHERE order_id = ?i " , $order_id);
    if(!$phone){
        $phone = db_get_field("SELECT b_phone FROM ?:orders WHERE order_id = ?i " , $order_id);
    }
    if(!$phone){
        $phone = db_get_field("SELECT s_phone FROM ?:orders WHERE order_id = ?i " , $order_id);
    }
    return $phone;
}

function fn_jmj_digital_send_sms($phone, $template){

    $template = urlencode($template);
    //$url = "http://nimbusit.co.in/api/swsend.asp?username=t1hrghotia&password=jsk@6506&sender=JMJAIN&sendto=$phone&message=$template&rpt=1%27";
   
   $url = "http://nimbusit.co.in/api/swsend.asp?username=t1hrghotia&password=jsk@6506&sender=JMJAIN&sendto=$phone&message=$template&rpt=1%27&entityID=1701159541566588374&templateID=1707162581220253900";
   
    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => "$url",
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "GET",
        CURLOPT_HTTPHEADER => array(
            "Cookie: ASPSESSIONIDAACSACAD=OOBGNLPDJNNGDAJADECDGGGI"
        ),
    ));

    $response = curl_exec($curl);
    curl_close($curl);

    if($response){
        return true;
    }else{
        return false;
    } 
}

function fn_jmj_digital_get_order_info(&$order, $additional_data){
    $order['vendor_statuses'] = fn_jmj_digital_get_all_vendor_statuses();
    $reason = db_get_field("SELECT reason FROM ?:order_disapproved_reason WHERE order_id = ?i " , $order['order_id']);
    if($reason){
        $order['reason'] = $reason;
    }

}

function fn_jmj_digital_get_complete_vendor_statuses($last_status_num){
    $complete_statuses = db_get_array("SELECT * FROM `?:vendor_order_statuses` WHERE serial_number <= ?i", $last_status_num);
    return $complete_statuses;
}

function fn_jmj_digital_get_current_vendor_status($last_status_num){
    $next_status = db_get_row("SELECT * FROM `?:vendor_order_statuses` WHERE serial_number = ?i", $last_status_num+1);
    return $next_status;
}

function fn_jmj_digital_get_all_vendor_statuses(){
    $statuses = db_get_array("SELECT * FROM `?:vendor_order_statuses`");
    return $statuses;
}
function fn_get_all_custom_brands($params = array(), &$auth, $items_per_page = 0, $lang_code = CART_LANGUAGE)
{
    // Init filter
    $_view = 'cities';
    
    // Set default values to input params
    $default_params = array (
        'page' => 1,
        'items_per_page' => $items_per_page
    );

    $params = array_merge($default_params, $params);

    // Define fields that should be retrieved
    $fields = array (
        '?:brands.*',
        'company.company',
    );


    // Define sort fields
    $sortings = array (
        'id' => '?:brands.id',
        'brand' => '?:brands.city',
        'date' => '?:brands.created_at',
        'status' => '?:brands.status',
    );

    $condition = $join = $group = '';

    $group .= " GROUP BY ?:brands.id";
    $join .= " INNER JOIN ?:companies company ON(?:brands.company_id = company.company_id)";

    if (isset($params['brand']) && fn_string_not_empty($params['brand'])) {
        $condition .= db_quote(" AND ?:brands.brand LIKE ?l", "%".trim($params['brand'])."%");
    }

    if (isset($params['company_id']) && !empty($params['company_id'])) {
        $condition .= db_quote(" AND ?:brands.company_id = ?i", $params['company_id']);
    }

    if (isset($params['company_name']) && fn_string_not_empty($params['company_name'])) {
        $condition .= db_quote(" AND company.company LIKE ?l", "%".trim($params['company_name'])."%");
    }

    if (isset($params['location']) && !empty($params['location'])) {
        $condition .= db_quote(" AND company.location = ?i", $params['location']);
    }

    if (!empty($params['status'])) {
        if (is_array($params['status'])) {
            $condition .= db_quote(" AND ?:brands.status IN (?a)", $params['status']);
        } else {
            $condition .= db_quote(" AND ?:brands.status = ?s", $params['status']);
        }
    }
    

    $sorting = db_sort($params, $sortings, 'id', 'desc');

    // Paginate search results
    $limit = '';
    if (!empty($params['items_per_page'])) {
        $params['total_items'] = db_get_field("SELECT COUNT(DISTINCT(?:brands.id)) FROM ?:brands $join WHERE 1 $condition");
        $limit = db_paginate($params['page'], $params['items_per_page'], $params['total_items']);
    }
    
    $brands = db_get_array("SELECT " . implode(', ', $fields) . " FROM ?:brands $join WHERE 1 $condition $group $sorting $limit");

    return array($brands, $params);
}
function fn_update_brands($brand_data, $brand_id = 0, $lang_code = CART_LANGUAGE)
{
    // add new city
    if (empty($brand_id)) {

        if (empty($brand_data['brand'])) {
            fn_set_notification('E', __('error'), 'empty brand name');
            return false;
        }
        
        $brand_id = db_query("INSERT INTO ?:brands ?e", $brand_data);

        if (empty($brand_id)) {
            return false;
        }

        $brand_data['id'] = $brand_id;

        $action = 'add';
      
    // update city information
    } else {
      
        if (!empty($brand_data['status'])) {
            $status_from = db_get_field("SELECT status FROM ?:brands WHERE id = ?i", $city_id);
        }
        
        db_query("UPDATE ?:brands SET ?u WHERE id = ?i", $brand_data, $brand_id);

        if (isset($status_from) && $status_from != $brand_data['status']) {
            fn_change_brand_status($brand_id, $brand_data['status'], '', $status_from, true);
        }

        $action = 'update';
    }
    return $brand_id;
}
function fn_change_brand_status($brand_id, $status_to, $reason = '', &$status_from = '', $skip_query = false, $notify = true)
{
    if (empty($status_from)) {
        $status_from = db_get_field("SELECT status FROM ?:brands WHERE id = ?i", $brand_id);
    }

    if (!in_array($status_to, array('A', 'P', 'D')) || $status_from == $status_to) {
        return false;
    }

    $result = $skip_query ? true : db_query("UPDATE ?:brands SET status = ?s WHERE id = ?i", $status_to, $brand_id);

    if (!$result) {
        return false;
    }

    $city_data = fn_get_brand_data($brand_id);
    return $city_data;
}

function fn_get_brand_data($brand_id, $lang_code = DESCR_SL, $extra = array())
{
    if (empty($brand_id)) {
        return false;
    }

    $fields = array(
        'brands.*',
    );

    $join = $condition = '';

    $brand_data = db_get_row(
        'SELECT ' . implode(', ', $fields) . ' FROM ?:brands AS brands ?p'
        . ' WHERE brands.id = ?i ?p',
        $join,
        $brand_id,
        $condition
    );
    return $brand_data;
}

function fn_get_next_step($current_step){
    $max_step_num = db_get_field("SELECT MAX(step_number) FROM `?:product_create_steps`");
    $all_steps = db_get_array("SELECT * FROM `?:product_create_steps` WHERE status = ?s", 'Y');
   
    for($i= $current_step+1; $i <= $max_step_num; $i++){
        $key = array_search($i, array_column($all_steps, 'step_number'));
        if($key === false){
            continue;
        }else{
            return $all_steps[$key]['step_number']; 
        }
    }
}
function fn_get_previous_step($current_step){
    if($current_step == 1) {
        return 0;
    }else{
        $all_steps = db_get_array("SELECT * FROM `?:product_create_steps` WHERE status = ?s", 'Y');
        for($i=$current_step-1; $i>= 1; $i--){
            $key = array_search($i, array_column($all_steps, 'step_number'));
            if($key === false){
                continue;
            }else{
                return $all_steps[$key]['step_number']; 
            }
        }
    }
}
function fn_get_step_name($current_step){
    return db_get_field("SELECT step_name FROM `?:product_create_steps` WHERE step_number = ?i", $current_step);   
}
function fn_get_companies_for_brand(){
    return db_get_array("SELECT company_id, company FROM `?:companies` WHERE status = 'A'");   
}
function fn_get_brand_for_companies($company_id=0, $lang_code=CART_LANGUAGE){
    $sql = "SELECT pf.feature_id, pfv.variant_id, pfvd.variant";
    $sql .= " FROM ?:product_features pf";
    $sql .= " INNER JOIN ?:product_feature_variants pfv ON(pf.feature_id=pfv.feature_id)";
    $sql .= " INNER JOIN ?:product_feature_variant_descriptions pfvd ON(pfv.variant_id=pfvd.variant_id)";
    $sql .= " WHERE pf.feature_style = 'brand' AND lang_code = '$lang_code'";

    if($company_id){
        $sql .= " AND pfvd.company_id = $company_id";
    }
   
    return db_get_array($sql);

}

function fn_jmj_digital_update_product_pre(&$product_data, $product_id, $lang_code, $can_update){
    $feature_data = array_values($product_data['feature_data']);
    if(!empty($feature_data)){
        $product_data['brand_variant'] = $feature_data[0];
    }
    if(!empty($product_data['full_description'])){
        preg_match_all('/[0-9]/', $product_data['full_description'], $matches);
        $matches = $matches[0];
        if(!empty($matches)){
            $product_data['integer_in_full_description'] = 'Y';
        }else{
            $product_data['integer_in_full_description'] = 'N';
        }
    }
}
function fn_check_fabric_value($product_id){
    return db_get_field("SELECT count(*) as total FROM ?:custom_variant_total WHERE product_id = ?i", $product_id);
}


function fn_get_all_quote_request($params = array(), $items_per_page = 0, $lang_code = CART_LANGUAGE)
{
    // Init filter
    $_view = 'product_enquiry_form_details';
    
    // Set default values to input params
    $default_params = array (
        'page' => 1,
        'items_per_page' => $items_per_page
    );

    $params = array_merge($default_params, $params);

    // Define fields that should be retrieved
    $fields = array (
        '?:product_enquiry_form_details.id',
        '?:product_enquiry_form_details.user_name',
        '?:product_enquiry_form_details.phone_num',
        '?:product_enquiry_form_details.email_bulk',
        '?:product_enquiry_form_details.pincode',
        '?:product_enquiry_form_details.product_name',
        '?:product_enquiry_form_details.enq_qty',
        '?:product_enquiry_form_details.message_bulk',
        '?:product_enquiry_form_details.assigned',
        '?:product_enquiry_form_details.product_id',
        '?:product_enquiry_form_details.price',
        '?:product_enquiry_form_details.comment',
        '?:product_enquiry_form_details.assign_tocustomer',
        
    );


    // Define sort fields
    $sortings = array (
        'id' => '?:product_enquiry_form_details.id',
        'user_name' => '?:product_enquiry_form_details.user_name',
        'phone_num' => '?:product_enquiry_form_details.phone_num',
        'email_bulk' => '?:product_enquiry_form_details.email_bulk',
        'pincode' => '?:product_enquiry_form_details.pincode',
        'product_name' => '?:product_enquiry_form_details.product_name',
        'enq_qty' => '?:product_enquiry_form_details.enq_qty',
        'message_bulk' => '?:product_enquiry_form_details.message_bulk',
    );

    $condition = $join = $group = '';

    if(!empty($params['company_id']) && $params['user_type'] == 'V'){
        $condition = ' AND company_id= '.$params['company_id'].' and assigned=1';
    }

    $sorting = db_sort($params, $sortings, 'id', 'desc');

    // Paginate search results
    $limit = '';
    if (!empty($params['items_per_page'])) {
        $params['total_items'] = db_get_field("SELECT COUNT(DISTINCT(?:product_enquiry_form_details.id)) FROM ?:product_enquiry_form_details $join WHERE 1 $condition");
        $limit = db_paginate($params['page'], $params['items_per_page'], $params['total_items']);
    }
    
    $record = db_get_array("SELECT " . implode(', ', $fields) . " FROM ?:product_enquiry_form_details $join WHERE 1 $condition $sorting $limit");

    return array($record, $params);
}

//create brand on active status
function fn_jmj_digital_update_brand_variants($feature_id, $_data)
{
    $variant_ids = array();
    $feature_data = array();
    $feature_data = fn_get_product_feature_data($feature_id, false, false, DESCR_SL);
    $feature_data['original_var_ids'] = '';
    $get_max_variant_position = db_get_field("SELECT MAX(position) FROM ?:product_feature_variants WHERE feature_id = ?i", $feature_id);
    if($get_max_variant_position){
        $position = $get_max_variant_position+1;
    }else{
        $position = 100;
    }
    $new_variant = array(
        'color' => '#ffffff',
        'position' => $position,
        'variant' => $_data['brand'],
        'seo_name' => str_replace(" ", "-", $_data['brand']),
        'company_id' => $_data['company_id'],
        'vendor_brand_id' => $_data['vendor_brand_id']
    );

    $feature_data['variants'][1] = $new_variant;

    //update image from url
    $variant_image = array(
        'pair_id' => '',
        'type' => V,
        'object_id' => 0,
        'image_alt' => ''
    ); 

    $path = Registry::get('config.http_host').Registry::get('config.http_path').'/';
	$protocol = stripos($_SERVER['SERVER_PROTOCOL'],'https') === 0 ? 'https://' : 'http://';
	$url_prefix = $protocol.$path.'images/brands/';
    $logo_url = $url_prefix.$_data['logo'];

    $_REQUEST['variant_image_image_data'][1] = $variant_image;
    $_REQUEST['file_variant_image_image_icon'][1] = $logo_url;
    $_REQUEST['type_variant_image_image_icon'][1] = 'url';
    $_REQUEST['is_high_res_variant_image_image_icon'][1] = 'N';
    
    fn_update_product_feature_variants($feature_id, $feature_data);

    unset( $_REQUEST['variant_image_image_data']);
    unset( $_REQUEST['file_variant_image_image_icon']);
    unset( $_REQUEST['type_variant_image_image_icon']);
    unset( $_REQUEST['is_high_res_variant_image_image_icon']);
    
}
function fn_delete_brands($id){
    $variant_id = db_get_field("SELECT variant_id FROM ?:product_feature_variant_descriptions WHERE vendor_brand_id = ?i", $id);
    if($variant_id){
        fn_delete_product_feature_variants(0, array($variant_id));
    }

    db_query("DELETE FROM ?:brands WHERE id = ?i", $id);
}


function fn_user_quote($params, $items_per_page = 0)
{
    // Set default values to input params
    $default_params = array (
        'page' => 1,
        'items_per_page' => $items_per_page
    );

    $params = array_merge($default_params, $params);

    $sortings = array (
        'timestamp' => 'timestamp'
    );

    $sorting = db_sort($params, $sortings, 'timestamp', 'desc');

    $limit = '';
    if (!empty($params['items_per_page'])) {
        $params['total_items'] = db_get_field("SELECT COUNT(*) FROM ?:product_enquiry_form_details WHERE user_id = ?i", $params['user_id']);
        $limit = db_paginate($params['page'], $params['items_per_page'], $params['total_items']);
    }

    $quotes = db_get_array("SELECT * FROM ?:product_enquiry_form_details WHERE user_id = ?i $sorting $limit", $params['user_id']);

    return array($quotes, $params);
}

function fn_get_hsn_numbers()
{
    return db_get_fields("SELECT hsn_number FROM ?:hsn_numbers");
}

function fn_get_brand_classes(){
    $brand_classes = db_get_fields("SELECT brand_class FROM ?:brands_class_type group by brand_class");
    return $brand_classes;
}

function fn_get_product_details($id){
    return db_get_field("SELECT product_details FROM ?:brands_class_type WHERE id =?i", $id);
}

function get_brand_class_product_details($brand_class){

    if(!$brand_class){
        return false;
    }

    $product_details = db_get_array("SELECT id, product_details FROM ?:brands_class_type WHERE brand_class = ?s", $brand_class);

    return $product_details;

}

function fn_jmj_send_otp_for_customer_register($phone){
    $otp = fn_generate_otp(4);

    $update_data = array(
        'otp' => $otp,
        'otp_insert_time' => date('H:i:s')
    );

    $insert_data = array(
        'otp' => $otp,
        'phone'    => $phone,
        'otp_insert_time' => date('H:i:s')
    );
   
    $check = db_get_field("SELECT id FROM ?:customer_additional_data WHERE phone = ?i", $phone);
    if($check){
        db_query('UPDATE ?:customer_additional_data SET ?u WHERE phone = ?i', $update_data, $phone);
    }else{
        db_query('INSERT INTO ?:customer_additional_data ?e', $insert_data);
    }
   
    $expire_time = OTP_TIMEOUT_TIME_IN_MINUTE;
    $template = urlencode("OTP is $otp to login JMJ. Valid till $expire_time minute. Do not share OTP for security reasons.");
    
    $url = "http://nimbusit.co.in/api/swsend.asp?username=t1hrghotia&password=jsk@6506&sender=JMJAIN&sendto=$phone&message=$template&rpt=1%27&entityID=1701159541566588374&templateID=1707162581220253900";
   
    $curl = curl_init();

    curl_setopt_array($curl, array(
        CURLOPT_URL => "$url",
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "GET",
        CURLOPT_HTTPHEADER => array(
            "Cookie: ASPSESSIONIDAACSACAD=OOBGNLPDJNNGDAJADECDGGGI"
        ),
    ));

    $response = curl_exec($curl);
    curl_close($curl);

    if($response){
        return $otp;
    }else{
        return false;
    } 

}

function fn_jmj_verify_otp_for_customer_register($phone, $otp){
    $valid = false;
    $data = db_get_row("SELECT id, register_last_step, user_id, otp_insert_time FROM ?:customer_additional_data WHERE phone = ?i AND otp = ?i", $phone, $otp);
    if(isset($data['otp_insert_time'])){
        $time1 = strtotime($data['otp_insert_time']);
        $time2 = strtotime(date('H:i:s'));
        $timediff = round(($time2-$time1)/60, 2);
        
        if($timediff <= OTP_TIMEOUT_TIME_IN_MINUTE){
            $valid = true;
            return $data;
        }
    }
    
    return $valid;
}

function fn_jmj_send_otp_for_company_register($phone){
    $otp = fn_generate_otp(4);

    $update_data = array(
        'otp' => $otp,
        'otp_insert_time' => date('H:i:s')
    );

    $insert_data = array(
        'otp' => $otp,
        'phone'    => $phone,
        'otp_insert_time' => date('H:i:s')
    );
   
    $check = db_get_field("SELECT id FROM ?:company_additional_data WHERE phone = ?i", $phone);
    if($check){
        db_query('UPDATE ?:company_additional_data SET ?u WHERE phone = ?i', $update_data, $phone);
    }else{
        db_query('INSERT INTO ?:company_additional_data ?e', $insert_data);
    }
   
    $expire_time = OTP_TIMEOUT_TIME_IN_MINUTE;
    $template = urlencode("OTP is $otp to login JMJ. Valid till $expire_time minute. Do not share OTP for security reasons.");
    
    $url = "http://nimbusit.co.in/api/swsend.asp?username=t1hrghotia&password=jsk@6506&sender=JMJAIN&sendto=$phone&message=$template&rpt=1%27&entityID=1701159541566588374&templateID=1707162581220253900";
   
    $curl = curl_init();

    curl_setopt_array($curl, array(
        CURLOPT_URL => "$url",
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "GET",
        CURLOPT_HTTPHEADER => array(
            "Cookie: ASPSESSIONIDAACSACAD=OOBGNLPDJNNGDAJADECDGGGI"
        ),
    ));

    $response = curl_exec($curl);
    curl_close($curl);

    if($response){
        return $otp;
    }else{
        return false;
    } 

}

function fn_jmj_verify_otp_for_company_register($phone, $otp){
    $valid = false;
    $data = db_get_row("SELECT id, register_last_step, otp_insert_time FROM ?:company_additional_data WHERE phone = ?i AND otp = ?i", $phone, $otp);
    if(isset($data['otp_insert_time'])){
        $time1 = strtotime($data['otp_insert_time']);
        $time2 = strtotime(date('H:i:s'));
        $timediff = round(($time2-$time1)/60, 2);
        
        if($timediff <= OTP_TIMEOUT_TIME_IN_MINUTE){
            $valid = true;
            return $data;
        }
    }
    
    return $valid;
}

function fn_jmj_verify_gstin($gstin){
    
    $url = "https://commonapi.mastersindia.co/commonapis/searchgstin?gstin=$gstin";
    
    $curl = curl_init();

    curl_setopt_array($curl, array(
      CURLOPT_URL => $url,
      CURLOPT_RETURNTRANSFER => true,
      CURLOPT_ENCODING => '',
      CURLOPT_MAXREDIRS => 10,
      CURLOPT_TIMEOUT => 0,
      CURLOPT_FOLLOWLOCATION => true,
      CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
      CURLOPT_CUSTOMREQUEST => 'GET',
      CURLOPT_HTTPHEADER => array(
        'Content-Type: application/json',
        'Authorization: Bearer 772dc72bd6bccbc8f38db7de8565cf7356ea24bc',
        'client_id: AsICHCBcXOhNAZHewA'
      ),
    ));
    
    $response = curl_exec($curl);
    $response = json_decode($response);
    curl_close($curl);
    
    return $response;
   
}

function fn_jmj_digital_pre_delete_user($user_id){
    
    if(isset($_SESSION['vendor_register_form_id'])){
        unset($_SESSION['vendor_register_form_id']);
    }
    if(isset($_SESSION['phone_verified'])){
        unset($_SESSION['phone_verified']);
    }
    $user_data = db_get_row("SELECT user_type, company_id FROM ?:users WHERE user_id = ?i", $user_id);
    
    if($user_data['user_type'] == 'C'){
        db_query("DELETE FROM ?:customer_additional_data WHERE user_id = ?i", $user_id);
    }
    // elseif($user_data['user_type'] == 'V'){
    //     db_query("DELETE FROM ?:company_additional_data WHERE company_id = ?i", $user_data['company_id']);
    // }
}

function fn_jmj_digital_delete_company_pre($company_id, $can_delete){
    
    if($_SESSION['vendor_register_form_id']){
        unset($_SESSION['vendor_register_form_id']);
    }
    if($_SESSION['phone_verified']){
        unset($_SESSION['phone_verified']);
    }
    
    db_query("DELETE FROM ?:company_additional_data WHERE company_id = ?i", $company_id);
}

function fn_add_bulk_enquiry($data){
    
}

function fn_jmj_digital_save_tax_number_vendor($tax_number, $user_id){
    
        $check1 = db_get_field("SELECT object_id FROM ?:profile_fields_data WHERE object_id = ?i AND object_type =?s AND field_id=?i", $user_id, 'U', 54);
        if($check1){
            
            $update_data_1 = array(
                'value' => $tax_number
            );
            db_query("UPDATE ?:profile_fields_data SET ?u WHERE object_id = ?i AND object_type =?s AND field_id=?i", $update_data_1, $user_id, 'U', 54);
        
            
        }else{
            
            $insert_data_1 = array(
                'object_id'   => $user_id,
                'object_type' => 'U',
                'field_id'    => 54,
                'value'       => $tax_number
            );
            
            db_query("INSERT INTO ?:profile_fields_data ?e", $insert_data_1);
        }
        
        $check2 = db_get_field("SELECT object_id FROM ?:profile_fields_data WHERE object_id = ?i AND object_type =?s AND field_id=?i", $user_id, 'U', 55);
        if($check2){
            
            $update_data_2 = array(
                'value' => $tax_number
            );
            db_query("UPDATE ?:profile_fields_data SET ?u WHERE object_id = ?i AND object_type =?s AND field_id=?i", $update_data_2, $user_id, 'U', 55);
        
            
        }else{
            
            $insert_data_2 = array(
                'object_id'   => $user_id,
                'object_type' => 'U',
                'field_id'    => 55,
                'value'       => $tax_number
            );
            
            db_query("INSERT INTO ?:profile_fields_data ?e", $insert_data_2);
        }

}
