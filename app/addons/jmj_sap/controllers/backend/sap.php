<?php

use Tygh\Helpdesk;
use Tygh\Navigation\LastView;
use Tygh\Registry;
use Tygh\Settings;
use Tygh\BlockManager\Layout;
use Tygh\Themes\Styles;
use Tygh\Common\Robots;
use Tygh\Tools\DateTimeHelper;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($mode == 'sap_login') {    
    $curl = curl_init();

    $data = array('CompanyDB'=>'DB_JMJTEST',
              'Password'=>'yash@2004',
              'UserName'=>'manager1');

    $post_data = http_build_query($data);

    curl_setopt_array($curl, array(
      CURLOPT_PORT => "50000",
      CURLOPT_URL => "https://111.93.207.12:50000/b1s/v1/Login",
      //CURLOPT_SSL_VERIFYPEER =>false,
      //CURLOPT_SSL_VERIFYHOST => false,
      CURLOPT_RETURNTRANSFER => true,
      CURLOPT_ENCODING => "",
      CURLOPT_MAXREDIRS => 10,
      CURLOPT_TIMEOUT => 30,
      CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
      CURLOPT_CUSTOMREQUEST => "POST",
      CURLOPT_POSTFIELDS => $post_data,
      CURLOPT_HTTPHEADER => array(
        "cache-control: no-cache"
      ),
    ));

    $response = curl_exec($curl);
    $err = curl_error($curl);

    curl_close($curl);

    if ($err) {
      echo "cURL Error #:" . $err;
    } else {
      echo $response;
    }
    exit;
}


if ($mode == 'get_sap_hsncode') {    
    $response = fn_get_sap_data('Get_HSNCodeList');
    $response = json_decode($response);
    foreach ($response as $key => $value) {
        $val = (array)$value;
        $hsn_id = fn_insert_sap_hsn_code($val['HSNCode']);
    }
    echo 'HSNCode inserted/updated';
    exit;
}

if ($mode == 'get_sap_delivered_cityname') {    
    $response = fn_get_sap_data('Get_DeliverdTo');
    $response = json_decode($response);
    foreach ($response as $key => $value) {
        $val = (array)$value;
        $city_id = fn_insert_sap_cityname($val['CityName']);
    }
    echo 'CityName inserted/updated';
    exit;
}

if ($mode == 'get_sap_branches') {    
    $response = fn_get_sap_data('Get_BPAllocatedBranches');
    $response = json_decode($response);
    foreach ($response as $key => $value) {
        $val = (array)$value;
        $branches_id = fn_insert_sap_branches($val);
    }
    echo 'Allocated Branche inserted/updated';
    exit;
}

if ($mode == 'get_sap_location_cityname') {    
    $response = fn_get_sap_data('Get_Locations');
    $response = json_decode($response);
    foreach ($response as $key => $value) {
        $val = (array)$value;
        $location_id = fn_insert_sap_location($val['Locations']);
    }
    echo 'Locations inserted/updated';
    exit;
}


if ($mode == 'get_sap_marketingperson') {    
    $response = fn_get_sap_data('Get_MarketingPerson');
    $response = json_decode($response);
    $final_response = array();
    
    foreach ($response as $key => $value) {
        $val = (array)$value;
        $branch = $val['Branch'];
        $email = $val['Email'];
        if(empty($email)){
          $val['Email'] = $val['Mobile'].'@jmjain.com';
        }
        $city_id = fn_get_sap_location_id($branch);
        $final_response[$key] = $val;
        $first_name = current(explode(' ', $val['SlpName']));
        $last_name = trim(strstr($val['SlpName']," "));
        $final_response[$key]['location_id'] = $city_id;
        $final_response[$key]['first_name'] = $first_name;
        $final_response[$key]['last_name'] = $last_name;
        $response = fn_create_sap_marketing_person($final_response[$key]);        
    }
    
    echo 'MarketingPerson Inserted/Updated';
    exit;
}

if ($mode == 'get_sap_customer_contact') {    
    $response = fn_get_sap_data('Get_CustomerContact');
    $response = json_decode($response);
    $final_response = array();
    
    foreach ($response as $key => $value) {
        $val = (array)$value;        
        $response = fn_create_sap_user($val);        
    }
    
    echo 'CustomerContact Inserted/Updated';
    exit;
}