<style>
    #remove1{
        margin-left: 0px!important;
    }
    .btn-danger{
        color:red;
    }
</style>
{if $brand_data.id}
    {assign var="id" value=$brand_data.id}
{else}
    {assign var="id" value=0}
{/if}


{include file="views/profiles/components/profiles_scripts.tpl"}

{capture name="mainbox"}

{capture name="tabsbox"}
{** /Item menu section **}

<form class="form-horizontal form-edit {$form_class} {if !fn_check_view_permissions("brands.update", "POST")}cm-hide-inputs{/if} {if !$id}cm-comet cm-disable-check-changes{/if}" action="{""|fn_url}" method="post" id="brands_update_form" enctype="multipart/form-data"> {* departments update form *}
{* class=""*}
<input type="hidden" name="fake" value="1" />
<input type="hidden" name="selected_section" id="selected_section" value="{$smarty.request.selected_section}" />
<input type="hidden" name="id" value="{$id}" />

{** General info section **}
<div id="content_detailed" class="hidden"> {* content detailed *}
<fieldset>


{include file="common/subheader.tpl" title=__("information")}

{hook name="cities:general_information"}

<div class="control-group">
    <label class="control-label cm-required" for="elm_city_name">Brand Name:</label>
    <div class="controls">{if $brand_data.status == "A"}{$brand_data.brand}{else}
        <input type="text" class="input-large" name="brand_data[brand]" id="elm_brand_name" size="32" value="{$brand_data.brand}" required="" />
    {/if}
    </div>
</div>   
<div class="control-group"> 
    <label class="control-label cm-required">Brand Logo:</label>
    <div class="controls">
        {if $brand_data.status != "A"}
            <input type="file" name="logo" required="" />
        {/if}
        {if $brand_data.logo}
            <a href="images/brands/{$brand_data.logo}" target="_blank">View Logo</a>
        {/if}    
    </div>
</div>
<div class="control-group">    
    <label class="control-label" for="elm_city_name">Brand Website Link:</label>
    <div class="controls">
        {if $brand_data.status == "A"}
            {if $brand_data.link}
                {$brand_data.link}
            {else}
                {__('no_link_provided')}
            {/if}
        {else}
            <input type="url" class="input-large" name="brand_data[link]" id="elm_brand_link" size="32" value="{$brand_data.link}" />
        {/if}
    </div>
</div>
<div class="control-group">    
    <label class="control-label cm-required" for="elm_city_name">{__('brand_relationship')}:</label>
    <div class="controls">
        <div class="radio">
            <input id="radio-1" name="brand_data[owner]" type="radio" value="1" {if $brand_data.owner == '1'}checked{/if}>
            <label for="radio-1" class="radio-label">I manufacture the product and own the brand.</label>
        </div>

        <div class="radio">
            <input id="radio-2" name="brand_data[owner]" type="radio" value="0" {if $brand_data.owner == '0'}checked{/if}>
            <label  for="radio-2" class="radio-label">I am authorised by the brand owner to manage the product information for their branded product on JMJXplore.</label>
        </div>
    </div>
</div>
<div class="control-group">
    <label class="control-label cm-required" for="elm_city_name">Brand Document:</label>
    <div class="controls">
        {if $brand_data.status != "A"}
            <input type="file" class="input-large" name="doc" id="elm_brand_logo" size="32" required="" />(Upload any of the following brand authenticity  document ( Trademark Certificate Brand Authorisation certificate))
        {/if}
        {if $brand_data.doc}
            <a href="images/brands/{$brand_data.doc}" target="_blank">View Doc</a>
        {/if}
    </div>
