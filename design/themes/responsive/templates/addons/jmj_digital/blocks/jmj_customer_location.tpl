{** block-description:jmj_customer_location **}

{if $auth.user_id}
    {assign var="locations" value=fn_get_customer_locations($auth.user_id)}

    <form id="location-select-form" name="location_select_form" method="post" action="{"jmj_catalog.change_location"|fn_url}" style="margin: 1px 5px 1px 0px;">
        {if $locations}
            <div class="select-location">
                <select name="location" id="location">
                    <option value="0" {if !$smarty.session.location_id}selected{/if}>{__('All')}</option>
                    {foreach from=$locations item="location"}
                        <option value="{$location.id}" {if $smarty.session.location_id == $location.id}selected{/if}>{$location.city}</option>
                    {/foreach }
                </select>
            </div>
        {/if}
    </form>
{/if}

<script>
    $('#location').off().on('change', function(){
        document.getElementById("location-select-form").submit();
    });
</script>