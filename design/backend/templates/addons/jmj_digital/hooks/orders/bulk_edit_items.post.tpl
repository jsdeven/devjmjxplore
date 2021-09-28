{if $approve_order_permission}
    <li class="btn bulk-edit__btn bulk-edit__btn--print dropleft-mod">
        <span class="bulk-edit__btn-content dropdown-toggle" data-toggle="dropdown">{__("order_aprroval")} <span class="caret mobile-hide"></span></span>

        <ul class="dropdown-menu">
            <li>
                {btn type="list" 
                    text=__("approve_selected")
                    dispatch="dispatch[orders.m_approve]" 
                    form="orders_list_form" 
                    class="cm-process-items"}
            </li>
            <li>
                {btn type="list" 
                    text=__("disapprove_selected")
                    form="orders_list_form" 
                    class="cm-process-items cm-dialog-opener cm-dialog-auto-size" 
                    data=["data-ca-target-id" => "content_disapprove_selected"]}
            </li>
        </ul>
    </li>
{/if}    