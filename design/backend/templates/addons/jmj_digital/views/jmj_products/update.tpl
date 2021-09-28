{literal}
    <style>
        #myImg {
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }
        .modal {
            z-index: 1500;
            display: none;
            left: 36%;
        }
        #img01 {
            max-width: 100%;
            height: 580px;
            vertical-align: middle;
            border: 0;
            -ms-interpolation-mode: bicubic;
            width: 900px;
        }
        .AClass{
            right:0px;
            position: absolute;
        }
       
    </style>
{/literal}

{script src="js/tygh/backend/categories.js"}

{if $language_direction == "rtl"}
    {$direction = "right"}
{else}
    {$direction = "left"}
{/if}

{capture name="mainbox"}

    {capture name="tabsbox"}
        {** /Item menu section **}

        {assign var="categories_company_id" value=$product_data.company_id}
        {assign var="allow_save" value=$product_data|fn_allow_save_object:"product"}

        {if "ULTIMATE"|fn_allowed_for}
            {assign var="categories_company_id" value=""}
            {if $runtime.company_id && $product_data.shared_product == "Y" && $product_data.company_id != $runtime.company_id}
                {assign var="no_hide_input_if_shared_product" value="cm-no-hide-input"}
                {assign var="is_shared_product" value=true}
            {/if}

            {if !$runtime.company_id && $product_data.shared_product == "Y"}
                {assign var="show_update_for_all" value=true}
            {/if}
        {/if}

        {if $product_data.product_id}
            {assign var="id" value=$product_data.product_id}
        {else}
            {assign var="id" value=0}
        {/if}

        {$is_form_readonly = fn_check_form_permissions("") || ($id && $runtime.company_id && (fn_allowed_for("MULTIVENDOR") || $product_data.shared_product == "Y") && $product_data.company_id != $runtime.company_id)}

        <form id="form" action="{""|fn_url}" method="post" name="product_update_form" class="form-horizontal form-edit  cm-disable-empty-files {if $is_form_readonly}cm-hide-inputs{/if}" enctype="multipart/form-data"> {* product update form *}
            <input type="hidden" name="fake" value="1" />
            <input type="hidden" name="current_step" value="{$current_step}" />
            {if $secount_last_step}
                <input type="hidden" name="next_step" value="last_step" />
            {else}    
                <input type="hidden" name="next_step" value="{$next_step}" />
            {/if}
            <input type="hidden" name="is_last_step" value="{$is_last_step}" />
            <input type="hidden" name="product_id" value="{$product_id}" />
            <input type="hidden" class="{$no_hide_input_if_shared_product}" name="selected_section" id="selected_section" value="{$smarty.request.selected_section}" />
            <input type="hidden" class="{$no_hide_input_if_shared_product}" name="product_id" value="{$id}" />

            {** Product description section **}

            {** Detailed section **}
            <div class="product-manage hidden" id="content_detailed"> {* content detailed *}
                {** General info section **}
                {include file="addons/jmj_digital/views/jmj_products/components/step_1.tpl"}
            </div>
            {** /Detailed section **}

            {** Images section **}
            <div class="product-manage hidden" id="content_upload_images">
                {include file="addons/jmj_digital/views/jmj_products/components/step_2.tpl"}
            </div>
            {** /Images section **}

            {** Quantity discounts section **}
            {include file="addons/jmj_digital/views/jmj_products/components/products_update_qty_discounts.tpl"}
            {** /Quantity discounts section **}

            {** Product features section **}
            {include file="addons/jmj_digital/views/jmj_products/components/products_update_features.tpl" product_id=$product_data.product_id}
            {** /Product features section **}

            {** Options section **}
            <div class="product-manage hidden" id="content_create_options">
                {if $current_step == 5}
                    {include file="addons/jmj_digital/views/jmj_products/components/step_5.tpl"}
                {/if}    
            </div>

            {** Product full description section **}
            <div class="product-manage hidden" id="content_step_6">
                {include file="addons/jmj_digital/views/jmj_products/components/step_6.tpl"}
            </div>    
            {** /Product full description  section **}
            
             {** Buy Together section **}
       
            {include file="addons/jmj_digital/views/jmj_products/components/buy_together.tpl"}
          
            {** /Buy Together  section **}

            {** Product shipping section **}
            <div class="product-manage hidden" id="content_shippings">
                {include file="addons/jmj_digital/views/jmj_products/components/product_update_shippings_settings.tpl"}
            </div>    
            {** /Product shipping section **}

            <div class="product-manage hidden" id="content_jmj_addons">
                {include file="addons/jmj_digital/views/jmj_products/components/products_addons.tpl"}
            </div>    

            {include file="addons/jmj_digital/views/jmj_products/components/rewards_points.tpl"}

            {** Variants section **}
            <div class="product-manage hidden" id="content_all_variants"> 
                {include file="addons/jmj_digital/views/jmj_products/components/last_step.tpl"}
            </div>
            {** /Variants section **}

            {if $current_step != 1}
                <a href="{"jmj_products.add?product_id=`$product_id`&step=`$previous_step`"|fn_url}" class="btn ty-btn float-left ty-btn__secondary">{__('previous_step')}</a>
            {/if}
            {if $is_last_step}
                {include file="buttons/button.tpl" but_text=__("create_product") but_name="dispatch[jmj_products.m_update]" but_id="submit" but_meta="ty-btn float-right ty-btn__secondary" value = "submit"}
            {else}
                {include file="buttons/button.tpl" but_text=__("submit_and_continue") but_name="dispatch[jmj_products.update]" but_id="submit" but_meta="ty-btn float-right ty-btn__secondary {if $current_step == 5} hidden {/if}" value = "submit"}
            {/if}
            
            {capture name="buttons"}
            {hook name="products:update_product_buttons"}
                {include file="common/view_tools.tpl" url="products.update?product_id="}
                
                {if $id}
                    {capture name="tools_list"}
                        {hook name="products:update_tools_list"}
                            {if $view_uri}
                                <li>{btn type="list" target="_blank" text=__("preview") href=$view_uri}</li>
                                <li class="divider"></li>
                            {/if}
                        {/hook}
                    {/capture}
                    {dropdown content=$smarty.capture.tools_list}
                {/if}
            {/hook}    
            {/capture}    
                
        </form> {* /product update form *}
    {/capture}
    {include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox group_name=$runtime.controller active_tab=$smarty.request.selected_section track=true}

