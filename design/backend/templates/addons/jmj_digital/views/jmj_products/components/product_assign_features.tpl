{literal}
    <style>
        .feature_image {
            max-width: 100%;
            height: 500px;
            vertical-align: middle;
            border: 0;
            width: 550px;
        }
        #myImg {
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }
        #img_variant_image {
            max-width: 100%;
            height: 580px;
            vertical-align: middle;
            border: 0;
            -ms-interpolation-mode: bicubic;
            width: 900px;
        }
        
    </style>
{/literal}
{script src="js/tygh/backend/select2_color.js"}

{$features_used = []}
{foreach from=$product_features item=feature key="feature_id"}
    
    {$allow_enter_variant = $feature|fn_allow_save_object:"product_features"}

    {if $feature.feature_style == "ProductFeatureStyles::COLOR"|enum || $feature.filter_style == "ProductFilterStyles::COLOR"|enum}
        {$template_type = "color"}
        {$enable_images = false}
        {$template_result_selector = "#template_result_feature_color"}
        {$template_selection_selector = "#template_selection_feature_color"}
        {$template_result_add_selector = "#template_result_add_feature_color"}
        {$features_used[] = "color"}

    {elseif $feature.feature_style == "ProductFeatureStyles::BRAND"|enum}
        {$template_type = "image"}
        {$enable_images = true}
        {$template_result_selector = "#template_result_feature_image"}
        {$template_selection_selector = ""}
        {$template_result_add_selector = "#template_result_add_feature"}
        {$features_used[] = "image"}
    {else}
        {$template_type = ""}
        {$enable_images = false}
        {$template_result_selector = "#template_result_feature"}
        {$template_selection_selector = "#template_selection_feature"}
        {$template_result_add_selector = "#template_result_add_feature"}
    {/if}
   
    {if $feature.feature_type != "ProductFeatures::GROUP"|enum}
        
        {hook name="products:update_product_feature"}
        <div class="control-group" {if $feature.feature_style == "ProductFeatureStyles::BRAND"|enum} style="display:none"{/if}>
            <label class="control-label" for="feature_{$feature_id}">{$feature.description}</label>
            <div class="controls">
            {if $feature.prefix}<span>{$feature.prefix}</span>{/if}

            {if $feature.feature_variant_design == 1 && $feature.feature_style == "ProductFeatureStyles::MULTIPLE_CHECKBOX"|enum}
                <div style="margin-top: 5px;">
                    <span onclick="showPopup({$feature_id});" id="feature_select_button_{$feature_id}" class="feature-select-button">{__('choose_feature')}</span>
                    <span id="selected_variant_type_{$feature_id}" class="selected-feature">{* __('no_feature_choosen') *}</span>                    
                </div>
            {elseif $feature.feature_variant_design == 2 && $feature.feature_type == "ProductFeatures::MULTIPLE_CHECKBOX"|enum}
                <input type="hidden" name="product_data[product_features][{$feature_id}]" value="" />
                <input type="hidden" name="product_data[add_new_variant][{$feature_id}][variant]" id="product_feature_{$feature_id}_add_new_variant" value="" />
                <span onclick="showPopup_febric({$feature_id});" id="feature_select_button_{$feature_id}" class="feature-select-button">{__('choose_feature')}</span>
                <span id="selected_variant_type_{$feature_id}" class="selected-feature">
                    {foreach from=$feature.variants item="variant"}
                        {if $variant.selected} {$variant.variant} &nbsp;<input type="hidden" class="ischeckSelected" name="ischeckSelected" value="{$variant.variant}_{$feature_id}"/>{/if}
                    {/foreach}
                </span>
            {elseif $feature.multi_colors_filter == 1}
                
               <input type="hidden" name="product_data[add_new_variant][{$feature_id}][variant]" id="product_feature_{$feature_id}_add_new_variant" value="" />
                <span onclick="showPopup_color({$feature_id});" id="feature_select_button_{$feature_id}" class="feature-select-button">{__('choose_feature')}</span>
                <span id="selected_color_variant_type_{$feature_id}" class="selected-feature">
                    {foreach from=$feature.variants item="variant"}
                        {if $variant.selected} {$variant.variant} &nbsp;<input type="hidden" class="ischeckSelected" name="ischeckSelected" value="{$variant.variant}_{$feature_id}"/>{/if}
                    {/foreach}
                </span>
                
            {else}
                {if $feature.feature_type == "ProductFeatures::TEXT_SELECTBOX"|enum
                    || $feature.feature_type == "ProductFeatures::NUMBER_SELECTBOX"|enum
                    || $feature.feature_type == "ProductFeatures::EXTENDED"|enum}
                    {assign var="value_selected" value=false}
                    <input type="hidden"
                            name="product_data[product_features][{$feature_id}]"
                            value="{$selected|default:$feature.variant_id}"
                    />
                    <input type="hidden"
                            name="product_data[add_new_variant][{$feature_id}][variant]"
                            id="product_feature_{$feature_id}_add_new_variant"
                            value=""
                    />
                  
                     <div class="object-selector object-selector--mobile-full-width">
                        <select id="feature_{$feature_id}"
                                class="cm-object-selector object-selector--mobile-full-width"
                                name="product_data[product_features][{$feature_id}]"
                                data-ca-enable-images="{$enable_images|default:false}"
                                data-ca-image-width="30"
                                data-ca-image-height="30"
                                data-ca-enable-search="true"
                                data-ca-escape-html="false"
                                data-ca-load-via-ajax="{$feature.use_variant_picker|default:false}"
                                data-ca-page-size="10"
                                data-ca-data-url="{"product_features.get_variants_list?include_empty=Y&feature_id=`$feature_id`&product_id=`$product_id`&lang_code=`$descr_sl`"|fn_url nofilter}"
                                data-ca-placeholder="-{__("none")}-"
                                data-ca-allow-clear="true"
                                data-ca-enable-add="{$select2_enable_add|default:$allow_enter_variant}"
                                data-ca-template-type="{$select2_template_type|default:$template_type}"
                                data-ca-template-result-selector="{$template_result_selector}"
                                data-ca-template-selection-selector="{$template_selection_selector}"
                                data-ca-template-result-add-selector="{$template_result_add_selector}"
                                data-ca-new-value-holder-selector="#product_feature_{$feature_id}_add_new_variant"
                                >
                            <option value="">-{__("none")}-</option>
                            {foreach from=$feature.variants item="variant"}
                                {if $feature.feature_style == "ProductFeatureStyles::COLOR"|enum || $feature.filter_style == "ProductFilterStyles::COLOR"|enum}
                                    <option
                                        value="{$variant.variant_id}"
                                        {if $variant.selected} selected="selected"{/if}
                                        data-ca-feature-color="{$variant.color}"
                                    >{$variant.variant}</option>
                                {else}
                                    <option
                                        value="{$variant.variant_id}"
                                        {if $variant.selected} selected="selected"{/if}
                                    >{$variant.variant}</option>
                                {/if}
                            {/foreach}
                            <option value="">-{__("none")}-</option>
                        </select>
                    </div>
                {elseif $feature.feature_type == "ProductFeatures::MULTIPLE_CHECKBOX"|enum}
                    <div class="object-selector">
                        <select id="feature_{$feature_id}"
                                class="cm-object-selector"
                                name="product_data[product_features][{$feature_id}][]"
                                multiple
                                data-ca-load-via-ajax="{$feature.use_variant_picker|default:false}"
                                data-ca-placeholder="{__("search")}"
                                data-ca-enable-search="true"
                                data-ca-escape-html="false"
                                data-ca-enable-images="true"
                                data-ca-image-width="30"
                                data-ca-image-height="30"
                                data-ca-close-on-select="false"
                                data-ca-page-size="10"
                                data-ca-data-url="{"product_features.get_variants_list?feature_id=`$feature_id`&product_id=`$product_id`&lang_code=`$descr_sl`"|fn_url nofilter}"
                                data-ca-enable-add="{$select2_enable_add|default:$allow_enter_variant}"
                                data-ca-template-type="{$select2_template_type|default:$template_type}"
                                data-ca-template-result-selector="{$template_result_selector}"
                                data-ca-template-selection-selector="{$template_selection_selector}"
                                data-ca-template-result-add-selector="{$template_result_add_selector}"
                                data-ca-new-value-holder-selector="#product_feature_{$feature_id}_add_new_variant"
                                >
                            {foreach from=$feature.variants item="variant"}
                                <option value="{$variant.variant_id}"{if $variant.selected} selected="selected"{/if}>{$variant.variant}</option>
                            {/foreach}
                        </select>
                    </div>
                {elseif $feature.feature_type == "ProductFeatures::SINGLE_CHECKBOX"|enum}
                    <label class="checkbox">
                    <input type="hidden" name="product_data[product_features][{$feature_id}]" value="N" />
                    <input type="checkbox" name="product_data[product_features][{$feature_id}]" value="Y" id="feature_{$feature_id}" {if $feature.value == "Y"}checked="checked"{/if} /></label>
                {elseif $feature.feature_type == "ProductFeatures::DATE"|enum}
                    {include file="common/calendar.tpl" date_id="date_`$feature_id`" date_name="product_data[product_features][$feature_id]" date_val=$feature.value_int|default:""}
                {else}
                    <input type="text" name="product_data[product_features][{$feature_id}]" value="{if $feature.feature_type == "ProductFeatures::NUMBER_FIELD"|enum}{if $feature.value_int != ""}{$feature.value_int|floatval}{/if}{else}{$feature.value}{/if}" id="feature_{$feature_id}" class="{if $feature.feature_type == "ProductFeatures::NUMBER_FIELD"|enum} cm-value-decimal{/if}" />
                {/if}
            {/if}    
            {if $feature.suffix}<span>{$feature.suffix}</span>{/if}
            </div>
        </div>
        {/hook}
    {/if}
     
