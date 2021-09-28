<?php

namespace Tygh\Api\Entities;

use Tygh\Api\AEntity;
use Tygh\Api\Response;
use Tygh\Registry;

class ProductSteps extends AEntity
{
    public function index($id = '', $params = array())
    {
        $data = array();
        if ($id) {
            $status = Response::STATUS_NOT_FOUND;
            $step = db_get_array("SELECT * FROM ?:product_create_steps WHERE id =?i", $id);
            if (!empty($step)) {
                $status = Response::STATUS_OK;
                $data = array(
                    'step' => $step,
                );
            }
        }else {
            $status = Response::STATUS_NOT_FOUND;
            $steps = db_get_array("SELECT * FROM ?:product_create_steps");
            if (!empty($steps)) {
                $status = Response::STATUS_OK;
                $data = array(
                    'steps' => $steps,
                );
            }
        }
        return array(
            'status' => Response::STATUS_OK,
            'data' => $data
        );
    }

    public function create($params)
    {
        $status = Response::STATUS_BAD_REQUEST;
        $data = array();

        $email = $this->safeGet($params, 'email', '');
        $password = $this->safeGet($params, 'password', '');

        if (!$email) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'email'
            ));
        } elseif (!$password) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'password'
            ));
        } else {
            $status = Response::STATUS_NOT_FOUND;

            list($user_exists, $user_data, $login, $password, $salt) = fn_auth_routines(
                array(
                    'user_login' => $email,
                    'password'   => $password,
                ),
                array()
            );
            if ($user_data && fn_generate_salted_password($password, $salt) == $user_data['password']) {
                $otp = fn_jmj_user_send_otp($user_data);
                if($otp){
                    $status = Response::STATUS_OK;
                    $data = array(
                        'otp' => $otp,
                        'user_id'   => $user_data['user_id'],
                        'msg'       => __('otp_sent'),
                    );
                }
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
            'index'  => true,
            'create' => true,
            'update' => false,
            'delete' => false
        );
    }
}