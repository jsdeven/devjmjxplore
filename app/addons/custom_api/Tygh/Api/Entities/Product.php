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

namespace Tygh\Api\Entities;

use Tygh\Enum\ProductFeatures;
use Tygh\Api\AEntity;
use Tygh\Api\Response;
use Tygh\Registry;
use Tygh\Addons\ProductVariations\Product\Type\Type;
use Tygh\Addons\ProductVariations\ServiceProvider;
use Tygh\Addons\ProductVariations\Product\FeaturePurposes;
use Tygh\Addons\ProductVariations\Product\Group\GroupFeature;
use Tygh\Addons\ProductVariations\Product\Group\GroupFeatureCollection;
use Illuminate\Support\Collection;

class Product extends AEntity
{
    public function index($id = 0, $params = array())
    {
        $status = Response::STATUS_OK;
        $lang_code = $this->getLanguageCode($params);
        $params['extend'][] = 'categories';

        if ($this->getParentName() == 'categories') {
            $parent_category = $this->getParentData();
            $params['cid'] = $parent_category['category_id'];
        }

        if (!empty($id)) {
            $data = fn_get_product_data($id, $this->auth, $lang_code, '', true, true, true, false, false, false, false);

            if (empty($data)) {
                $status = Response::STATUS_NOT_FOUND;
            } else {
                $data['selected_options'] = $this->safeGet($params, 'selected_options', []);
                $products = $this->getProductsAdditionalData(array($data), $params);
                $data = reset($products);
            }

        } else {
            $items_per_page = $this->safeGet($params, 'items_per_page', Registry::get('settings.Appearance.admin_elements_per_page'));
            list($products, $search) = fn_get_products($params, $items_per_page, $lang_code);

            $products = $this->getProductsAdditionalData($products, $params);

            $data = array(
                'products' => array_values($products),
                'params'   => $search,
            );
        }

        return array(
            'status' => $status,
            'data'   => $data,
        );
    }

