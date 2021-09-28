<?php

namespace Tygh\Api\Entities;

use Tygh\Api\AEntity;
use Tygh\Api\Response;

class Checkpincode extends AEntity
{
    public function index($id = '', $params = array())
    {
        return array(
            'status' => Response::STATUS_OK,
            'data' => array()
        );
    }

    public function create($params)
    {
        $data = array();
        $pincode = !empty($params['pincode']) ?$params['pincode']: '';
        if (empty($pincode)) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'pincode'
            ));
        }else{
            $pincode_data = fn_pincode_availablity_check($pincode);
            if(!empty($pincode_data)){
                $msg = '';
                $data['availablity'] = 1;
                if(!empty($pincode_data['estimate_del_date'])){
                    $msg .='Get it by '.$pincode_data['estimate_del_date'].' | ';
                }
                $msg .= __('pincode_available');
                $data['message'] = $msg;
            }else{
                $data['availablity'] = 0;
                $data['message'] = __('pincode_not_available');
            }
        }
        return array(
            'status' => Response::STATUS_OK,
            'data' => $data
        );
    }

    public function update($id, $params)
    {
        return array(
            'status' => Response::STATUS_OK,
            'data' => array()
        );
    }

    public function delete($id)
    {
        return array(
            'status' => Response::STATUS_NO_CONTENT,
        );
    }

    public function privileges()
    {
        return array(
            'index'  => false,
            'create' => true,
            'update' => false,
            'delete' => false
        );
    }
}