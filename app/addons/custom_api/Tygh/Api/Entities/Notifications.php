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

class notifications extends AEntity
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
		$data = array();
        $data = db_get_array('SELECT * FROM ?:push_notifications ORDER BY id DESC LIMIT 0,10 ');
        if(!empty($data)){
            $status = Response::STATUS_OK;
        }else{
            $data['message'] = __('no_data');
        }

        return array(
            'status' => $status,
            'data' => $data
        );
    }
	
    public function create($params)
    {
    }

    public function update($id = 0, $params)
    {
		
    }

    public function delete($id)
    {
        
    }

    public function privileges()
    {
        return array(
            'create' => false,
            'update' => false,
            'delete' => false,
            'index'  => true
        );
    }

    
}