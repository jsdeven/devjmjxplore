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
use Tygh\Navigation\LastView;

class ReturnPolicy extends AEntity
{
    /**
     * Gets user data for a specified id; if no id specified, gets user list
     * satisfying filter conditions specified  in params
     *
     * @param  int   $id     User identifier
     * @param  array $params Filter params (user_ids param ignored on getting one user)
     * @return mixed
     */
    public function index($id = 0, $params = array())
    {
        
        $valid_params = true;
        $data = array();
        if (empty($id) && empty($params["user_id"])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'user_id'
            ));
            $valid_params = false;
        }


        if ($valid_params) {
            
            if (!empty($id)) {
                $params['user_id'] = $id;
            } elseif (!empty($params['user_ids']) && is_array($params['user_ids'])) {
                $params['user_id'] = $params['user_ids'];
            }
           
            $auth = $this->auth;
            $items_per_page = $this->safeGet($params, 'items_per_page', Registry::get('settings.Appearance.admin_elements_per_page'));
            $lang_code = $this->safeGet($params, 'lang_code', DEFAULT_LANGUAGE);
            list($data["returns"], $params) = $this->getRMAReturns($params, Registry::get('settings.Appearance.' . (AREA == 'A' ? 'admin_' : '') . 'elements_per_page'), $lang_code);
            
            // list($data, $params) = fn_get_users($params, $auth, $items_per_page);

            // $data = reset($data);

            if (!empty($data['returns']) || empty($id)) {
               
                /*get_reasons true****/
                if (isset($params["get_reasons"]) && $params["get_reasons"] == true)
                    $data["reasons"] = array_values(fn_get_rma_properties(RMA_REASON)) ;
                /*get_actions true****/
                if (isset($params["get_actions"]) && $params["get_actions"] == true)
                    $data["actions"] = array_values(fn_get_rma_properties(RMA_ACTION));
                    
                /*get_statuses true****/
                if (isset($params["get_statuses"]) && $params["get_statuses"] == true)
                    $data["statuses"] = array_values(fn_get_statuses(STATUSES_RETURN, false, false));

                $status = Response::STATUS_OK;
            } else {
                
                $status = Response::STATUS_NOT_FOUND;
            }
        } else {
            $status = Response::STATUS_NOT_FOUND;
        }

        

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function create($params)
    {
        $valid_params = true;
        $data = array();
        $auth = $this->auth;
        $user_id = 0;
        $status = Response::STATUS_BAD_REQUEST;
        
        /*Id or user id mandatory *** */
        if (empty($id) && empty($params["user_id"])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'user_id'
            ));
            $valid_params = false;
        }

        /*Order ID mandatory *** */
        if (empty($params["order_id"])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'order_id'
            ));
            $valid_params = false;
        }

        /*Action  mandatory *** */
        if (empty($params["action"])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'action'
            ));
            $valid_params = false;
        }

       
        /*Returns  mandatory *** */
        if (empty($params["returns"])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'returns'
            ));
            $valid_params = false;
        } else {
            foreach ($params["returns"] as $key => $value) {
                
                /*Product  mandatory *** */                
                if (empty($value["product_id"])) {
                    $data['message'] = __('api_required_field', array(
                        '[field]' => 'product_id'
                    ));
                    $valid_params = false;
                }

                /*Reason  mandatory *** */                
                if (empty($value["reason"])) {
                    $data['message'] = __('api_required_field', array(
                        '[field]' => 'reason'
                    ));
                    $valid_params = false;
                }

                /*Amount  mandatory *** */                
                if (empty($value["amount"])) {
                    $data['message'] = __('api_required_field', array(
                        '[field]' => 'amount'
                    ));
                    $valid_params = false;
                }

                /*Available Amount  mandatory *** */                
                if (empty($value["available_amount"])) {
                    $data['message'] = __('api_required_field', array(
                        '[field]' => 'available_amount'
                    ));
                    $valid_params = false;
                }
            }
        }

        
        if ($valid_params) {
            $user_id = (int) $params['user_id'];
            $order_id = (int) $params['order_id'];
            $returns = (array) $params['returns'];
            $action = $params['action'];
            $comment = $params['comment'];
            if ($this->returnRequestValid($user_id,$order_id,$returns) && !$this->returnExist($order_id,$returns)) {
                
                $order_info = fn_get_order_info($order_id);
                if (empty($order_info)) {
                    $status = Response::STATUS_NOT_FOUND;
                }
                
                $order_lang_code = $order_info['lang_code'];

                if (AREA != 'A' && !fn_is_order_allowed($order_id, $auth)) {
                    $status = Response::STATUS_NOT_FOUND;
                }

                $total_amount = 0;
                foreach ($returns as $k => $v) {
                    if (isset($v['chosen']) && $v['chosen'] == 'Y') {
                        $total_amount += $v['amount'];
                    }
                }

                $_data = array(
                    'order_id' => $order_id,
                    'user_id' => $user_id,
                    'action' => $action,
                    'timestamp' => TIME,
                    'status' => RMA_DEFAULT_STATUS,
                    'total_amount' => $total_amount,
                    'comment' => $comment
                );
                $return_id = db_query('INSERT INTO ?:rma_returns ?e', $_data);

                $order_items = db_get_hash_array("SELECT item_id, order_id, extra, price, amount FROM ?:order_details WHERE order_id = ?i", 'item_id', $order_id);
                foreach ($returns as $item_id => $v) {
                    if (isset($v['chosen']) && $v['chosen'] == 'Y') {
                        if (true == fn_rma_declined_product_correction($order_id, $k, $v['available_amount'], $v['amount'])) {
                            $_item = $order_items[$item_id];
                            $extra = @unserialize($_item['extra']);
                            $_data = array (
                                'return_id' => $return_id,
                                'item_id' => $item_id,
                                'product_id' => $v['product_id'],
                                'reason' => !empty($v['reason']) ? $v['reason'] : '',
                                'amount' => $v['amount'],
                                'product_options' => !empty($extra['product_options_value']) ? serialize($extra['product_options_value']) : '',
                                'price' => fn_format_price((((!isset($extra['exclude_from_calculate'])) ? $_item['price'] : 0) * $_item['amount']) / $_item['amount']),
                                'product' => !empty($extra['product']) ? $extra['product'] : fn_get_product_name($v['product_id'], $order_lang_code)
                            );

                            db_query('INSERT INTO ?:rma_return_products ?e', $_data);

                            if (!isset($extra['returns'])) {
                                $extra['returns'] = array();
                            }
                            $extra['returns'][$return_id] = array(
                                'amount' => $v['amount'],
                                'status' => RMA_DEFAULT_STATUS
                            );
                            db_query('UPDATE ?:order_details SET ?u WHERE item_id = ?i AND order_id = ?i', array('extra' => serialize($extra)), $item_id, $order_id);
                        }
                    }
                }

                //Send mail
                $return_info = fn_get_return_info($return_id);
                $order_info = fn_get_order_info($order_id);
                fn_send_return_mail($return_info, $order_info, array('C' => true, 'A' => true, 'S' => true));

                $status = Response::STATUS_CREATED;
                $data = array(
                    'return_info' => $return_info
                );

                //sent notifications
                $sms_template_data = fn_get_sms_template_data('ret_ini');
                if(!empty($sms_template_data) && $sms_template_data['status'] == 'A'){

                    $find = array(
                        '{firstname}',
                        '{lastname}',
                        '{order_id}'
                    );
    
                    $replace = array(
                        'firstname' => $order_info['firstname'],
                        'lastname' => $order_info['lastname'],
                        'order_id' => $order_info['order_id']
                    );
    
                    $template = trim(str_replace($find, $replace, $sms_template_data['template']));
                    fn_sent_msg($order_info['phone'], $template);
                }    

            } else {
                $status = Response::STATUS_OK;
                $data["message"] = __('already_in_list_or_not_valid_params');
            }
        } 
        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function update($id, $params)
    {
        $auth = $this->auth;

        $data = array();
        $status = Response::STATUS_BAD_REQUEST;

        $params = $this->filterUserData($params);

        list($user_id, $profile_id) = fn_update_user($id, $params, $auth, false, false);
        if ($user_id) {
            $status = Response::STATUS_OK;
            $data = array(
                'user_id' => $user_id,
                'profile_id' => $profile_id
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

        if (fn_delete_user($id)) {
            $status = Response::STATUS_NO_CONTENT;
        } elseif (!fn_notification_exists('extra', 'user_delete_no_permissions')) {
            $status = Response::STATUS_NOT_FOUND;
        }

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function privileges()
    {
        return array(
            'create' => 'manage_users',
            'update' => 'manage_users',
            'delete' => 'manage_users',
            'index'  => 'view_users'
        );
    }

    public function childEntities()
    {
        return array(
            'usergroups',
        );
    }


    /**
     * Filters user data.
     *
     * @param array $user_data
     *
     * @return array
     */
    protected function filterUserData($user_data)
    {
        unset($user_data['user_id'], $user_data['salt']);

        if (isset($user_data['password'])) {
            $user_data['password1'] = $user_data['password2'] = $user_data['password'];
            unset($user_data['password']);
        }

        return $user_data;
    }

    protected function getRMAReturns($params, $items_per_page = 0, $lang_code = CART_LANGUAGE)
    {
        // Init filter
        $params = LastView::instance()->update('rma', $params);

        // Set default values to input params
        $default_params = array (
            'page' => 1,
            'items_per_page' => $items_per_page
        );

        $params = array_merge($default_params, $params);

        // Define fields that should be retrieved
        $fields = array (
            'DISTINCT ?:rma_returns.return_id',
            '?:rma_returns.order_id',
            '?:rma_returns.timestamp',
            '?:rma_returns.status',
            '?:rma_returns.total_amount',
            '?:rma_returns.comment',
            '?:rma_property_descriptions.property AS action',
            '?:users.firstname',
            '?:users.lastname'
        );

        // Define sort fields
        $sortings = array (
            'return_id' => "?:rma_returns.return_id",
            'timestamp' => "?:rma_returns.timestamp",
            'order_id' => "?:rma_returns.order_id",
            'status' => "?:rma_returns.status",
            'amount' => "?:rma_returns.total_amount",
            'action' => "?:rma_returns.action",
            'customer' => "?:users.lastname"
        );

        $sorting = db_sort($params, $sortings, 'timestamp', 'desc');

        $join = $condition = $group = '';

        if (isset($params['cname']) && fn_string_not_empty($params['cname'])) {
            $arr = fn_explode(' ', $params['cname']);
            foreach ($arr as $k => $v) {
                if (!fn_string_not_empty($v)) {
                    unset($arr[$k]);
                }
            }
            if (sizeof($arr) == 2) {
                $condition .= db_quote(" AND ?:users.firstname LIKE ?l AND ?:users.lastname LIKE ?l", "%".array_shift($arr)."%", "%".array_shift($arr)."%");
            } else {
                $condition .= db_quote(" AND (?:users.firstname LIKE ?l OR ?:users.lastname LIKE ?l)", "%".trim($params['cname'])."%", "%".trim($params['cname'])."%");
            }
        }

        if (isset($params['email']) && fn_string_not_empty($params['email'])) {
            $condition .= db_quote(" AND ?:users.email LIKE ?l", "%".trim($params['email'])."%");
        }

        if (isset($params['rma_amount_from']) && fn_is_numeric($params['rma_amount_from'])) {
            $condition .= db_quote("AND ?:rma_returns.total_amount >= ?d", $params['rma_amount_from']);
        }

        if (isset($params['rma_amount_to']) && fn_is_numeric($params['rma_amount_to'])) {
            $condition .= db_quote("AND ?:rma_returns.total_amount <= ?d", $params['rma_amount_to']);
        }

        if (!empty($params['action'])) {
            $condition .= db_quote(" AND ?:rma_returns.action = ?s", $params['action']);
        }

        if (!empty($params['return_id'])) {
            $condition .= db_quote(" AND ?:rma_returns.return_id = ?i", $params['return_id']);
        }

        if (!empty($params['request_status'])) {
            $condition .= db_quote(" AND ?:rma_returns.status IN (?a)", $params['request_status']);
        }

        if (!empty($params['period']) && $params['period'] != 'A') {
            list($params['time_from'], $params['time_to']) = fn_create_periods($params);
            $condition .= db_quote(" AND (?:rma_returns.timestamp >= ?i AND ?:rma_returns.timestamp <= ?i)", $params['time_from'], $params['time_to']);
        }

        if (!empty($params['order_id'])) {
            $condition .= db_quote(" AND ?:rma_returns.order_id = ?i", $params['order_id']);

        } elseif (!empty($params['order_ids'])) {
            $condition .= db_quote(" AND ?:rma_returns.order_id IN (?a)", $params['order_ids']);
        }

        if (isset($params['user_id'])) {
            $condition .= db_quote(" AND ?:rma_returns.user_id = ?i", $params['user_id']);
        }

        if (!empty($params['order_status'])) {
            $condition .= db_quote(" AND ?:orders.status IN (?a)", $params['order_status']);
        }

        if (!empty($params['p_ids']) || !empty($params['product_view_id'])) {
            $arr = (strpos($params['p_ids'], ',') !== false || !is_array($params['p_ids'])) ? explode(',', $params['p_ids']) : $params['p_ids'];
            if (empty($params['product_view_id'])) {
                $condition .= db_quote(" AND ?:order_details.product_id IN (?n)", $arr);
            } else {
                $condition .= db_quote(" AND ?:order_details.product_id IN (?n)", db_get_fields(fn_get_products(array('view_id' => $params['product_view_id'], 'get_query' => true))));
            }

            $join .= " LEFT JOIN ?:order_details ON ?:order_details.order_id = ?:orders.order_id";
            $group .=  db_quote(" GROUP BY ?:rma_returns.return_id HAVING COUNT(?:orders.order_id) >= ?i", count($arr));
        }

        $limit = '';
        if (!empty($params['items_per_page'])) {
            $params['total_items'] = db_get_field("SELECT COUNT(DISTINCT ?:rma_returns.return_id) FROM ?:rma_returns LEFT JOIN ?:rma_return_products ON ?:rma_return_products.return_id = ?:rma_returns.return_id LEFT JOIN ?:rma_property_descriptions ON ?:rma_property_descriptions.property_id = ?:rma_returns.action LEFT JOIN ?:users ON ?:rma_returns.user_id = ?:users.user_id LEFT JOIN ?:orders ON ?:rma_returns.order_id = ?:orders.order_id $join WHERE 1 $condition $group");
            $limit = db_paginate($params['page'], $params['items_per_page'], $params['total_items']);
        }

        $return_requests = db_get_array("SELECT " . implode(', ', $fields) . " FROM ?:rma_returns LEFT JOIN ?:rma_return_products ON ?:rma_return_products.return_id = ?:rma_returns.return_id LEFT JOIN ?:rma_property_descriptions ON (?:rma_property_descriptions.property_id = ?:rma_returns.action AND ?:rma_property_descriptions.lang_code = ?s) LEFT JOIN ?:users ON ?:rma_returns.user_id = ?:users.user_id LEFT JOIN ?:orders ON ?:rma_returns.order_id = ?:orders.order_id $join WHERE 1 $condition $group $sorting $limit", $lang_code);

        LastView::instance()->processResults('rma_returns', $return_requests, $params);

        return array($return_requests, $params);
    }

    protected function returnRequestValid($user_id = null,$order_id = null ,$returns = array())
    {
        $response = true;

        if ($order_id != null && !empty($returns) && $user_id != null) {
            foreach ($returns as $item_id => $item) {
                $product_id = $item["product_id"];
                $sql = "SELECT * FROM `?:order_details` INNER JOIN ?:orders ON ?:orders.order_id=?:order_details.order_id WHERE 1 AND ?:order_details.item_id='$item_id' AND ?:order_details.order_id='$order_id' AND ?:orders.user_id='$user_id'";
                $count = db_get_field($sql);      
                if ($count == 0 || $count == '')
                    $response = false;
            }
        }
        return $response;
    }

    protected function returnExist($order_id = null ,$returns = array())
    {
        $response = false;

        if ($order_id != null && !empty($returns)) {
            foreach ($returns as $item_id => $item) {
                $product_id = $item["product_id"];
                $sql = "SELECT COUNT(DISTINCT ?:rma_returns.return_id) as count FROM ?:rma_returns INNER JOIN ?:rma_return_products ON ?:rma_return_products.return_id = ?:rma_returns.return_id WHERE 1 AND ?:rma_returns.order_id=$order_id AND ?:rma_return_products.item_id='$item_id' AND ?:rma_return_products.product_id='$product_id'";
                $count = db_get_field($sql);      
                if ($count > 0)
                    $response = true;
            }
        }
        return $response;
    }
}
