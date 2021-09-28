
{include file="views/profiles/components/profiles_scripts.tpl"}

{capture name="mainbox"}

{capture name="tabsbox"}
{** /Item menu section **}

<form class="form-horizontal form-edit {$form_class} {if !fn_check_view_permissions("brands.product_class", "POST")}cm-hide-inputs{/if} {if !$id}cm-comet cm-disable-check-changes{/if}" action="{""|fn_url}" method="post" id="product_class_update_form" enctype="multipart/form-data">
{* class=""*}
<input type="hidden" name="fake" value="1" />
<input type="hidden" name="selected_section" id="selected_section" value="{$smarty.request.selected_section}" />
<input type="hidden" name="id" value="{$id}" />

{include file="common/subheader.tpl" title=__("information")}

{hook name="brands_class:general_information"}

    <div class="table-responsive-wrapper">
        <table class="table table-middle table--relative table-responsive" width="100%">
        <thead class="cm-first-sibling">
        <tr>
            <th width="20%">{__("chapter_id")}</th>
            <th width="20%">{__("product_class")}</th>
        </tr>
        </thead>
        <tbody>
        {assign var="_key" value="0"}
        {foreach from=$product_class_data item="pcd" key="lower_limit"}
        
            <input type="hidden" name="product_class_data[{$_key}][id]" value="{$pcd.id}" />
        <tr class="cm-row-item">
            <td width="20%">
                <input type="text" name="product_class_data[{$_key}][brand_class]" value="{$pcd.brand_class}" size="10" class="input-change input-medium" />
            </td>
            <td width="20%">
                <input type="text" name="product_class_data[{$_key}][product_details]" value="{$pcd.product_details}" size="10" class="input-change input-large" />
            </td>
            <td width="15%" class="nowrap {$no_hide_input_if_shared_product} right">
                {include file="buttons/clone_delete.tpl" dummy_href=true microformats="cm-delete-row" no_confirm=true}
            </td>
        </tr>
        
        {$_key = $_key+1}
        {/foreach}
        
        {math equation="x+1" x=$_key|default:0 assign="new_key"}
        <tr class="{cycle values="table-row , " reset=1}" id="box_add_qty_discount">

            <td width="20%">
                <input type="text" name="product_class_data[{$new_key}][brand_class]" value="" size="10" class="input-change input-medium" />
            </td>
            <td width="20%">
                <input type="text" name="product_class_data[{$new_key}][product_details]" value="" size="10" class="input-change input-large" />
            </td>
            <td width="15%" class="right">
                {include file="buttons/multiple_buttons.tpl" item_id="add_qty_discount"}
            </td>
        </tr>
        </tbody>
        </table>
    </div>
{/hook}

</form>

{/capture}
{include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox group_name="cities" active_tab=$smarty.request.selected_section track=true}

{/capture}



{** Form submit section **}
{capture name="buttons"}
    {include file="buttons/save_cancel.tpl" but_name="dispatch[brands.product_class]" but_target_form="product_class_update_form" but_meta="cm-comet" save=true}
{/capture}
{** /Form submit section **}

{if $id}
    {include file="common/mainbox.tpl"
        title_start="Product Class"
        title_end=$brand_data.brand
        content=$smarty.capture.mainbox
        select_languages=true
        buttons=$smarty.capture.buttons
        sidebar=$smarty.capture.sidebar}
{else}
    {include file="common/mainbox.tpl" title="Product Class" content=$smarty.capture.mainbox sidebar=$smarty.capture.sidebar buttons=$smarty.capture.buttons}
{/if}

