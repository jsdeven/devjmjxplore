<?php 
use Tygh\Enum\YesNo;
use Tygh\Registry;
use Tygh\BlockManager\ProductTabs;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if($mode == 'product_enquiry_bulk'){
     
        $qty = !empty($_REQUEST['quantity']) ? $_REQUEST['quantity'] : 0;
        
        if(!empty($_REQUEST['first_name']) && !empty($_REQUEST['last_name']) && !empty($_REQUEST['product_name']) && !empty($_REQUEST['mobile_num']) && !empty($_REQUEST['email_bulk']) && !empty($_REQUEST['pincode'])){
            $user_name = $_REQUEST['first_name']. ' '. $_REQUEST['last_name'];
            $bulk_enquiry_form_id = db_query("INSERT INTO ?:product_enquiry_form_details SET user_name='" . addslashes($user_name) . "',phone_num='" . (int) $_REQUEST['mobile_num'] . "',email_bulk='" . addslashes($_REQUEST['email_bulk']) . "',pincode='" . (int) $_REQUEST['pincode'] . "', message_bulk='" . addslashes($_REQUEST['message_bulk']) . "',user_id='" . $_REQUEST['user_id'] . "',product_name='" .addslashes($_REQUEST['product_name']) . "' ,enq_qty=". (int) $qty. ',company_id='.$_REQUEST['company_id']. ',product_id='.$_REQUEST['product_id']);            
        }else{
            fn_set_notification('E', __('notice'),__('please_fill_required_field'));
            return array(CONTROLLER_STATUS_REDIRECT,'products.view?product_id='.$_REQUEST['product_id']);
        }
        if(empty($_REQUEST['product_id']))  {
            return array(CONTROLLER_STATUS_REDIRECT,'index.index');
        }else {
            fn_set_notification('N', __('notice'),__('enquiry_submitted'));
            return array(CONTROLLER_STATUS_REDIRECT,'products.view?product_id='.$_REQUEST['product_id']);
        }
    }
}

