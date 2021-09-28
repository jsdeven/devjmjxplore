<?php

namespace Tygh\Api\Entities;

use Tygh\Api\AEntity;
use Tygh\Api\Response;
use Tygh\Registry;

class LoginViaOTP extends AEntity
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

        $status = Response::STATUS_BAD_REQUEST;
        $data = array();

        $otp = $this->safeGet($params, 'otp', '');
        $user_id = $this->safeGet($params, 'user_id', '');
    
        if (!$otp) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'otp'
            ));

        }elseif (!$user_id) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'user_id'
            ));

        }else {
            
            $user_data = fn_get_user_info($user_id, false);

            if ($user_data && !empty($otp) && ($otp == $user_data['otp']) && ($user_data['verified']== 0)) {
                list($token, $expiry_time) = fn_get_user_auth_token($user_data['user_id']);

                //update otp verified field
                $data = array(
                    'verified'=> 1
                );
                db_query('UPDATE ?:users SET ?u WHERE email = ?s', $data, $user_data['user_id']);

                $status = Response::STATUS_CREATED;

                $data = array(
                    'token' => $token,
                    'ttl'   => $expiry_time - TIME,
                    'user_data'   => $user_data,
                );
            }
        }

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function update($id, $params)
    {

        return array(
            'status' => $status,
            'data' => $data
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