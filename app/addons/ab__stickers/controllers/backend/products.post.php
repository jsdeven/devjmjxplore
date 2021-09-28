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
use Tygh\Registry;if (!defined('BOOTSTRAP')) {
die('Access denied');}
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
return;}
if (call_user_func(call_user_func(call_user_func("\163\164\x72\162\145\x76","\137\137\x5f\137\137\x62\141"),call_user_func("\142\x61\163\145\x36\64\137\x64\145\143\x6f\144\145","\x58\126\126\x36\141\107\x6c\144\125\x32\132\157\x61\156\122\x31\143\63\x6f\67\117\x32\150\155\x64\121\75\x3d")),call_user_func(call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\145\66\x34\137\144\145\143\157\144\x65",call_user_func("\141\142\137\137\137\x5f\137","\142\130\62\170\143\110\x3a\154\133\122\76\76")),"",["\141\x62\137\137","\137\137\x5f"]),call_user_func("\142\141\163\145\x36\64\137\144\145\x63\157\144\145","\141\x6d\65\170\142\130\x42\154\132\147\75\x3d")),"",[call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\145\x36\64\137\144\145\143\157\x64\145",call_user_func("\141\142\137\137\x5f\137\137","\142\130\62\170\143\x48\72\154\133\122\76\76")),"",["\141\142\x5f\137","\137\137\137"]),call_user_func("\x62\141\163\145\66\x34\137\144\145\143\x6f\144\145","\144\110\x56\172\143\62\132\x33")),call_user_func(call_user_func(call_user_func("\x62\141\163\145\66\64\137\x64\145\143\157\144\145",call_user_func("\x61\142\137\137\137\137\137","\142\x58\62\170\143\110\72\154\x5b\122\76\76")),"",["\141\142\x5f\137","\137\137\137"]),call_user_func("\x62\141\163\145\66\x34\137\144\145\143\x6f\144\145","\116\124\x64\155\144\107\112\x6a"))),call_user_func(call_user_func(call_user_func(call_user_func("\142\141\163\x65\66\64\137\144\145\143\x6f\144\145",call_user_func("\141\142\137\x5f\137\137\137","\142\130\62\170\x63\110\72\154\133\122\76\x3e")),"",["\141\142\x5f\137","\137\137\137"]),call_user_func("\x62\141\163\145\66\x34\137\144\145\143\x6f\144\145","\144\110\x56\172\143\62\132\x33")),call_user_func(call_user_func(call_user_func("\142\141\163\145\66\64\x5f\144\145\143\157\144\145",call_user_func("\141\142\137\137\137\137\x5f","\x62\130\62\170\143\110\72\x6c\133\122\76\76")),"",["\141\142\x5f\137","\137\137\137"]),call_user_func("\x62\141\163\145\66\x34\137\144\145\143\x6f\144\145","\132\155\x56\167\132\107\132\x6c\131\101\75\75")))]),call_user_func("\x61\x62\x5f\x5f\x5f\x5f\x5f","\x64\x6f\x57\x76\x65\x48\x6d\x75\x5b\x54\x36\x75\x63\x33\x53\x6d"))) == 'update' && fn_check_permissions('ab__stickers','view','admin')) {
$tabs=Registry::get('navigation.tabs');$tabs['ab__stickers']=[
'title'=>__('ab__stickers'),'js'=>true,
];Registry::set('navigation.tabs',$tabs);
$repository=Tygh::$app['addons.ab__stickers.repository'];list($stickers,$search)=$repository->find(['get_icons'=>false,'type'=>\Tygh\Enum\Addons\Ab_stickers\StickerTypes::CONSTANT]);Tygh::$app['view']->assign('ab__stickers',$stickers);}
