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
$user_type = $_SESSION['auth']['user_type'];


$schema['central']['vendors']['items']['locations'] = [
    'href' => 'cities.manage',
    'position' => 300,
    'alt' => 'cities.manage',
    'description' => 'cities',
];

/** Start Swati Coding for More then 2-3 days pending order in approval list  **/

$schema['central']['orders']['items']['pending_disapproved_orders'] = array(
    'href' => 'pending_disapproved_orders.manage',
    'position' => 600,
    'description' => 'pending_disapproved_orders',
);

$schema['central']['products'] = [
            'title' => __('products_menu_title'),
    'items' => [
        'categories' => [
            'href' => 'categories.manage',
            'position' => 100,
        ],
        'products' => [
            'href' => 'products.manage',
            'alt' => 'product_options.inventory,product_options.exceptions,products.update,products.m_update,products.add',
            'position' => 200,
        ],
        'filters' => [
            'href' => 'product_filters.manage',
            'position' => 400,
        ],
        'options' => [
            'href' => 'product_options.manage',
            'position' => 500,
        ],
    ],
    'position' => 200,
];

if($_SESSION['auth']['user_type'] != 'V'){
    $schema['central']['products']['items']['features'] = array(
        'href' => 'product_features.manage',
        'position' => 300
    );
 
}

/** End Swati Coding for More then 2-3 days pending order in approval list  **/

$schema['central']['products']['items']['product_steps'] = array(
    'href' => 'jmj_products.step_manage',
    'position' => 600,
    'description' => 'products_step_manage',
);

$schema['central']['products']['items']['products_error_in_full_desc'] = array(
    'href' => 'products.manage&error_in_full_desc=Y',
    'position' => 600,
    'description' => 'products_manage',
);
/*
$schema['central']['products']['items']['manage_quotes'] = array(        
    'href' => 'quotes.manage',
    'position' => 600,
);
*/

$schema['central']['vendors']['items']['brand_product_class'] = array(
    'href' => 'brands.product_class',
    'position' => 300,
);

 $schema['top']['administration']['items']['shippings_taxes']['subitems']['states'] = array(
'href' => 'new_states.manage',
'position' => 400,
'description' => 'states with zone',
 );
 
return $schema;
