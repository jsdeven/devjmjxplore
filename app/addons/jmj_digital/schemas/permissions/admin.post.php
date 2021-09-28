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

$schema =  array(
    'orders' => array (
        'modes' => array (
            'update_status' => array (
                'permissions' => 'change_order_status'
            ),
            'delete_orders' => array (
                'permissions' => 'delete_orders'
            ),
            'delete' => array (
                'permissions' => 'delete_orders'
            ),
            'm_delete' => array (
                'permissions' => 'delete_orders'
            ),
            'bulk_print' => array (
                'permissions' => 'view_orders'
            ),
            'remove_cc_info' => array (
                'permissions' => 'edit_order'
            ),
            'update_details' => array(
                'permissions' => 'edit_order'
            ),
            'assign_manager' => array(
                'permissions' => 'edit_order'
            ),
            'export_range' => array (
                'permissions' => 'exim_access'
            ),
        ),
        'permissions' => 'view_orders'
    ),
    'taxes' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_taxes'
            ),
        ),
        'permissions' => array ('GET' => 'view_taxes', 'POST' => 'manage_taxes'),
    ),
    'sitemap' => array (
        'permissions' => 'manage_sitemap',
    ),
    'datakeeper' => array (
        'permissions' => 'backup_restore',
    ),
    'product_options' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_product_options'
            ),
            'm_delete' => array (
                'permissions' => 'manage_product_options'
            ),
            'manage' => array (
                'permissions' => 'view_product_options'
            )
        ),
        'permissions' => array ('GET' => 'view_product_options', 'POST' => 'manage_product_options'),
    ),
    'tabs' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_tabs'
            ),
            'update_status' => array (
                'permissions' => 'manage_tabs'
            ),
            'update' => array (
                'permissions' => 'manage_tabs'
            ),
            'add' => array (
                'permissions' => 'manage_tabs'
            ),
            'manage' => array (
                'permissions' => 'manage_tabs'
            ),
            'picker' => array (
                'permissions' => 'manage_tabs'
            ),
        ),
        'permissions' => array ('GET' => 'manage_tabs', 'POST' => 'manage_tabs'),
    ),
    'products' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_products_custom'
            ),
            'clone' => array (
                'permissions' => 'manage_products_custom'
            ),
            'add' => array (
                'permissions' => 'manage_products_custom'
            ),
            'manage' => array (
                'permissions' => 'view_products_custom'
            ),
            'picker' => array (
                'permissions' => 'view_products_custom'
            ),
            'options' => array (
                'permissions' => 'edit_order'
            ),
        ),
        'permissions' => array ('GET' => 'view_catalog', 'POST' => 'manage_catalog'),
    ),
    'product_filters' => array(
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_product_filters'
            ),
            'manage' => array (
                'permissions' => 'view_product_filters'
            ),
        ),
        'permissions' => array ('GET' => 'view_product_filters', 'POST' => 'manage_product_filters'),
    ),
    'shippings' => array (
        'modes' => array (
            'delete_shipping' => array (
                'permissions' => 'manage_shipping'
            ),
            'add' => array(
                'permissions' => 'manage_shipping'
            ),
        ),
        'permissions' => array ('GET' => 'view_shipping', 'POST' => 'manage_shipping'),
    ),
    'usergroups' => array (
        'modes' => array (
            'update_status' => array (
                'permissions' => 'manage_usergroups'
            ),
            'delete' => array (
                'permissions' => 'manage_usergroups'
            ),
            'update' => array (
                'permissions' => 'manage_usergroups',
                'condition' => array(
                    'operator' => 'and',
                    'function' => array('fn_check_permission_manage_usergroups'),
                ),
            ),
        ),
        'permissions' => array ('GET' => 'view_usergroups', 'POST' => 'manage_usergroups'),
    ),
    'customization' => [
        'modes' => [
            'update_mode' => [
                'param_permissions' => [
                    'type' => [
                        'live_editor'   => 'manage_translation',
                        'design'        => 'manage_design',
                        'theme_editor'  => 'manage_design',
                        'block_manager' => 'edit_blocks',
                    ],
                ],
            ],
        ],
    ],
    'profiles' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_users'
            ),
            'delete_profile' => array (
                'permissions' => 'manage_users'
            ),
            'm_delete' => array (
                'permissions' => 'manage_users'
            ),
            'add' => array (
                'permissions' => 'manage_users'
            ),
            'update' => array (
                'permissions' => array('GET' => 'view_users', 'POST' => 'manage_users'),
                'condition' => array(
                    'operator' => 'or',
                    'function' => array('fn_check_permission_manage_own_profile'),
                ),
            ),
            'update_status' => array (
                'permissions' => 'manage_users'
            ),
            'm_activate' => [
                'permissions' => 'manage_users',
            ],
            'm_disable' => [
                'permissions' => 'manage_users',
            ],
            'manage' => array (
                'permissions' => 'view_users'
            ),
            'export_range' => array (
                'permissions' => 'exim_access'
            ),
            'act_as_user' => array(
                'permissions' => 'manage_act_as_user',
                'condition' => array(
                    'operator' => 'or',
                    'function' => array('fn_check_permission_act_as_user'),
                )
            ),
            'login_as_vendor' => [
                'permissions' => 'manage_users',
                'condition' => [
                    'operator' => 'or',
                    'function' => ['fn_check_permission_act_as_user'],
                ]
            ]
        ),
    ),
    'cart' => array(
        'modes' => array(
            'convert_to_order' => array(
                'permissions' => 'manage_carts',
            ),
            'cart_list' => array(
                'permissions' => 'manage_carts',
            ),
            'delete' => array(
                'permissions' => 'manage_carts',
            ),
            'm_delete' => array(
                'permissions' => 'manage_carts',
            ),
        ),
        'permissions' => array ('GET' => 'manage_carts', 'POST' => 'manage_carts'),
    ),
    'pages' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_pages'
            )
        ),
        'permissions' => array ('GET' => 'view_pages', 'POST' => 'manage_pages'),
    ),
    'profile_fields' => array (
        'permissions' => array ('GET' => 'view_users', 'POST' => 'manage_users'),
    ),
    'logs' => array (
        'modes' => array (
            'clean' => array (
                'permissions' => 'delete_logs'
            )
        ),
        'permissions' => 'view_logs',
    ),
    'categories' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_categories'
            ),
            'manage' => array (
                'permissions' => 'view_categories'
            )
        ),
        'permissions' => array ('GET' => 'view_categories', 'POST' => 'manage_categories'),
    ),
    'settings' => array (
        'modes' => array (
            'change_store_mode' => array (
                'permissions' => 'upgrade_store'
            )
        ),
        'permissions' => array ('GET' => 'view_settings', 'POST' => 'update_settings'),
    ),
    'settings_wizard' => array (
        'permissions' => 'update_settings',
    ),
    'robots' => array (
        'permissions' => 'update_settings',
    ),
    'upgrade_center' => array (
        'permissions' => 'upgrade_store',
    ),
    'payments' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_payments'
            )
        ),
        'permissions' => array ('GET' => 'view_payments', 'POST' => 'manage_payments'),
    ),
    'currencies' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_currencies'
            )
        ),
        'permissions' => array ('GET' => 'view_currencies', 'POST' => 'manage_currencies'),
    ),
    'destinations' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_locations'
            )
        ),
        'permissions' => array ('GET' => 'view_locations', 'POST' => 'manage_locations'),
    ),
    'localizations' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_locations'
            )
        ),
        'permissions' => array ('GET' => 'view_locations', 'POST' => 'manage_locations'),
    ),
    'exim' => array (
        'modes' => array (
            'export' => array (
                'param_permissions' => array(
                    'section' => array(
                        'features' => 'manage_product_features',
                        'orders' => 'view_orders',
                        'products' => 'view_products_custom',
                        'translations' => 'view_languages',
                        'users' => 'view_users',
                    ),
                )
            ),
            'import' => array (
                'param_permissions' => array(
                    'section' => array(
                        'features' => 'manage_product_features',
                        'orders' => 'edit_order',
                        'products' => 'manage_products_custom',
                        'translations' => 'manage_languages',
                        'users' => 'manage_users',
                    ),
                )
            )
        ),

        'permissions' => 'exim_access',
    ),
    'languages' => array (
        'modes' => array (
            'delete_variable' => array (
                'permissions' => 'manage_languages'
            ),
            'delete_language' => array (
                'permissions' => 'manage_languages'
            )
        ),
        'permissions' => array ('GET' => 'view_languages', 'POST' => 'manage_languages'),
    ),
    'product_features' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_product_features'
            ),
            'delete' => array (
                'permissions' => 'manage_product_features'
            )
        ),
        'permissions' => array ('GET' => 'view_product_features', 'POST' => 'manage_product_features'),
    ),
    'static_data' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_static_data'
            )
        ),
        'permissions' => array ('GET' => 'view_static_data', 'POST' => 'manage_static_data'),
    ),
    'statuses' => array (
        'permissions' => 'manage_order_statuses',
    ),
    'sales_reports' => array (
        'modes' => array (
            'view' => array (
                'permissions' => 'view_reports'
            ),
            'set_report_view' => array (
                'permissions' => 'view_reports'
            ),
        ),
        'permissions' => 'manage_reports',
    ),
    'addons' => array (
        'permissions' => 'update_settings',
    ),
    'states' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'manage_locations'
            )
        ),
        'permissions' => array ('GET' => 'view_locations', 'POST' => 'manage_locations'),
    ),
    'countries' => array (
        'permissions' => array ('GET' => 'view_locations', 'POST' => 'manage_locations'),
    ),
    'order_management' => array(
        'modes' => array(
            'edit' => array(
                'param_permissions' => array(
                    'copy' => array(
                        '1' => 'create_order'
                    ),
                ),
                'permissions' => 'edit_order'
            ),
            'new' => array(
                'permissions' => 'create_order'
            ),
            'add' => array(
                'permissions' => 'create_order'
            ),
        ),
        'permissions' => 'edit_order',
        'condition' => array(
            'operator' => 'or',
            'function' => array('fn_check_current_user_access', 'create_order'),
        )
    ),
    'file_editor' => array (
        'permissions' => 'edit_files',
    ),
    'block_manager' => array (
        'permissions' => 'edit_blocks',
    ),
    'menus' => array (
        'modes' => array (
            'delete' => array (
                'permissions' => 'edit_blocks'
            ),
        ),
        'permissions' => 'edit_blocks',
    ),
    'promotions' => array (
        'permissions' => 'manage_promotions',
    ),
    'shipments' => array (
        'modes' => array (
            'manage' => array (
                'permissions' => 'manage_shipments',
            ),
            'delete' => array (
                'permissions' => 'manage_shipments',
            ),
            'picker' => array (
                'permissions' => 'manage_shipments',
            ),
            'add' => array(
                'permissions' => 'manage_shipments',
            )
        ),
        'permissions' => 'manage_shipments',
    ),
    'tools' => array (
        'modes' => array (
            'update_position' => array(
                'param_permissions' => array (
                    'table' => array (
                        'product_tabs' => 'manage_tabs',
                        'template_table_columns' => 'manage_document_templates',
                        'statuses' => 'manage_order_statuses'
                    )
                )
            ),
            'view_changes' => array(
                'permissions' => 'view_file_changes',
            ),
            'update_status' => array(
                'param_permissions' => array(
                    'table' => array(
                        'categories' => 'manage_categories',
                        'states' => 'manage_locations',
                        'usergroups' => 'manage_usergroups',
                        'currencies' => 'manage_currencies',
                        'blocks' => 'edit_blocks',
                        'pages' => 'manage_pages',
                        'taxes' => 'manage_taxes',
                        'promotions' => 'manage_promotions',
                        'static_data' => 'manage_static_data',
                        'statistics_reports' => 'manage_reports',
                        'countries' => 'manage_locations',
                        'shippings' => 'manage_shipping',
                        'languages' => 'manage_languages',
                        'sitemap_sections' => 'manage_sitemap',
                        'localizations' => 'manage_locations',
                        'products' => 'manage_products_custom',
                        'destinations' => 'manage_locations',
                        'product_options' => 'manage_product_options',
                        'product_features' => 'manage_product_features',
                        'payments' => 'manage_payments',
                        'product_filters' => 'manage_product_filters',
                        'product_files' => 'manage_catalog',
                        'orders' => 'change_order_status',
                        'template_emails' => 'manage_email_templates',
                        'template_table_columns' => 'manage_document_templates',
                    )
                )
            ),
        )
    ),
    'storage' => array(
        'permissions' => 'manage_storage',
    ),
    'themes' => array(
        'permissions' => 'manage_themes',
    ),
    'email_templates' => array(
        'permissions' => 'manage_email_templates',
    ),
    'documents' => array(
        'permissions' => 'manage_document_templates',
    ),
    'templates' => array(
        'permissions' => 'edit_files'
    ),
    'storefronts' => [
        'permissions' => 'update_settings',
        'modes' => [
            'picker' => [
                'permissions' => true,
            ]
        ],
    ],
    'notification_settings' => [
        'permissions' => 'manage_notification_settings',
    ],
    'sync_data' => [
        'modes' => [
            'manage' => [
                'permissions' => true,
                'condition'   => [
                    'operator' => 'and',
                    'function' => ['fn_check_permission_sync_data'],
                ],
            ]
        ]
    ]
);

