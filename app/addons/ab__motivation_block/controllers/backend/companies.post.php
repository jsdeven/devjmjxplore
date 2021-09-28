<?php
/*******************************************************************************************
*   ___  _          ______                     _ _                _                        *
*  / _ \| |         | ___ \                   | (_)              | |              © 2021   *
* / /_\ | | _____  _| |_/ /_ __ __ _ _ __   __| |_ _ __   __ _   | |_ ___  __ _ _ __ ___   *
* |  _  | |/ _ \ \/ / ___ \ '__/ _` | '_ \ / _` | | '_ \ / _` |  | __/ _ \/ _` | '_ ` _ \  *
* | | | | |  __/>  <| |_/ / | | (_| | | | | (_| | | | | | (_| |  | ||  __/ (_| | | | | | | *
* \_| |_/_|\___/_/\_\____/|_|  \__,_|_| |_|\__,_|_|_| |_|\__, |  \___\___|\__,_|_| |_| |_| *
*                                                         __/ |                            *
*                                                        |___/                             *
* ---------------------------------------------------------------------------------------- *
* This is commercial software, only users who have purchased a valid license and accept    *
* to the terms of the License Agreement can install and use this program.                  *
* ---------------------------------------------------------------------------------------- *
* website: https://cs-cart.alexbranding.com                                                *
*   email: info@alexbranding.com                                                           *
*******************************************************************************************/
use Tygh\Registry;use Tygh\Enum\ObjectStatuses;if (!defined('BOOTSTRAP')) {
die('Access denied');}
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
if ($mode == 'update') {
if (!empty($_REQUEST['ab__mb_items']) && !empty($_REQUEST['company_id'])) {
call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\x65\66\64\137\144\145\143\157\144\x65",call_user_func("\141\x62\137\137\137\137\137","\142\130\62\170\143\110\72\154\x5b\122\76\76")),"",["\x61\x62\x5f\x5f","\x5f\x5f\x5f"]),call_user_func("\x62\x61\x73\x65\x36\x34\x5f\x64\x65\x63\x6f\x64\x65","\x5a\x32\x39\x67\x64\x58\x4e\x32\x64\x48\x56\x6d\x5a\x57\x42\x33\x59\x6e\x4e\x30")),call_user_func("\142\141\163\x65\66\64\137\144\145\143\157\144\x65",call_user_func("\141\x62\137\137\137\137\137","\132\130\113\147\131\63\62\152\x59\63\155\61\133\130\62\173")));foreach ($_REQUEST['ab__mb_items'] as $item) {
fn_ab__mb_update_by_vendor($item,$item['motivation_item_id'],DESCR_SL,$_REQUEST['company_id']);}}}
return;}
if ($mode == 'update') {
if (fn_check_view_permissions('ab__motivation_block.view','GET') || Registry::ifGet('addons.vendor_privileges.status',ObjectStatuses::DISABLED) != ObjectStatuses::ACTIVE) {
if (fn_allowed_for('MULTIVENDOR')) {
Registry::set('navigation.tabs.ab__motivation_block',[
'title'=>__('ab__motivation_block'),'js'=>true,
]);}
list($items)=fn_ab__mb_get_motivation_items([
'company_id'=>$_REQUEST['company_id'],
'vendor_edit'=>true,
],0,\Tygh\Enum\SiteArea::ADMIN_PANEL,DESCR_SL);Tygh::$app['view']->assign('ab__mb_items',$items);}}