{/capture}

<!-- The Modal -->
<div id="myModal" class="modal">
    <div style="position:relative;">
        <button type="submit" class="close AClass">
           <span id="close_modal">&times;</span>
        </button>
        <img class="modal-content" id="img01">
    </div>
</div>

{hook name="products:update_mainbox_params"}

{if $id}
    {$title_start = __("editing_product")}
    {$title_end = $product_data.product|strip_tags}
{else}
    {capture name="mainbox_title"}
        {__("new_product")}
    {/capture}
{/if}

{/hook}

{include file="common/mainbox.tpl"
    title_start=$title_start
    title_end=$title_end
    title=$smarty.capture.mainbox_title
    content=$smarty.capture.mainbox
    select_languages=$id
    buttons=$smarty.capture.buttons
    adv_buttons=$smarty.capture.adv_buttons
}

{if "MULTIVENDOR"|fn_allowed_for}
<script type="text/javascript">
  var fn_change_vendor_for_product = function(){
    $.ceAjax('request', Tygh.current_url, {
      data: {
        product_data: {
          company_id: $('[name="product_data[company_id]"]').val(),
          category_ids: $('[name="product_data[category_ids]"]').val()
        }
      },
      result_ids: 'product_amount,product_categories'
    });
  };
</script>
{/if}