    public function create($params)
    {
        $data = array();
        $valid_params = true;
        $status = Response::STATUS_BAD_REQUEST;
        unset($params['product_id']);

        if (empty($params['category_ids'])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'category_ids'
            ));
            $valid_params = false;
        }

        if (!isset($params['price'])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'price'
            ));
            $valid_params = false;
        }

        if ($valid_params) {

            if (!is_array($params['category_ids'])) {
                $params['category_ids'] = fn_explode(',', $params['category_ids']);
            }

            $this->prepareFeature($params);
            $this->prepareImages($params);
            $product_id = fn_update_product($params);
            
            //stpes
            $current_step = (empty($params['step']) ? 1 : $params['step']);
            $previous_step = fn_get_previous_step($current_step);
            $next_step = fn_get_next_step($current_step);
            $is_last_step = ($next_step) ? false : true;

            if ($product_id) {
                $status = Response::STATUS_CREATED;
                $data = array(
                    'product_data' => fn_get_product_data($product_id, $auth, DESCR_SL, '', true, true, true, true),
                    'previous_step' => $previous_step,
                    'next_step' => $next_step,
                    'is_last_step' => $is_last_step,
                );
            }
        }

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function update($id, $params)
    {
        $data = array();
        $status = Response::STATUS_BAD_REQUEST;

        $lang_code = $this->getLanguageCode($params);
        $this->prepareFeature($params);
        $this->prepareImages($params, $id);

        //update fabric values
        $fabric = $params['fabric'];
        $variant_value_total = 0;
        foreach ($fabric as $featureid => $featurevalue) {
            $variant_value_total = array_sum($featurevalue);
            if($variant_value_total == 100){
                foreach ($featurevalue as $variantid => $value) {
                    //query to check record exist
                    $v_id = db_get_field("SELECT id FROM ?:custom_variant_total WHERE product_id = ?i AND featureid=?i AND variantid= ?i", $id, $featureid, $variantid);
                    if($id){
                        db_query("UPDATE ?:custom_variant_total SET variant_value = ?i WHERE id = ?i", $value, $v_id);
                    }else{
                        db_query("INSERT INTO ?:custom_variant_total SET product_id = ?i, featureid=?i, variantid= ?i, variant_value=?i", $id, $featureid, $variantid, $value);
                    }
                }
            }
        }

         //Create product features for product variants creation
        list($product_features, $features_search) = fn_get_paginated_product_features(
            array('product_id' => $id),
            $auth
        );

        //Create product variants creation
        $combination_ids = isset($params['combination_ids']) ? (array) $params['combination_ids'] : [];
                
        $group_repository = ServiceProvider::getGroupRepository();
        $service = ServiceProvider::getService();

        $group_id = $group_repository->findGroupIdByProductId($id);
        
        if ($group_id) {
            $service->generateProductsAndAttachToGroup($group_id, $id, $combination_ids);
        } else {
            $service->generateProductsAndCreateGroup($id, $combination_ids);
        }
        
        $product_id = fn_update_product($params, $id, $lang_code);

        if (!empty($params['products_data'])) {

            foreach ($params['products_data'] as $p_id => $product) {
                if (!empty($product['product'])) { // Checking for required fields for new product

                    if (!empty($product['category_ids']) && !is_array($product['category_ids'])) {
                        $product['category_ids'] = explode(',', $product['category_ids']);
                    }
                    fn_update_product($product, $p_id, DESCR_SL);

                    // Updating products position in category
                    if (isset($product['position']) && !empty($_REQUEST['category_id'])) {
                        fn_update_product_position_in_category($product_id, $_REQUEST['category_id'], $product['position']);
                    }
                }
            }
        }
        //stpes
        $current_step = (empty($params['step']) ? 1 : $params['step']);
        $previous_step = fn_get_previous_step($current_step);
        $next_step = fn_get_next_step($current_step);
        $is_last_step = ($next_step) ? false : true;

        if ($product_id) {
            $status = Response::STATUS_OK;
            $data = array(
                'product_data' => fn_get_product_data($product_id, $auth, DESCR_SL, '', true, true, true, true),
                'previous_step' => $previous_step,
                'next_step' => $next_step,
                'is_last_step' => $is_last_step,
            );
        }

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function delete($id)
    {
        $data = array();
        $status = Response::STATUS_BAD_REQUEST;

        if (!fn_product_exists($id)) {
            $status = Response::STATUS_NOT_FOUND;
        } elseif (fn_delete_product($id)) {
            $status = Response::STATUS_NO_CONTENT;
        }

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function privileges()
    {
        return array(
            'create' => 'manage_catalog',
            'update' => 'manage_catalog',
            'delete' => 'manage_catalog',
            'index'  => 'view_catalog'
        );
    }

    public function privilegesCustomer()
    {
        return array(
            'index' => true
        );
    }

    public function childEntities()
    {
        return array(
            'features',
            'discussions',
        );
    }

    public function prepareImages($params, $product_id = 0, $object_name = '', $main_type = 'M')
    {
        if (isset($params['main_pair'])) {

            $_REQUEST['file_product_main_image_icon'] = array();
            $_REQUEST['type_product_main_image_icon'] = array();
            $_REQUEST['file_product_main_image_detailed'] = array();
            $_REQUEST['type_product_main_image_detailed'] = array();
            $_REQUEST['product_main_image_data'] = array();

            if ($product_id != 0) {
                $products_images = fn_get_image_pairs($product_id, 'product', 'M', true, true, DEFAULT_LANGUAGE);
                if (!empty($products_images)) {
                    fn_delete_image_pair($products_images['pair_id']);
                }
            }

            if (!empty($params['main_pair']['detailed']['image_path'])) {
                $_REQUEST['file_product_main_image_detailed'][] = $params['main_pair']['detailed']['image_path'];
                $_REQUEST['type_product_main_image_detailed'][] = (strpos($params['main_pair']['detailed']['image_path'], '://') === false) ? 'server' : 'url';
            }

            if (!empty($params['main_pair']['icon']['image_path'])) {
                $_REQUEST['file_product_main_image_icon'][] = $params['main_pair']['icon']['image_path'];
                $_REQUEST['type_product_main_image_icon'][] = (strpos($params['main_pair']['icon']['image_path'], '://') === false) ? 'server' : 'url';
            }

            $_REQUEST['product_main_image_data'][] = array(
                'pair_id' => 0,
                'type' => 'M',
                'object_id' => 0,
                'image_alt' => !empty($params['main_pair']['icon']['alt']) ? $params['main_pair']['icon']['alt'] : '',
                'detailed_alt' => !empty($params['main_pair']['detailed']['alt']) ? $params['main_pair']['detailed']['alt'] : '',
            );
        }

        if (isset($params['image_pairs'])) {

            $_REQUEST['file_product_add_additional_image_icon'] = array();
            $_REQUEST['type_product_add_additional_image_icon'] = array();
            $_REQUEST['file_product_add_additional_image_detailed'] = array();
            $_REQUEST['type_product_add_additional_image_detailed'] = array();
            $_REQUEST['product_add_additional_image_data'] = array();

            if ($product_id != 0) {
                $additional_images = fn_get_image_pairs($product_id, 'product', 'A', true, true, DEFAULT_LANGUAGE);
                foreach ($additional_images as $pair) {
                    fn_delete_image_pair($pair['pair_id']);
                }
            }

            foreach ($params['image_pairs'] as $pair_id => $pair) {

                if (!empty($pair['icon']['image_path'])) {
                    $_REQUEST['file_product_add_additional_image_icon'][] = $pair['icon']['image_path'];
                    $_REQUEST['type_product_add_additional_image_icon'][] = (strpos($pair['icon']['image_path'], '://') === false) ? 'server' : 'url';
                }

                if (!empty($pair['detailed']['image_path'])) {
                    $_REQUEST['file_product_add_additional_image_detailed'][] = $pair['detailed']['image_path'];
                    $_REQUEST['type_product_add_additional_image_detailed'][] = (strpos($pair['detailed']['image_path'], '://') === false) ? 'server' : 'url';
                }

                $_REQUEST['product_add_additional_image_data'][] = array(
                    'position' => !empty($pair['position']) ? $pair['position'] : 0,
                    'pair_id' => 0,
                    'type' => 'A',
                    'object_id' => 0,
                    'image_alt' => !empty($pair['icon']['alt']) ? $pair['icon']['alt'] : '',
                    'detailed_alt' => !empty($pair['detailed']['alt']) ? $pair['detailed']['alt'] : '',
                );
            }
        }
    }

    public function prepareFeature(&$params)
    {
        if (!empty($params['product_features'])) {
            $features = $params['product_features'];
            $params['product_features'] = array();

            foreach ($features as $feature_id => $feature) {
                if (!empty($feature['feature_type'])) {
                    if (strpos(ProductFeatures::TEXT_SELECTBOX . ProductFeatures::NUMBER_SELECTBOX . ProductFeatures::EXTENDED, $feature['feature_type']) !== false) {
                        $params['product_features'][$feature_id] = $feature['variant_id'];

                    } elseif (strpos(ProductFeatures::NUMBER_FIELD . ProductFeatures::DATE, $feature['feature_type']) !== false) {
                        $params['product_features'][$feature_id] = $feature['value_int'];

                    } elseif (strpos(ProductFeatures::MULTIPLE_CHECKBOX, $feature['feature_type']) !== false) {
                        foreach ($feature['variants'] as $variant) {
                            $params['product_features'][$feature_id][] = $variant['variant_id'];
                        }

                    } else { // SINGLE_CHECKBOX, TEXT_FIELD
                        $params['product_features'][$feature_id] = $feature['value'];
                    }

                } else {
                    $params['product_features'][$feature_id] = $feature;
                }
            }
        }
    }

    /**
     * Fetches products additional data
     *
     * @param array $products Array of products
     * @param array $params   Array of parameters
     *
     * @return mixed
     */
    protected function getProductsAdditionalData($products, $params)
    {
        $params['get_options'] = $this->safeGet($params, 'get_options', false);
        $params['get_features'] = $this->safeGet($params, 'get_features', true);
        $params['get_detailed'] = $this->safeGet($params, 'get_detailed', true);
        $params['get_icon'] = $this->safeGet($params, 'get_icon', true);
        $params['get_additional'] = $this->safeGet($params, 'get_additional', true);
        $params['detailed_params'] = $this->safeGet($params, 'detailed_params', false);
        $params['features_display_on'] = 'A';

        fn_gather_additional_products_data($products, $params);

        return $products;
    }
}
