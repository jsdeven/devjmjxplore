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

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

$_REQUEST['tax_id'] = empty($_REQUEST['tax_id']) ? 0 : $_REQUEST['tax_id'];

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $suffix = '';

    //
    // Update taxes
    //
    if ($mode == 'm_update') {

        // Update taxes data
        if (!empty($_REQUEST['tax_data'])) {
            foreach ($_REQUEST['tax_data'] as $k => $v) {

                db_query("UPDATE ?:taxes SET ?u WHERE tax_id = ?i", $v, $k);
                db_query("UPDATE ?:tax_descriptions SET ?u WHERE tax_id = ?i AND lang_code = ?s", $v, $k, DESCR_SL);
            }
        }

        $suffix = '.manage';
    }

    //
    // Delete taxes
    //
    if ($mode == 'm_delete') {

        // Delete selected taxes
        if (!empty($_REQUEST['tax_ids'])) {
            fn_delete_taxes($_REQUEST['tax_ids']);
        }

        $suffix = '.manage';
    }

    if (
        $mode === 'm_update_statuses'
        && !empty($_REQUEST['tax_ids'])
        && is_array($_REQUEST['tax_ids'])
        && !empty($_REQUEST['status'])
    ) {
        $status_to = (string) $_REQUEST['status'];

        foreach ($_REQUEST['tax_ids'] as $tax_id) {
            fn_tools_update_status([
                'table'             => 'taxes',
                'status'            => $status_to,
                'id_name'           => 'tax_id',
                'id'                => $tax_id,
                'show_error_notice' => false
            ]);
        }

        if (defined('AJAX_REQUEST')) {
            $redirect_url = fn_url('taxes.manage');
            if (isset($_REQUEST['redirect_url'])) {
                $redirect_url = $_REQUEST['redirect_url'];
            }
            Tygh::$app['ajax']->assign('force_redirection', $redirect_url);
            Tygh::$app['ajax']->assign('non_ajax_notifications', true);
            return [CONTROLLER_STATUS_NO_CONTENT];
        }
    }

    //
    // Update selected tax data
    //
    if ($mode == 'update') {
        $tax_id = fn_update_tax($_REQUEST['tax_data'], $_REQUEST['tax_id'], DESCR_SL);

        $suffix = ".update?tax_id=$tax_id";
    }

    if ($mode == 'apply_selected_taxes') {
        if (!empty($_REQUEST['tax_ids'])) {

            $tax_names = fn_get_tax_name($_REQUEST['tax_ids']);

            foreach ($_REQUEST['tax_ids'] as $v) {
                db_query("UPDATE ?:products SET tax_ids = ?p", fn_add_to_set('?:products.tax_ids', $v));

                fn_set_notification('N', __('notice'), __('text_tax_applied', array(
                    '[tax]' => $tax_names[$v]
                )));
            }
        }

        $suffix = '.manage';
    }

    if ($mode == 'unset_selected_taxes') {
        if (!empty($_REQUEST['tax_ids'])) {

            $tax_names = fn_get_tax_name($_REQUEST['tax_ids']);

            foreach ($_REQUEST['tax_ids'] as $v) {
                db_query("UPDATE ?:products SET tax_ids = ?p", fn_remove_from_set('?:products.tax_ids', $v));

                fn_set_notification('N', __('notice'), __('text_tax_unset', array(
                    '[tax]' => $tax_names[$v]
                )));
            }
        }

        $suffix = '.manage';
    }

    if ($mode == 'delete') {

        if (!empty($_REQUEST['tax_id'])) {
            fn_delete_taxes($_REQUEST['tax_id']);
        }

        $suffix = '.manage';
    }

    return array(CONTROLLER_STATUS_OK, 'taxes' . $suffix);
}

// ---------------------- GET routines ---------------------------------------

// Edit tax rates
if ($mode == 'update') {
    $tax = fn_get_tax($_REQUEST['tax_id'], DESCR_SL);
    if (empty($tax)) {
        return array(CONTROLLER_STATUS_NO_PAGE);
    }

    $destinations = fn_get_destinations();

    Registry::set('navigation.tabs', array (
        'general' => array (
            'title' => __('general'),
            'js' => true
        ),
        'tax_rates' => array (
            'title' => __('tax_rates'),
            'js' => true
        ),
    ));

    Tygh::$app['view']->assign('tax', $tax);
    Tygh::$app['view']->assign('rates',  db_get_hash_array("SELECT * FROM ?:tax_rates WHERE tax_id = ?i", 'destination_id', $_REQUEST['tax_id']));
    Tygh::$app['view']->assign('destinations', $destinations);

// Add tax
} elseif ($mode == 'add') {

    Registry::set('navigation.tabs', array (
        'general' => array (
            'title' => __('general'),
            'js' => true
        ),
        'tax_rates' => array (
            'title' => __('tax_rates'),
            'js' => true
        ),
    ));

    Tygh::$app['view']->assign('destinations', fn_get_destinations());

// Edit taxes
} elseif ($mode == 'manage') {

    Tygh::$app['view']->assign('taxes', fn_get_taxes(DESCR_SL));
}