{/foreach}

{foreach from=$product_features item=feature key="feature_id"}
    {if $feature.feature_type == "ProductFeatures::GROUP"|enum && $feature.subfeatures}
        {include file="common/subheader.tpl" title=$feature.description additional_id=$feature.feature_id}
        {include file="addons/jmj_digital/views/jmj_products/components/product_assign_features.tpl" product_features=$feature.subfeatures}
    {/if}
{/foreach}

<template id="template_result_feature">
    {include file="common/select2/components/object_result.tpl"}
</template>
<template id="template_result_add_feature">
    {include file="common/select2/components/object_result.tpl"
        prefix=__("add")
        icon="icon-plus-sign"
    }
</template>
<template id="template_selection_feature">
    {include file="common/select2/components/object_selection.tpl"}
</template>

{if in_array("color", $features_used)}
    <template id="template_result_feature_color">
        {include file="common/select2/components/color_result.tpl"}
    </template>
    <template id="template_result_add_feature_color">
        {include file="common/select2/components/color_result.tpl"
            prefix=__("add")
            help=true
        }
    </template>
    <template id="template_selection_feature_color">
        {include file="common/select2/components/color_selection.tpl"}
    </template>
{/if}

{if in_array("image", $features_used)}
    <template id="template_result_feature_image">
        {include file="common/select2/components/image_result.tpl"}
    </template>
{/if}
{foreach from=$product_features item=feature key="feature_id"}
<!-- The Modal -->
<div id="myModal-variant{$feature_id}" class="jmj-modal modal-feature-popup">
    <span id="close-modal{$feature_id}" class="jmj-close">&times;</span>
    <div>
        
        <div style="right: 14%;position: fixed;margin-right: 41px;
    margin-bottom: 65px!important;width:auto;height:auto;bottom:-7%" id="close-popup{$feature_id}" class="close-popup ty-btn__secondary ty-btn">Save</div>
    
        <div class="selected-feature-popup-title">{__('choose_feature_title')} ({$feature.description})</div>
    </div>
    
    <div>
    {if $feature.feature_type != "ProductFeatures::GROUP"|enum}
    
        {if $feature.product_variation_group.id eq ''}
            <div style="font-size: 15px;font-weight: bold;">
                <ul class="sbt_custom_block">
                    {if $feature.feature_type != "ProductFeatures::GROUP"|enum}
                        {if $feature.feature_variant_design == 1}
                            {foreach from=$feature.variants item="variant"}    
                                <li>
                                    {if $variant.image_pair.icon.image_path}
                                        <img src="{$variant.image_pair.icon.image_path}"  style="padding: 5px;width:230px;height:285px;margin-right: 10px">
                                    {else}
                                        <div class="no-image " style="width: 105px; height: 125px;"><i class="glyph-image" title="No image"></i></div>
                                    {/if}
                                    <input type="radio" id="{$variant.variant_id}" name="product_data[product_features][{$feature_id}][]" value="{$variant.variant_id}" {if $variant.selected} checked {/if}/>
                                    <label for="{$variant.variant_id}" onclick="select_feature_variant_type('{$variant.variant}',{$feature_id})">{$variant.variant}</label>
                                    {if $variant.selected}
                                        <input type="hidden" class="isSelected" name="isSelected"
                                        value="{$variant.variant}_{$feature_id}"/>
                                    {/if}
                                </li>                    
                            {/foreach}
                        {/if}
                    {/if}
                </ul>
            </div>
            
        {/if}
    {/if}            
    </div>
   
