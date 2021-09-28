{if $products}
    <div class="object-container product-variations__container">
        <table width="100%" class="table table-middle table--relative" data-ca-main-content>
            <thead>
            <tr>
                <th width="2%">&nbsp;</th>
                <th width="5%" class="product-variations__th-img">&nbsp;</th>
                <th width="25%" class="nowrap"><span>{__("name")}</span></th>
                <th width="13%" class="nowrap">{__("sku")}</th>
                {foreach $selected_features as $feature}
                    <th><span>{$feature.description}</span></th>
                {/foreach}
                <th width="13%" class="nowrap">{__("price")} ({$currencies.$primary_currency.symbol nofilter})</th>
                <th width="13%" class="nowrap">{__("net_price")} ({$currencies.$primary_currency.symbol nofilter})</th>
                <th width="13%" class="nowrap">{__("list_price")} ({$currencies.$primary_currency.symbol nofilter})</th>
                <th width="9%" class="nowrap">{__("quantity")}</th>
                <th width="9%" class="nowrap">{__("moq")}</th>
                <th width="9%" class="nowrap">{__("quantity_step")}</th>
                <th width="9%" class="nowrap">{__("list_quantity_count")}</th>
                <th width="6%" class="mobile-hide">&nbsp;</th>
            </tr>
            </thead>
            {foreach $products as $product_data}
                {if !$product_data.parent_product_id}
                    {if !$product@first}
                        </tbody>
                    {/if}

                    <tbody>
                        {include file="addons/jmj_digital/views/jmj_products/components/product_item.tpl"}
                    </tbody>
                    <tbody data-ca-switch-id="product_variations_group_{$product_data.product_id}">
                {else}
                    {include file="addons/jmj_digital/views/jmj_products/components/product_item.tpl"}
                {/if}
            {/foreach}
            </tbody>
        </table>
    </div>

    <div class="hidden">
        {foreach $selected_features as $feature}
            <select class="js-product-variation-feature" data-ca-feature-id="{$feature.feature_id}">
                {foreach $feature.variants as $variant}
                    <option value="{$variant.variant_id}">{$variant.variant}</option>
                {/foreach}
            </select>
        {/foreach}
    </div>
{else}
    <p class="no-items">{__("product_variations.add_variations_description")}</p>
{/if}