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

use Tygh\Api\AEntity;
use Tygh\Api\Response;
use Tygh\Registry;

class Filters extends AEntity
{
    public function index($id = 0, $params = array())
    {
        // $parent_data = $this->getParentData();
        // if(!isset($parent_data['category_id'])){
        //     return array(
        //         'status' => Response::STATUS_NOT_FOUND,
        //         'data' => array()
        //     );
        // }

        $params['category_id'] = $params['cid'];

        list($filters) = fn_get_filters_products_count($params);
       
        $category_filters = array();
        foreach ($filters as $key => $value) {
            if(isset($value['variants'])){
                $variants = array();
                foreach ($value['variants'] as $variant) {
                    $variants[] = $variant;  
                }

                $value['variants'] = $variants;
            }

            if(isset($value['selected_variants'])){
                $variants = array();
                foreach ($value['selected_variants'] as $variant) {
                    $variants[] = $variant;  
                }

                $value['selected_variants'] = $variants;
            }

            $category_filters[] = $value;
        }

        return array(
            'status' => Response::STATUS_OK,
            'data' => $category_filters
        );
        
    }

    public function create($params)
    {
       
    }

    public function update($id, $params)
    {
       
    }

    public function delete($id)
    {
    
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
}
