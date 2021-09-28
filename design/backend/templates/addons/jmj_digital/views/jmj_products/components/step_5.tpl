<div class="cm-tabs-content" id="tabs_content_{$product_data.product_id}">
    <div id="content_tab_create_new_{$product_data.product_id}">
        {include file="addons/product_variations/views/product_variations/components/generate_variations.tpl"}
    </div>
    {include file="buttons/button.tpl" but_text=__("submit_and_continue") but_name="dispatch[jmj_products.update]" but_id="submit" but_meta="ty-btn float-right ty-btn__secondary" value = "submit"}
</div>  
