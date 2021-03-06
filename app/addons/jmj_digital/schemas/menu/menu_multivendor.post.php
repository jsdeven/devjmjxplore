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

use Tygh\Enum\Addons\VendorDataPremoderation\ProductStatuses;
use Tygh\Enum\UserTypes;
use Tygh\Enum\VendorStatuses;
use Tygh\Registry;

defined('BOOTSTRAP') or die('Access denied');

/** @var array $schema */

if (Tygh::$app['session']['auth']['user_type'] === UserTypes::ADMIN) {
    
    $schema['central']['vendors']['items']['vendor_brands'] = [
        'href' => 'brands.manage',
        'position' => 300,
        'alt' => 'brands.manage',
        'description' => 'brands',
    ];
    

} else {
    
     $schema['central']['vendors']['items']['vendor_brands'] = [
        'href' => 'brands.manage',
        'position' => 300,
        'alt' => 'brands.manage',
        'description' => 'brands',
    ];
   
}

return $schema;
