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

use Tygh\BlockManager\Block;
use Tygh\BlockManager\ProductTabs;
use Tygh\Enum\SiteArea;
use Tygh\Enum\YesNo;
use Tygh\Languages\Languages;
use Tygh\Registry;
use Tygh\Storefront\Storefront;

function fn_get_sap_data($url_suffix){
    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => SAP_URL_PREFIX.$url_suffix,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "GET",
        CURLOPT_HTTPHEADER => array(
            "cache-control: no-cache"
        ),
    ));

    $response = curl_exec($curl);
    $err = curl_error($curl);
    curl_close($curl);

    if ($err) {
      echo "cURL Error #:" . $err;exit;
    } else {
        return $response;
    }
}
function fn_insert_sap_hsn_code($hsncode){
    $exist_hsn = db_get_field("SELECT hsn_number FROM ?:hsn_numbers WHERE hsn_number = ?i", $hsncode);
    $hsn_id = 1;//for true value only
    if(empty($exist_hsn)){
        $hsn_id = db_query("INSERT INTO ?:hsn_numbers SET hsn_number=?i", $hsncode);
    }
    return $hsn_id;
}
function fn_insert_sap_cityname($cityname){
    $exist_hsn = db_get_field("SELECT city FROM ?:sap_delivered WHERE city = '".$cityname."'");
    $id = 1;//for true value only
    if(empty($exist_hsn)){
        $hsn_id = db_query("INSERT INTO ?:sap_delivered SET city='$cityname' , status='A', created_at='".date("Y-m-d H:i:s")."'");
    }
    return $hsn_id;
}
function fn_insert_sap_branches($branches){    
    $record_id = db_get_field("SELECT id FROM ?:sap_branches WHERE location= '".$branches['Location']."' AND cardcode = '".$branches['CardCode']."'");
    $data = array(
        'cardcode' => $branches['CardCode'],
        'checked' => $branches['Checked'],
        'location' => $branches['Location'],
        'slipcode' => $branches['SlpCode'],
        'slpname' => $branches['SlpName'],
        'contactno' => $branches['ContactNo'],
        'created_at' => date("Y-m-d H:i:s"),
    );
    if(empty($record_id)){        
        $record_id = db_query("INSERT INTO ?:sap_branches ?e", $data);
    }else{
        db_query("UPDATE ?:sap_branches SET ?u WHERE id = ?i", $data, $record_id);
    }
    return $record_id;
}

function fn_insert_sap_location($location){
    $exist = db_get_field("SELECT city FROM ?:cities WHERE city = '".$location."'");
    $hsn_id = 1;//for true value only
    if(empty($exist)){
        $hsn_id = db_query("INSERT INTO ?:cities SET city='$location' , status='A', created_at='".date("Y-m-d H:i:s")."'");
    }
    return $hsn_id;
}

function fn_get_sap_location_id($location){
    $city_id = db_get_field("SELECT id FROM ?:cities WHERE city = '".trim($location)."'");
    return $city_id;
}

function fn_create_sap_marketing_person($datas){
    $user_code = db_get_field("SELECT user_code FROM ?:users WHERE user_code = '".$datas['SlpCode']."'");
    $salt = fn_generate_salt();
    $password = fn_generate_salted_password(fn_generate_password(), $salt);
    $data = array(
        'status' => 'A',
        'user_type' => 'A',
        'is_root' => 'N',
        'password' => $password,
        'salt' => $salt,
        'firstname' => $datas['first_name'],
        'lastname' => $datas['last_name'],
        'company' => 'Jmjain',
        'email' => $datas['Email'],
        'user_code' => $datas['SlpCode'],
        'phone' => $datas['Mobile'],
        'location' => $datas['location_id'],
    );
    
    if(empty($user_code)){        
        $user_id = db_query("INSERT INTO ?:users ?e", $data);
    }else{
        unset($data['status']);
        db_query("UPDATE ?:users SET ?u WHERE user_code = ?i", $data, $user_code);
    }
    $user_id = db_get_field("SELECT user_id FROM ?:users WHERE user_code = '".$datas['SlpCode']."'");
    db_query("UPDATE ?:users SET user_login='user_$user_id' WHERE user_id = ?i", $user_id);
    //profile check
    

    $profile_id = db_get_field("SELECT profile_id FROM ?:user_profiles WHERE user_id = '".$user_id."'");
    $profile_data = array(        
        'user_id' => $user_id,
        'profile_type' => 'P',
        'profile_name' => 'Main',
    );
    if(empty($profile_id)){        
        $profile_id = db_query("INSERT INTO ?:user_profiles ?e", $profile_data);
    }else{
        db_query("UPDATE ?:user_profiles SET ?u WHERE profile_id = ?i", $profile_data, $profile_id);
    }
    //assigning priviledge as marketing 8
    $link_id = db_get_field("SELECT link_id FROM ?:usergroup_links WHERE user_id = '".$user_id."'");
    $link_data = array(        
        'user_id' => $user_id,
        'usergroup_id' => '8',
        'status' => 'A',
    );
    if(empty($link_id)){        
        $link_id = db_query("INSERT INTO ?:usergroup_links ?e", $link_data);
    }else{
        db_query("UPDATE ?:usergroup_links SET ?u WHERE link_id = ?i", $link_data, $link_id);
    }
    return $user_id;
}

