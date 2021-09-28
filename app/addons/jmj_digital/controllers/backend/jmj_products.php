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

use Tygh\BlockManager\SchemesManager;
use Tygh\Enum\NotificationSeverity;
use Tygh\Enum\ProductFeatures;
use Tygh\Enum\ProductTracking;
use Tygh\Tools\Url;

use Tygh\Addons\ProductVariations\Form\GenerateVariationsForm;
use Tygh\Addons\ProductVariations\Product\Group\GroupFeatureCollection;
use Tygh\Addons\ProductVariations\Request\GenerateProductsAndAttachToGroupRequest;
use Tygh\Addons\ProductVariations\Request\GenerateProductsAndCreateGroupRequest;
use Tygh\Addons\ProductVariations\ServiceProvider;
use Tygh\Addons\ProductVariations\Product\FeaturePurposes;
use Tygh\Addons\ProductVariations\Product\Type\Type;
use Tygh\Enum\ObjectStatuses;
use Tygh\Registry;
use Illuminate\Support\Collection;


if (!defined('BOOTSTRAP')) { die('Access denied'); }

$_REQUEST['product_id'] = empty($_REQUEST['product_id']) ? 0 : $_REQUEST['product_id'];

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $suffix = '';

    // Define trusted variables that shouldn't be stripped
    fn_trusted_vars (
        'product_data',
        'override_products_data',
        'product_files_descriptions',
        'add_product_files_descriptions',
        'products_data',
        'product_file'
    );

    /**
     * Create/update product
     */
    if ($mode == 'update') {
        $fabric = $_REQUEST['fabric'];
       
        $variant_value_total = 0;
        foreach ($fabric as $featureid => $featurevalue) {
            if(isset($_REQUEST['fabric_error']) && $_REQUEST['fabric_error']){
                unset($_REQUEST['product_data']['product_features'][$featureid]);
            }
           
            $variant_value_total = array_sum($featurevalue);
            if($variant_value_total == 100){
                foreach ($featurevalue as $variantid => $value) {
                    //query to check record exist
                    $id = db_get_field("SELECT id FROM ?:custom_variant_total WHERE product_id = ?i AND featureid=?i AND variantid= ?i", $_REQUEST['product_id'], $featureid, $variantid);
                    if($id){
                        db_query("UPDATE ?:custom_variant_total SET variant_value = ?i WHERE id = ?i", $value, $id);
                    }else{
                        db_query("INSERT INTO ?:custom_variant_total SET product_id = ?i, featureid=?i, variantid= ?i, variant_value=?i", $_REQUEST['product_id'], $featureid, $variantid, $value);
                    }
                }
            }else{
                //restoring old data
                foreach ($_REQUEST['product_old_data']['product_features'] as $key => $value) {
                    $_REQUEST['product_data']['product_features'][$key] = $value;
                }                
            }
        }
        
        $product_id = (isset($_REQUEST['product_id']) && !empty($_REQUEST['product_id'])) ? $_REQUEST['product_id'] : null;
        $next_step = fn_get_next_step($_REQUEST['current_step']);
        
        $is_last_step = ($next_step) ? false : true;
        
        if (!empty($_REQUEST['product_data']['product'])) {
            $product_data = $_REQUEST['product_data'];
            $product_data['status'] = 'X';
           
            if (isset($product_data['category_ids']) && !is_array($product_data['category_ids'])) {
                $product_data['category_ids'] = explode(',', $product_data['category_ids']);
            }

            if (!empty($product_data['linked_option_ids'])) {
                foreach ($product_data['linked_option_ids'] as $linked_option_id) {
                    fn_add_global_option_link($_REQUEST['product_id'], $linked_option_id);
                }

            }
            if($_REQUEST['current_step'] == 1 && $_REQUEST['product_id']){
                $product_data['product_features'] = $product_data['feature_data'];
            }
            
            if($_REQUEST['product_id'] && $_REQUEST['current_step'] == 5){
        
                //Create product features for product variants creation
                list($product_features, $features_search) = fn_get_paginated_product_features(
                    array('product_id' => $product_id),
                    $auth, $product_data,
                    DESCR_SL
                );

                //Create product variants creation
                $generation_form = GenerateVariationsForm::create($_REQUEST['product_id'], $_REQUEST);
             
                $group_repository = ServiceProvider::getGroupRepository();
                $service = ServiceProvider::getService();

                $group_id = $group_repository->findGroupIdByProductId($_REQUEST['product_id']);
               
                if ($group_id) {
                    $request = new GenerateProductsAndAttachToGroupRequest(
                        $group_id,
                        $_REQUEST['product_id'],
                        $generation_form->getCombinationsData()
                    );
                    $request->setFeaturesVariantsMap($generation_form->getFeaturesVariantsMap());
                    $result = $service->generateProductsAndAttachToGroup($request);
                } else {
                    $request = new GenerateProductsAndCreateGroupRequest(
                        $_REQUEST['product_id'],
                        $generation_form->getCombinationsData(),
                        $generation_form->getFeatureCollection()
                    );
                    $request->setFeaturesVariantsMap($generation_form->getFeaturesVariantsMap());
                    $result = $service->generateProductsAndCreateGroup($request);
                }
            
            }
            
            
         
            $product_id = fn_update_product($product_data, $_REQUEST['product_id'], DESCR_SL);

            if($_REQUEST['current_step'] == 1){
                $product_data['product_features'] = $product_data['feature_data'];
                fn_update_product($product_data, $product_id, DESCR_SL);
            }
          
        

            if ($product_id === false) {
                // Some error occurred
                fn_save_post_data('product_data');
                return array(CONTROLLER_STATUS_REDIRECT, 'jmj_products.add');
            }
        }
        
        // Update main image
        fn_attach_image_pairs('product_main', 'product', $product_id);

        // Update additional images
        fn_attach_image_pairs('product_additional', 'product', $product_id);
        
        

        Tygh::$app['view']->assign('product_id', $product_id);
        //echo "<pre>";print_r($next_step);die;
          //multi-colors feature functionality
        foreach($_REQUEST['product_data']['product_features_new'] as $feature_key => $feature_value){
            $multi_colors_filter = db_get_field("SELECT multi_colors_filter FROM ?:product_features WHERE feature_id = ?i", $feature_key);
            
            if($multi_colors_filter){
                db_query("DELETE FROM ?:product_features_values WHERE feature_id = ?i AND product_id = ?i",$feature_key, $product_id);
                foreach ($_REQUEST['product_data']['product_features_new'][$feature_key] as $color) {
                    db_query("INSERT INTO ?:product_features_values SET feature_id = ?i, product_id = ?i, variant_id = ?i, lang_code = ?s", $feature_key, $product_id , $color, CART_LANGUAGE);
                }
            }  
        }
        //die;
        if (!empty($product_id) && !$is_last_step) {
            $suffix = ".add?step=$next_step&product_id=$product_id";
            return array(CONTROLLER_STATUS_REDIRECT, 'jmj_products' . $suffix);
        } else if($is_last_step) {
            $suffix = ".manage";
            return array(CONTROLLER_STATUS_REDIRECT, 'jmj_products' . $suffix);
        }

    }

    //
    // Processing multiple updating of product elements
    //
    if ($mode == 'm_update') {
        // Update multiple products data
        if (!empty($_REQUEST['products_data'])) {

            if (fn_allowed_for('MULTIVENDOR') && !fn_company_products_check(array_keys($_REQUEST['products_data']))) {
                return array(CONTROLLER_STATUS_DENIED);
            }

            // Update images
            fn_attach_image_pairs('product_main', 'product', 0, DESCR_SL);

            foreach ($_REQUEST['products_data'] as $product_id => $product) {
                if (!empty($product['product'])) { // Checking for required fields for new product

                    if (fn_allowed_for('ULTIMATE,MULTIVENDOR') && Registry::get('runtime.company_id')) {
                        unset($product['company_id']);
                    }

                    if (!empty($product['category_ids']) && !is_array($product['category_ids'])) {
                        $product['category_ids'] = explode(',', $product['category_ids']);
                    }

                    fn_update_product($product, $product_id, DESCR_SL);

                    // Updating products position in category
                    if (isset($product['position']) && !empty($_REQUEST['category_id'])) {
                        fn_update_product_position_in_category($product_id, $_REQUEST['category_id'], $product['position']);
                    }
                }
            }
        }
        $suffix = ".manage";
        return array(CONTROLLER_STATUS_REDIRECT, 'jmj_products' . $suffix);
        
    }

    //
    // Delete product
    //
    if ($mode == 'delete') {
        
        if (!empty($_REQUEST['product_id'])) {
            $redirect_url = (isset($_REQUEST['redirect_url']) && !empty($_REQUEST['redirect_url'])) ? $_REQUEST['redirect_url'] : '.manage';
            $result = fn_delete_product($_REQUEST['product_id']);
            if ($result) {
                fn_set_notification('N', __('notice'), __('text_product_has_been_deleted'));
                return array(CONTROLLER_STATUS_REDIRECT, 'jmj_products' . $redirect_url);
            } else {
                return array(CONTROLLER_STATUS_REDIRECT, 'jmj_products' . $redirect_url);
            }
        }else{
            return array(CONTROLLER_STATUS_REDIRECT, 'jmj_products.manage');
        }
    }

    //
    // Storing selected fields for using in m_update mode
    //
    if ($mode == 'store_selection') {

        if (!empty($_REQUEST['product_ids'])) {
            Tygh::$app['session']['product_ids'] = $_REQUEST['product_ids'];
            Tygh::$app['session']['selected_fields'] = $_REQUEST['selected_fields'];

            unset($_REQUEST['redirect_url']);

            $suffix = ".m_update";
        } else {
            fn_set_notification('W', __('warning'), __('bulk_edit.some_products_were_omitted_other_storefront'));
            $suffix = ".manage";
        }
    }

    //
    // Processing global updating of product elements
    //

    if ($mode == 'global_update') {

        fn_global_update_products($_REQUEST['update_data']);

        $suffix = '.global_update';

    }

    if ($mode == 'steps_update') {
        if(isset($_REQUEST['step_data']) && !empty($_REQUEST['step_data'])){
            foreach($_REQUEST['step_data'] as $key => $step_data){
                if($step_data['step_number'] == 1){
                    $status = 'Y';
                }else{
                   $status = isset($step_data['status']) ? $step_data['status'] : 'N';
                }
                $data = array(
                    'status' => $status,
                    'step_name' => $step_data['step_name']
                );

                db_query("UPDATE ?:product_create_steps SET ?u WHERE id = ?i", $data, $key);
            }
        }

        return [CONTROLLER_STATUS_OK, 'jmj_products.step_manage'];
    }    

    return [CONTROLLER_STATUS_OK, 'jmj_products' . $suffix];
    //update steps 
    
    
}
//
// 'Add new product' page
//
if ($mode == 'add') {
    
    $current_step = (empty($_REQUEST['step']) ? 1 : $_REQUEST['step']);
    $previous_step = fn_get_previous_step($current_step);
    $next_step = fn_get_next_step($current_step);
    $is_last_step = ($next_step) ? false : true;
    
    $product_id = (empty($_REQUEST['product_id']) ? 0 : $_REQUEST['product_id']);
    Tygh::$app['view']->assign('taxes', fn_get_taxes());
    

    if(Registry::get('runtime.company_id')){
        $company_id = Registry::get('runtime.company_id');
    }else{
        $company_id = 0;
    }

    Tygh::$app['view']->assign('companies_brands', fn_get_brand_for_companies($company_id,CART_LANGUAGE));

    // [Page sections]
    
    if($product_id){
        $product_data = fn_get_product_data($product_id, $auth, CART_LANGUAGE, '', true, true, false, true, false, true, true);
        
        $sharing_company_id = Registry::get('runtime.company_id')
        ? Registry::get('runtime.company_id')
        : $product_data['company_id'];
        // Preview URL only exists for companies that have this product shared
        // if (fn_allowed_for('ULTIMATE') && !in_array($sharing_company_id, $product_data['shared_between_companies'])) {
        //     $preview_url = null;
        // } elseif (fn_allowed_for('MULTIVENDOR')) {
        //     /** @var \Tygh\Storefront\Repository $storefront_repository */
        //     $storefront_repository = Tygh::$app['storefront.repository'];
        //     $storefront = $storefront_repository->findByCompanyId($product_data['company_id']);
        //     $storefront = empty($storefront) ? $storefront_repository->findDefault() : $storefront;

        //     $preview_url = fn_get_preview_url(
        //         "products.view?product_id={$product_id}&storefront_id={$storefront->storefront_id}",
        //         $product_data,
        //         $auth['user_id']
        //     );
        // } else {
        //     $preview_url = fn_get_preview_url(
        //         "products.view?product_id={$product_id}",
        //         $product_data,
        //         $auth['user_id']
        //     );
        // }
        
        $host = Registry::get('config.https_location');
        $preview_url = "$host/index.php?dispatch=products.preview&product_id={$_REQUEST['product_id']}";
        
        Tygh::$app['view']->assign('view_uri', $preview_url);
        
    }else{
        $product_data = (array) fn_restore_post_data('product_data');

        if (isset($_REQUEST['product_data']['company_id']) && !Registry::get('runtime.company_id')) {
            $product_data['company_id'] = $_REQUEST['product_data']['company_id'];
        }

        if (isset($_REQUEST['category_id'])) {
            $product_data['category_ids'] = (array) $_REQUEST['category_id'];
        }

        if (empty($product_data['main_category'])
            && !empty($product_data['category_ids'])
            && is_array($product_data['category_ids'])
        ) {
            $product_data['main_category'] = reset($product_data['category_ids']);
        }
    }
    
    Tygh::$app['view']->assign('product_data', $product_data);
    //Category Steps
    $params['max_nesting_level'] = 1;
    list($main_categories, ) = fn_get_categories($params);
    Tygh::$app['view']->assign('main_categories', $main_categories);
    if(!empty($product_data['main_category'])){
        $sub_sub_category_id = $product_data['main_category'];
        $sub_category_id = db_get_field("SELECT parent_id FROM ?:categories WHERE category_id = ?i", $sub_sub_category_id);
        $main_category_id = db_get_field("SELECT parent_id FROM ?:categories WHERE category_id = ?i", $sub_category_id);

        $sub_categories = fn_get_subcategories($main_category_id);
        $sub_sub_categories = fn_get_subcategories($sub_category_id);
        
        Tygh::$app['view']->assign('sub_sub_categories', $sub_sub_categories);
        Tygh::$app['view']->assign('sub_categories', $sub_categories);
        Tygh::$app['view']->assign('main_category_id', $main_category_id);
        Tygh::$app['view']->assign('sub_category_id', $sub_category_id);
        Tygh::$app['view']->assign('sub_sub_category_id', $sub_sub_category_id);
    }

    if($current_step == 1){

        Registry::set('navigation.tabs', array (
            'detailed' => array (
                'title' => fn_get_step_name($current_step),
                'js' => true
            )
        ));
    }else if($current_step == 2){
        
        // get guideline image
        $sub_category_id = db_get_field("SELECT parent_id FROM ?:categories WHERE category_id = ?i", $product_data['main_category']);
        $cat_guideline_image = fn_get_image_pairs($sub_category_id, 'cat_guideline_image', 'M', true, true, $lang_code);
        if(isset($cat_guideline_image['icon']['image_path'])){
            Tygh::$app['view']->assign('cat_guideline_image', $cat_guideline_image['icon']['image_path']);
        }
       
        $categoryData = db_get_row("SELECT product_image_count, product_image_type FROM ?:categories WHERE category_id = ?i", $product_data['main_category']);
        
        //$ProductImagesCount = $categoryData['product_image_count'];
        $ProductImagesType = $categoryData['product_image_type'];
        if($ProductImagesType && !is_array($ProductImagesType)){
            $ProductImagesType = explode(',', $categoryData['product_image_type']);
            $ProductImagesCount = count($ProductImagesType);
        }
        
        Tygh::$app['view']->assign('ProductImagesCount', $ProductImagesCount);
        Tygh::$app['view']->assign('ProductImagesType', $ProductImagesType);

        Registry::set('navigation.tabs', array (
            'upload_images' => array (
                'title' => fn_get_step_name($current_step),
                'js' => true
            )
        ));
    }else if($current_step == 3){
        Registry::set('navigation.tabs', array (
            'qty_discounts' => array (
                'title' => fn_get_step_name($current_step),
                'js' => true
            )
        ));
    
    }else if($current_step == 4){
        
        Registry::set('navigation.tabs', array (
            'features' => array (
                'title' => fn_get_step_name($current_step),
                'js' => true
            )
        ));

        list($product_features, $features_search) = fn_get_paginated_product_features(
            array('product_id' => $product_data['product_id']),
            $auth, $product_data,
            DESCR_SL
        );
        
        Tygh::$app['view']->assign('product_features', $product_features);
    
    }else if($current_step == 5){
        
        
        $generation_form = GenerateVariationsForm::create($_REQUEST['product_id'], $_REQUEST);
       
        if (!$product_data) {
            return [CONTROLLER_STATUS_NO_PAGE];
        }
    
        $product_type = Type::createByProduct($product_data);
        
        /** @var \Tygh\SmartyEngine\Core $view */
        $view = Tygh::$app['view'];
        $view->assign([
            'product_data'                 => $product_data,
            'feature_value_collection'     => $generation_form->getFeatureValueCollection(),
            'group'                        => $generation_form->getGroup(),
            'combinations'                 => $generation_form->getCombinations(),
            'selected_features'            => $generation_form->getFeatures(),
            'new_combinations_count'       => $generation_form->getNewCombinationsCount(),
            'feature_ids'                  => array_keys($generation_form->getFeatures()),
            'features_variant_ids'         => $generation_form->getFeaturesVariantsMap(),
            'exists_features_variant_ids'  => $generation_form->getExistsFeaturesVariantsMap(),
            'is_allow_generate_variations' => $product_type->isAllowGenerateVariations(),
            'is_all_combinations_active'   => $generation_form->isAllCombinationsActive(),
        ]);
    
        Registry::set('navigation.tabs', array (
            'create_options' => array (
                'title' => fn_get_step_name($current_step),
                'js' => true
            )
        ));

    }else if($current_step == 6){
        Registry::set('navigation.tabs', array (
            'step_6' => array (
                'title' => fn_get_step_name($current_step),
                'js' => true
            )
        ));
    }else if($current_step == 7){
        $is_restricted = false;
        $show_notice = false;
    
        fn_set_hook('buy_together_restricted_product', $_REQUEST['product_id'], $auth, $is_restricted, $show_notice);
    
        if (!$is_restricted) {
            Registry::set('navigation.tabs.buy_together', array (
                'title' => fn_get_step_name($current_step),
                'js' => true
            ));
    
            $params = array(
                'product_id' => $_REQUEST['product_id'],
            );
    
            $chains = fn_buy_together_get_chains($params, array(), DESCR_SL);
    
            Tygh::$app['view']->assign('chains', $chains);
        }
    }else if($current_step == 8){
        Registry::set('navigation.tabs', array (
            'shippings' => array (
                'title' => fn_get_step_name($current_step),
                'js' => true
            )
        ));
    }else if($current_step == 9){
        Registry::set('navigation.tabs', array (
            'jmj_addons' => array (
                'title' => fn_get_step_name($current_step),
                'js' => true
            )
        ));
    }else if($current_step == 10){

        Registry::set('navigation.tabs', array (
            'reward_points' => array (
                'title' => fn_get_step_name($current_step),
                'js' => true
            )
        ));

        Tygh::$app['view']->assign(
            'reward_usergroups',
            fn_get_usergroups(
                array(
                    'type'            => 'C',
                    'status'          => array('A', 'H'),
                    'include_default' => true
                )
            )
        );
    }else if($current_step == 11){

        $redirect_url = "jmj_products.add?step=4&product_id=$product_id";
        Tygh::$app['view']->assign('redirect_url', $redirect_url);
        
        $group_repository = ServiceProvider::getGroupRepository();
        $product_repository = ServiceProvider::getProductRepository();

        $group = $group_repository->findGroupByProductId($product_id);

        if ($group) {
            $parent_to_child_map = [];

            foreach ($group->getProducts() as $group_product) {
                if (!$group_product->getParentProductId()) {
                    continue;
                }

                $parent_to_child_map[$group_product->getParentProductId()] = $group_product->getProductId();
            }

            $params = array_merge($_REQUEST, [
                'sort_by' => 'null',
                'pid'     => $group->getProductIds(),
            ]);

            // FIXME its need to master products
            if (fn_allowed_for('MULTIVENDOR')) {
                $runtime_company_id = Registry::get('runtime.company_id');
                Registry::set('runtime.company_id', 0);
            }

            list($products, $search) = fn_get_products($params);
           
            fn_gather_additional_products_data($products, [
                'get_icon'            => true,
                'get_detailed'        => true,
                'get_options'         => false,
                'get_discounts'       => false,
                'get_features'        => false,
                'get_product_type'    => true
            ]);
            
            // FIXME its need to master products
            if (fn_allowed_for('MULTIVENDOR')) {
                Registry::set('runtime.company_id', $runtime_company_id);
            }

            $selected_features = $product_repository->findFeaturesByFeatureCollection($group->getFeatures());
            $selected_features = $product_repository->loadFeaturesVariants($selected_features);

            foreach ($products as &$product) {
                $product['has_children'] = isset($parent_to_child_map[$product['product_id']]);
            }
            unset($product);

            $products = $product_repository->loadProductsFeatures($products, $group->getFeatures());

            $products = Collection::make($products)->sortBy(function ($item) {
                $key_1 = [];
                $key_2 = [];

                foreach ($item['variation_features'] as $feature) {
                    if (FeaturePurposes::isCreateCatalogItem($feature['purpose'])) {
                        $key_1[] = $feature['variant_position'];
                        $key_1[] = $feature['variant_id'];
                    } else {
                        $key_2[] = $feature['variant_position'];
                        $key_2[] = $feature['variant_id'];
                    }
                }

                if ($item['parent_product_id']) {
                    $key_1[] = 1;
                } else {
                    $key_1[] = 0;
                }

                $key_2[] = $item['product_id'];

                return implode('_', array_merge($key_1, $key_2));
            })->all();

            Tygh::$app['view']->assign([
                'product_id'        => $product_id,
                'product'           => $product_data,
                'group'             => $group,
                'products'          => $products,
                'search'            => $search,
                'selected_features' => $selected_features
            ]);
        } else {
            $features = $product_repository->findAvailableFeatures($product_id);
            $group_codes = $group_repository->findGroupCodesByFeatureIds(array_keys($features));

            Tygh::$app['view']->assign([
                'product_id'  => $product_id,
                'product'     => $product_data,
                'features'    => $features,
                'group_codes' => $group_codes
            ]);
        }

        Registry::set('navigation.tabs', array (
            'all_variants' => array (
                'title' => fn_get_step_name($current_step),
                'js' => true
            )
        ));
    }
    
    if (fn_allowed_for('MULTIVENDOR') && Registry::get('runtime.company_id')) {
        Tygh::$app['view']->assign('disable_edit_popularity', true);
    } else {
        Tygh::$app['view']->assign('disable_edit_popularity', false);
    }

    Tygh::$app['view']->assign('previous_step', $previous_step);
    Tygh::$app['view']->assign('current_step', $current_step);
    Tygh::$app['view']->assign('next_step', $next_step);
    Tygh::$app['view']->assign('product_id', $product_id);
    Tygh::$app['view']->assign('secount_last_step', $secount_last_step);
    Tygh::$app['view']->assign('is_last_step', $is_last_step);
    
    
//
// 'product update' page
//
}else if ($mode == 'update') {    
    $step = (empty($_REQUEST['selected_section']) ? 'detailed' : $_REQUEST['selected_section']);
    
    // Get current product data
    $skip_company_condition = !fn_is_product_company_condition_required($_REQUEST['product_id']);

    $product_data = fn_get_product_data($_REQUEST['product_id'], $auth, DESCR_SL, '', true, true, true, true, false, false, $skip_company_condition);

    if (!empty($_REQUEST['deleted_subscription_id'])) {
        if (!Registry::get('runtime.company_id') || Registry::get('runtime.company_id') && $product_data['company_id'] == Registry::get('runtime.company_id')) {
            db_query("DELETE FROM ?:product_subscriptions WHERE subscription_id = ?i", $_REQUEST['deleted_subscription_id']);
        }
    }
    
    if (empty($product_data)) {
        return array(CONTROLLER_STATUS_NO_PAGE);
    }
    
    list($product_features, $features_search) = fn_get_paginated_product_features(
        array('product_id' => $product_data['product_id']),
        $auth, $product_data,
        DESCR_SL
    );

    $taxes = fn_get_taxes();

    Tygh::$app['view']->assign([
        'product_features' => $product_features,
        'features_search'  => $features_search,
        'product_data'     => $product_data,
        'taxes'            => $taxes,
    ]);

    $product_options = fn_get_product_options($_REQUEST['product_id'], DESCR_SL);

    if (!empty($product_options)) {
        $has_inventory = false;
        foreach ($product_options as $p) {
            if ($p['inventory'] == 'Y') {
                $has_inventory = true;
                break;
            }
        }
        Tygh::$app['view']->assign('has_inventory', $has_inventory);
    }

    list($global_options) = fn_get_product_global_options();
    Tygh::$app['view']->assign([
        'product_options' => $product_options,
        'global_options'  => $global_options,
    ]);

    // If the product is electronnicaly distributed, get the assigned files
    list($product_files) = fn_get_product_files(array('product_id' => $_REQUEST['product_id']));
    list($product_file_folders) = fn_get_product_file_folders( array('product_id' => $_REQUEST['product_id']) );
    $files_tree = fn_build_files_tree($product_file_folders, $product_files);

    $sharing_company_id = Registry::get('runtime.company_id')
        ? Registry::get('runtime.company_id')
        : $product_data['company_id'];

    // Preview URL only exists for companies that have this product shared
    if (fn_allowed_for('ULTIMATE') && !in_array($sharing_company_id, $product_data['shared_between_companies'])
    ) {
        $preview_url = null;
    } else {
        if (fn_allowed_for('MULTIVENDOR')) {
            /** @var \Tygh\Storefront\Repository $storefront_repository */
            $storefront_repository = Tygh::$app['storefront.repository'];
            $storefront = $storefront_repository->findByCompanyId($product_data['company_id']);
            $storefront = empty($storefront) ? $storefront_repository->findDefault() : $storefront;

            $preview_url = fn_get_preview_url(
                "products.view?product_id={$_REQUEST['product_id']}&storefront_id={$storefront->storefront_id}",
                $product_data,
                $auth['user_id']
            );
        } else {
            $preview_url = fn_get_preview_url(
                "products.view?product_id={$_REQUEST['product_id']}",
                $product_data,
                $auth['user_id']
            );
        }
    }

    if (fn_allowed_for('MULTIVENDOR') && Registry::get('runtime.company_id')) {
        Tygh::$app['view']->assign('disable_edit_popularity', true);
    } else {
        Tygh::$app['view']->assign('disable_edit_popularity', false);
    }

    Tygh::$app['view']->assign('view_uri', $preview_url);

    Tygh::$app['view']->assign('product_file_folders', $product_file_folders);
    Tygh::$app['view']->assign('product_files', $product_files);
    Tygh::$app['view']->assign('files_tree', $files_tree);

    Tygh::$app['view']->assign('expand_all', true);

    list($subscribers, $search) = fn_get_product_subscribers($_REQUEST, Registry::get('settings.Appearance.admin_elements_per_page'));
    Tygh::$app['view']->assign('product_subscribers', $subscribers);
    Tygh::$app['view']->assign('product_subscribers_search', $search);

    // [Page sections]
    $tabs = array (
        'detailed' => array (
            'title' => __('general'),
            'js' => true
        )
    );
    // If we have some additional product fields, lets add a tab for them
    if (!empty($product_features)) {
        $tabs['features'] = array(
            'title' => __('features'),
            'js' => true
        );
    }
    Registry::set('navigation.tabs', $tabs);
    // [/Page sections]

//
// 'Mulitple products updating' page
//
}
//
// 'Management' page
//
if ($mode == 'manage' || $mode == 'p_subscr') {
    unset(Tygh::$app['session']['product_ids']);
    unset(Tygh::$app['session']['selected_fields']);

    $params = $_REQUEST;
    $params['only_short_fields'] = true;
    $params['apply_disabled_filters'] = true;
    $params['extend'][] = 'companies';

    if (fn_allowed_for('ULTIMATE')) {
        $params['extend'][] = 'sharing';
    }

    if ($mode == 'p_subscr') {
        $params['get_subscribers'] = true;
    }

    list($products, $search) = fn_get_products($params, Registry::get('settings.Appearance.admin_elements_per_page'), DESCR_SL);
    fn_gather_additional_products_data($products, array('get_icon' => true, 'get_detailed' => true, 'get_options' => false, 'get_discounts' => false));

    $page = $search['page'];
    $valid_page = db_get_valid_page($page, $search['items_per_page'], $search['total_items']);

    if ($page > $valid_page) {
        $_REQUEST['page'] = $valid_page;

        return array(CONTROLLER_STATUS_REDIRECT, Registry::get('config.current_url'));
    }

    Tygh::$app['view']->assign('products', $products);
    Tygh::$app['view']->assign('search', $search);

    if (!empty($_REQUEST['redirect_if_one']) && $search['total_items'] == 1) {
        return array(CONTROLLER_STATUS_REDIRECT, 'products.update?product_id=' . $products[0]['product_id']);
    }

    $selected_fields = fn_get_product_fields();

    Tygh::$app['view']->assign('selected_fields', $selected_fields);
    if (!fn_allowed_for('ULTIMATE:FREE')) {
        $filter_params = array(
            'get_product_features' => true,
            'short' => true,
            'feature_type' => str_split(ProductFeatures::getAllTypes())
        );

        if (!empty($_REQUEST['filter_variants'])) {
            $filter_params['variants_only'] = $_REQUEST['filter_variants'];
        }

        list($filters) = fn_get_product_filters($filter_params);
        Tygh::$app['view']->assign('filter_items', $filters);
        unset($filters);
    }

    $feature_params = array(
        'plain' => true,
        'statuses' => array('A', 'H'),
        'variants' => true,
        'exclude_group' => true,
        'exclude_filters' => true
    );

    // Preload variants selected at search form. They will be shown at AJAX variants loader as pre-selected.
    if (!empty($_REQUEST['feature_variants'])) {
        $feature_params['variants_only'] = $_REQUEST['feature_variants'];
    }

    list($features, $features_search) = fn_get_product_features($feature_params, PRODUCT_FEATURES_THRESHOLD);

    if ($features_search['total_items'] <= PRODUCT_FEATURES_THRESHOLD) {
        Tygh::$app['view']->assign('feature_items', $features);
    } else {
        Tygh::$app['view']->assign('feature_items_too_many', true);
    }

}elseif ($mode === 'export_found') {
    if (empty(Tygh::$app['session']['export_ranges'])) {
        Tygh::$app['session']['export_ranges'] = [];
    }

    if (empty(Tygh::$app['session']['export_ranges']['products']['pattern_id'])) {
        Tygh::$app['session']['export_ranges']['products'] = ['pattern_id' => 'products'];
    }

    Tygh::$app['session']['export_ranges']['products']['data_provider'] = [
        'count_function' => 'fn_exim_get_last_view_products_count',
        'function'       => 'fn_exim_get_last_view_product_ids_condition',
    ];

    unset($_REQUEST['redirect_url'], Tygh::$app['session']['export_ranges']['products']['data']);

    return [
        CONTROLLER_STATUS_OK,
        'exim.export?section=products&pattern_id=' . Tygh::$app['session']['export_ranges']['products']['pattern_id'],
    ];
}elseif ($mode == 'm_update') {

    if (empty(Tygh::$app['session']['product_ids']) || empty(Tygh::$app['session']['selected_fields']) || empty(Tygh::$app['session']['selected_fields']['object']) || Tygh::$app['session']['selected_fields']['object'] != 'product') {
        return array(CONTROLLER_STATUS_REDIRECT, 'jmj_products.manage');
    }

    $product_ids = Tygh::$app['session']['product_ids'];

    if (fn_allowed_for('MULTIVENDOR') && !fn_company_products_check($product_ids)) {
        return array(CONTROLLER_STATUS_DENIED);
    }

    $selected_fields = Tygh::$app['session']['selected_fields'];

    $field_groups = array (
        'A' => array ( // inputs
            'product' => 'products_data',
            'product_code' => 'products_data',
            'page_title' => 'products_data',
        ),

        'B' => array ( // short inputs
            'price' => 'products_data',
            'list_price' => 'products_data',
            'amount' => 'products_data',
            'min_qty' => 'products_data',
            'max_qty' => 'products_data',
            'weight' => 'products_data',
            'shipping_freight' => 'products_data',
            'box_height' => 'products_data',
            'box_length' => 'products_data',
            'box_width' => 'products_data',
            'min_items_in_box' => 'products_data',
            'max_items_in_box' => 'products_data',
            'qty_step' => 'products_data',
            'list_qty_count' => 'products_data',
            'popularity' => 'products_data'
        ),

        'C' => array ( // checkboxes
            'free_shipping' => 'products_data',
        ),

        'D' => array ( // textareas
            'short_description' => 'products_data',
            'full_description' => 'products_data',
            'meta_keywords' => 'products_data',
            'meta_description' => 'products_data',
            'search_words' => 'products_data',
            'promo_text' => 'products_data',
        ),
        'T' => array( // dates
            'timestamp' => 'products_data',
            'avail_since' => 'products_data',
        ),
        'S' => array ( // selectboxes
            'out_of_stock_actions' => array (
                'name' => 'products_data',
                'variants' => array (
                    'N' => 'none',
                    'B' => 'buy_in_advance',
                    'S' => 'sign_up_for_notification'
                ),
            ),
            'status' => array (
                'name' => 'products_data',
                'variants' => array (
                    'A' => 'active',
                    'D' => 'disabled',
                    'H' => 'hidden'
                ),
            ),
            'tracking' => array (
                'name' => 'products_data',
                'variants' => array (
                    ProductTracking::TRACK_WITH_OPTIONS => 'track_with_options',
                    ProductTracking::TRACK_WITHOUT_OPTIONS => 'track_without_options',
                    ProductTracking::DO_NOT_TRACK => 'dont_track'
                ),
            ),
            'zero_price_action' => array (
                'name' => 'products_data',
                'variants' => array (
                    'R' => 'zpa_refuse',
                    'P' => 'zpa_permit',
                    'A' => 'zpa_ask_price'
                ),
            ),
        ),
        'E' => array ( // categories
            'categories' => 'products_data'
        ),
        'W' => array( // Product details layout
            'details_layout' => 'products_data'
        )
    );

    if (Registry::get('settings.General.enable_edp') == 'Y') {
        $field_groups['C']['is_edp'] = 'products_data';
        $field_groups['C']['edp_shipping'] = 'products_data';
    }

    if (!fn_allowed_for('ULTIMATE:FREE')) {
        $field_groups['L'] = array( // miltiple selectbox (localization)
            'localization' => array(
                'name' => 'localization'
            ),
        );
    }

    $data = array_keys($selected_fields['data']);
    $get_taxes = false;
    $get_features = false;

    $fields2update = $data;

    if (!empty($selected_fields['data']['features']) && $selected_fields['data']['features'] == 'Y') {
        $fields2update[] = 'features';
        $get_features = true;

        list($all_product_features, $all_features_search) = fn_get_paginated_product_features(array('over' => true), $auth, array(), DESCR_SL);

        Tygh::$app['view']->assign(array(
            'all_product_features' => $all_product_features,
            'all_features_search' => $all_features_search,
        ));
    }

    // Process fields that are not in products or product_descriptions tables
    if (!empty($selected_fields['categories']) && $selected_fields['categories'] == 'Y') {
        $fields2update[] = 'categories';
    }
    if (!empty($selected_fields['main_pair']) && $selected_fields['main_pair'] == 'Y') {
        $fields2update[] = 'main_pair';
    }
    if (!empty($selected_fields['data']['taxes']) && $selected_fields['data']['taxes'] == 'Y') {
        Tygh::$app['view']->assign('taxes', fn_get_taxes());
        $fields2update[] = 'taxes';
        $get_taxes = true;
    }

    $product_features = array();
    $features_search = array();
    foreach ($product_ids as $value) {
        $products_data[$value] = fn_get_product_data($value, $auth, DESCR_SL, '?:products.*, ?:product_descriptions.*', false, true, $get_taxes, false, false, false, true);
        $products_data[$value]['price'] = fn_format_price($products_data[$value]['price'], CART_PRIMARY_CURRENCY, 2, false);
        $products_data[$value]['base_price'] = $products_data[$value]['price'];
        if ($get_features) {
            list($product_features[$value], $features_search[$value]) = fn_get_paginated_product_features(array('product_id' => $value), $auth, $products_data[$value], DESCR_SL);
        }
    }

    Tygh::$app['view']->assign(array(
        'product_features' => $product_features,
        'features_search' => $features_search,
    ));

    $filled_groups = array();
    $field_names = array();

    foreach ($fields2update as $k => $field) {
        if ($field == 'main_pair') {
            $desc = 'image_pair';
        } elseif ($field == 'tracking') {
            $desc = 'inventory';
        } elseif ($field == 'edp_shipping') {
            $desc = 'downloadable_shipping';
        } elseif ($field == 'is_edp') {
            $desc = 'downloadable';
        } elseif ($field == 'timestamp') {
            $desc = 'creation_date';
        } elseif ($field == 'categories') {
            $desc = 'categories';
        } elseif ($field == 'status') {
            $desc = 'status';
        } elseif ($field == 'avail_since') {
            $desc = 'available_since';
        } elseif ($field == 'min_qty') {
            $desc = 'min_order_qty';
        } elseif ($field == 'max_qty') {
            $desc = 'max_order_qty';
        } elseif ($field == 'qty_step') {
            $desc = 'quantity_step';
        } elseif ($field == 'list_qty_count') {
            $desc = 'list_quantity_count';
        } elseif ($field == 'usergroup_ids') {
            $desc = 'usergroups';
        } elseif ($field == 'details_layout') {
            $desc = 'product_details_view';
        } elseif ($field == 'max_items_in_box') {
            $desc = 'maximum_items_in_box';
        } elseif ($field == 'min_items_in_box') {
            $desc = 'minimum_items_in_box';
        } elseif ($field == 'amount') {
            $desc = 'quantity';
        } else {
            $desc = $field;
        }

        if (!empty($field_groups['A'][$field])) {
            $filled_groups['A'][$field] = __($desc);
            continue;
        } elseif (!empty($field_groups['B'][$field])) {
            $filled_groups['B'][$field] = __($desc);
            continue;
        } elseif (!empty($field_groups['C'][$field])) {
            $filled_groups['C'][$field] = __($desc);
            continue;
        } elseif (!empty($field_groups['D'][$field])) {
            $filled_groups['D'][$field] = __($desc);
            continue;
        } elseif (!empty($field_groups['S'][$field])) {
            $filled_groups['S'][$field] = __($desc);
            continue;
        } elseif (!empty($field_groups['T'][$field])) {
            $filled_groups['T'][$field] = __($desc);
            continue;
        } elseif (!empty($field_groups['E'][$field])) {
            $filled_groups['E'][$field] = __($desc);
            continue;
        } elseif (!empty($field_groups['L'][$field])) {
            $filled_groups['L'][$field] = __($desc);
            continue;
        } elseif (!empty($field_groups['W'][$field])) {
            $filled_groups['W'][$field] = __($desc);
            continue;
        }

        $field_names[$field] = __($desc);
    }

    ksort($filled_groups, SORT_STRING);

    Tygh::$app['view']->assign(array(
        'field_names'   => $field_names,
        'field_groups'  => $field_groups,
        'filled_groups' => $filled_groups,
        'products_data' => $products_data,
    ));

}elseif ($mode == 'change_image'){
    $product_id = (isset($_REQUEST['product_id']) && !empty($_REQUEST['product_id'])) ? $_REQUEST['product_id'] : 0;

    $product_data = fn_get_product_data($product_id, $auth, CART_LANGUAGE, '', true, true, false, false, false, false, true);
    if (!$product_data) {
        return [CONTROLLER_STATUS_NO_PAGE];
    }
    $categoryData = db_get_row("SELECT product_image_count, product_image_type FROM ?:categories WHERE category_id = ?i", $product_data['main_category']);
        
    $ProductImagesCount = $categoryData['product_image_count'];
    $ProductImagesType = $categoryData['product_image_type'];
    if($ProductImagesType && !is_array($ProductImagesType)){
        $ProductImagesType = explode(',', $categoryData['product_image_type']);
    }
    
    Tygh::$app['view']->assign('ProductImagesCount', $ProductImagesCount);
    Tygh::$app['view']->assign('ProductImagesType', $ProductImagesType);
    Tygh::$app['view']->assign('product_data', $product_data);

}elseif ($mode == 'step_manage'){
    
    $steps = db_get_array("SELECT * FROM ?:product_create_steps");
    Tygh::$app['view']->assign('steps', $steps);
   
}

if ($mode == 'getfeature_variantImage') {
    $variant_id = $_REQUEST['variant_id'];
    $imageUrl = fn_get_image_pairs($variant_id, 'feature_variant', 'V', true, true, $lang_code);
    if($imageUrl){
        echo json_encode($imageUrl['icon']['image_path']);
    }
   
    exit;
}
if ($mode == 'get_sub_categories') {
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



