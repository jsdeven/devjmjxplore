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

class Discussion extends AEntity
{
    public function index($id = 0, $params = array())
    {
        if (fn_allowed_for('MULTIVENDOR') && $this->auth['user_type'] == 'V' && $this->getParentName() != 'products') {
            return array(
                'status' => Response::STATUS_FORBIDDEN
            );
        }

        $data = array();

        if ($this->getParentName() == 'products') {
            $parent_product = $this->getParentData();
            $params['object_id'] = $parent_product['product_id'];
            $params['object_type'] = 'P';
            unset($params['thread_id']);
        }

        if (!empty($id)) {
            $data = $this->getPost($id, $params);

            if ($data) {
                $status = Response::STATUS_OK;
            } else {
                $status = Response::STATUS_NOT_FOUND;
            }

        } else {
            $items_per_page = $this->safeGet(
                $params, 'items_per_page', Registry::get('settings.Appearance.admin_elements_per_page')
            );
            list($discussions, $search) = fn_get_discussions($params, $items_per_page);

            $data = array(
                'discussions' => array_values($discussions),
                'params' => $search
            );
            $status = Response::STATUS_OK;
        }

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function create($params)
    {   
       
        if (fn_allowed_for('MULTIVENDOR') && $this->auth['user_type'] == 'V') {
            if ($this->getParentName() != 'products') {
                return array(
                    'status' => Response::STATUS_FORBIDDEN
                );
            }
            unset($params['rating_value']);
        }

        $data = array();
        $status = Response::STATUS_OK;
        
        if ($this->getParentName() == 'products') {
            $parent_product = $this->getParentData();
            $params['object_id'] = $parent_product['product_id'];
            $params['object_type'] = 'P';
            unset($params['thread_id']);
        }
        
        $valid_params = true;
        if (empty($params['thread_id'])) {
            foreach (array('object_type', 'object_id', 'name') as $field) {
                if (!isset($params[$field])) {
                    $data['message'] = __('api_required_field', array('[field]' => $field));
                    $valid_params = false;
                    break;
                }
            }
        }

        $u_data = db_get_row("SELECT user_id, tax_exempt, user_type FROM ?:users WHERE user_id = ?i", $params["user_id"]);
        $customer_auth = fn_fill_auth($u_data, array(), false, 'C');

        /*custom for user_id mandatory*/
        if (empty($params["user_id"]) || $params["user_id"] == 0) {
            $data['message'] = __('api_required_field', array('[field]' => 'user_id'));
            $valid_params = false;
        } else {
             /*Check User is Valid or Not*/
            if ($customer_auth["user_id"] <= 0) {
                $data['message'] = "Invalid user Id";
                $valid_params = false;


            } else {
                $object = fn_discussion_get_object($params);
                //review post condition 
                $review_user_id = $customer_auth["user_id"];
                if(!empty($object['thread_id'])){
                    $review_thread_id = $object['thread_id'];
                    $reviewed = db_get_field("SELECT COUNT(post_id) FROM ?:discussion_posts WHERE thread_id = ?i AND user_id = ?i", $review_thread_id, $review_user_id);
                    //print_r($reviewed);die;
                    if($reviewed){
                        $review_product_id = $object['object_id'];
                        $data['message'] = "Already reviewed given by you.";
                        $valid_params = false;
                    }else{
                        $review_product_id = $object['object_id'];
                    }
                }else{
                    $review_product_id = $params['object_id'];
                }
                
                $check = db_get_field("SELECT COUNT(od.order_id) FROM ?:orders o INNER JOIN ?:order_details od ON (o.order_id = od.order_id) WHERE o.user_id = ?i AND od.product_id = ?i AND o.status = ?s", $review_user_id, $review_product_id, 'C');
                if(!$check){
                    $data['message'] = "Please buy this product first then you will be able to add review of this product.";
                    $valid_params = false;
                }

            }
        }

        if ($valid_params && empty($params['rating_value']) && empty($params['message'])) {
            $show_field = 'rating_value/message';
            if (fn_allowed_for('MULTIVENDOR') && $this->auth['user_type'] == 'V') {
                $show_field = 'message';
            }
            $data['message'] = __('api_required_field', array('[field]' => $show_field));
            $valid_params = false;
        }

        if ($valid_params) {
            $send_notifications = $this->safeGet($params, 'send_notifications', true);
            $post_id = $this->fnAddDiscussionPost($params,$customer_auth);

            if ($post_id) {
                $status = Response::STATUS_CREATED;
                $data['message'] = "Your feedback has been submitted.";
            }
        }
        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function update($id, $params)
    {
        if (fn_allowed_for('MULTIVENDOR') && $this->auth['user_type'] == 'V') {
            return array(
                'status' => Response::STATUS_FORBIDDEN
            );
        }

        $data = array();
        $status = Response::STATUS_BAD_REQUEST;

        if ($this->getParentName() == 'products') {
            $parent_product = $this->getParentData();
            $params['object_id'] = $parent_product['product_id'];
            $params['object_type'] = 'P';
        }

        if ($this->getPost($id, $params)) {
            $posts = array(
                $id => $params
            );

            if (fn_update_discussion_posts($posts)) {
                $status = Response::STATUS_OK;
                $data = array(
                    'post_id' => $id
                );
            }
        }

        return array(
            'status' => $status,
            'data' => $data
        );
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

        if ($this->getParentName() == 'products') {
            $parent_product = $this->getParentData();
            $params['object_id'] = $parent_product['product_id'];
            $params['object_type'] = 'P';
        }

        if ($this->getPost($id, $params)) {
            fn_discussion_delete_post($id);
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
            'create' => 'manage_discussions',
            'update' => 'manage_discussions',
            'delete' => 'manage_discussions',
            'index'  => 'view_discussions'
        );
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

    protected function fnAddDiscussionPost($post_data,$auth)
    {
        $ip = fn_get_ip();
        $post_data['ip_address'] = fn_ip_to_db($ip['host']);
        $post_data['status'] = 'A';

        $sql = "SELECT thread_id FROM ?:discussion WHERE 1 AND  object_id='".$post_data["object_id"]."' AND object_type='".$post_data["object_type"]."'";

        $thread_id = db_get_field($sql);

        if ($thread_id <= 0 || $thread_id == '') {
            $discussion_data = array(
                "object_id" => $post_data["object_id"],
                "object_type" => $post_data["object_type"],
                "type" => "B"
            );
            $thread_id = db_query("INSERT INTO ?:discussion ?e", $discussion_data);    
        }
        
        $discussion_posts_data = array(
            "thread_id" => $thread_id,
            "name" => $post_data["name"],
            "timestamp" => time(),
            "user_id" => $post_data["user_id"],
            "ip_address" => $post_data['ip_address'],
            "status" => $post_data['status']
        );

        $post_id = db_query("INSERT INTO ?:discussion_posts ?e", $discussion_posts_data);
        // gk_discussion_posts

        $discussion_rating_data = array(
            "rating_value" => $post_data["rating_value"],
            "post_id" => $post_id,
            "thread_id" => $thread_id
        );

        db_query("INSERT INTO ?:discussion_rating ?e", $discussion_rating_data);

        $discussion_messages_data = array(
            "message"=>$post_data["message"],
            "post_id" => $post_id,
            "thread_id" => $thread_id
        );

        db_query("INSERT INTO ?:discussion_messages ?e", $discussion_messages_data);
        return $post_id;
    }

    protected function checkIsuserAlreadyPosted($user_id = 0,$object_id = 0,$object_type = 'P')
    {
        $response = false;

        if ($user_id > 0 && $object_id > 0) {
            $sql = "SELECT post_id FROM `?:discussion_posts` INNER JOIN ?:discussion ON ?:discussion_posts.thread_id=?:discussion.thread_id WHERE 1 AND ?:discussion_posts.user_id='$user_id' AND ?:discussion.object_id='$object_id' AND ?:discussion.object_type='$object_type'";
            $post_id = db_get_field($sql);

            if ($post_id > 0)
                $response = true;    
        }
        return $response;
    }
    protected function checkIsuserAllowed($user_id = 0,$object_id = 0,$object_type = 'P')
    {
        $response = false;

        if ($user_id > 0 && $object_id > 0) {
            $sql = "SELECT post_id FROM `?:discussion_posts` INNER JOIN ?:discussion ON ?:discussion_posts.thread_id=?:discussion.thread_id WHERE 1 AND ?:discussion_posts.user_id='$user_id' AND ?:discussion.object_id='$object_id' AND ?:discussion.object_type='$object_type'";
            $post_id = db_get_field($sql);

            if ($post_id > 0)
                $response = true;    
        }
        return $response;
    }
    
}
