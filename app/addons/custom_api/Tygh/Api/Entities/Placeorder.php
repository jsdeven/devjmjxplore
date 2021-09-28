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

class Placeorder extends AEntity
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
        $data = array();
        $valid_params = true;
        $status = Response::STATUS_BAD_REQUEST;
        
        fn_clear_cart($cart, true);
        if (!empty($params['user_data'])) {
            $cart['user_data'] = $params['user_data'];
            if(empty($params['user_data']['b_email'])){
                $cart['user_data']['email'] = db_get_field("SELECT email FROM ?:users WHERE user_id = ?i", $params['user_id']);
            }else{
                $cart['user_data']['email'] = $params['user_data']['b_email'];
            }
        } elseif (!empty($params['user_id'])) {
			$cart['user_data'] = fn_get_user_info($params['user_id']);
		}
		$params['order_from'] = 'A';
		$cart['user_data'] = array_merge($cart['user_data'], $params);
		$this->auth['user_id'] = $cart['user_data']['user_id'];
        if (empty($params['user_id'])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'user_id/user_data'
            ));
            $valid_params = false;

        } elseif (empty($params['payment_id'])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'payment_id'
            ));
            $valid_params = false;

        }
        if ($valid_params) { 
            $cart['payment_id'] = $params['payment_id'];
            $customer_auth = fn_fill_auth($cart['user_data']);
            
            foreach($params['products'] as $c_product){
                $products_ids[]= $c_product['product_id'];
            }
            $c_params['extend'][] = 'categories';
            $c_params['status'] = 'A';
            $c_params['subcats'] = 'Y';
            $c_params['item_ids'] = implode(',', $products_ids);
            list($c_products, ) = fn_get_products($c_params);

            $check_cart_product_amount = true;
            foreach($c_products as $c_product_data){
                
                if($c_product_data['amount'] == 0 || $c_product_data['amount'] == null){
                    $check_cart_product_amount = false;
                    $out_of_stock_products[] = $c_product_data['product'];
                }
            }
            if($check_cart_product_amount){

                fn_add_product_to_cart($params['products'], $cart, $customer_auth);
                if(isset($params['coupon_code'])){
                    $this->apply_coupon( $cart ,$params['coupon_code']);
                }
                if(isset($params['reward_points']) && !empty($params['reward_points'])){
                    $this->apply_reward_points( $cart ,$params['reward_points']);
                }
                //Apply Gift Certificates
                if(isset($params['gift_certificate']) && !empty( $params['gift_certificate'] )) {
                    
                    //GIFT CERTIFICATES 
                    $gift_flag = fn_check_gift_certificate_code(array_keys(array($params['gift_certificate'])), true, $customer_auth['company_id']);
                    if(isset($gift_flag) && array_key_exists($params['gift_certificate'],$gift_flag)){
                        $cart['use_gift_certificates'][$params['gift_certificate']] = 'Y';
                        $cart['pending_certificates'][] = $params['gift_certificate'];
                        $this->apply_gift_certificates($cart,array($params['gift_certificate']),$customer_auth);
                    }
                }
                fn_calculate_cart_content($cart, $customer_auth);
                if (!empty($cart['product_groups']) && !empty($params['shipping_ids'])) {
                    foreach ($cart['product_groups'] as $key => $group) {
                        if(!$group['free_shipping']){
                            foreach ($group['shippings'] as $shipping_id => $shipping) {
                                if ($params['shipping_ids'] == $shipping['shipping_id']) {
                                    $cart['chosen_shipping'][$key] = $shipping_id;
                                    break;
                                }
                            }
                        }
                    }
                }

                $cart['calculate_shipping'] = true;
                fn_calculate_cart_content($cart, $customer_auth);
                if (empty($cart['shipping_failed']) || empty($params['shipping_ids'])) {
                
                    fn_update_payment_surcharge($cart, $customer_auth);
                    $cart['order_total'] = $cart['total'];
                    list($order_id, ) = fn_place_order($cart, $customer_auth, '', $this->auth['user_id']);
                
                    if (!empty($order_id)) {
                        $order_info = fn_get_order_info($order_id);

                        $order = fn_get_order_info($order_id,true);
                        if(!empty($order)){
                            $products = !empty($order['products']) ? $order['products'] : array();
                            foreach ($products as $key => $value) {
                                $items[$key] = $value['product'];
                            } 
                            $products_name = implode(',', $items);
                        }
                        
                        // SMS to Buyer
                        // if(isset($order_info["phone"]) && !empty($order_info["phone"]))
                        // {
                        // 	if($order_info['payment_id'] == 12){

                        // 		$sms_Message=urlencode("Order Placed: Your Order for ".$products_name." Order ID –".$order_id." for Rs. ".$order_info['total']." has been confirmed. Your order will be processed soon. ");

                        // 	}else{
                        // 		$sms_Message=urlencode("Order Placed: Your Order for ".$products_name." Order ID –".$order_id." for Rs. ".$order_info['total']." has been confirmed. Our representative will contact you soon for further process. ");
                        // 	}
                        
                        // 	$sms_MobNo=$order_info["phone"];
                        // 	$smsUrl="http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=threea&passwd=pass@123&mobilenumber=".$sms_MobNo."&message=".$sms_Message."&sid=THREEA&mtype=N&DR=Y";

                        // 	$ch = curl_init();
                        // 	curl_setopt($ch, CURLOPT_URL, $smsUrl);
                        // 	curl_setopt($ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
                        // 	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                        // 	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 30);
                        // 	curl_setopt($ch, CURLOPT_TIMEOUT, 30);
                        // 	$data = curl_exec($ch);
                        // 	curl_close($ch);
                        // }

                        // SMS to Vendor
                        // if(isset($order_info["product_groups"][0]["package_info"]["origination"]["phone"]) && !empty($order_info["product_groups"][0]["package_info"]["origination"]["phone"]))
                        // {
                        // 	$sms_Message=urlencode("Your Product has been sold - order no ".$order_id.". login in your vendor account on 3adeal.com for detail. Thank You");
                        // 	$sms_MobNo=$order_info["product_groups"][0]["package_info"]["origination"]["phone"];
                        // 	// if($_SERVER['REMOTE_ADDR'] =='122.160.42.8'){
                        // 	// // $sms_MobNo='8826857085';
                        // 	// }
                        // 	$smsUrl="http://api.smscountry.com/SMSCwebservice_bulk.aspx?User=threea&passwd=3acapital&mobilenumber=".$sms_MobNo."&message=".$sms_Message."&sid=THREEA&mtype=N&DR=Y";
                        // 	$ch = curl_init();
                        // 	curl_setopt($ch, CURLOPT_URL, $smsUrl);
                        // 	curl_setopt($ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
                        // 	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                        // 	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 30);
                        // 	curl_setopt($ch, CURLOPT_TIMEOUT, 30);
                        // 	$data = curl_exec($ch);
                        // 	curl_close($ch);
                        // } 

                        //fn_change_order_status($order_id, STATUS_INCOMPLETED_ORDER);
                        $status = Response::STATUS_CREATED;
                        $data = array(
                            'order_id' => $order_id,
                        );
                        
                    }
                }else{
                    $data['message'] = __('no_shipping_method_available');
                }
            }else{
                $status = Response::STATUS_OK;
                $message .= implode(',', $out_of_stock_products);
                $message .=  'availability out of stock';
                $data['out_of_stock'] = 1;
                $data['message'] = $message;
            }    
        }
        return array(
            'status' => $status,
            'data' => $data
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

    //============================Apply Coupon====================================//
	
	private function apply_coupon(&$cart,$coupon_code){
		fn_trusted_vars('coupon_code');
		
        $cart['pending_coupon'] = strtolower(trim($coupon_code));
        $cart['recalculate'] = true;

        if (!empty($cart['chosen_shipping'])) {
            $cart['calculate_shipping'] = true;
        }
    }

    private function apply_reward_points(&$cart,$reward_points){
		
        // $cart['stored_subtotal_discount'] = 'Y';
        // $cart['subtotal_discount'] = fn_format_price($reward_points);
        // $cart['original_subtotal_discount'] = fn_format_price($reward_points);
        // //print_r($cart['original_subtotal_discount']);die;
        $cart['points_info']['in_use']['points'] = $reward_points;
        $cart['recalculate'] = true;
        
        if (!empty($cart['chosen_shipping'])) {
            $cart['calculate_shipping'] = true;
        }
    }

}