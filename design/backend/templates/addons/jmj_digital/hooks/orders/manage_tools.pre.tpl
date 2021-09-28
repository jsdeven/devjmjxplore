{if $process_approved_order_permission && $_REQUEST.status == 'A'}
    {include file="buttons/button.tpl" but_name="dispatch[orders.process_approved_order]" but_text = "{__("Process")}" but_meta="cm-process-items jmj_orders_btn" but_role="submit-button" but_target_form="orders_list_form"}
{/if}