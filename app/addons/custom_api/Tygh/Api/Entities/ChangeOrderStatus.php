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

class ChangeOrderStatus extends AEntity
{
    public function index($id = '', $params = [])
    {
        
        $status = Response::STATUS_BAD_REQUEST;
        $data = [];

        return [
            'status' => $status,
            'data'   => $data
        ];
    }

    public function create($params)
    {
        $status = Response::STATUS_BAD_REQUEST;
        $data = [];
        $valid_params = true;

        if (empty($params['order_id'])) {
            $data['message'] = __('api_required_field', [
                '[field]' => 'order_id'
            ]);
            $valid_params = false;
        }

        if ($valid_params == true) {
            fn_change_order_status($params['order_id'], 'C');
                $status = Response::STATUS_CREATED;
                $data = [
                    'order_id' => $params['order_id'],
                    'message' => Response::STATUS_CREATED
                ];
        }

        return [
            'status' => $status,
            'data'   => $data
        ];
    }

    public function update($id, $params)
    {
        $status = Response::STATUS_BAD_REQUEST;
        $data = [];

        

        return [
            'status' => $status,
            'data'   => $data
        ];
    }

    public function delete($id)
    {
        $data = [];
        $status = Response::STATUS_BAD_REQUEST;

       
        return [
            'status' => $status,
            'data'   => $data
        ];
    }

    public function privileges()
    {
        return [
            'create' => 'manage_order_statuses',
            'update' => 'manage_order_statuses',
            'delete' => 'manage_order_statuses',
            'index'  => 'manage_order_statuses'
        ];
    }
}
