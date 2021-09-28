{if $user_data.user_code}
    <div class="control-group">
        <label for="user_code" class="control-label">{__("user_code")} </label>
        <div class="controls">
            <input type="text" id="user_code" name="user_data[user_code]" class="input-medium" size="32" maxlength="128" value="{$user_data.user_code}" disabled/>
        </div>
    </div>
{/if}

{if $_REQUEST.user_type == 'A'}
    {if $approve_order_permission}
        <div class="control-group">
            <label for="user_type" class="control-label">{__("location")}:</label>
            <div class="controls">
            <select id="location" name="user_data[location]">
                <option value="0">{__("none")}</option>
                {foreach from=$cities item=city}
                    <option value="{$city.id}" {if $city.id == $user_data.location.0}selected="selected"{/if}>{$city.city}</option>
                {/foreach}    
            </select>
            </div>
        </div>
    {/if}    
{else}
    <div class="control-group" id="elm_customer_location">
        <label for="elm_customer_location" class="control-label cm-required">{__("customer_location")} </label>
        <div class="controls">
            <div style="border: 1px solid #CCCCCC;border-radius: 3px;width: 500px;height: auto;overflow: scroll;padding: 8px;">
                {foreach from=$cities item=city}
                    <label class="control-label" style = "width: 100%;float: none;text-align: left;"><input type = "checkbox" value = "{$city.id}" name = "user_data[locations][]" {if $user_data.location && in_array($city.id,$user_data.location)} checked {/if} /> {$city.city} <br /></label>
                    <label for="marketing_user" class="control-label">{__("marketing_user")}:</label>
                    <select id="marketing_user" name="user_data[marketing_user][{$city.id}]">
                        {assign var="location_marketing_users" value=fn_get_location_marketing_users($city.id)}
                        {foreach from=$location_marketing_users item=lmu}
                            <option value="{$lmu.user_id}" {if fn_check_location_marketing_user_id($lmu.user_id, $user_data.location_marketing_users_data)}selected="selected"{/if}>{$lmu.firstname} {$lmu.lastname}</option>
                        {/foreach}  
                    </select>
                {/foreach}
            </div>
        </div>
    </div>
{/if}    
