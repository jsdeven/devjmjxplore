{assign var="complete_vendor_statuses" value=fn_jmj_digital_get_complete_vendor_statuses($order_info.last_complete_vendor_status)}
{assign var="current_vendor_status" value=fn_jmj_digital_get_current_vendor_status($order_info.last_complete_vendor_status)}

<div class = "container">
    <h3>{__('vendor_process_status')}</h3>
    {if $complete_vendor_statuses}
        {foreach from=$complete_vendor_statuses item=cvs}
            <label class = "checkbox-inline" style="float: left;margin-right: 10px;">
                <input {if $auth.user_type != 'V'}disabled{/if} class="vendor_status_id" name="last_status_secound" type="checkbox" value="{$cvs.serial_number}" style="margin-top: -4px;" checked><span style="margin-left: 5px;">{$cvs.status}</span>
            </label>
        {/foreach}
    {/if}
   
    {if $current_vendor_status}
        <label class = "checkbox-inline" style="float: left;margin-right: 10px;">
            <input {if $auth.user_type != 'V'}disabled{/if} class="vendor_status_id" name="last_status_first" type="checkbox" value="{$current_vendor_status.serial_number}" style="margin-top: -4px;"><span style="margin-left: 5px;">{$current_vendor_status.status}</span>
        </label>
    {/if}
</div>
{if $check_order_permission}
    <div class = "container" style="min-height: 0px;padding-bottom: 0px;">
        <label class="checkbox-inline" style="float: left;margin-right: 10px;">
            <input class="order_check_id" name="order_checked" type="checkbox" value="Y" style="margin-top: -4px;" {if $order_info.check_order == 'Y'}checked disabled{/if}><span style="margin-left: 5px;color: #142d67;font-weight: bold;">{__('order_check')}</span>
        </label>
    </div>
{/if}    
{include file="buttons/button.tpl" but_text=__("update_vendor_status") but_meta="hidden update_vendor_status" but_name="dispatch[orders.update_last_complete_vendor_status]"}
{include file="buttons/button.tpl" but_text=__("update_vendor_status") but_meta="hidden order_check_id_button" but_name="dispatch[orders.update_check_complete_order]"}

{if $approve_order_permission && ($order_info.status == 'O' || $order_info.status == 'A' || $order_info.status == 'E')} 
    
    <td data-th="{__("tools")}">
        {capture name="disapprove"}
            {include file="addons/jmj_digital/views/orders/disapproval_popup.tpl" name="approval_data[`$order_info.order_id`]" status="N" order_id=$order_info.order_id company_id=$order_info.company_id}
            <div class="buttons-container">
                {include file="buttons/save_cancel.tpl" but_text=__("disapprove") but_name="dispatch[orders.order_disapproval.disapprove.`$order_info.order_id`]" cancel_action="close" but_meta=""}
            </div>
        {/capture}
        
        {if $order_info.status == "O" || $order_info.status == "A"}
            {include file="common/popupbox.tpl" id="disapprove_`$order_info.order_id`" text="{__("disapprove_order")} \"`$order_info.order_id`\"" content=$smarty.capture.disapprove act="link" link_class="btn ty-btn__primary" link_text={__("disapprove")}}
        {/if}
    
        {if $order_info.status == "O" || $order_info.status == "E"}
            <a href="{"orders.order_approval.approve.`$order_info.order_id`"|fn_url}" style="margin-left: 15px;" class="btn ty-btn__secondary">{__("approve")}</a>
        {/if}
        
    </td>
{/if} 

<script type="text/javascript">
    $(document).ready(function(){
        $('.vendor_status_id').on('change', function(){
           $(".update_vendor_status").trigger( "click" )
        });
    });
    
    $(document).ready(function(){
        $('.order_check_id').on('change', function(){
           $(".order_check_id_button").trigger( "click" )
        });
    });
   
</script>