function fn_create_sap_user($user_data){
    
    $user_code = $user_data['CardCode'];
    $phone = $user_data['Cellolar'];
    $email = $user_data['EmailId'];
    $user_type = substr($user_code,0,1);

    $response = fn_get_sap_data('Get_BPAllocatedBranches?strBPCode='.$user_code);
    $allocated_branches = json_decode($response);
    $location_array = array();
    foreach ($allocated_branches as $key => $value){
        $val = (array)$value;
        $location_array[] = $val['Location'];
    }
    $locations = implode("','", $location_array);
    $location_id = db_get_field("SELECT GROUP_CONCAT(id) as id FROM `jmj_cities` WHERE CITY IN ('$locations')");

    //getting address
    $response = fn_get_sap_data('Get_BPAddress?strBPCode='.$user_code);
    $bill_ship_address = json_decode($response);
    foreach ($bill_ship_address as $key => $value) {
        $values = (array)$value;
        if ($values['AdresType'] == 'B') {
            $address = $values['Address'];
            $first_name = current(explode(' ', $address));
            $last_name = trim(strstr($address," "));
            break;
        }
    }    

    //processing user data now
    $is_root = 'N';
    if($user_type == 'V') {
        $is_root = 'Y';
    }
    $user_id = db_get_field("SELECT user_id FROM ?:users WHERE user_code = '".$user_code."'");
    $salt = fn_generate_salt();
    $password = fn_generate_salted_password(fn_generate_password(), $salt);
    $data = array(
        'status' => 'D',
        'user_type' => $user_type,
        'is_root' => $is_root,
        'password' => $password,
        'salt' => $salt,
        'firstname' => $first_name,
        'lastname' => $last_name,
        'company' => $address,
        'email' => $email,
        'user_code' => $user_code,
        'phone' => $phone,
        'location' => $location_id,
    );
    $company_name = $address;

    if(empty($user_id)){        
        $user_id = db_query("INSERT INTO ?:users ?e", $data);
    }else{
        unset($data['status']);
        db_query("UPDATE ?:users SET ?u WHERE user_id = ?i", $data, $user_id);
    }
    //update user_login field
    db_query("UPDATE ?:users SET user_login='user_$user_id' WHERE user_id = ?i", $user_id);

    
    foreach ($bill_ship_address as $key => $value) {
        $address = (array)$value;
        if($address['AdresType']=='B'){
            $profile_name = 'Main';
            $profile_type = 'P';
            $company_address = $address['Block'].' '.$address['Street'];
            $company_city = $address['City'];
            $company_state = $address['State'];
            $company_country = $address['Country'];
            $company_zipcode = $address['ZipCode'];
        }else{
            $profile_name = 'Profile '.($key+1);
            $profile_type = 'S';
        }

        $ZipCode = $address['ZipCode'];
        $GSTRegnNo = $address['GSTRegnNo'];

        $profile_data = array(        
            'user_id' => $user_id,
            'profile_type' => $profile_type,
            'b_address' => $address['Address'],
            'b_address_2' => $address['Block'].' '.$address['Street'],
            'b_city' => $address['City'],
            'b_state' => $address['State'],
            'b_country' => $address['Country'],
            'b_zipcode' => $address['Country'],
            'b_phone' => $phone,
            's_address' => $address['Address'],
            's_address_2' => $address['Block'].' '.$address['Street'],
            's_city' => $address['City'],
            's_state' => $address['State'],
            's_country' => $address['Country'],
            's_zipcode' => $address['Country'],
            'profile_name' => $profile_name,
        );
        $profile_id = db_query("INSERT INTO ?:user_profiles ?e", $profile_data);
    }

    if($user_type == 'V'){
        //assigning priviledge as vendor 7
        $link_id = db_get_field("SELECT link_id FROM ?:usergroup_links WHERE user_id = '".$user_id."'");
        $link_data = array(        
            'user_id' => $user_id,
            'usergroup_id' => '7',
            'status' => 'A',
        );
        if(empty($link_id)){        
            $link_id = db_query("INSERT INTO ?:usergroup_links ?e", $link_data);
        }else{
            db_query("UPDATE ?:usergroup_links SET ?u WHERE link_id = ?i", $link_data, $link_id);
        }
        //creation/updation of company
        $company_id = db_get_field("SELECT company_id FROM ?:users WHERE user_id = '".$user_id."'");
        if(empty($company_id)){

            $company_data = array(
                'status' => 'A',
                'company' => $company_name,
                'lang_code' => 'en',
                'email' => $email,
                'phone' => $phone,
                'address' => $company_address,
                'city' => $company_city,
                'state' => $company_state,
                'country' => $company_country,
                'zipcode' => $company_zipcode,              
            );
            $company_id = db_query("INSERT INTO ?:companies ?e", $company_data);
            //update company_id field
            db_query("UPDATE ?:users SET company_id='$company_id' WHERE user_id = ?i", $user_id);
        }        
    }
}

function fn_jmj_sap_login_user_pre($user_id, $udata, $auth, $condition)
{
    //update user billing and shiipping address here if user found in sap
}