</div>
<!-- model for multi colors-->
<div id="myModal-variant-color{$feature_id}" class="jmj-modal modal-feature-popup">
    <span id="close-modal-color{$feature_id}" class="jmj-close">&times;</span>
    <div>
        
        <div style="right: 14%;position: fixed;margin-right: 41px;
    margin-bottom: 65px!important;width:auto;height:auto;bottom:7%" id="close-popup-color{$feature_id}" class="close-popup ty-btn__secondary ty-btn">Save</div>
    
        <div class="selected-feature-popup-title">{__('choose_feature_title')} ({$feature.description})
        </div>
    {if $feature.feature_type != "ProductFeatures::GROUP"|enum}
    
        {if $feature.product_variation_group.id eq ''}
            <div style="font-size: 15px;font-weight: bold;">
                <ul class="">
                    {if $feature.feature_type != "ProductFeatures::GROUP"|enum}
                        {if $feature.multi_colors_filter == 1}
                            <div class="table-responsive-wrapper" id="profile_fields">
                            <table width="100%" class="table table-middle table--relative table-responsive profile-fields__section">
                                <tbody id="section_fields_{$section}" {if $is_deprecated}class="hidden"{/if}>
                                    {foreach from=$feature.variants item="variant"}
                                        <tr>
                                            <td data-th="{__("checkbox")}" width="10%">
                                                <input onclick="GetSelectedColors('{$variant.variant}',{$feature_id})" class="dialog-colors multi_color_checkbox" type="checkbox" id="{$variant.variant_id}" name="product_data[product_features_new][{$feature_id}][]" value="{$variant.variant_id}" data="{$variant.variant}" {if $variant.selected} checked="checked"{/if} style="float: left;margin-left: 15px; margin-right: 5px; margin-top: 10px;">
                                                <input type="checkbox" name="product_old_data[product_features_new][{$feature_id}][]" value="{$variant.variant_id}" data="{$variant.variant}" {if $variant.selected} checked="checked"{/if} style="display: none;">
                                            </td>
                                            <td style="background-color:{$variant.variant};border-radius: 57px;width: 90px;"><td>
                                            <td data-th="{__("variant_name")}">
                                                <b id="multi_colors_title_{$variant.variant_id}"> {$variant.variant}</b>
                                            </td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                        {/if}
                    {/if}
                </ul>
            </div>
        {/if}
    {/if}            
    </div>
