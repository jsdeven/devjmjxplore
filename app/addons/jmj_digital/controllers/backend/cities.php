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
        'city_data'
    );

    //
    // Processing additon of new company
    //
    if ($mode == 'add') {
        if (fn_allowed_for('ULTIMATE:FREE')) {
            return array(CONTROLLER_STATUS_DENIED);
        }

        $suffix = '.add';
        if (!empty($_REQUEST['city_data']['city'])) {  // Checking for required fields for new company

            if (Registry::get('runtime.simple_ultimate')) {
                Registry::set('runtime.simple_ultimate', false);
            }
            
                $city_data = $_REQUEST['city_data'];
                $city_id = fn_update_cities($city_data);
                
                if($city_id){
                   
                    $suffix = ".update?id=$city_id";
            
                    $redirect_url = empty($_REQUEST['redirect_url']) ? 'cities' . $suffix : $_REQUEST['redirect_url'];
            
                    if (defined('AJAX_REQUEST')) {
                        Tygh::$app['ajax']->assign('non_ajax_notifications', true);
                        Tygh::$app['ajax']->assign('force_redirection', fn_url($redirect_url));
            
                        exit();
                    }
            
                }else {
                    fn_save_post_data('city_data', 'update');
                }
         }

        
    }

    //
    // Processing updating of city element
    //
    if ($mode == 'update') {
        
        if (!empty($_REQUEST['city_data']['city'])) {
            $city_dta = $_REQUEST['city_data'];
            unset($city_dta['code']);
            fn_update_cities($city_dta, $_REQUEST['id'], DESCR_SL);
          
        }
        $suffix = ".update?id=$_REQUEST[id]";
    }

    if ($mode == 'm_delete') {
        //$robots = new Robots;

        if (!empty($_REQUEST['ids'])) {
            foreach ($_REQUEST['ids'] as $v) {
                fn_delete_cities($v);
            }
        }

        return array(CONTROLLER_STATUS_OK, 'cities.manage');
    }

   
    if ($mode == 'delete') {
        fn_delete_cities($_REQUEST['id']);

        return array(CONTROLLER_STATUS_REDIRECT, 'cities.manage');
    }

    if ($mode == 'update_status') {

        if (fn_change_city_status($_REQUEST['id'], $_REQUEST['status'], '', $status_from, false, $notification)) {
            fn_set_notification('N', __('notice'), __('status_changed'));
        } else {
            fn_set_notification('E', __('error'), __('error_status_not_changed'));
            Tygh::$app['ajax']->assign('return_status', $status_from);
        }
        if (!empty($_REQUEST['return_url'])) {
            return array(CONTROLLER_STATUS_REDIRECT, $_REQUEST['return_url']);
        }
        exit;
    }

    return array(CONTROLLER_STATUS_OK, 'cities' . $suffix);
}

if ($mode == 'manage') {
    
    list($cities, $search) = fn_get_all_cities($_REQUEST, $auth, Registry::get('settings.Appearance.admin_elements_per_page'));
   
    Tygh::$app['view']->assign('cities', $cities);
    Tygh::$app['view']->assign('search', $search);
   

} elseif ($mode == 'update' || $mode == 'add') {
    if ($mode == 'add' && fn_allowed_for('ULTIMATE:FREE')) {
        return array(CONTROLLER_STATUS_DENIED);
    }

    $id = !empty($_REQUEST['id']) ? $_REQUEST['id'] : 0;
    $city_data = !empty($id) ? fn_get_city_data($id) : array();
    
    if ($mode == 'update' && empty($city_data)) {
        return array(CONTROLLER_STATUS_NO_PAGE);
    }

    Tygh::$app['view']->assign('city_data', $city_data);

    $profile_fields = fn_get_profile_fields('A', array(), CART_LANGUAGE, array(
        'get_custom' => true,
        'get_profile_required' => true
    ));
    Tygh::$app['view']->assign('profile_fields', $profile_fields);

    $tabs['detailed'] = array(
        'title' => __('general'),
        'js' => true
    );

    Registry::set('navigation.tabs', $tabs);

} 


