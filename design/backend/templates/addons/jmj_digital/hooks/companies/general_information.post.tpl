<style>
    .row {
     display: -ms-flexbox;
     display: flex;
     -ms-flex-wrap: wrap;
     flex-wrap: wrap;
     margin-right: -15px;
     margin-left: -15px;
 }
 .col-md-6 {
     -ms-flex: 0 0 50%;
     flex: 0 0 50%;
     max-width: 50%;
 }
 .subheader {
     margin: 41px 0px 13px 20px;
 }
 
 
 </style>

<div class="control-group">
    <label for="user_type" class="control-label cm-required">{__("location")}:</label>
    <div class="controls">
    <select id="location" name="company_data[location]">
        <option value="0">{__("none")}</option>
        {foreach from=$cities item=city}
            <option value="{$city.id}" {if $city.id == $company_data.location}selected="selected"{/if}>{$city.city}</option>
        {/foreach}    
    </select>
    </div>
</div>




{if $company_additional_data}

   
    <div class="row">
        <div class="col-md-6">
          <div class="form-group">
            {include file="common/subheader.tpl" title=__("company_additional_data")}
            <div class="control-group" style="margin-bottom: 0px;">
                <label for="user_type" class="control-label" style="padding-top: 0px;">{__("firstname")}:</label>
                <div class="controls">
                    {$company_additional_data.firstname}
                </div>
            </div>
            <div class="control-group" style="margin-bottom: 0px;">
                <label for="user_type" class="control-label" style="padding-top: 0px;">{__("lastname")}:</label>
                <div class="controls">
                    {$company_additional_data.lastname}
                </div>
            </div>
            <div class="control-group" style="margin-bottom: 0px;">
                <label for="user_type" class="control-label" style="padding-top: 0px;">{__("phone")}:</label>
                <div class="controls">
                    {$company_additional_data.phone}
                </div>
            </div>
            <div class="control-group" style="margin-bottom: 0px;">
                <label for="user_type" class="control-label" style="padding-top: 0px;">{__("alter_phone")}:</label>
                <div class="controls">
                    {$company_additional_data.phone_2}
                </div>
            </div>
            <div class="control-group" style="margin-bottom: 0px;">
                <label for="user_type" class="control-label" style="padding-top: 0px;">{__("web_site")}:</label>
                <div class="controls">
                    {$company_additional_data.url}
                </div>
            </div>
          </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                {include file="common/subheader.tpl" title=__("company_information")}
                <div class="control-group" style="margin-bottom: 0px;">
                    <label for="user_type" class="control-label" style="padding-top: 0px;">{__("company")}:</label>
                    <div class="controls">
                        {$company_additional_data.company}
                    </div>
                </div>
                
                <div class="control-group" style="margin-bottom: 0px;">
                    <label for="user_type" class="control-label" style="padding-top: 0px;">{__("company_type")}:</label>
                    <div class="controls">
                        {$company_additional_data.company_type}
                    </div>
                </div>
                <div class="control-group" style="margin-bottom: 0px;">
                    <label for="user_type" class="control-label" style="padding-top: 0px;">{__("nature_of_business")}:</label>
                    <div class="controls">
                        {$company_additional_data.nature_of_business}
                    </div>
                </div>
                <div class="control-group" style="margin-bottom: 0px;">
                    <label for="user_type" class="control-label" style="padding-top: 0px;">{__("company_year")}:</label>
                    <div class="controls">
                        {$company_additional_data.company_year}
                    </div>
                </div>
                <div class="control-group" style="margin-bottom: 0px;">
                    <label for="user_type" class="control-label" style="padding-top: 0px;">{__("gstin_number")}:</label>
                    <div class="controls">
                        {$company_additional_data.gstin_number}
                    </div>
                </div>
                <div class="control-group" style="margin-bottom: 0px;">
                    <label for="user_type" class="control-label" style="padding-top: 0px;">{__("pan_number")}:</label>
                    <div class="controls">
                        {$company_additional_data.pan_number}
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
            {include file="common/subheader.tpl" title=__("billing_from")}
            <div class="control-group" style="margin-bottom: 0px;">
                <label for="user_type" class="control-label" style="padding-top: 0px;">{__("b_name")}:</label>
                <div class="controls">
                    {$company_additional_data.b_name}
                </div>
            </div>
            <div class="control-group" style="margin-bottom: 0px;">
                <label for="user_type" class="control-label" style="padding-top: 0px;">{__("b_address")}:</label>
                <div class="controls">
                    {$company_additional_data.b_address}
                </div>
            </div>
        <!--<div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("b_address_2")}:</label>
            <div class="controls">
                {$company_additional_data.b_address_2}
            </div>
        </div>-->
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("b_city")}:</label>
            <div class="controls">
                {$company_additional_data.b_city}
            </div>
        </div>
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("b_state")}:</label>
            <div class="controls">
                {$company_additional_data.b_state}
            </div>
        </div>
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("b_country")}:</label>
            <div class="controls">
                {$company_additional_data.b_country}
            </div>
        </div>
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("b_pincode")}:</label>
            <div class="controls">
                {$company_additional_data.b_pincode}
            </div>
        </div>
        
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("india_zone")}:</label>
            <div class="controls">
                {$company_additional_data.india_zone}
            </div>
        </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="form-group">
            {include file="common/subheader.tpl" title=__("shipping_from")}
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("s_name")}:</label>
            <div class="controls">
                {$company_additional_data.s_name}
            </div>
        </div>
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("s_address")}:</label>
            <div class="controls">
                {$company_additional_data.s_address}
            </div>
        </div>
    <!--<div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("s_address_2")}:</label>
        <div class="controls">
            {$company_additional_data.s_address_2}
        </div>
    </div>-->
    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("s_city")}:</label>
        <div class="controls">
            {$company_additional_data.s_city}
        </div>
    </div>
    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("s_state")}:</label>
        <div class="controls">
            {$company_additional_data.s_state}
        </div>
    </div>
    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("s_country")}:</label>
        <div class="controls">
            {$company_additional_data.s_country}
        </div>
    </div>
    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("s_pincode")}:</label>
        <div class="controls">
            {$company_additional_data.s_pincode}
        </div>
    </div>
    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("gst_type")}:</label>
        <div class="controls">
            {$company_additional_data.gst_type}
        </div>
    </div>
    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("india_zone")}:</label>
        <div class="controls">
            {$company_additional_data.india_zone}
        </div>
    </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-6">
        <div class="form-group">
        {include file="common/subheader.tpl" title=__("brand_and_category")}

    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("brand_1")}:</label>
        <div class="controls">
            {$company_additional_data.brand_1}
        </div>
    </div>
    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("brand_2")}:</label>
        <div class="controls">
            {$company_additional_data.brand_2}
        </div>
    </div>
    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("brand_3")}:</label>
        <div class="controls">
            {$company_additional_data.brand_3}
        </div>
    </div>

    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("categories")}:</label>
        <div class="controls">
            <table border="1">
                <thead>
                    <th>{__("categories")}</th>
                    <th>{__("sub_categories")}</th>
                    <th>{__("sub_sub_categories")}</th>
                    <th>{__("product_range")}</th>
                </thead>
                {foreach from=$company_additional_data.categories item="cat"}
                    <tr>
                        <td>{fn_get_category_name($cat.main_category_id)}</td><td>{fn_get_category_name($cat.sub_category_id)}</td>
                        <td>{fn_get_category_name($cat.sub_sub_category_id)} </td>
                        <td>{$cat.product_range}</td>
                    </tr>
                {/foreach}
            </table>    
        </div>
    </div>

    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("private_label")}:</label>
        <div class="controls">
            {if $company_additional_data.private_label == 'Y'}Yes {else}No{/if}
        </div>
    </div>
    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("average_monthly_production")}:</label>
        <div class="controls">
            {$company_additional_data.average_monthly_production}
        </div>
    </div>


    </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            {include file="common/subheader.tpl" title=__("company_other_info")}
    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("total_emp")}:</label>
        <div class="controls">
            {$company_additional_data.total_emp}
        </div>
    </div>
    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("annual_turnover")}:</label>
        <div class="controls">
            {$company_additional_data.annual_turnover}
        </div>
    </div>
  
    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("company_advantage")}:</label>
        <div class="controls">
            <p>{$company_additional_data.company_advantage}</p>
        </div>
    </div>
    <div class="control-group" style="margin-bottom: 0px;">
        <label for="user_type" class="control-label" style="padding-top: 0px;">{__("main_market_coverage")}:</label>
        <div class="controls">
            {$company_additional_data.main_market_coverage}
        </div>
    </div>
  

    </div>
    </div>
