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

use Tygh\Helpdesk;
use Tygh\Registry;
use Tygh\Settings;
use Tygh\BackendMenu;
use Tygh\Navigation\Breadcrumbs;
use Tygh\Enum\YesNo;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if (Registry::get('runtime.controller') == 'profiles' && $_SERVER['REQUEST_METHOD'] == 'GET') {
    $suffix = '?';
    $requestData = $_REQUEST;
    $dispatch = $requestData['dispatch'];
    $dispatch = explode('.', $dispatch);
    $mode = $dispatch[1];
    $suffix .= "dispatch=jmj_profiles.$mode";
    unset($requestData['dispatch']);
    foreach($requestData as $key => $value){
        $suffix .="&$key=$value";
    }
    
    return array(CONTROLLER_STATUS_REDIRECT, $suffix);
} 

if (Registry::get('runtime.controller') == 'products' && $_SERVER['REQUEST_METHOD'] == 'GET') {
    $suffix = '?';
    $requestData = $_REQUEST;
    $dispatch = $requestData['dispatch'];
    $dispatch = explode('.', $dispatch);
    $mode = $dispatch[1];
    $suffix .= "dispatch=products.preview";
    unset($requestData['dispatch']);
    foreach($requestData as $key => $value){
        $suffix .="&$key=$value";
    }
    
    if(isset($_REQUEST['action']) && $_REQUEST['action'] == 'preview' && $mode == 'view'){
        return array(CONTROLLER_STATUS_REDIRECT, $suffix);
    }
    
} 

