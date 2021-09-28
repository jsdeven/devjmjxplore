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

defined('BOOTSTRAP') or die('Access denied');

fn_register_hooks(
    'update_category_pre',
    'get_category_data_post',
    'update_category_post',
    'update_product_feature_post',
    'get_product_feature_data_post',
    'get_product_features_post',
    'update_user_pre',
    'get_user_info',
    'get_products',
    'update_product_prices',
    'get_product_data_post',
    'get_orders',
    'get_order_info',
    'get_product_data',
    'get_cart_product_data',
    'pre_place_order',
    'update_product_pre',
    'pre_delete_user',
    'delete_company_pre'
);

