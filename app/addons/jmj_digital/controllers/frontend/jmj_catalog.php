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

use Tygh\BlockManager\SchemesManager;
use Tygh\Enum\NotificationSeverity;
use Tygh\Enum\ProductFeatures;
use Tygh\Enum\ProductTracking;
use Tygh\Registry;
use Tygh\Tools\Url;

use Tygh\Addons\ProductVariations\ServiceProvider;
use Tygh\Addons\ProductVariations\Product\FeaturePurposes;
use Tygh\Addons\ProductVariations\Product\Group\GroupFeature;
use Tygh\Addons\ProductVariations\Product\Group\GroupFeatureCollection;
use Tygh\Addons\ProductVariations\Product\Type\Type;
use Illuminate\Support\Collection;


if (!defined('BOOTSTRAP')) { die('Access denied'); }

/** @var array $cart */
$cart = &Tygh::$app['session']['cart'];

$_REQUEST['product_id'] = empty($_REQUEST['product_id']) ? 0 : $_REQUEST['product_id'];

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $return_url = '';

    //
    // change customer location
    //

    if ($mode == 'change_location') {

        $return_url = '';
        if(isset($_REQUEST['location']) && !empty($_REQUEST['location'])){
            $_SESSION['location_id'] = $_REQUEST['location'];
        }else{
            unset($_SESSION['location_id']);
        }

        fn_calculate_cart_content($cart, $auth, 'E', true, 'F', true);

        if(isset($_REQUEST['return_url']) && !empty($_REQUEST['return_url'])){
            $return_url = $_REQUEST['return_url'];
        }
        
        return array(CONTROLLER_STATUS_REDIRECT, fn_url($return_url));
        
    }
}

