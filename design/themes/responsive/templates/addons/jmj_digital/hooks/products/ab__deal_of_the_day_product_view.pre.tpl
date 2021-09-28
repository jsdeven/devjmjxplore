<span class="usergroup_select">
    {assign var="usergroups" value=$smarty.session.cart.user_data.usergroups}
    {assign var="CC_USERGROUP_ID" value=$smarty.const.CC_USERGROUP_ID}
    {assign var="CL_USERGROUP_ID" value=$smarty.const.CL_USERGROUP_ID}
    
    {foreach from=$usergroups key="usergroup_id" item="usergroup"}
        {if $usergroup_id == $CC_USERGROUP_ID && $usergroup.status == 'A'}
            {assign var="price_name" value= __('net_price')}
        {elseif $usergroup_id == $CL_USERGROUP_ID && $usergroup.status == 'A'}
            {assign var="price_name" value= __('wsp_price')}
        {/if} 
    {/foreach}
    {if $price_name}
        <span class="ty-price-num" style="color:#1d365d;">{$price_name}</span>
    {/if}
</span>