$schema['root']['sync_data'] = $schema['sync_data'];

if (Registry::get('config.tweaks.disable_localizations') == true || fn_allowed_for('ULTIMATE:FREE')) {
    $schema['localizations'] = $schema['root']['localizations'] = array(
        'permissions' => 'none',
    );
}

$schema['cities']['modes']['manage'] = array(
    'permissions' => 'manage_cities' 
);

$schema['orders']['modes']['order_approval'] =  array(
    'permissions' => 'approve_order'
);

$schema['orders']['modes']['manage_check_order'] =  array(
    'permissions' => 'manage_check_order'
);

$schema['orders']['modes']['process_approved_order'] =  array(
    'permissions' => 'process_approved_order'
);

$schema['pending_disapproved_orders']['modes']['manage'] =  array(
    'permissions' => 'approve_order'
);

$schema['jmj_products']['modes']['step_manage'] =  array(
    'permissions' => 'step_manage'
);

if($_SESSION['auth']['user_type'] == 'A'){
    $schema['brands']['modes']['manage'] =  array(
        'permissions' => 'manage_brands'
    );
}

$schema['brands']['modes']['product_class'] =  array(
    'permissions' => 'manage_brands'
);

$schema['quotes']['modes']['manage'] =  array(
    'permissions' => 'quotes_manage'
);

