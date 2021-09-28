<tr>
    <td width="40">
        {if !$product_data.parent_product_id && $product_data.has_children}
            <button alt="{__("expand_collapse_list")}" title="{__("expand_collapse_list")}" id="sw_product_variations_group_{$product_data.product_id}" aaaid="on_variations" class="cm-combinations cm-product-variations__collapse product-variations__collapse-btn product-variations__collapse-btn--collapsed" type="button">
                <span class="icon-caret-down" data-ca-switch-id="product_variations_group_{$product_data.product_id}"> </span>
                <span class="icon-caret-right hidden" data-ca-switch-id="product_variations_group_{$product_data.product_id}"> </span>
            </button>
        {else}
            &nbsp;
        {/if}
    </td>
    {if $product_data.parent_product_id}
        <td>
            <div class="product-variations__table-img product-variations__table-img--main">
                {include file="common/image.tpl" image=$product_data.main_pair.icon|default:$product_data.main_pair.detailed image_id=$product_data.main_pair.image_id image_width=40 href="products.update?product_id=`$product_data.product_id`"|fn_url}
            </div>
            <span>
                <a href="{"jmj_products.change_image?product_id=`$product_data.parent_product_id`"|fn_url}" data-ca-target-id=change_image class=" cm-dialog-opener cm-dialog-auto-size">{__('change_image')}</a>
            </span>

        </td>
    {else}
        <td>
            <div class="product-variations__table-img product-variations__table-img--main">
                {include file="common/image.tpl" image=$product_data.main_pair.icon|default:$product_data.main_pair.detailed image_id=$product_data.main_pair.image_id image_width=70 href="products.update?product_id=`$product_data.product_id`"|fn_url }
            </div>
            <span>
                <a href="{"jmj_products.change_image?product_id=`$product_data.product_id`"|fn_url}" data-ca-target-id="change_image" class=" cm-dialog-opener cm-dialog-auto-size">{__('change_image')}</a>
            </span>
        </td>
    {/if}

    <td class="product-variations__table-name">
        <input type="hidden" name="products_data[{$product_data.product_id}][product]" value="{$product_data.product}" class="{$no_hide_input_if_shared_product}"/>

        {if $product_id == $product_data.product_id}
            <strong>{$product_data.product|truncate:140 nofilter}</strong>
        {else}
            <a title="{$product_data.product|strip_tags}" href="{"jmj_products.add?product_id=`$product_data.product_id`"|fn_url}">{$product_data.product|truncate:140 nofilter}</a>
        {/if}
        {include file="views/companies/components/company_name.tpl" object=$product}
    </td>

    <td width="13%" data-th="{__("sku")}">
        {if $is_form_readonly || !$product_data.product_type_instance->isFieldAvailable("product_code")}
            <div class="product-variations__table-code">{$product_data.product_code}</div>
        {else}
            <input type="text" name="products_data[{$product_data.product_id}][product_code]" value="{$product_data.product_code}" class="input-full input-hidden product-variations__table-code" />
        {/if}
    </td>

    {foreach $selected_features as $feature}
        {if $is_form_readonly || !$product_data.product_type_instance->isFieldAvailable("variation_features")}
            <td><span>{$product_data.variation_features[$feature.feature_id].variant}</span></td>
        {else}
            <td><select
                        name="products_variation_feature_values[{$product_data.product_id}][{$feature.feature_id}]"
                        class="input-hidden product-variations__table-select js-product-variation-feature-item"
                        data-ca-feature-id="{$feature.feature_id}"
                >
            {foreach $feature.variants as $variant}
                {if $product_data.variation_features[$feature.feature_id].variant_id == $variant.variant_id}
                    <option value="{$variant.variant_id}" selected>{$variant.variant}</option>
                {/if}
            {/foreach}
            </select></td>
        {/if}
    {/foreach}

    <td class="{$no_hide_input_if_shared_product}" width="13%" data-th="{__("price")}">
        <input type="text" name="products_data[{$product_data.product_id}][price]" value="{$product_data.price|fn_format_price:$primary_currency:null:false}" class="input-full input-hidden product-variations__table-price"/>
    </td>
    <td class="{$no_hide_input_if_shared_product}" width="13%" data-th="{__("net_price")}">
        <input type="text" name="products_data[{$product_data.product_id}][net_price]" value="{$product_data.net_price|fn_format_price:$primary_currency:null:false}" class="input-full input-hidden product-variations__table-price"/>
    </td>
    <td class="{$no_hide_input_if_shared_product}" width="13%" data-th="{__("list_price")}">
        <input type="text" name="products_data[{$product_data.product_id}][list_price]" value="{$product_data.list_price|fn_format_price:$primary_currency:null:false}" class="input-full input-hidden product-variations__table-list_price"/>
    </td>
    <td width="9%" data-th="{__("quantity")}">
        {hook name="product_variations:list_quantity"}
            {if $is_form_readonly}
                <div class="product-variations__table-quantity">{$product_data.amount}</div>
            {else}
                <input type="text" name="products_data[{$product_data.product_id}][amount]" size="6" value="{$product_data.amount}" class="input-full input-hidden product-variations__table-quantity" />
            {/if}
        {/hook}
    </td>
    <td class="{$no_hide_input_if_shared_product}" width="13%" data-th="{__("moq")}">
        <input type="text" name="products_data[{$product_data.product_id}][min_qty]" value="{$product_data.min_qty|default:"0"}" class="input-full input-hidden product-variations__table-moq"/>
    </td>
    <td class="{$no_hide_input_if_shared_product}" width="13%" data-th="{__("quantity_step")}">
       <input type="text" name="products_data[{$product_data.product_id}][qty_step]" value="{$product_data.qty_step|default:"0"}" class="input-full input-hidden product-variations__table-qty_step"/>
    </td>
    <td class="{$no_hide_input_if_shared_product}" width="13%" data-th="{__("list_quantity_count")}">
        <input type="text" name="products_data[{$product_data.product_id}][list_qty_count]" value="{$product_data.list_qty_count|default:"0"}" class="input-full input-hidden product-variations__table-list_qty_count"/>
    </td>
    <td width="6%" class="nowrap mobile-hide">
        <div class="hidden-tools cm-hide-with-inputs">
            {capture name="tools_list"}
                {if !$is_form_readonly && $product_data.parent_product_id}
                    <li>{btn type="list" id="mark_main_product_product_from_group_{$product_data.product_id}" text=__("product_variations.mark_main_product") class="cm-post cm-confirm" href="product_variations.mark_main_product?product_id={$product_data.product_id}&redirect_url={$redirect_url|escape:url}" method="POST"}</li>
                {/if}
                <li>{btn type="list" text=__("edit") href="{"jmj_products.add?product_id=`$product_data.product_id`"|fn_url}"}</li>
                {if !$is_form_readonly}
                    <li>{btn type="list" id="delete_product_{$product_data.product_id}" text=__("product_variations.delete_product") class="cm-post cm-confirm" href="jmj_products.delete?product_id={$product_data.product_id}&redirect_url={$redirect_url|escape:url}" method="POST"}</li>
                {/if}
            {/capture}
            {dropdown content=$smarty.capture.tools_list}
        </div>
    </td>
</tr>
