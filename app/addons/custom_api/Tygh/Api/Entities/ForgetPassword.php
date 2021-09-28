<?php
namespace Tygh\Api\Entities;

use Tygh\Api\AEntity;
use Tygh;
use Tygh\Api\Response;
use Tygh\Registry;

class ForgetPassword extends AEntity
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
        return array(
            'status' => Response::STATUS_NOT_FOUND,
            'data' => array()
        );
    }

    public function create($params)
    {
        $status = Response::STATUS_BAD_REQUEST;
        $data = array();
        $valid_params = true;
        $signUpWith = '';
        $auth = $this->auth;

        $user_id = 0;

        if (empty($params['email_phone'])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'email_phone'
            ));
            $valid_params = false;
        }  
        if($valid_params){
            $user_data = db_get_row("SELECT email, user_id, company_id FROM ?:users WHERE email = ?s", $params['email_phone']);
            if($user_data['email']){
                $verification_code = fn_generate_otp(6);
                $view = Tygh::$app['view'];
                $mailer = Tygh::$app['mailer'];
                $response = $mailer->send(array(
                    'to' => $user_data['email'],
                    'from' => 'company_users_department',
                    'data' => array(
                        'verification_code' => $verification_code,
                    ),
                    'template_code' => 'verification_code',
                    'tpl' => 'addons/custom_api/common/verification_code.tpl', // this parameter is obsolete and is used for back compatibility
                    'company_id' => $user_data['company_id']
                ), 'C', CART_LANGUAGE);
                //print_r($response);die;
                //if($response){
                    $status = Response::STATUS_OK;
                    $data = array(
                        'user_id' => $user_data['user_id'],
                        'verfication_code'=> $verification_code,
                        'message' => 'Verfication code sent to your email!'
                    ); 
                //}     
            }else{
                $data['message'] = 'This email is not registered!';
            }
        }
        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function update($id, $params)
    {   
        //print_r($id);die;
        $status = Response::STATUS_BAD_REQUEST;
        $data = array();
        $valid_params = true;
        $user_id = $id;
        if (empty($params['password'])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'password'
            ));
            $valid_params = false;
        } 
        if (empty($params['confirm_password'])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'confirm_password'
            ));
            $valid_params = false;
        } 
        
        if($valid_params){
            if($params['password'] === $params['confirm_password']){
                $user_data = db_get_row("SELECT * FROM ?:users WHERE user_id = ?i", $user_id);
               
                $password = fn_generate_salted_password($params['password'], $user_data['salt']);
                $password_data = array(
                    'password' => $password,
                    'last_passwords' => $user_data['password']
                );
                $id = db_query("UPDATE ?:users SET ?u WHERE user_id = ?i", $password_data, $user_id);
                
                $status = Response::STATUS_OK;
                $data = array(
                    'user_id' => $user_id,
                    'message' => 'Password updated successfully'
                );
                
            }else{
                $data['message'] = 'Your password field did not match!';
            }
            

        }
       
        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function delete($id)
    {
        return array(
            'status' => Response::STATUS_NOT_FOUND,
            'data' => array()
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
    

   
}
