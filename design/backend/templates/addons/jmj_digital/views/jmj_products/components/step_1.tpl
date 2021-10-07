<div id="acc_information" class="collapse in collapse-visible">
    <div class="control-group {$no_hide_input_if_shared_product}">
        <label for="product_description_product" class="control-label cm-required" disable>{__("name")}</label>
        <div class="controls">
            <input class="input-large" form="form" type="text" name="product_data[product]" size="55" id="product_description_product" value="{$product_data.product}" disabled />
            <input type="hidden" name="product_data[product]" id="product_description_product_1" value="{$product_data.product}"  />
            {include file="buttons/update_for_all.tpl" display=$show_update_for_all object_id="product" name="update_all_vendors[product]"}
        </div>
    </div>
</div>

{hook name="jmj_products:categories_section"}
    {$result_ids = "product_categories"}

    {if "MULTIVENDOR"|fn_allowed_for && $mode != "add"}
            {$js_action = "fn_change_vendor_for_product();"}
    {/if}

    {hook name="companies:product_details_fields"}

    {if "ULTIMATE"|fn_allowed_for}
        {assign var="companies_tooltip" value=__("text_ult_product_store_field_tooltip")}
    {/if}

    {include file="views/companies/components/company_field.tpl"
        name="product_data[company_id]"
        id="product_data_company_id"
        selected=$product_data.company_id
        tooltip=$companies_tooltip
    }

    {/hook}

   
    <div class="control-group">
        <label for="companies_brands" class="control-label cm-required">{__("choose_vendor_brands")}:</label>
        <div class="controls">
            <select id="companies_brands" name="product_data[feature_data][{$companies_brands.0.feature_id}]">
                <option value="">{__('choose_brand')}</option>
                {foreach from=$companies_brands item=company_brand}
                    <option value="{$company_brand.variant_id}" {if $company_brand.variant_id == $product_data.brand_variant}selected="selected"{/if}>{$company_brand.variant}</option>
                {/foreach}    
            </select>
        </div>
    </div>
   

    {assign var="hsn_numbers" value=fn_get_hsn_numbers()}
    
    <div class="control-group">
        <label for="hsn_numbers" class="control-label cm-required" for="hsn_numbers">{__("hsn_numbers")}:</label>
        <div class="controls">
            <select id="hsn_numbers" name="product_data[hsn_number]">
                <option value="">{__('choose_hsn_number')}</option>
                {foreach from=$hsn_numbers item=hsn_number}
                    <option value="{$hsn_number}" {if $hsn_number == $product_data.hsn_number}selected="selected"{/if}>{$hsn_number}</option>
                {/foreach}    
            </select>
        </div>
    </div>
    
    <div class="control-group">
        <label for="main_category" class="control-label cm-required">{__("main_category")}:</label>
        <div class="controls">
            <select id="main_category" name="product_data[main_category_id]" class="category_image">
                <option value="">{__('choose_category')}</option>
                {foreach from=$main_categories item=main_category}
                    <option value="{$main_category.category_id}" {if $main_category.category_id == $main_category_id}selected="selected"{/if}>{$main_category.category}</option>
                {/foreach}    
            </select>
        </div>
    </div>
    <div class="control-group">
        <label for="sub_category" class="control-label cm-required">{__("sub_category")}:</label>
        <div class="controls">
            <select id="sub_category" name="product_data[sub_category_id]" class="category_image">
                {if $sub_categories}
                    {foreach from=$sub_categories item=sub_category}
                        <option value="{$sub_category.category_id}" {if $sub_category.category_id == $sub_category_id}selected="selected"{/if}>{$sub_category.category}</option>
                    {/foreach}  
                {else}
                    <option value="0">{__('choose_main_category')}</option>
                {/if}
                
            </select>
        </div>
    </div>

    <div class="control-group">
        <label for="sub_sub_category" class="control-label cm-required">{__("sub_sub_category")}:</label>
        <div class="controls">
            <select id="sub_sub_category" name="product_data[category_ids][]" class="category_image">
                {if $sub_sub_categories}
                    {foreach from=$sub_sub_categories item=sub_sub_category}
                        <option value="{$sub_sub_category.category_id}" {if $sub_sub_category.category_id == $sub_sub_category_id}selected="selected"{/if}>{$sub_sub_category.category}</option>
                    {/foreach}  
                {else}
                    <option value="0">{__('choose_sub_category')}</option> 
                {/if}
            </select>
        </div>
    </div>
    
    <input type="hidden" value="{$result_ids}" name="result_ids">

