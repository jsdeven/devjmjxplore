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

use Tygh\Enum\ProductTracking;
use Tygh\Api\AEntity;
use Tygh\Api\Response;
use Tygh\Registry;
use Tygh\Storage;

class Wishlist extends AEntity
{

    public $wishlists = array();

    public function index($id = 0, $params = array())
    {
        $data = array();
        $status = Response::STATUS_BAD_REQUEST;
        if ($id) {
            $this->getWishlistData($id);

            if (is_array($this->wishlists))
                $data = $this->getWishlistProducts($this->wishlists, $params);
                //print_r($data);die;

                if (!empty($data))
                    $status = Response::STATUS_OK; 
                else {
                    $data = array(
                        "message" => __('no_data')
                    );
                    $status = Response::STATUS_OK;    
                }
        } else {
            $data = array(
                "message" => __('require_user_id')
            );
        }
        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function create($params)
    {

        $data = array();
        $status = Response::STATUS_BAD_REQUEST;
        $valid_params = true;
        
        if (empty($params['user_id'])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'user_id'
            ));
            $valid_params = false;
        }

        if (empty($params['product_id'])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'product_id'
            ));
            $valid_params = false;
        }
        
        if($valid_params){
            $id = $params['user_id'];

            $this->getWishlistData($id);
            // $wishlist = $this->getAddWishlistArray($params["product_data"]);
            $wishlist = $params["product_id"];
            $previous_wishlist = array_values($this->wishlists);
            
            if (!empty($previous_wishlist)){
                // list($add_wishlist,$same_wishlist) = $this->compareWishlists($wishlist,$previous_wishlist);
                if( in_array($wishlist, $previous_wishlist)){
                    $same_wishlist = true;
                    $status = Response::STATUS_OK;
                    $data = array(
                        "message" => __('already_in_wishlist')
                    );
                }
                
            }else{
                $same_wishlist = false;
            }
            //print_r($same_wishlist);die;
            if (empty($same_wishlist)) {
                $wishlist = array(
                    'products' => array()
                );
               
                $product_id = $this->addWishlistSessionData($id,$params["product_id"]);
                $status = Response::STATUS_OK;

                $data = array(
                    "message" =>  __('added_in_wishlist')
                );
            }
        } 

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    protected function getAddWishlistArray($product_data = array())
    {
        $result = array();
        foreach ($product_data as $key => $value) {
            if ($value > 0)
                $result[] = $value;
        }
        return array_unique($result);
    }

    public function update($id, $params)
    {

        $data = array();
        $status = Response::STATUS_BAD_REQUEST;
        $product_id = isset($params["product_id"]) ? $params["product_id"] : 0;
        if ($id) {
            $this->getWishlistData($id);

            $result = false;
            if (is_array($this->wishlists))
                $result = $this->deleteWishlistProducts($id,$product_id,$this->wishlists);

            
                if ($result) {
                    $data = array(
                        "message" => __('deleted_wishlist_product')
                    );
                    $status = Response::STATUS_OK; 
                } else {
                    $data = array(
                        "message" => __('no_data_found')
                    );
                    $status = Response::STATUS_NOT_FOUND;       
                }

        } else {
            $data = array(
                "message" => __('require_user_id')
            );
        }
        return array(
            'status' => $status,
            'data' => $data
        );
    }

    protected function deleteWishlistProducts($user_id,$product_id,$previous_wishlist = array())
    {
       $result = false;
        if ( in_array($product_id, $previous_wishlist) ) {
            try {
                if (db_query("DELETE FROM ?:user_session_products WHERE 1 AND type = 'W' AND user_id=$user_id AND product_id=$product_id")) {
                    $result = true;
                }
            } catch (Exception $e) {
                echo 'Exception :'.$e->getMessage();
            }
        }
        return $result;
    }

    public function delete($id)
    {
       if (fn_allowed_for('MULTIVENDOR') && $this->auth['user_type'] == 'V') {
            return array(
                'status' => Response::STATUS_FORBIDDEN
            );
        }

        $status = Response::STATUS_NOT_FOUND;
        $data = array();
        $params = array();

        if ($this->deleteWishlist($id)) {
           $status = Response::STATUS_OK;
           $data["message"] = __('wishlist_cleared');
        }

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function privileges()
    {
        return array(
            'create' => 'manage_discussions',
            'update' => 'manage_discussions',
            'delete' => 'manage_discussions',
            'index'  => 'view_discussions'
        );
    }

    protected function deleteWishlist($user_id = 0)
    {
        $data = '';
        if ($user_id <= 0 || $user_id == '')
            return;

        $products = array();
        try {
            db_query("DELETE FROM ?:user_session_products WHERE 1 AND user_id=$user_id AND type='W' AND user_type='R' AND item_type='P'");
            return true;
        } catch (Exception $e) {
            echo 'Exception: '.$e->getMessage();
        }
        return false;
    }

    protected function getPost($post_id, $params = array())
    {
        list($discussions) = fn_get_discussions(array('post_id' => $post_id));
        if (!$discussions) {
            return false;
        }

        $discussion = reset($discussions);

        if (
            !empty($params['object_type']) && $params['object_type'] != $discussion['object_type']
            || !empty($params['object_id']) && $params['object_id'] != $discussion['object_id']
        ) {
            return false;
        }

        return $discussion;
    }

    protected function getWishlistData($user_id = 0) 
    {
        $data = '';
        if ($user_id <= 0 || $user_id == '')
            return;

        $products = array();
        try {
            $this->wishlists = db_get_field("SELECT GROUP_CONCAT(DISTINCT ?:user_session_products.product_id) as ids  FROM ?:user_session_products  LEFT JOIN ?:product_descriptions ON ?:user_session_products.product_id = ?:product_descriptions.product_id AND ?:product_descriptions.lang_code = 'DESCR_SL'  WHERE ?:user_session_products.user_id = $user_id  AND ?:user_session_products.type = 'W' AND ?:user_session_products.item_type='P'");

            if ($this->wishlists != '')
                $this->wishlists =  explode(',', $this->wishlists);

        } catch (Exception $e) {
            echo 'Exception: '.$e->getMessage();
        }
    }

    public function getWishlistProducts($wishlist = array(), $params)
    {
        
        $products = array();
        if (!empty($wishlist)) {
            $lang_code = $this->safeGet($params, 'lang_code', DEFAULT_LANGUAGE);

            $params['product_ids'] = $wishlist;
            list($products,) = fn_get_products($params);
            
            $params['get_options'] = $this->safeGet($params, 'get_options', false);
            $params['get_detailed'] = $this->safeGet($params, 'get_detailed', true);
            $params['get_icon'] = $this->safeGet($params, 'get_icon', true);
            $params['detailed_params'] = $this->safeGet($params, 'detailed_params', false);

            foreach ($products as $key => &$product) {
                $product["in_wishlist"] = 1;
                $added_to_store = 0;
                $liked = 0;
                if($product['media_id']){
                    $liked_check = db_get_field("SELECT id FROM ?:media_social_user msu WHERE msu.media_id =?i AND msu.user_id = ?i AND msu.user_like = ?i", $product['media_id'], $params['media_user_id'], 1);
                    if($liked_check){
                        $liked = 1;
                    }
            
                    $added_to_store_check = db_get_field("SELECT asm.id FROM ?:add_store_media asm INNER JOIN ?:shop s ON(asm.shop_id=s.id) WHERE asm.media_id = ?i AND s.user_id = ?i", $product['media_id'], $params['media_user_id']);
                    
                    if($added_to_store_check){
                        $added_to_store = 1;
                    }
                    
                }    
                $product['liked'] = $liked;
                $product['added_to_store'] = $added_to_store;
            }
            //print_r($product);die;
            
            if(!empty($products)){
                fn_gather_additional_products_data($products, $params);
            }
            $products = array_values($products);
        }
        return $products;
    }

    // private function compareWishlists($wishlist = array(),$previous_wishlist = array())
    // {
    //     print_r($previous_wishlist);die;
    //     $prev_add_wishlist = array_diff($previous_wishlist,$wishlist);
    //     $new_add_wishlist = array_diff($wishlist,$previous_wishlist);
        
    //     $prev_same_wishlist = array_intersect($previous_wishlist,$wishlist);
    //     $new_same_wishlist = array_intersect($wishlist,$previous_wishlist);

    //     return array($new_add_wishlist,$new_same_wishlist);
    // }

    protected function getProductsAdditionalData($products, $params)
    {
        $params['get_detailed'] = $this->safeGet($params, 'get_detailed', true);
        $params['get_icon'] = $this->safeGet($params, 'get_icon', true);
        $params['get_additional'] = $this->safeGet($params, 'get_additional', false);
        $params['detailed_params'] = $this->safeGet($params, 'detailed_params', false);
        
        $params['features_display_on'] = 'A';

        fn_gather_additional_products_data($products, $params);
        return $products[0];
    }

    protected function addWishlistSessionData($user_id = 0,$product_id)
    {
       $result = false;

        if ((!empty($product_id)) && $user_id > 0) {
            $tempArr = array();
            $_data = array(
                'user_id' => $user_id,
                'timestamp' => (int)( time() + 1000),
                'type' => "W",
                'user_type' => "R",
                'item_type' => "P",
                'product_id' => $product_id,
                'amount' => 1,
                'item_id'  => (int)( time() + 1000)
            );
            
            try {
                if (db_query("INSERT INTO ?:user_session_products ?e", $_data)) {
                    $tempArr[] = $product_id;
                }
            } catch (Exception $e) {
                echo 'Exception :'.$e->getMessage();
            }
        
            $result = true;
        }
        return $result;
    }
}
