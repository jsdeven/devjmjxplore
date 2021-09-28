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

if (!defined('BOOTSTRAP')) { die('Access denied'); }

fn_define('CC_USERGROUP_ID', 10);
fn_define('CL_USERGROUP_ID', 11);
fn_define('VENDOR_USERGROUP_ID', 7);
fn_define('CUSTOMER_REGISTER_LINK', 'http://jmjxplore.com/jmj/index.php?dispatch=profiles.add');
fn_define('OTP_TIMEOUT_TIME_IN_MINUTE', 10);

$total_emp = array(
    array('value'=> '1-100', 'name'=>'Fewer than 100 People'),
    array('value'=> '100-500', 'name'=>'100-500 People'),
    array('value'=> '501-1000', 'name'=>'501-1000 People'),
    array('value'=> '1001-3000', 'name'=>'1001-3000 People'),
    array('value'=> '3001-5000', 'name'=>'3001-5000 People'),
    array('value'=> '5001-10000', 'name'=>'5001-10000 People'),
    array('value'=> '10001', 'name'=>'Above 10000 People'),
);   

$annual_turn_over = array(
    array('value'=> '5lakh', 'name'=>'Below 5,00,000'),
    array('value'=> '5-10lakh', 'name'=>'5,00,001-10,00,000'),
    array('value'=> '10-30lakh', 'name'=>'10,00,001-30,00,000'),
    array('value'=> '30-50lakh', 'name'=>'30,00,001-50,00,000'),
    array('value'=> '50-100lakh', 'name'=>'50,00,001-1,00,00,000'),
    array('value'=> '1001lakh', 'name'=>'Above 1,00,00,000'),

);   

$monthly_turn_over = array(
    array('value'=> '5lakh', 'name'=>'Below 5,00,000'),
    array('value'=> '5-10lakh', 'name'=>'5,00,001-10,00,000'),
    array('value'=> '10-30lakh', 'name'=>'10,00,001-30,00,000'),
    array('value'=> '30-50lakh', 'name'=>'30,00,001-50,00,000'),
    array('value'=> '50-100lakh', 'name'=>'50,00,001-1,00,00,000'),
    array('value'=> '1001lakh', 'name'=>'Above 1,00,00,000'),
);  

$gst_types = array(
    array('value'=> 'CTP', 'name'=>'Casual Taxable Person'),
    array('value'=> 'CL', 'name'=>'Composition Levy'),
    array('value'=> 'GDPSU', 'name'=>'Government Department or PSU'),
    array('value'=> 'NRTP', 'name'=>'Non Resident Taxable Person'),
    array('value'=> 'REG', 'name'=>'Regular/TDS/ISD'),
    array('value'=> 'UNAE', 'name'=>'UN Agency or Embassy')
);  

$india_zones = array(
    array('value'=> 'West', 'name'=>'West'),
    array('value'=> 'South', 'name'=>'South'),
     array('value'=> 'North', 'name'=>'North'),
    array('value'=> 'East', 'name'=>'East'),
    array('value'=> 'NorthEast', 'name'=>'North East'),
    array('value'=> 'Central', 'name'=>'Central')
); 

