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

class Paymentmethods extends AEntity
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
		
        $lang_code = $this->safeGet($params, 'lang_code', DEFAULT_LANGUAGE);
        $data = array();
        $status = Response::STATUS_NOT_FOUND;
        $valid_params = true;
        if (!empty($id)) {
            $response = fn_get_payment_method_data($id,$lang_code);
            if(!empty($response)){
                $status = Response::STATUS_OK;
                $response['processor_params']['name'] = $response['payment'];
                $data = $response['processor_params'];
            }
        }else{
            $params['status'] = 'A';
            $response = fn_get_payments($params);
            $response_new = array();
            if(!empty($response)){
                $status = Response::STATUS_OK;
                foreach($response as $res){
                    $res['processor_params'] = unserialize($res['processor_params']);
                    $response_new[] = $res;
                }
            }
            $data = $response_new;
        }
        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function create($params,$function = '')
    {   
        $auth = $this->auth;

        $data = array();
        $status = Response::STATUS_BAD_REQUEST;

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

}


   


	