{/hook}

{hook name="jmj_products:product_update_price"}
    <div class="control-group {$no_hide_input_if_shared_product}">
        <label for="elm_price_price" class="control-label cm-required">{__("price")} ({$currencies.$primary_currency.symbol nofilter}):</label>
        <div class="controls">
            <input type="text" name="product_data[price]" id="elm_price_price" size="10" value="{$product_data.price}" class="input-long" />
            {include file="buttons/update_for_all.tpl" display=$show_update_for_all object_id="price" name="update_all_vendors[price]"}
        </div>
    </div>
    <div class="control-group {$no_hide_input_if_shared_product}">
        <label for="elm_net_price" class="control-label">{__("net_price")} ({$currencies.$primary_currency.symbol nofilter}):</label>
        <div class="controls">
            <input type="text" name="product_data[net_price]" id="elm_net_price" size="10" value="{$product_data.net_price}" class="input-long" />
        </div>
    </div>
{/hook}

<div class="control-group">
    <label class="control-label cm-required" for="elm_product_code">{__("sku")}:</label>
    <div class="controls">
        <input type="text" name="product_data[product_code]" id="elm_product_code" size="20" maxlength={"ProductFieldsLength::PRODUCT_CODE"|enum}  value="{$product_data.product_code}" class="input-large" />
    </div>
</div>

<div class="control-group">
    <label class="control-label cm-required" for="elm_list_price">{__("list_price")} ({$currencies.$primary_currency.symbol nofilter}) :</label>
    <div class="controls">
        <input type="text" name="product_data[list_price]" id="elm_list_price" size="10" value="{$product_data.list_price}" class="input-long" />
    </div>
</div>
<div class="control-group">
    <label class="control-label cm-required" for="elm_in_stock">{__("in_stock")}:</label>
    <div class="controls">
        {if $product_data.tracking == "ProductTracking::TRACK_WITH_OPTIONS"|enum}
            {include file="buttons/button.tpl" but_text=__("edit") but_href="product_options.inventory?product_id=`$id`" but_role="edit"}
        {else}
            <input type="text" name="product_data[amount]" id="elm_in_stock" size="10" value="{$product_data.amount|default:"1"}" class="input-small" />
        {/if}
    </div>
</div>
<div class="control-group">
    <label class="control-label cm-required" for="elm_min_qty">{__("min_order_qty")}:</label>
    <div class="controls">
        <input type="text" name="product_data[min_qty]" size="10" id="elm_min_qty" value="{$product_data.min_qty}" class="input-small" />
    </div>
</div>

<div class="control-group">
    <label class="control-label cm-required" for="elm_max_qty">{__("max_order_qty")}:</label>
    <div class="controls">
        <input type="text" name="product_data[max_qty]" id="elm_max_qty" size="10" value="{$product_data.max_qty}" class="input-small" />
    </div>
</div>

<div class="control-group">
    <label class="control-label cm-required" for="elm_qty_step">{__("quantity_step")}:</label>
    <div class="controls">
        <input type="text" data-v-min="0" data-m-dec="0" data-a-sep="" name="product_data[qty_step]" id="elm_qty_step" value="{$product_data.qty_step}" class="input-small cm-numeric" />
    </div>
</div>

<div class="control-group">
    <label class="control-label cm-required" for="elm_list_qty_count">{__("list_quantity_count")}:</label>
    <div class="controls">
        <input type="text" name="product_data[list_qty_count]" id="elm_list_qty_count" size="10" value="{$product_data.list_qty_count}" class="input-small" />
    </div>
