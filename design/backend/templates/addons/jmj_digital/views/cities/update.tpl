<style>
    #remove1{
        margin-left: 0px!important;
    }
    .btn-danger{
        color:red;
    }
</style>
{if $city_data.id}
    {assign var="id" value=$city_data.id}
{else}
    {assign var="id" value=0}
{/if}


{include file="views/profiles/components/profiles_scripts.tpl"}

{capture name="mainbox"}

{capture name="tabsbox"}
{** /Item menu section **}

<form class="form-horizontal form-edit {$form_class} {if !fn_check_view_permissions("cities.update", "POST")}cm-hide-inputs{/if} {if !$id}cm-ajax cm-comet cm-disable-check-changes{/if}" action="{""|fn_url}" method="post" id="cities_update_form" enctype="multipart/form-data"> {* departments update form *}
{* class=""*}
<input type="hidden" name="fake" value="1" />
<input type="hidden" name="selected_section" id="selected_section" value="{$smarty.request.selected_section}" />
<input type="hidden" name="id" value="{$id}" />

{** General info section **}
<div id="content_detailed" class="hidden"> {* content detailed *}
<fieldset>


{include file="common/subheader.tpl" title=__("information")}

{hook name="cities:general_information"}

<div class="control-group">
    <label class="control-label cm-required" for="elm_city_name">City Name:</label>
    <div class="controls">
        <input type="text" class="input-large" name="city_data[city]" id="elm_city_name" size="32" value="{$city_data.city}" />
    </div>
</div>

{if "MULTIVENDOR"|fn_allowed_for}
    {if !$city_data.id}
        {include file="common/select_status.tpl" input_name="city_data[status]" id="city_data" obj=$city_data items_status="cities"|fn_get_predefined_statuses:$city_data.status}
    {else}
        <div class="control-group">
            <label class="control-label">{__("status")}:</label>
            <div class="controls">
                <label class="radio"><input type="radio" checked="checked" />{if $city_data.status == "A"}{__("active")}{elseif $city_data.status == "P"}{__("pending")}{elseif $city_data.status == "N"}{__("new")}{elseif $city_data.status == "D"}{__("disabled")}{/if}</label>
            </div>
        </div>
    {/if}

   
{/if}


{/hook}

</fieldset>
</div> {* /content detailed *}
{** /General info section **}



<div id="content_addons" class="hidden">
    {hook name="cities:detailed_content"}{/hook}
</div>

{hook name="cities:tabs_content"}{/hook}

</form> {* /product update form *}

{hook name="cities:tabs_extra"}{/hook}

{/capture}
{include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox group_name="cities" active_tab=$smarty.request.selected_section track=true}

{/capture}



{** Form submit section **}
{capture name="buttons"}
    {if $id}
        {capture name="tools_list"}
        {hook name="cities:tools_list"}
            <li>{btn type="list" text=__("delete") class="cm-confirm" href="cities.delete?id=$id" method="POST"}</li>
        {/hook}
        {/capture}
        {dropdown content=$smarty.capture.tools_list}

        {include file="buttons/save_cancel.tpl" but_name="dispatch[cities.update]" but_target_form="cities_update_form" save=$id}
    {else}
        {if $is_companies_limit_reached}
            {include file="buttons/save_cancel.tpl" but_meta="btn cm-promo-popup"}
        {else}
            {include file="buttons/save_cancel.tpl" but_name="dispatch[cities.add]" but_target_form="cities_update_form" but_meta="cm-comet"}
        {/if}
    {/if}
{/capture}
{** /Form submit section **}

{if $id}
    {include file="common/mainbox.tpl"
        title_start="Editing City"
        title_end=$city_data.city
        content=$smarty.capture.mainbox
        select_languages=true
        buttons=$smarty.capture.buttons
        sidebar=$smarty.capture.sidebar}
{else}
    {include file="common/mainbox.tpl" title="New City" content=$smarty.capture.mainbox sidebar=$smarty.capture.sidebar buttons=$smarty.capture.buttons}
{/if}
