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

class Faq extends AEntity
{
    public function index($id = 0, $params = array())
    {
        $lang_code = $this->safeGet($params, 'lang_code', DEFAULT_LANGUAGE);
        if (!empty($id)) {
            $status = Response::STATUS_NOT_FOUND;
            $lang_code = $this->safeGet($params, 'lang_code', DEFAULT_LANGUAGE);
        
        } else {
            
            // when interacting with an authorized customer, use his/her user ID instead of the passed one
            if (!empty($this->auth['is_token_auth'])) {
                $params['user_id'] = $this->auth['user_id'];
            }
            list($faqs, $search) = fn_get_faqs($params);
            $data = array(
                'faqs' => $faqs,
                'params' => $search,
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
        $shipping_ids = $data = array();
        $valid_params = true;
        $status = Response::STATUS_BAD_REQUEST;

        
        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function update($id, $params)
    {   
        $shipping_ids = $data = array();
        $valid_params = true;
        $status = Response::STATUS_BAD_REQUEST;

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function delete($id)
    {
        $data = array();
        $status = Response::STATUS_NOT_FOUND;

        if (fn_delete_order($id)) {
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
            'create' => false,
            'update' => false,
            'delete' => false,
            'index'  => 'view_faq'
        );
    }
}