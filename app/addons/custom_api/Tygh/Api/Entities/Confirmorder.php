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
use Tygh\Api\SimpleHtmlDom;

class Confirmorder extends AEntity
{
    /**
     * Gets user data for a specified id; if no id specified, gets user list
     * satisfying filter conditions specified  in params
     *
     * @param  int   $id     User identifier
     * @param  array $params Filter params (user_ids param ignored on getting one user)
     * @return mixed
     */
		 
    public function index($id = 0, $params = array(),$function = '')
    {
        return array(
	        'status' => Response::STATUS_BAD_REQUEST,
	        'data' => $data
	    );
	       
    }
    public function create($params,$function = '')
    {   
        $getdata = array();
        $valid_params = true;
        $status = Response::STATUS_BAD_REQUEST;
    
        if (empty($params['order_id'])) {
            $getdata['message'] = __('api_required_field', array(
            '[field]' => 'order_id'
            ));
            $valid_params = false;
        }
        if (empty($params['shop_id'])) {
            $getdata['message'] = __('api_required_field', array(
            '[field]' => 'shop_id'
            ));
            $valid_params = false;
        }	
        if($valid_params) { 
                $order_id = 	$params['order_id'];
                $shop_id = 	$params['shop_id'];
                $data = array (
                'order_id' => $params['order_id'],
                'status' => 'N'
                );
                $paytm_response = !empty($params['paytm_response']) ? $params['paytm_response'] : '';
                $res   =   db_get_array("SELECT count(*) as total FROM ?:orders WHERE order_id = $data[order_id]");
                $payment_data   =   db_get_row("SELECT payment_id, user_id FROM ?:orders WHERE order_id = $data[order_id]");
                if ($res[0]['total'] >= 1) {
                   if (!empty($order_id)) {

                        fn_change_order_status($order_id, 'O', '', false);
                        if(!empty($paytm_response)){
                            $paytm_response = array(
                                'paytm_response' => json_encode($paytm_response)
                            );

                            db_query("UPDATE ?:orders SET ?u WHERE order_id =?i", $paytm_response, $data['order_id']);
                        }
                        $data_shop = array(
                            'shop_id' => $shop_id,
                            'order_id' => $order_id
                        );
                        db_query("REPLACE ?:shop_order ?e", $data_shop);

                        // update reward points 
                        // if($payment_data['reward_point'] == 1){
                        //     db_query("UPDATE ?:user_rewards_point SET points=points-$payment_data[subtotal_discount] WHERE user_id=?i", $payment_data['user_id']);
                        // }
                        $status = Response::STATUS_OK;
                        $getdata = array(
                            'order_id' => $order_id,
                            'message' => __('text_order_placed_successfully')
                        );

                        //clear coupan
                        db_query("DELETE FROM ?:user_cart_coupon WHERE user_id=?i", $payment_data['user_id']);
                        //clear cart here
                        $cart_data = array(
                            'type' => 'C'
                        );
                        fn_delete_user_cart($payment_data['user_id'], $cart_data);
                    }
                }
        }
        return array(
            'status' => $status,
            'data' => $getdata
        );
    }
	
    public function update($id, $params,$function = '')
    {
        $auth = $this->auth;

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
            'create' => true,
            'update' => false,
            'delete' => false,
            'index'  => true
        );
    }

}