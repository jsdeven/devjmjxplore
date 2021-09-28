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

$schema['controllers']['jmj_products'] = array(
    'permissions' => true,
);

$schema['controllers']['pages'] = array(
    'permissions' => false,
);

$schema['controllers']['brands'] = array(
    'permissions' => true,
);

$schema['controllers']['quotes'] = array(
    'permissions' => true,
);

$schema['controllers']['brands']['modes']['product_class'] = array(
    'permissions' => false,
);

return $schema;