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
    $suffix = '';

    // Define trusted variables that shouldn't be stripped
    fn_trusted_vars(
        'brand_data'
    );

    //
    // Processing additon of new Brand
    //
    if ($mode == 'add') {
        if (fn_allowed_for('ULTIMATE:FREE')) {
            return array(CONTROLLER_STATUS_DENIED);
        }
        
        $logo = time().$_FILES['logo']['name'];
        $doc = time().$_FILES['doc']['name'];
        $_REQUEST['brand_data']['logo'] = $logo;
        $_REQUEST['brand_data']['doc'] = $doc;
         
        if (!file_exists('images/brands/')) {
            mkdir('images/brands/', 0777, true);
        }
        move_uploaded_file($_FILES['logo']['tmp_name'], 'images/brands/'.$logo);
        move_uploaded_file($_FILES['doc']['tmp_name'], 'images/brands/'.$doc);

        $suffix = '.manage';
        if (!empty($_REQUEST['brand_data']['brand'])) {

            if (Registry::get('runtime.simple_ultimate')) {
                Registry::set('runtime.simple_ultimate', false);
            }
            if (Registry::get('runtime.company_id')) {
                $_REQUEST['brand_data']['company_id'] = Registry::get('runtime.company_id');
            }

            $brand_data = $_REQUEST['brand_data'];
            $brand_id = fn_update_brands($brand_data, $_REQUEST['id']);

            if($brand_id){
                fn_set_notification('N', __('notice'), __('brand_created'));
                return array(CONTROLLER_STATUS_OK, 'brands.success');
            }
        }       
    }

    if ($mode == 'product_class') {
       
        $product_class_data = $_REQUEST['product_class_data'];
        if(!empty($product_class_data)){
            foreach($product_class_data as $pcd){
                if(isset($pcd['id']) && !empty($pcd['id'])){

                    if(!empty($pcd['brand_class']) && !empty($pcd['product_details'])){
                        $update_data = array(
                            'brand_class' => $pcd['brand_class'],
                            'product_details' => $pcd['product_details']
                        );

                        db_query("UPDATE ?:brands_class_type SET ?u WHERE id = ?i", $update_data, $pcd['id']);

                    }else{
                        db_query("DELETE FROM ?:brands_class_type WHERE id = ?i", $pcd['id']);
                    }    

                }else{
                    if(!empty($pcd['brand_class'])){
                        db_query("INSERT INTO ?:brands_class_type ?e", $pcd);
                    }    
                }
                
            }
        }
    
        return array(CONTROLLER_STATUS_OK, 'brands.product_class');
    }

    if ($mode == 'm_delete') {
      
        if (!empty($_REQUEST['ids'])) {
            foreach ($_REQUEST['ids'] as $v) {
                fn_delete_brands($v);
            }
        }

        return array(CONTROLLER_STATUS_OK, 'cities.manage');
    }

    if ($mode == 'update_status') {
        $feature_id = db_get_field("SELECT feature_id FROM ?:product_features WHERE feature_style = ?s AND status = ?s", 'brand', 'A');
       
        if($feature_id){
            $brand_data = fn_get_brand_data($_REQUEST['id']);
            $brand_data['vendor_brand_id'] = $_REQUEST['id'];

            if($_REQUEST['status'] == 'A'){
                fn_jmj_digital_update_brand_variants($feature_id, $brand_data);
                $result = db_query("UPDATE ?:brands SET status = ?s WHERE id = ?i", $_REQUEST['status'], $_REQUEST['id']);
            }
            if($_REQUEST['status'] == 'D'){
                $variant_id = db_get_field("SELECT variant_id FROM ?:product_feature_variant_descriptions WHERE vendor_brand_id = ?i", $_REQUEST['id']);
                if($variant_id){
                    fn_delete_product_feature_variants(0, array($variant_id));
                }
                $result = db_query("UPDATE ?:brands SET status = ?s WHERE id = ?i", $_REQUEST['status'], $_REQUEST['id']);
            }
    
            if ($result) {
                fn_set_notification('N', __('notice'), __('status_changed'));
            } else {
                fn_set_notification('E', __('error'), __('error_status_not_changed'));
                Tygh::$app['ajax']->assign('return_status', $status_from);
            }
        }else{
            fn_set_notification('E', __('error'), __('brand_feature_not_created'));
        }
        
        if (!empty($_REQUEST['return_url'])) {
            return array(CONTROLLER_STATUS_REDIRECT, $_REQUEST['return_url']);
        }
        exit;
    }

    return array(CONTROLLER_STATUS_OK, 'brands' . $suffix);
}

if ($mode == 'manage') {

    if (Registry::get('runtime.company_id')) {
        $_REQUEST['company_id'] = Registry::get('runtime.company_id');
    }
    list($brands, $search) = fn_get_all_custom_brands($_REQUEST, $auth, Registry::get('settings.Appearance.admin_elements_per_page'));
    
    list($cities,) = fn_get_all_cities($params, $auth);
    Tygh::$app['view']->assign('cities', $cities);
    Tygh::$app['view']->assign('brands', $brands);
    Tygh::$app['view']->assign('search', $search);
}
if ($mode == 'update' || $mode == 'add') {
    if ($mode == 'add' && fn_allowed_for('ULTIMATE:FREE')) {
        return array(CONTROLLER_STATUS_DENIED);
    }

    $id = !empty($_REQUEST['id']) ? $_REQUEST['id'] : 0;
    $brand_data = !empty($id) ? fn_get_brand_data($id) : array();
    
    if ($mode == 'update' && empty($brand_data)) {
        return array(CONTROLLER_STATUS_NO_PAGE);
    }

    Tygh::$app['view']->assign('brand_data', $brand_data);

    $profile_fields = fn_get_profile_fields('A', array(), CART_LANGUAGE, array(
        'get_custom' => true,
        'get_profile_required' => true
    ));
    Tygh::$app['view']->assign('profile_fields', $profile_fields);

    $tabs['detailed'] = array(
        'title' => __('general'),
        'js' => true
    );

    Tygh::$app['view']->assign('brand_classes', fn_get_brand_classes());

    Registry::set('navigation.tabs', $tabs);
}

if ($mode == 'brand_class_product_details') {

    if (defined('AJAX_REQUEST')) {

        $brand_class = $_REQUEST['brand_class'];
        $product_details = get_brand_class_product_details($brand_class);
        $response = array();
        $str = "";

        if(!empty($product_details)){
            $msg = __('choose_product_detail');
            $str .=" <option value='0'>$msg</option> <br>";
            foreach($product_details as $product_detail){
                $str .=" <option value='$product_detail[id]'>$product_detail[product_details]</option> <br>";
            }
            $response['status'] = true;
        }else{
            $msg = __('no_product_details_found');
            
        }

        $response['str'] = $str;
        echo json_encode($response);
    
        exit;
    }    
}

if( $mode == 'success'){
    
}

if( $mode == 'product_class' ){
    $product_class_data = db_get_array("SELECT * FROM ?:brands_class_type");
    Tygh::$app['view']->assign('product_class_data',$product_class_data);
}