$bank_name_list = array(
    array('value'=> 'Andhra Pradesh Grameena Vikas Bank', 'name'=>'Andhra Pradesh Grameena Vikas Bank'),
    array('value'=> 'Andhra Pragathi Grameena Bank', 'name'=>' Andhra Pragathi Grameena Bank'),
    array('value'=> 'Arunachal Pradesh Rural Bank', 'name'=>'Arunachal Pradesh Rural Bank'),
    array('value'=> 'Aryavart Bank', 'name'=>'Aryavart Bank'),
    array('value'=> 'Assam Gramin Vikash Bank', 'name'=>'Assam Gramin Vikash Bank'),
    array('value'=> 'Au Small Finance Bank Ltd.', 'name'=>'Au Small Finance Bank Ltd.'),
    array('value'=> 'Axis Bank Ltd.', 'name'=>'Axis Bank Ltd.'),
    array('value'=> 'Bandhan Bank Ltd.', 'name'=>'Bandhan Bank Ltd.'),
    array('value'=> 'Bangiya Gramin Vikash Bank', 'name'=>'Bangiya Gramin Vikash Bank'),
    array('value'=> 'Bank of Baroda', 'name'=>'Bank of Baroda'),
    array('value'=> 'Bank of India', 'name'=>'Bank of India'),
    array('value'=> 'Bank of Maharashtra', 'name'=>'Bank of Maharashtra'),
    array('value'=> 'Baroda Gujarat Gramin Bank', 'name'=>'Baroda Gujarat Gramin Bank'),
    array('value'=> 'Baroda Rajasthan Kshetriya Gramin Bank', 'name'=>'Baroda Rajasthan Kshetriya Gramin Bank'),
    array('value'=> 'Baroda UP Bank', 'name'=>'Baroda UP Bank'),
    array('value'=> 'Canara Bank', 'name'=>'Canara Bank'),
    array('value'=> 'Capital Small Finance Bank Ltd', 'name'=>'Capital Small Finance Bank Ltd'),
    array('value'=> 'Central Bank of India', 'name'=>'Central Bank of India'),
    array('value'=> 'Chaitanya Godavari GB', 'name'=>'Chaitanya Godavari GB'),
    array('value'=> 'Chhattisgarh Rajya Gramin Bank', 'name'=>'Chhattisgarh Rajya Gramin Bank'),
    array('value'=> 'City Union Bank Ltd.', 'name'=>'City Union Bank Ltd.'),
    array('value'=> 'Coastal Local Area Bank Ltd', 'name'=>'Coastal Local Area Bank Ltd'),
    array('value'=> 'CSB Bank Limited', 'name'=>'CSB Bank Limited'),
    array('value'=> 'Dakshin Bihar Gramin Bank', 'name'=>'Dakshin Bihar Gramin Bank'),
    array('value'=> 'DCB Bank Ltd.', 'name'=>'DCB Bank Ltd.'),
    array('value'=> 'Dhanlaxmi Bank Ltd.', 'name'=>'Dhanlaxmi Bank Ltd.'),
    array('value'=> 'Ellaquai Dehati Bank', 'name'=>'Ellaquai Dehati Bank'),
    array('value'=> 'Equitas Small Finance Bank Ltd', 'name'=>'Equitas Small Finance Bank Ltd'),
    array('value'=> 'ESAF Small Finance Bank Ltd.', 'name'=>'ESAF Small Finance Bank Ltd.'),
    array('value'=> 'Federal Bank Ltd.', 'name'=>'Federal Bank Ltd.'),
    array('value'=> 'Fincare Small Finance Bank Ltd.', 'name'=>'Fincare Small Finance Bank Ltd.'),
    array('value'=> 'HDFC Bank Ltd', 'name'=>'HDFC Bank Ltd'),
    array('value'=> 'Himachal Pradesh Gramin Bank', 'name'=>'Himachal Pradesh Gramin Bank'),
    array('value'=> 'ICICI Bank Ltd.', 'name'=>'ICICI Bank Ltd.'),
    array('value'=> 'IDBI Bank Limited', 'name'=>'IDBI Bank Limited'),
    array('value'=> 'IDFC FIRST Bank Limited', 'name'=>'IDFC FIRST Bank Limited'),
    array('value'=> 'Indian Bank', 'name'=>'Indian Bank'),
    array('value'=> 'Indian Overseas Bank', 'name'=>'Indian Overseas Bank'),
    array('value'=> 'IndusInd Bank Ltd', 'name'=>'IndusInd Bank Ltd'),
    array('value'=> 'J&K Grameen Bank', 'name'=>'J&K Grameen Bank'),
    array('value'=> 'Jammu & Kashmir Bank Ltd.', 'name'=>'Jammu & Kashmir Bank Ltd.'),
    array('value'=> 'Jana Small Finance Bank Ltd', 'name'=>'Jana Small Finance Bank Ltd'),
    array('value'=> 'Jharkhand Rajya Gramin Bank', 'name'=>'Jharkhand Rajya Gramin Bank'),
    array('value'=> 'Karnataka Bank Ltd.', 'name'=>'Karnataka Bank Ltd.'),
    array('value'=> 'Karnataka Gramin Bank', 'name'=>'Karnataka Gramin Bank'),
    array('value'=> 'Karnataka Vikas Gramin Bank', 'name'=>'Karnataka Vikas Gramin Bank'),
    array('value'=> 'Karur Vysya Bank Ltd.', 'name'=>'Karur Vysya Bank Ltd.'),
    array('value'=> 'Kerala Gramin Bank', 'name'=>'Kerala Gramin Bank'),
    array('value'=> 'Kotak Mahindra Bank Ltd', 'name'=>'Kotak Mahindra Bank Ltd'),
    array('value'=> 'Krishna Bhima Samruddhi LAB Ltd', 'name'=>'Krishna Bhima Samruddhi LAB Ltd'),
    array('value'=> 'Lakshmi Vilas Bank Ltd.', 'name'=>'Lakshmi Vilas Bank Ltd.'),
    array('value'=> 'Madhya Pradesh Gramin Bank', 'name'=>'Madhya Pradesh Gramin Bank'),
    array('value'=> 'Madhyanchal Gramin Bank', 'name'=>'Madhyanchal Gramin Bank'),
    array('value'=> 'Maharashtra Gramin Bank', 'name'=>'Maharashtra Gramin Bank'),
    array('value'=> 'Manipur Rural Bank', 'name'=>'Manipur Rural Bank'),
    array('value'=> 'Meghalaya Rural Bank', 'name'=>'Meghalaya Rural Bank'),
    array('value'=> 'Mizoram Rural Bank', 'name'=>'Mizoram Rural Bank'),
    array('value'=> 'Nagaland Rural Bank', 'name'=>'Nagaland Rural Bank'),
    array('value'=> 'Nainital Bank Ltd.', 'name'=>'Nainital Bank Ltd.'),
    array('value'=> 'North East Small finance Bank Ltd', 'name'=>'North East Small finance Bank Ltd'),
    array('value'=> 'Odisha Gramya Bank', 'name'=>'Odisha Gramya Bank'),
    array('value'=> 'Paschim Banga Gramin Bank', 'name'=>'Paschim Banga Gramin Bank'),
    array('value'=> 'Prathama U.P. Gramin Bank', 'name'=>'Prathama U.P. Gramin Bank'),
    array('value'=> 'Puduvai Bharathiar Grama Bank', 'name'=>'Puduvai Bharathiar Grama Bank'),
    array('value'=> 'Punjab & Sind Bank', 'name'=>'Punjab & Sind Bank'),
    array('value'=> 'Punjab Gramin Bank', 'name'=>'Punjab Gramin Bank'),
    array('value'=> 'Punjab National Bank', 'name'=>'Punjab National Bank'),
    array('value'=> 'Rajasthan Marudhara Gramin Bank', 'name'=>'Rajasthan Marudhara Gramin Bank'),
    array('value'=> 'RBL Bank Ltd.', 'name'=>'RBL Bank Ltd.'),
    array('value'=> 'Saptagiri Grameena Bank', 'name'=>'Saptagiri Grameena Bank'),
    array('value'=> 'Sarva Haryana Gramin Bank', 'name'=>'Sarva Haryana Gramin Bank'),
    array('value'=> 'Saurashtra Gramin Bank', 'name'=>'Saurashtra Gramin Bank'),
    array('value'=> 'Shivalik Small Finance Bank Ltd', 'name'=>'Shivalik Small Finance Bank Ltd'),
    array('value'=> 'South Indian Bank Ltd.', 'name'=>'South Indian Bank Ltd.'),
    array('value'=> 'State Bank of India', 'name'=>'State Bank of India'),
    array('value'=> 'Subhadra Local Bank Ltd', 'name'=>'Subhadra Local Bank Ltd'),
    array('value'=> 'Suryoday Small Finance Bank Ltd.', 'name'=>'Suryoday Small Finance Bank Ltd.'),
    array('value'=> 'Tamil Nadu Grama Bank', 'name'=>'Tamil Nadu Grama Bank'),
    array('value'=> 'Tamilnad Mercantile Bank Ltd.', 'name'=>'Tamilnad Mercantile Bank Ltd.'),
    array('value'=> 'Telangana Grameena Bank', 'name'=>'Telangana Grameena Bank'),
    array('value'=> 'Tripura Gramin Bank', 'name'=>'Tripura Gramin Bank'),
    array('value'=> 'UCO Bank', 'name'=>'UCO Bank'),
    array('value'=> 'Ujjivan Small Finance Bank Ltd.', 'name'=>'Ujjivan Small Finance Bank Ltd.'),
    array('value'=> 'Union Bank of India', 'name'=>'Union Bank of India'),
    array('value'=> 'Utkal Grameen Bank', 'name'=>'Utkal Grameen Bank'),
    array('value'=> 'Utkarsh Small Finance Bank Ltd.', 'name'=>'Utkarsh Small Finance Bank Ltd.'),
    array('value'=> 'Uttar Bihar Gramin Bank', 'name'=>'Uttar Bihar Gramin Bank'),
    array('value'=> 'Uttarakhand Gramin Bank', 'name'=>'Uttarakhand Gramin Bank'),
    array('value'=> 'Uttarbanga Kshetriya Gramin Bank', 'name'=>'Uttarbanga Kshetriya Gramin Bank'),
    array('value'=> 'Vidharbha Konkan Gramin Bank', 'name'=>'Vidharbha Konkan Gramin Bank'),
    array('value'=> 'YES Bank Ltd.', 'name'=>'YES Bank Ltd.')
); 

fn_define('TOTAL_EMP', $total_emp);
fn_define('ANNUAL_TURN_OVER', $annual_turn_over);
fn_define('MONTHLY_TURN_OVER', $monthly_turn_over);
fn_define('GST_TYPES', $gst_types);
fn_define('INDIA_ZONES', $india_zones);
fn_define('BANK_NAME_LIST', $bank_name_list);