</div>

<!-- The Modal febric -->
<div id="myModal-variant-febric{$feature_id}" class="jmj-modal modal-feature-popup">
    <span id="close-modal-febric{$feature_id}" class="jmj-close">&times;</span>
         <div style="right: 14%;position: fixed;margin-right: 41px;
    margin-bottom: 65px!important;width:auto;height:auto;bottom:-7%" class="close-popup ty-btn__secondary ty-btn" id="close-popup-febric{$feature_id}">Save</div>
        <div><div class="selected-feature-popup-title">{__('choose_feature_title')} ({$feature.description})</div></div>
       
        {if $feature.feature_type != "ProductFeatures::GROUP"|enum}
            {if $feature.feature_variant_design == 2}
                <div class="table-responsive-wrapper" id="profile_fields">
                    <table width="100%" class="table table-middle table--relative table-responsive profile-fields__section">
                        <input type="hidden" id="fabric_error" name="fabric_error" value="0">
                        <tbody id="section_fields_{$section}" {if $is_deprecated}class="hidden"{/if}>
                            {assign var="have_fabric_value" value=fn_check_fabric_value($product_id)}
                            {foreach from=$feature.variants item="variant"}
                                {assign var="fabric_value" value=$product_id|fn_get_fabricvalue:$feature_id:$variant.variant_id}
                    
                                <tr>
                                    <td data-th="{__("checkbox")}" width="10%">
                                        <input class="dialog febric_checkbox" type="checkbox" id="{$variant.variant_id}" name="product_data[product_features][{$feature_id}][]" value="{$variant.variant_id}" data="{$variant.variant}" {if $variant.selected} checked="checked"{/if} style="float: left;margin-left: 15px; margin-right: 5px; margin-top: 10px;" {if !$fabric_value && $have_fabric_value} disabled {/if}>
                                        <input type="checkbox" name="product_old_data[product_features][{$feature_id}][]" value="{$variant.variant_id}" data="{$variant.variant}" {if $variant.selected} checked="checked"{/if} style="display: none;">
                                    </td>
                                    <td data-th="{__("variant_name")}">
                                        <b id="fabric_title_{$variant.variant_id}"> {$variant.variant}</b>
                                    </td>
                                
                                    <td data-th="{__("variant_value")}">
                                        <input style="width:45px" type="text" name="fabric[{$feature_id}][{$variant.variant_id}]" id="fabric_{$variant.variant_id}" onkeyup="GetSelected('{$variant.variant}',{$feature_id})" value="{$fabric_value}" placeholder="0"><b>%</b>            
                                    </td>
                                </tr>
                            {/foreach}
                
                        </tbody>
                    </table>
                </div>
            
                <div class="selected-feature-popup-title" style="color:green;"><b>Hint</b> :Choose max 3 fabrics & {__('sum_should_be_100')} %</div>
            {/if}           
        {/if}
