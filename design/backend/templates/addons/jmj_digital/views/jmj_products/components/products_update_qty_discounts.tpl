{if !"ULTIMATE:FREE"|fn_allowed_for}
    {assign var="usergroups" value=["type"=>"C", "status"=>["A", "H"]]|fn_get_usergroups}
{/if}

<div id="content_qty_discounts" class="hidden">
    <div class="table-responsive-wrapper">
        <table class="table table-middle table--relative table-responsive" width="100%">
        <thead class="cm-first-sibling">
        <tr>
            <th width="5%">{__("quantity")}</th>
            <th width="20%">{__("wsp_price")}</th>
            <th width="20%">{__("net_price")}</th>
            <th width="20%">{__("mrp")}</th>
            <th width="15%">&nbsp;</th>
        </tr>
        </thead>
        <tbody>
        {assign var="_key" value="0"}
        {foreach from=$product_data.prices_new item="price" key="lower_limit" name="prod_prices"}
        <tr class="cm-row-item">
            
            <td width="5%" class="{$no_hide_input_if_shared_product}" data-th="{__("quantity")}">
                {if $lower_limit == "1"}
                    &nbsp;{$lower_limit}
                {else}
                <input type="text" name="product_data[prices][{$_key}][lower_limit]" value="{$lower_limit}" class="input-micro" />
                {/if}</td>
            <td width="20%" class="{$no_hide_input_if_shared_product}" data-th="{__("value")}">
                {if $lower_limit == "1"}
                {assign var="CL_USERGROUP_ID" value=$smarty.const.CL_USERGROUP_ID}
                    &nbsp;<span id="input_price_{$_key}">{$price.0|default:"0.00"|fn_format_price:$primary_currency:null:false}</span>
                {else}
                <input type="text" name="product_data[prices][{$_key}][cl_price]" value="{$price.$CL_USERGROUP_ID|default:"0.00"|fn_format_price:$primary_currency:null:false}" size="10" class="input-change input-medium" />
                {/if}</td>
            <td width="20%" class="{$no_hide_input_if_shared_product}" data-th="{__("value")}">
                {if $lower_limit == "1"}
                {assign var="CC_USERGROUP_ID" value=$smarty.const.CC_USERGROUP_ID}
                    &nbsp;<span id="input_price_{$_key}">{$product_data.net_price|default:"0.00"|fn_format_price:$primary_currency:null:false}</span>
                {else}
                <input type="text" name="product_data[prices][{$_key}][cc_price]" value="{$price.$CC_USERGROUP_ID|default:"0.00"|fn_format_price:$primary_currency:null:false}" size="10" class="input-change input-medium" />
                {/if}</td>

            <td width="20%" class="{$no_hide_input_if_shared_product}" data-th="{__("value")}">
                &nbsp;<span id="input_price_{$_key}">{$product_data.list_price|default:"0.00"|fn_format_price:$primary_currency:null:false}</span>
                </td>
            
            <input type="hidden" name="product_data[prices][{$_key}][type]" value="A" />
    
            <td width="15%" class="nowrap {$no_hide_input_if_shared_product} right">
                {if $lower_limit == "1"}
                &nbsp;{else}
                {include file="buttons/clone_delete.tpl" dummy_href=true microformats="cm-delete-row" no_confirm=true}
                {/if}
            </td>
        </tr>
        {$_key = $_key+1}
        {/foreach}
        {math equation="x+1" x=$_key|default:0 assign="new_key"}
        <tr class="{cycle values="table-row , " reset=1}{$no_hide_input_if_shared_product}" id="box_add_qty_discount">
            <td width="5%" data-th="{__("quantity")}">
                <input type="text" name="product_data[prices][{$new_key}][lower_limit]" value="" class="input-micro" id="lower_limit_{$new_key}" /></td>
            <td width="20%" data-th="{__("value")}">
                <input id="input_price_{$new_key}" type="text" name="product_data[prices][{$new_key}][cl_price]" value="0.00" size="10" class="input-medium input-change" data-key="{$new_key}" /></td>
            <td width="20%" data-th="{__("value")}">
                <input id="input_price_{$new_key}" type="text" name="product_data[prices][{$new_key}][cc_price]" value="0.00" size="10" class="input-medium input-change" data-key="{$new_key}" /></td>
            <td width="20%" data-th="{__("value")}">
                &nbsp;<span id="input_price_{$new_key}">{$product_data.list_price|default:"0.00"|fn_format_price:$primary_currency:null:false}</span>
            </td>
            
            <input type="hidden" name="product_data[prices][{$new_key}][type]" value="A" />
            <td width="15%" class="right">
                {include file="buttons/multiple_buttons.tpl" item_id="add_qty_discount"}
            </td>
        </tr>
        </tbody>
        </table>
    </div>
    

</div>