</div>
<div class="control-group">
    <label class="control-label cm-required" for="elm_city_name">{__('brand_reg_class')}:</label>
    <div class="controls">
        {if $brand_data.status == "A"}
            {if $brand_data.brand_reg_class} {$brand_data.brand_reg_class}{else}{__('no_class_selected')}{/if}
        {else}

            <select name="brand_data[brand_reg_class]" id="brand_reg_class">
                <option value="">{__('choose_brand_class')}</option>
                {foreach from=$brand_classes item=brand_class}
                    <option value="{$brand_class}" {if $brand_data.brand_reg_class="$brand_class"}selected{/if}>{$brand_class}</option>
                {/foreach}          
            </select>
        {/if}
    </div>
</div>
<div class="control-group">    
    <label class="control-label cm-required" for="elm_city_name">{__('brand_product_details')}:</label>
    <div class="controls">
        {if $brand_data.product_detail}
            {assign var="product_details" value=fn_get_product_details($brand_data.product_detail)}
        {/if}
        {if $brand_data.status == "A"}
            {if $brand_data.product_detail} {$product_details}{else}{__('no_product_details_selected')}{/if}
        {else}
            <select name="brand_data[product_detail]" id="product_details">
                <option value="">{__('choose_product_details')}</option>
                {if $brand_data.product_detail}
                    <option value="{$brand_data.product_detail}" selected>{$product_details}</option>
                {/if}    
            </select>
        {/if}
    </div>
</div>    

</div>

{if "MULTIVENDOR"|fn_allowed_for}
    {if !$brand_data.id}
        <div class="control-group">
            <label class="control-label cm-required">Status:</label>
            <div class="controls">
                <label class="radio inline" for="brand_data_0_a"><input type="radio" name="brand_data[status]" id="brand_data_0_a" checked="checked" value="P">Pending</label>
            </div>
        </div>
    {else}
        <div class="control-group">
            <label class="control-label">{__("status")}:</label>
            <div class="controls">
                <label class="radio"><input type="radio" checked="checked" />{if $brand_data.status == "A"}{__("active")}{elseif $brand_data.status == "P"}{__("pending")}{elseif $brand_data.status == "N"}{__("new")}{elseif $brand_data.status == "D"}{__("disabled")}{/if}</label>
            </div>
        </div>
    {/if}

   
{/if}


{/hook}

</fieldset>
</div> {* /content detailed *}
{** /General info section **}



<div id="content_addons" class="hidden">
    {hook name="cities:detailed_content"}{/hook}
</div>

{hook name="cities:tabs_content"}{/hook}

</form> {* /product update form *}

{hook name="cities:tabs_extra"}{/hook}

{/capture}
{include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox group_name="cities" active_tab=$smarty.request.selected_section track=true}

{/capture}



{** Form submit section **}
{capture name="buttons"}
    {if $brand_data.status != "A"}
        {if $is_companies_limit_reached}
            {include file="buttons/save_cancel.tpl" but_meta="btn cm-promo-popup"}
        {else}
            {include file="buttons/save_cancel.tpl" but_name="dispatch[brands.add]" but_target_form="brands_update_form" but_meta="cm-comet"}
        {/if}
    {else}
        
    {/if}
{/capture}
{** /Form submit section **}

{if $id}
    {include file="common/mainbox.tpl"
        title_start="Brand Detail"
        title_end=$brand_data.brand
        content=$smarty.capture.mainbox
        select_languages=true
        buttons=$smarty.capture.buttons
        sidebar=$smarty.capture.sidebar}
{else}
    {include file="common/mainbox.tpl" title="New Brand" content=$smarty.capture.mainbox sidebar=$smarty.capture.sidebar buttons=$smarty.capture.buttons}
{/if}


<script type="text/javascript">

	$('#brand_reg_class').on('change', function(){
		var brand_class = $(this).val();
		var url = "{"brands.brand_class_product_details"|fn_url}";
	
		var data = {
			brand_class: brand_class
		}

		if(brand_class){
			$.ceAjax('request', url, {
			cache: false,
			data:data,
			callback: function(response) {
				var restext = $.parseJSON(response.text);
				if(response){
					$('#product_details').html(restext.str);
				}  
			}
		});
		} 
	});
	
</script>
