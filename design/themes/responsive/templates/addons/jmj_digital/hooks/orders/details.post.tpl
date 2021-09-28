<h5>{__('order_checked_by_marketing_user_status')}: {if $order_info.check_order == 'Y'}<span style="color:#0f8a1e;">{__('yes_checked')}</span>{else}<span style="color:#bf2e17;"> {__('no_unchecked')}</span>{/if}</h5>
{assign var="vendor_statuses" value=$order_info.vendor_statuses}
<ol class="progtrckr" data-progtrckr-steps="8">
    {if $vendor_statuses}
        {assign var="i" value=1}
        {foreach from=$vendor_statuses item=vendor_status}
            {if $i <= $order_info.last_complete_vendor_status}
                <li class="progtrckr-done">{$vendor_status.status}</li>
            {else}    
                <li class="progtrckr-todo">{$vendor_status.status}</li>
            {/if}

            {$i = $i+1}
        {/foreach}
    {/if}
</ol>