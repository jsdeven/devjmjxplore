<?php

use Tygh\Helpdesk;
use Tygh\Navigation\LastView;
use Tygh\Registry;
use Tygh\Settings;
use Tygh\BlockManager\Layout;
use Tygh\Themes\Styles;
use Tygh\Common\Robots;
use Tygh\Tools\DateTimeHelper;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($mode == 'manage') {

    $params['include_incompleted'] = true;
    $params['period'] = '12/22/2020';
    $params['time_from'] = strtotime("-2 weeks");
    $params['time_to']   = strtotime("+1 day");
    $params['status']    = 'O';


    if (fn_allowed_for('MULTIVENDOR')) {
        $params['company_name'] = true;
    }

    if (isset($params['phone'])) {
        $params['phone'] = str_replace(' ', '', preg_replace('/[^0-9\s]/', '', $params['phone']));
    }

    list($orders, $search, $totals) = fn_get_orders($params, Registry::get('settings.Appearance.admin_elements_per_page'), true);

    if (!empty($_REQUEST['redirect_if_one']) && count($orders) == 1) {
        return array(CONTROLLER_STATUS_REDIRECT, 'orders.details?order_id=' . $orders[0]['order_id']);
    }

    $company_id = fn_get_runtime_company_id();
    $shippings = fn_get_available_shippings($company_id);
    $shippings = array_column($shippings, 'shipping', 'shipping_id');

    $remove_cc = db_get_field(
        "SELECT COUNT(*)"
        . " FROM ?:status_data"
        . " WHERE status_id IN (?n)"
            . " AND param = 'remove_cc_info'"
            . " AND value = 'N'",
        array_keys(fn_get_statuses_by_type(STATUSES_ORDER))
    );
    $remove_cc = $remove_cc > 0 ? true : false;
    Tygh::$app['view']->assign('remove_cc', $remove_cc);

    Tygh::$app['view']->assign('orders', $orders);
    Tygh::$app['view']->assign('search', $search);

    Tygh::$app['view']->assign('totals', $totals);
    Tygh::$app['view']->assign('display_totals', fn_display_pending_disapproved_order_totals($orders));
    Tygh::$app['view']->assign('shippings', $shippings);

    $payments = fn_get_payments(array('simple' => true));
    Tygh::$app['view']->assign('payments', $payments);

    if (fn_allowed_for('MULTIVENDOR')) {
        Tygh::$app['view']->assign('selected_storefront_id', empty($_REQUEST['storefront_id']) ? 0 : (int) $_REQUEST['storefront_id']);
    }
} 

function fn_display_pending_disapproved_order_totals($orders)
{
    $result = array();
    $result['gross_total'] = 0;
    $result['totally_paid'] = 0;

    if (is_array($orders)) {
        foreach ($orders as $k => $v) {
            $result['gross_total'] += $v['total'];
            if ($v['status'] == 'C' || $v['status'] == 'P') {
                $result['totally_paid'] += $v['total'];
            }
        }
    }

    return $result;
}


