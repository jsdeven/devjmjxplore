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

class ProductCombinations extends AEntity
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

                $product_type = Type::createByProduct($product_data);

                $group_repository = ServiceProvider::getGroupRepository();
                $product_repository = ServiceProvider::getProductRepository();
                $service = ServiceProvider::getService();

                $group = $group_repository->findGroupByProductId($product_id);
                $search = $products = $combinations = $selected_features = [];
                $count_available_combinations = 0;

                if ($group) {
                    $group_features = $group->getFeatures();
                    $product_ids = $group->getProductIds();
                    $feature_ids = $group->getFeatureIds();
                } else {
                    $features = $product_repository->findAvailableFeatures($product_id);
                    $group_features = GroupFeatureCollection::createFromFeatureList($features);
                    $feature_ids = array_keys($features);
                    $product_ids = [$product_id];
                }

                if ($feature_ids) {
                    $selected_features = $product_repository->findFeaturesByFeatureCollection($group_features);

                    $combinations_count = array_reduce(array_map(function ($feature_id) {
                        return (int) fn_get_product_feature_variants([
                            'feature_id'             => $feature_id,
                            'fetch_total_count_only' => true
                        ]);
                    }, $feature_ids), function ($carry, $item) { return $carry * $item; }, 1);

                    if ($combinations_count > 5000) { // FIXME Will be refactored, see 1-24713
                        $view->assign('is_too_many_combinations', true);
                    } else {
                        if ($group) {
                            $combinations = $service->getFeaturesVariantsCombinationsByGroup($group);
                        } else {
                            $combinations = $service->getFeaturesVariantsCombinations($group_features, [$product_id]);
                        }

                        foreach ($combinations as $combination) {
                            if (!$combination['exists']) {
                                $combination_new[] = $combination;
                                $count_available_combinations++;
                            }
                        }
                    }
                
                }
            }

            $data['combinations']                 = $combination_new;
            $data['count_available_combinations'] = $count_available_combinations;
            $data['is_allow_generate_variations'] = $product_type->isAllowGenerateVariations();

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
