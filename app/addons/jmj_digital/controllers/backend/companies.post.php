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

use Tygh\Development;
use Tygh\Registry;
use Tygh\Helpdesk;
use Tygh\Tools\Url;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

}

if ($mode == 'update' || $mode == 'add' ) {
     
    $params = array(
        'status' => 'A'
    );
    list($cities, $search) = fn_get_all_cities($params, $auth);

    $company_additional_data = db_get_row("SELECT * FROM ?:company_additional_data WHERE company_id = ?i", $_REQUEST['company_id']);
    if(isset($company_additional_data['categories']) && !empty($company_additional_data['categories'])){
        $company_additional_data['categories'] = unserialize($company_additional_data['categories']);
    }

    if(isset($company_additional_data['main_market_coverage']) && !empty($company_additional_data['main_market_coverage'])){
        $company_additional_data['main_market_coverage'] = explode(',', $company_additional_data['main_market_coverage']);
        $states = db_get_fields("SELECT sd.state FROM ?:states s INNER JOIN ?:state_descriptions sd ON(s.state_id = sd.state_id) WHERE s.code IN (?a) AND s.country_code = 'IN'", $company_additional_data['main_market_coverage']);
        $company_additional_data['main_market_coverage'] = implode(',', $states);
    }
    
    Tygh::$app['view']->assign('cities', $cities);
    Tygh::$app['view']->assign('company_additional_data', $company_additional_data);
}


