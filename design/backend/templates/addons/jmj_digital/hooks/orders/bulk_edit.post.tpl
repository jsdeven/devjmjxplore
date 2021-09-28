{if $approve_order_permission}
    {capture name="disapprove_selected"}
        {include file="addons/jmj_digital/views/orders/components/reason_container.tpl" type="declined"}
        <div class="buttons-container">
            {include file="buttons/save_cancel.tpl" but_text=__("proceed") but_name="dispatch[orders.m_decline]" cancel_action="close" but_meta="cm-process-items"}
        </div>
    {/capture}
    {include file="common/popupbox.tpl" id="disapprove_selected" text=__("disapprove_selected") content=$smarty.capture.disapprove_selected link_text=__("disapprove_selected")}
{/if}    