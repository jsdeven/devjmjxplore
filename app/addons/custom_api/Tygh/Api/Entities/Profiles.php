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

class Profiles extends AEntity
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
			
		if ($this->getParentName() == 'users') {
            $parent_user = $this->getParentData();
			$params['user_id'] = $parent_user['user_id'];
        }
		if (!empty($id)) {
			$params = array();
            $params['profile_id'] = $id;
            $user_data = $this->get_user_profile_info($params['profile_id'],false );
            if (!empty($user_data)) {
                $status = Response::STATUS_OK;
                $user_data = $user_data;
            } else {
                $status = Response::STATUS_NOT_FOUND;
            }
               
            return array(
				'status' => $status,
				'data' => $user_data[0]
			);
		}else if(isset($params['user_id'])){
		
            $user_data = $this->get_user_profile_info( false, $params['user_id'] );
            if (!empty($user_data)) {
                $status = Response::STATUS_OK;
                $user_data = $user_data;
            } else {
                $status = Response::STATUS_NOT_FOUND;
            }
            return array(
				'status' => $status,
				'data' => $user_data
			);
		}
    }

    public function create($params,$function = '')
    {
       
        $data = array();
        $valid_params = true;
        $status = Response::STATUS_BAD_REQUEST;
		$lang_code = $this->safeGet($params, 'lang_code', DEFAULT_LANGUAGE);
        
		if($valid_params){
		    
            $u_data = db_get_row("SELECT user_id, tax_exempt, user_type FROM ?:users WHERE user_id = ?i", $params['user_id']);
            $customer_auth = fn_fill_auth($u_data, array(), false, 'C');
            unset(  $params['user_id'] );
            
            fn_restore_processed_user_password($params['user_data'], $params['user_data']);
            $res = fn_update_user($customer_auth['user_id'], $params['user_data'], $customer_auth, !empty($params['ship_to_another']), true);
            if($res){
                $status = Response::STATUS_OK;
                $user_data = $this->get_user_profile_info($res[1],false );
            } else{
                $status = Response::STATUS_NOT_FOUND;
                $user_data = $this->get_user_profile_info($res[1],false );
            }
            $data = $user_data[0];
        }    
		return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function update($id = 0, $params,$function = '')
    {
		if (!empty($id)) {
            $params['profile_id'] = $id;
        }   
        
        $data = array();
        $valid_params = true;
        $status = Response::STATUS_BAD_REQUEST;
		$lang_code = $this->safeGet($params, 'lang_code', DEFAULT_LANGUAGE);
    
		if($valid_params){
		    $u_data = db_get_row("SELECT user_id, tax_exempt, user_type FROM ?:users WHERE user_id = ?i", $params['user_id']);
            $customer_auth = fn_fill_auth($u_data, array(), false, 'C');
            unset(  $params['user_id'] );
            
            $params['user_data']['profile_id'] = $params['profile_id'];
            fn_restore_processed_user_password($params['user_data'], $params['user_data']);
            $res = fn_update_user($customer_auth['user_id'], $params['user_data'], $customer_auth, !empty($params['ship_to_another']), true);
            if($res){
                $status = Response::STATUS_OK;
                $user_data = $this->get_user_profile_info($res[1],false );
            } else{
                $status = Response::STATUS_NOT_FOUND;
                $user_data = $this->get_user_profile_info($res[1],false );
            }
            $data = $user_data[0];
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
        if (!empty($id)) {
           
            $res = db_query("DELETE FROM ?:user_profiles WHERE profile_id = ?i", $id);
            if($res){
                $status = Response::STATUS_OK;
                $data['message'] = "Profile deleted successfully.";
            }else{
                $status = Response::STATUS_NOT_FOUND;
            }
            
        }   
        return array(
            'status' => $status,
            'data' => $data
        ); 
        
    }

    public function privileges()
    {
        return array(
            'create' =>  true,
            'update' =>  true,
            'delete' =>  true,
            'index'  =>  true
        );
    }

    public function get_user_profile_info($profile_id = false,$user_id = false){
		$profile_result = array();
		if( $user_id ){
			$profile_result = db_get_array("SELECT * FROM ?:user_profiles WHERE user_id = ?i", $user_id);
		}else if( $profile_id ){
			$profile_result = db_get_array("SELECT * FROM ?:user_profiles WHERE profile_id = ?i", $profile_id);
		}
		if(!$profile_id && !$user_id){
			$profile_result = db_get_array("SELECT * FROM ?:user_profiles");
		}
		
        return $profile_result;
	}

    
}