</div>

<div class="row">
    <div class="col-md-6">
        <div class="form-group">
    {include file="common/subheader.tpl" title=__("bank_information")}
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("bank_name")}:</label>
            <div class="controls">
                {$company_additional_data.bank_name}
            </div>
        </div>
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("account_number")}:</label>
            <div class="controls">
                {$company_additional_data.account_number}
            </div>
        </div>
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("ifsc_code")}:</label>
            <div class="controls">
                {$company_additional_data.ifsc_code}
            </div>
        </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            {include file="common/subheader.tpl" title=__("company_documents")}
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("cancel_cheque_copy_image")}:</label>
            <div class="controls">
                {if $company_additional_data.cancel_cheque_copy_image}
                    <a target="_blank" href="images/sellers-additional-data/{$company_additional_data.id}/{$company_additional_data.cancel_cheque_copy_image}">{__('click_to_show')}</a>
                {else}
                    {__('no_image_uploaded')}
                {/if}
            </div>
        </div>
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("company_profile_image")}:</label>
            <div class="controls">
                {if $company_additional_data.company_profile_image}
                    <a target="_blank" href="images/sellers-additional-data/{$company_additional_data.id}/{$company_additional_data.company_profile_image}">{__('click_to_show')}</a>
                {else}
                    {__('no_image_uploaded')}
                {/if}
            </div>
        </div>
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("product_catalogue_image")}:</label>
            <div class="controls">
                {if $company_additional_data.product_catalogue_image}
                    <a target="_blank" href="images/sellers-additional-data/{$company_additional_data.id}/{$company_additional_data.product_catalogue_image}">{__('click_to_show')}</a>
                {else}
                    {__('no_image_uploaded')}
                {/if}
            </div>
        </div>
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("office_front_image")}:</label>
            <div class="controls">
                {if $company_additional_data.office_front_image}
                    <a target="_blank" href="images/sellers-additional-data/{$company_additional_data.id}/{$company_additional_data.office_front_image}">{__('click_to_show')}</a>
                {else}
                    {__('no_image_uploaded')}
                {/if}
            </div>
        </div>
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("office_inside_image")}:</label>
            <div class="controls">
                {if $company_additional_data.office_inside_image}
                    <a target="_blank" href="images/sellers-additional-data/{$company_additional_data.id}/{$company_additional_data.office_inside_image}">{__('click_to_show')}</a>
                {else}
                    {__('no_image_uploaded')}
                {/if}
            </div>
        </div>

        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("owners_logo_image")}:</label>
            <div class="controls">
                {if $company_additional_data.owners_logo_image}
                    <a target="_blank" href="images/sellers-additional-data/{$company_additional_data.id}/{$company_additional_data.owners_logo_image}">{__('click_to_show')}</a>
                {else}
                    {__('no_image_uploaded')}
                {/if}
            </div>
        </div>

        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("owners_pancard_image")}:</label>
            <div class="controls">
                {if $company_additional_data.owners_pancard_image}
                    <a target="_blank" href="images/sellers-additional-data/{$company_additional_data.id}/{$company_additional_data.owners_pancard_image}">{__('click_to_show')}</a>
                {else}
                    {__('no_image_uploaded')}
                {/if}
            </div>
        </div>
        <div class="control-group" style="margin-bottom: 0px;">
            <label for="user_type" class="control-label" style="padding-top: 0px;">{__("gstin_certificate_image")}:</label>
            <div class="controls">
                {if $company_additional_data.gstin_certificate_image}
                    <a target="_blank" href="images/sellers-additional-data/{$company_additional_data.id}/{$company_additional_data.gstin_certificate_image}">{__('click_to_show')}</a>
                {else}
                    {__('no_image_uploaded')}
                {/if}
            </div>
        </div>
        </div>
    </div>
</div>
{/if}   