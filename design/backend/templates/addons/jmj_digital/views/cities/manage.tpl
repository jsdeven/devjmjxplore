{include file="views/profiles/components/profiles_scripts.tpl"}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="cities_form" id="cities_form">
<input type="hidden" name="fake" value="1" />

{include file="common/pagination.tpl" save_current_page=true save_current_url=true}

{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
{assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
{assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}

{assign var="return_url" value=$config.current_url|escape:"url"}

{if $cities}
<div class="table-responsive-wrapper">
    <table width="100%" class="table table-middle table-responsive">
    <thead>
    <tr>
        <th width="1%" class="left mobile-hide">
            {include file="common/check_items.tpl"}</th>
        <th width="6%"><a class="cm-ajax" href="{"`$c_url`&sort_by=id&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("id")}{if $search.sort_by == "id"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="25%"><a class="cm-ajax" href="{"`$c_url`&sort_by=city&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">City{if $search.sort_by == "city"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        <th width="20%"><a class="cm-ajax" href="{"`$c_url`&sort_by=date&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">Date {if $search.sort_by == "date"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
        {hook name="cities:list_extra_th"}{/hook}
        <th width="10%" class="nowrap">&nbsp;</th>
        {if "MULTIVENDOR"|fn_allowed_for}
            <th width="10%" class="right"><a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}{__("status")}</a></th>
        {/if}
    </tr>
    </thead>
    {foreach from=$cities item=city}
    <tr class="cm-row-status-{$city.status|lower}" data-ct-city-id="{$city.id}">
        <td class="left mobile-hide">
            <input type="checkbox" name="ids[]" value="{$city.id}" class="cm-item" />
        </td>
        <td class="row-status" data-th="{__("id")}"><a href="{"cities.update?id=`$city.id`"|fn_url}">&nbsp;<span>{$city.id}</span>&nbsp;</a></td>
        <td class="row-status" data-th="city"><a href="{"cities.update?id=`$city.id`"|fn_url}">{$city.city}</a></td>
        <td class="row-status" data-th="date">{$city.created_at|date_format:"`$settings.Appearance.date_format`"}</td>
        {hook name="cities:list_extra_td"}{/hook}
        <td class="nowrap" data-th="{__("tools")}">
            {capture name="tools_items"}
            {hook name="cities:list_extra_links"}
               
                {if !$runtime.company_id && fn_check_view_permissions("cities.update", "POST")}
                    <li>{btn type="list" href="cities.update?id=`$city.id`" text=__("edit")}</li>
                    <li class="divider"></li>
                    {if $runtime.simple_ultimate}
                        <li class="disabled"><a>{__("delete")}</a></li>
                    {else}
                        <li>{btn type="list" class="cm-confirm" href="cities.delete?id=`$city.id`&redirect_url=`$return_current_url`" text=__("delete") method="POST"}</li>
                    {/if}
                {/if}
            {/hook}
            {/capture}
            <div class="hidden-tools">
                {dropdown content=$smarty.capture.tools_items}
            </div>
        </td>
        {if "MULTIVENDOR"|fn_allowed_for}
            <td class="right nowrap" data-th="{__("status")}">
                {assign var="notify" value=true}
                {include file="common/select_popup.tpl"
                    id=$city.id
                    status=$city.status
                    items_status="cities"|fn_get_predefined_statuses:$city.status
                    object_id_name="id"
                    hide_for_vendor=$runtime.company_id
                    update_controller="cities"
                    notify=$notify
                    notify_text= "Notify City"
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
        {hook name="cities:manage_tools_list"}
            {if !$runtime.company_id && fn_check_view_permissions("cities.update", "POST")}
                <li>{btn type="delete_selected" dispatch="dispatch[cities.m_delete]" form="cities_form"}</li>
            {/if}
           
        {/hook}
    {/capture}
    {dropdown content=$smarty.capture.tools_items class="mobile-hide"}
{/capture}

{capture name="adv_buttons"}
   
    {include file="common/tools.tpl" tool_href="cities.add" prefix="top" hide_tools=true title="New City" icon="icon-plus"}
    
{/capture}

{capture name="sidebar"}
    {hook name="cities:manage_sidebar"}
    {include file="common/saved_search.tpl" dispatch="cities.manage" view_type="cities"}
    {include file="addons/jmj_digital/views/cities/components/cities_search_form.tpl" dispatch="cities.manage"}
    {/hook}
{/capture}

{include file="common/mainbox.tpl" title="Cities" content=$smarty.capture.mainbox buttons=$smarty.capture.buttons adv_buttons=$smarty.capture.adv_buttons sidebar=$smarty.capture.sidebar}
