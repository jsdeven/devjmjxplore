<?php
use Tygh\Registry;


if (!defined('BOOTSTRAP')) { die('Access denied'); }

/** @var array $cart */
$cart = &Tygh::$app['session']['cart'];

$_REQUEST['product_id'] = empty($_REQUEST['product_id']) ? 0 : $_REQUEST['product_id'];



if ($mode == 'manage') {

    $params = $_REQUEST;
    if (AREA == 'C') {
        $params['user_id'] = $auth['user_id'];
    }

    if (empty($params['user_id'])) {
        if (AREA == 'C') {
            return array(CONTROLLER_STATUS_REDIRECT, 'auth.login_form?return_url=' . urlencode(Registry::get('config.current_url')));
        } else {
            return array(CONTROLLER_STATUS_NO_PAGE);
        }
    }

    
    fn_add_breadcrumb(__('rqlist'));
    

    $params['user_id'] = $auth['user_id'];
    list($quotes, $search) = fn_user_quote($params, Registry::get('settings.Appearance.admin_elements_per_page'));

    Tygh::$app['view']->assign('quotes', $quotes);
    Tygh::$app['view']->assign('search', $search);
    
}