if ($mode == 'preview') {

    $_REQUEST['product_id'] = empty($_REQUEST['product_id']) ? 0 : $_REQUEST['product_id'];

    if (!empty($_REQUEST['product_id']) && empty($auth['user_id'])) {

        $uids = explode(',', db_get_field('SELECT usergroup_ids FROM ?:products WHERE product_id = ?i', $_REQUEST['product_id']));

        if (!in_array(USERGROUP_ALL, $uids) && !in_array(USERGROUP_GUEST, $uids)) {
            return array(CONTROLLER_STATUS_REDIRECT, 'auth.login_form?return_url=' . urlencode(Registry::get('config.current_url')));
        }
    }

    $product = fn_get_product_data(
        $_REQUEST['product_id'],
        $auth,
        CART_LANGUAGE,
        '',
        true,
        true,
        true,
        true,
        true,
        true,
        false,
        true
    );

    if (empty($product)) {
        return array(CONTROLLER_STATUS_NO_PAGE);
    }

    if (fn_allowed_for('MULTIVENDOR')) {
        /** @var \Tygh\Storefront\Storefront $storefront */
        $storefront = Tygh::$app['storefront'];
        if (
            isset($product['company_id'])
            && $storefront->getCompanyIds()
            && !in_array($product['company_id'], $storefront->getCompanyIds())
        ) {
            return [CONTROLLER_STATUS_NO_PAGE];
        }
    }

    if ((empty(Tygh::$app['session']['current_category_id']) || empty($product['category_ids'][Tygh::$app['session']['current_category_id']])) && !empty($product['main_category'])) {
        if (!empty(Tygh::$app['session']['breadcrumb_category_id']) && in_array(Tygh::$app['session']['breadcrumb_category_id'], $product['category_ids'])) {
            Tygh::$app['session']['current_category_id'] = Tygh::$app['session']['breadcrumb_category_id'];
        } else {
            Tygh::$app['session']['current_category_id'] = $product['main_category'];
        }
    }

    if (!empty($product['meta_description']) || !empty($product['meta_keywords'])) {
        Tygh::$app['view']->assign('meta_description', $product['meta_description']);
        Tygh::$app['view']->assign('meta_keywords', $product['meta_keywords']);

    } else {
        $meta_tags = db_get_row(
            "SELECT meta_description, meta_keywords"
            . " FROM ?:category_descriptions"
            . " WHERE category_id = ?i AND lang_code = ?s",
            Tygh::$app['session']['current_category_id'],
            CART_LANGUAGE
        );
        if (!empty($meta_tags)) {
            Tygh::$app['view']->assign('meta_description', $meta_tags['meta_description']);
            Tygh::$app['view']->assign('meta_keywords', $meta_tags['meta_keywords']);
        }
    }
    // if (!empty(Tygh::$app['session']['current_category_id'])) {
    //     Tygh::$app['session']['continue_url'] = "categories.view?category_id=".Tygh::$app['session']['current_category_id'];

    //     $parent_ids = fn_get_category_ids_with_parent(Tygh::$app['session']['current_category_id']);

    //     if (!empty($parent_ids)) {
    //         Registry::set('runtime.active_category_ids', $parent_ids);
    //         $cats = fn_get_category_name($parent_ids);
    //         foreach ($parent_ids as $c_id) {
    //             fn_add_breadcrumb($cats[$c_id], "categories.view?category_id=$c_id");
    //         }
    //     }
    // }
    //fn_add_breadcrumb($product['product']);

    if (!empty($_REQUEST['combination'])) {
        $product['combination'] = $_REQUEST['combination'];
    }

    fn_gather_additional_product_data($product, true, true);
    Tygh::$app['view']->assign('product', $product);

    // If page title for this product is exist than assign it to template
    if (!empty($product['page_title'])) {
        Tygh::$app['view']->assign('page_title', $product['page_title']);
    }

    $params = array (
        'product_id' => $_REQUEST['product_id'],
        'preview_check' => true
    );
    list($files) = fn_get_product_files($params);

    if (!empty($files)) {
        Tygh::$app['view']->assign('files', $files);
    }

    // Initialize product tabs
    fn_init_product_tabs($product);

    // Set recently viewed products history
    fn_add_product_to_recently_viewed($_REQUEST['product_id']);

    // Increase product popularity
    fn_set_product_popularity($_REQUEST['product_id']);

    $product_notification_enabled = (isset(Tygh::$app['session']['product_notifications']) ? (isset(Tygh::$app['session']['product_notifications']['product_ids']) && in_array($_REQUEST['product_id'], Tygh::$app['session']['product_notifications']['product_ids']) ? 'Y' : 'N') : 'N');
    if ($product_notification_enabled) {
        if ((Tygh::$app['session']['auth']['user_id'] == 0) && !empty(Tygh::$app['session']['product_notifications']['email'])) {
            if (!db_get_field("SELECT subscription_id FROM ?:product_subscriptions WHERE product_id = ?i AND email = ?s", $_REQUEST['product_id'], Tygh::$app['session']['product_notifications']['email'])) {
                $product_notification_enabled = 'N';
            }
        } elseif (!db_get_field("SELECT subscription_id FROM ?:product_subscriptions WHERE product_id = ?i AND user_id = ?i", $_REQUEST['product_id'], Tygh::$app['session']['auth']['user_id'])) {
            $product_notification_enabled = 'N';
        }
    }

    Tygh::$app['view']->assign('show_qty', true);
    Tygh::$app['view']->assign('product_notification_enabled', $product_notification_enabled);
    Tygh::$app['view']->assign('product_notification_email', (isset(Tygh::$app['session']['product_notifications']) ? Tygh::$app['session']['product_notifications']['email'] : ''));

    // custom vendor blocks
    if ($vendor_id = fn_get_runtime_vendor_id()) {
        Tygh::$app['view']->assign('company_id', $vendor_id);
        $_REQUEST['company_id'] = $vendor_id;
    }
    
    $params = $_REQUEST;
    $product = Tygh::$app['view']->getTemplateVars('product');
    if (YesNo::toBool(Registry::get('addons.ab__motivation_block.use_additional_categories'))) {
    $params['category_ids'] = $product['category_ids'];
    } else {
    $params['category_ids'] = [$product['main_category']];
    }
    if (fn_allowed_for('MULTIVENDOR') && !empty($product['company_id'])) {
    $params['company_id'] = $product['company_id'];
    } else {
    $params['company_id'] = fn_get_runtime_company_id();
    }
    unset($params['sort_by']);
    list($motivation_items) = fn_ab__mb_get_motivation_items($params);
    Tygh::$app['view']->assign('ab__motivation_items', $motivation_items);


}