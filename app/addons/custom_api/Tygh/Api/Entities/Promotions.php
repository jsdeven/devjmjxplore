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

class Promotions extends AEntity
{
    public function index($id = 0, $params = array())
    {
       
        $lang_code = $this->safeGet($params, 'lang_code', DEFAULT_LANGUAGE);
        $valid_params = true;
        $status = Response::STATUS_BAD_REQUEST;
        $data = array();
        
        if (empty($params['user_id'])) {
            $data['message'] = __('api_required_field', array(
                '[field]' => 'user_id'
            ));
            $valid_params = false;
        }
        if($valid_params){
            if (!empty($id)) {
                $promotion = fn_get_promotion_data($id);
                if(!empty($promotion)){
                    $promotion['to_date'] = date("Y-m-d", $p['to_date']);
                    $promotion['from_date'] = date("Y-m-d", $p['from_date']);

                    $p['conditions'] = unserialize($p['conditions']);
                        $p['bonuses'] = unserialize($p['bonuses']);
                        //
                        foreach($p['conditions']['conditions'] as $cond){
                            //print_r($p['conditions']);die;
                            $c[] = $cond;
                        }
                        $p['conditions'] = $c;
                        //
                        foreach($p['bonuses'] as $bonus){
                            $b[] = $bonus;
                        }
                        $p['bonuses'] = $b;
                    $data = array(
                        'promotion' => $promotion,
                        'params' => $search
                    );
                    $status = Response::STATUS_OK;
                }else{
                    $status = Response::STATUS_NOT_FOUND;
                } 
            } else {

                $items_per_page = $this->safeGet($params, 'items_per_page', Registry::get('settings.Appearance.admin_elements_per_page'), $lang_code);
                $to_date =  date('d-m-Y', strtotime('+1 days'));
                $from_date = date('d-m-Y', strtotime('-1 days'));
                $params['to_date'] = $to_date;
                $params['from_date'] = $from_date;
                $params['for_app'] = 'Y';

                //print_r($params);die;
                list($promotions, $search) =  fn_get_promotions($params, $items_per_page);
                if(!empty($promotions)){
                    $promotion = array();
                    
                    foreach($promotions as $p){
                       
                        $p['conditions'] = unserialize($p['conditions']);
                        $p['bonuses'] = unserialize($p['bonuses']);
                        //
                        $c = array();
                        foreach($p['conditions']['conditions'] as $cond){
                            
                            $c[] = $cond;
                        }
                        $p['conditions'] = $c;
                        //
                        $b = array();
                        foreach($p['bonuses'] as $bonus){
                            $b[] = $bonus;
                        }
                        $p['bonuses'] = $b;

                        $p['to_date'] = date("Y-m-d", $p['to_date']);
                        $p['from_date'] = date("Y-m-d", $p['from_date']);

                        $promotion[] = $p;
                    }
                    $data = array(
                        'promotions' => $promotion,
                        'params' => $search
                    );
                    $status = Response::STATUS_OK;
                }else{
                    $status = Response::STATUS_NOT_FOUND;
                } 

            }
        }    

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function create($params)
    {
        $data = array();
        $status = Response::STATUS_NOT_FOUND;

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function update($id, $params)
    {
        $data = array();
        $status = Response::STATUS_NOT_FOUND;

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function delete($id)
    {
        $data = array();
        $status = Response::STATUS_NOT_FOUND;

        return array(
            'status' => $status,
            'data' => $data
        );
    }

    public function privileges()
    {
        return array(
            'create' => 'create_promotion',
            'update' => 'edit_promotion',
            'delete' => 'delete_promotion',
            'index'  => 'view_promotion'
        );
    }
}    

   