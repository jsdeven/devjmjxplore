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
        $email = $this->safeGet($params, 'email', '');
        $password = $this->safeGet($params, 'password', '');
    
        if (!$otp) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'otp'
            ));

        }elseif (!$email) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'email'
            ));
            
        }elseif (!$password) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'password'
            ));

        }else {
            
            $status = Response::STATUS_NOT_FOUND;
           
            list($user_exists, $user_data, $login, $password,) = fn_auth_routines(
                array(
                    'user_login' => $email,
                    'password'   => $password,
                ),
                array()
            );
            
            if ($user_data && fn_user_password_verify((int) $user_data['user_id'], $password, (string) $user_data['password'], $salt) && !empty($otp) && ($otp == $user_data['otp']) && ($user_data['verified']== 0) && $user_data['user_type'] != 'V') {
                
                list($token, $expiry_time) = fn_get_user_auth_token($user_data['user_id']);

                //update otp verified field
                $data = array(
                    'verified'=> 1
                );
                
                db_query('UPDATE ?:users SET ?u WHERE email = ?s', $data, $user_data['user_id']);

                $status = Response::STATUS_CREATED;

                $data = array(
                    'token' => $token,
                    'ttl'   => $expiry_time - TIME
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