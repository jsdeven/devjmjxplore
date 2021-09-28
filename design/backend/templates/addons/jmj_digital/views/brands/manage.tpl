{include file="views/profiles/components/profiles_scripts.tpl"}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="brands_form" id="brands_form">
<input type="hidden" name="fake" value="1" />

{include file="common/pagination.tpl" save_current_page=true save_current_url=true}

{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
{assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
{assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}

{assign var="return_url" value=$config.current_url|escape:"url"}

{if $brands}
<div class="table-responsive-wrapper">
    <table width="100%" class="table table-middle table-responsive">
    <thead>
    <tr>
        <th width="1%" class="left mobile-hide">
            {include file="common/check_items.tpl"}</th>
        <th width="6%"><a class="cm-ajax" href="{"`$c_url`&sort_by=id&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("id")}{if $search.sort_by == "id"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="25%"><a class="cm-ajax" href="{"`$c_url`&sort_by=brand&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">Brand{if $search.sort_by == "brand"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="25%">Link</th>
        {if $auth.user_type != 'V'}
            <th width="20%">Company</th>
        {/if}    
        <th width="20%"><a class="cm-ajax" href="{"`$c_url`&sort_by=date&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">Date {if $search.sort_by == "date"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        {hook name="brands:list_extra_th"}{/hook}
        
        {if "MULTIVENDOR"|fn_allowed_for}
            <th width="10%" class="right"><a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}{__("status")}</a></th>
        {/if}
    </tr>
    </thead>
    {foreach from=$brands item=brand}
    <tr class="cm-row-status-{$brand.status|lower}" data-ct-brand-id="{$brand.id}">
        <td class="left mobile-hide">
            <input type="checkbox" name="ids[]" value="{$brand.id}" class="cm-item" />
        </td>
        <td class="row-status" data-th="{__("id")}"><a href="{"brands.update?id=`$brand.id`"|fn_url}">&nbsp;<span>{$brand.id}</span>&nbsp;</a></td>
        <td class="row-status" data-th="brand"><a href="{"brands.update?id=`$brand.id`"|fn_url}">{$brand.brand}</a></td>
        <td class="row-status" data-th="brand">{$brand.link}</td>
        {if $auth.user_type != 'V'}
            <td class="row-status" data-th="brand"><a href="{"companies.update?company_id=`$brand.company_id`"|fn_url}">{$brand.company}</a></td>
        {/if}  
        <td class="row-status" data-th="date">{$brand.created_at|date_format:"`$settings.Appearance.date_format`"}</td>
        {hook name="brands:list_extra_td"}{/hook}
        
        {if "MULTIVENDOR"|fn_allowed_for}
            <td class="right nowrap" data-th="{__("status")}">
                {assign var="notify" value=true}
                {include file="common/select_popup.tpl"
                    id=$brand.id
                    status=$brand.status
                    items_status="brands"|fn_get_predefined_statuses:$brand.status
                    object_id_name="id"
                    hide_for_vendor=$runtime.company_id
                    update_controller="brands"
                    notify=$notify
                    notify_text= "Notify Brand"
                    status_target_id="pagination_contents"
                    extra="&return_url=`$return_url`"
                }
            </td>
        {/if}
    </tr>
    {/foreach}
    </table>
</div>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}


{include file="common/pagination.tpl"}
</form>
{/capture}
{capture name="buttons"}
    {capture name="tools_items"}
        {hook name="brands:manage_tools_list"}
            {if !$runtime.company_id && fn_check_view_permissions("brands.update", "POST")}
                <li>{btn type="delete_selected" dispatch="dispatch[brands.m_delete]" form="brands_form"}</li>
            {/if}
           
        {/hook}
    {/capture}
    {dropdown content=$smarty.capture.tools_items class="mobile-hide"}
{/capture}

{capture name="adv_buttons"}
    {if $auth.user_type == 'V'}
        {include file="common/tools.tpl" tool_href="brands.add" prefix="top" hide_tools=true title="New Brand" icon="icon-plus"}
    {/if}
{/capture}

{capture name="sidebar"}
    {hook name="brands:manage_sidebar"}
    {include file="common/saved_search.tpl" dispatch="brands.manage" view_type="brands"}
    {include file="addons/jmj_digital/views/brands/components/brands_search_form.tpl" dispatch="brands.manage"}
    {/hook}
{/capture}

{include file="common/mainbox.tpl" title="Brand Request List" content=$smarty.capture.mainbox buttons=$smarty.capture.buttons adv_buttons=$smarty.capture.adv_buttons sidebar=$smarty.capture.sidebar}