$schema['profiles']['modes']['act_as_user'] =  array(
    'permissions' => 'manage_act_as_user'
);

$schema['companies'] = [
    'modes' => [
        'manage' => [
            'permissions' => ['GET' => 'view_vendors', 'POST' => 'manage_vendors'],
        ],
        'add' => [
            'permissions' => 'manage_vendors',
        ],
        'invite' => [
            'permissions' => 'manage_vendors',
        ],
        'invitations' => [
            'permissions' => 'manage_vendors',
        ],
        'm_delete_invitations' => [
            'permissions' => 'manage_vendors',
        ],
        'delete_invitation' => [
            'permissions' => 'manage_vendors',
        ],
        'update' => [
            'permissions' => ['GET' => 'view_vendors', 'POST' => 'manage_vendors'],
        ],
        'get_companies_list' => [
            'permissions' => 'view_vendors',
        ],
        'payouts_m_delete' => [
            'permissions' => 'manage_payouts',
        ],
        'payouts_add' => [
            'permissions' => 'manage_payouts',
        ],
        'payout_delete' => [
            'permissions' => 'manage_payouts',
        ],
        'balance' => [
            'permissions' => 'view_payouts',
        ],
    ],
    'permissions' => 'manage_vendors',
];

$schema['exim']['modes']['export']['param_permissions']['section']['vendors'] = 'view_vendors';
$schema['exim']['modes']['import']['param_permissions']['section']['vendors'] = 'manage_vendors';


return $schema;