</div>
{/foreach}
<script type="text/javascript">
    $(document).ready(function(){
        $('.select2-results__option').off().on('click', function(){
            var modal = document.getElementById("myModal");
            var close_popup = document.getElementsByClassName("close-popup")[0];
            var close = document.getElementsByClassName("close")[0];
            var modalImg = document.getElementById("img01");
            
            $("#myModal").prepend('<div class="text-center three-quarters-loader">');
            var cat_id = $(this).children('.object-picker__result').children('.object-picker__categories-main').children('.object-picker__categories-main-content').children('.select2__category-name').attr('image_category_id');
            var url = "{"jmj_products.getCatImage"|fn_url}";
                url += "&cat_id="+cat_id;
    
            if(cat_id){
                $.ajax({
                    url: url,
                    dataType: 'json',
                    success: function(response){
                        if(response){
                            $(".three-quarters-loader").remove();
                            modal.style.display = "block";
                            modalImg.src = response;
                        }  
                    }

                });
            }

            // When the user clicks on <span> (x), close the modal
            close.onclick = function() { 
                modal.style.display = "none";
            }
            close_popup.onclick = function() { 
                modal.style.display = "none";
            }
   
        });
        
        $('select').off().on('change', function(){
            var modal = document.getElementById("myModal-variant");
            var close = document.getElementsByClassName("close");
            var modalImg = document.getElementById("img_variant_image");
            var feature_variant_id = $(this).val();
            
            $("#myModal").prepend('<div class="text-center three-quarters-loader">');
            
            var url = "{"jmj_products.getfeature_variantImage"|fn_url}";
                url += "&variant_id="+feature_variant_id;
    
            if(feature_variant_id){
                $.ajax({
                    url: url,
                    dataType: 'json',
                    success: function(response){
                        if(response){
                            $(".three-quarters-loader").remove();
                            modal.style.display = "block";
                            modalImg.src = response;
                        }  
                    }

                });
            } 

            // When the user clicks on <span> (x), close the modal
            $('#close-modal').on('click', function(){
                modal.style.display = "none";
            });
   
        });
        
    });
    
    //show popup for feature variants color
    function showPopup_color(popup_id){
    
        var modal = document.getElementById("myModal-variant-color"+popup_id);            
        modal.style.display = "block";
        
        $('#close-popup-color'+popup_id).on('click', function(){
            modal.style.display = "none";
        });
        $('#close-modal-color'+popup_id).on('click', function(){
            modal.style.display = "none";
        });
        return false;
    }

    //show popup for feature variants febric
    function showPopup_febric(popup_id){
    
        var modal = document.getElementById("myModal-variant-febric"+popup_id);            
        modal.style.display = "block";
        
        $('#close-modal-febric'+popup_id).on('click', function(){
            modal.style.display = "none";
        });
        $('#close-popup-febric'+popup_id).on('click', function(){
            modal.style.display = "none";
        });
        return false;
    }

    //show popup for feature variants
    function showPopup(popup_id){
        
        var modal = document.getElementById("myModal-variant"+popup_id);            
        modal.style.display = "block";

        $('#close-modal'+popup_id).on('click', function(){
            modal.style.display = "none";
        });
        
        $('#close-popup'+popup_id).on('click', function(){
            modal.style.display = "none";
        });
        
        return false;
    }

    function select_feature_variant_type(name,feature_id){
        document.getElementById("selected_variant_type_"+feature_id).innerHTML = name;
        $('.modal-feature-popup').hide();    
    }

    function showSelected_feature_variant_type(){
        jQuery('.isSelected').each(function() {
            var currentElement = $(this);
            var value = currentElement.val();

            if(value != ''){
                var res = value.split("_");
                document.getElementById("selected_variant_type_"+res[1]).innerHTML = res[0];
                document.getElementById("feature_select_button_"+res[1]).innerHTML = 'Change';
            }
        });
    }

    //call for to show if variant_type is already selected
    showSelected_feature_variant_type();

    function GetSelected(name, feature_id) {
       
        var selected = new Array();
        var $total_value = 0;
        
        $('.dialog').each(function() {
            if($(this).is(':checked')){
                var val = document.getElementById("fabric_"+ this.id).value;
               
                if(val>0){
                    document.getElementById(this.id).disabled= false;
                    $total_value = $total_value + parseInt(val);
                    selected.push($("#fabric_title_"+this.id).text());
                    
                }else{
                    document.getElementById(this.id).disabled= true;
                }
            }else{

                if($total_value != 100){
                    document.getElementById(this.id).disabled= false;
                }else{
                    document.getElementById(this.id).disabled= true;
                }
                document.getElementById("fabric_"+ this.id).value = '';
                
            }
            
        });

        $('.dialog').each(function() {
            if($(this).is(':checked')){
        
            }else{
                if(selected.length < 3){
                    if($total_value != 100){
                        document.getElementById(this.id).disabled= false;
                    }else{
                        document.getElementById(this.id).disabled= true;
                    }
                }else{
                    document.getElementById(this.id).disabled= true;
                }    
                
            }
            
        });
        
        str = selected.toString();
        if(selected.length <= 3){
            if($total_value != 100){
                str = "<span style='color:red'>{__('sum_should_be_100')}</span>";
                document.getElementById("fabric_error").value = 1;
        
            }else{
                $(this).is(':checked');
                 document.getElementById("fabric_error").value = 0;
            }
        }else{
            str = "<span style='color:red'>{__('sum_should_be_100')}</span>";
            document.getElementById("fabric_error").value = 1;
            document.getElementById(this.id).disabled= true;
        }       

        if (str.length > 0) {
            document.getElementById("selected_variant_type_"+feature_id).innerHTML = str;
        }
    };
    $('.febric_checkbox').on('click', function(){
        var selected_checkbox = new Array();
        $('.dialog').each(function() {
            if($(this).is(':checked')){
                selected_checkbox.push('1');
            }
            
            if(selected_checkbox.length >= 3){
                var variant_id = this.id;
                variant_id++;
                document.getElementById(variant_id).disabled= true;
            }else{
                document.getElementById(this.id).disabled= false;
            }
        });
        
        
    });
    
    function GetSelectedColors(name, feature_id) {
        var selected_checkbox_new = new Array();
         console.log(selected_checkbox_new);
       
        $('.multi_color_checkbox').each(function() {
            if($(this).is(':checked')){
                console.log($("#multi_colors_title_"+this.id).text());
                selected_checkbox_new.push($("#multi_colors_title_"+this.id).text());
            }
        });
        console.log(selected_checkbox_new);
        
        str = selected_checkbox_new.toString();
        document.getElementById("selected_color_variant_type_"+feature_id).innerHTML = str;
    }
    function show_ischeckSelected(){
        jQuery('.ischeckSelected').each(function() {
            var currentElement = $(this);
            var value = currentElement.val();

            if(value != ''){
                var res = value.split("_");                
                document.getElementById("feature_select_button_"+res[1]).innerHTML = 'Change';
            }
        });
    }
    show_ischeckSelected();
    
    var modalEle = document.querySelector(".jmj-modal");
    document.querySelector(".jmj-close").addEventListener('click',()=>{
        modalEle.style.display = "none";
    });
    
    document.querySelector(".close-popup").addEventListener('click',()=>{
        console.log('32243');
        modalEle.style.display = "none";
    });

</script>