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

class ProductVariation extends AEntity
{
    public function index($id = 0, $params = array())
    {
        $status = Response::STATUS_OK;
        $lang_code = $this->getLanguageCode($params);

        if (!empty($id)) {
            $product_data = fn_get_product_data($id, $this->auth, $lang_code, '', true, true, true, false, false, false, false);
            
            if (empty($product_data)) {
                $status = Response::STATUS_NOT_FOUND;
            } else {

                $group_repository = ServiceProvider::getGroupRepository();
                $product_repository = ServiceProvider::getProductRepository();

                $group = $group_repository->findGroupByProductId($id);
                
                if ($group) {
                    $parent_to_child_map = [];

                    foreach ($group->getProducts() as $group_product) {
                        if (!$group_product->getParentProductId()) {
                            continue;
                        }

                        $parent_to_child_map[$group_product->getParentProductId()] = $group_product->getProductId();
                    }

                    $params = array_merge(array("product_id" => $id), [
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
                }    
            }

            $data['products'] = $products;

        } 

        return array(
            'status' => $status,
            'data'   => $data,
        );
    }

    public function create($params)
    {
        $data = array();
        $status = Response::STATUS_BAD_REQUEST;

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function update($id, $params)
    {
        $data = array();
        $status = Response::STATUS_BAD_REQUEST;

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function delete($id)
    {
        $data = array();
        $status = Response::STATUS_BAD_REQUEST;

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function privileges()
    {
        return array(
            'create' => false,
            'update' => false,
            'delete' => false,
            'index'  => true
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

}