</div>
<div class="control-group">
    <label class="control-label cm-required">{__("taxes")}:</label>
    <div class="controls">
        <input type="hidden" name="product_data[tax_ids]" value="" />
        {foreach from=$taxes item="tax"}
            <label class="checkbox inline" for="elm_taxes_{$tax.tax_id}">
                <input type="checkbox" name="product_data[tax_ids][{$tax.tax_id}]" id="elm_taxes_{$tax.tax_id}" {if $tax.tax_id|in_array:$product_data.tax_ids}checked="checked"{/if} value="{$tax.tax_id}" />
                {$tax.tax}</label>
            {foreachelse}
            &ndash;
        {/foreach}
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        var modal = document.getElementById("myModal");
        var close_modal = document.getElementById("close_modal");
        var modalImg = document.getElementById("img01");

        $('#companies_brands').on('change', function(){

            //Update product name on category change
            var sub_sub_cat_name = $("#sub_sub_category option:selected" ).text();
            var main_cat_name = $("#main_category option:selected" ).text();
            var full_cat_name = main_cat_name + ' - ' + sub_sub_cat_name;

            var brand_name = $("#companies_brands option:selected").text();
            var product_name = $.trim(brand_name) + ' - ' + full_cat_name;
            
            $('#product_description_product').val(product_name);
            $('#product_description_product_1').val(product_name);
            
        });

        $('#sub_sub_category').on('change', function(){

            //Update product name on category change
            var sub_sub_cat_name = $( "#sub_sub_category option:selected" ).text();
            var brand_name = $("#companies_brands option:selected").text();
            var main_cat_name = $("#main_category option:selected" ).text();
            var full_cat_name = main_cat_name + ' - ' + sub_sub_cat_name;

            var product_name = $.trim(brand_name) + ' - ' + full_cat_name;
            
            $('#product_description_product').val(product_name);
            $('#product_description_product_1').val(product_name);
            
        });

        $('#main_category').on('change', function(){

            //Update product name on category change
            var sub_sub_cat_name = $( "#sub_sub_category option:selected" ).text();
            var brand_name = $("#companies_brands option:selected").text();
            var main_cat_name = $("#main_category option:selected" ).text();
            var full_cat_name = main_cat_name + ' - ' + sub_sub_cat_name;
            
            var product_name = $.trim(brand_name) + ' - ' + full_cat_name;
            
            $('#product_description_product').val(product_name);
            $('#product_description_product_1').val(product_name);
            
        });

        $('#main_category').on('change', function(){
            var category_id = $(this).val();
            var url = "{"jmj_products.get_sub_categories"|fn_url}";
                url += "&category_id="+category_id;

            $("#myModal").prepend('<div class="text-center three-quarters-loader">');

            if(category_id != '0'){
                $.ajax({
                    url: url,
                    dataType: 'json',
                    success: function(response){
                        if(response){
                           $('#sub_category').html(response.str);
                        }  
                        if(response.image){
                            $(".three-quarters-loader").remove();
                            modal.style.display = "block";
                            modalImg.src = response.image;
                        }  
                    }
                });
            }else{
		    
    		    var str =" <option value='0'>Select Sub-Category</option> <br>";
    		    $('#sub_category').html(str);
    		    var str_1 =" <option value='0'>Select Sub-Sub-Category</option> <br>";
    		    $('#sub_sub_category').html(str_1);
    		} 
        });

        $('#sub_category').on('change', function(){
            var category_id = $(this).val();
            var url = "{"jmj_products.get_sub_categories"|fn_url}";
                url += "&category_id="+category_id;

            $("#myModal").prepend('<div class="text-center three-quarters-loader">');

            if(category_id != '0'){
                $.ajax({
                    url: url,
                    dataType: 'json',
                    success: function(response){
                        if(response){
                           $('#sub_sub_category').html(response.str);
                        }
                        if(response.image){
                            $(".three-quarters-loader").remove();
                            modal.style.display = "block";
                            modalImg.src = response.image;
                        }  
                    }
                });
            }else{
    		    var str_1 =" <option value='0'>Select Sub-Sub-Category</option> <br>";
    		    $('#sub_sub_category').html(str_1);
    		} 
        });

        $('#sub_sub_category').on('change', function(){
            var category_id = $(this).val();
            var url = "{"jmj_products.get_sub_categories"|fn_url}";
                url += "&category_id="+category_id;

            $("#myModal").prepend('<div class="text-center three-quarters-loader">');

            if(category_id){
                $.ajax({
                    url: url,
                    dataType: 'json',
                    success: function(response){
                        if(response.image){
                            $(".three-quarters-loader").remove();
                            modal.style.display = "block";
                            modalImg.src = response.image;
                        }  
                    }
                });
            } 
        });
        
        // When the user clicks on <span> (x), close the modal
        close_modal.onclick = function() 
        { 
            modal.style.display = "none";
        }
       
    });
   
</script>

