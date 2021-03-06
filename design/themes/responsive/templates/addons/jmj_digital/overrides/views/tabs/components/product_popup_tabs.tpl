{capture name="popupsbox"}
    {foreach from=$tabs item="tab" key="tab_id"}
        {if $tab.show_in_popup == "Y" && $tab.status == "A"}
            {assign var="product_tab_id" value="product_tab_`$tab.tab_id`"}
            {assign var="tab_content_capture" value="tab_content_capture_`$tab_id`"}

            {capture name=$tab_content_capture}
                {if $tab.tab_type == 'B'}
                    {render_block block_id=$tab.block_id dispatch="products.view" use_cache=false parse_js=false}
                {elseif $tab.tab_type == 'T'}
                    {include file=$tab.template product_tab_id=$product_tab_id force_ajax=true}
                {/if}
            {/capture}

            {if $smarty.capture.$tab_content_capture|trim}
                <li class="ty-popup-tabs__item"><i class="ty-popup-tabs__icon ty-icon-popup"></i><a id="{$tab.html_id}" class="cm-dialog-opener" data-ca-target-id="content_block_popup_{$tab_id}" rel="nofollow">{$tab.name}</a></li>
                <div id="content_block_popup_{$tab_id}" class="hidden" title="{$tab.name}" data-ca-keep-in-place="true">
                    {$smarty.capture.$tab_content_capture nofilter}
                </div>
            {/if}
        {/if}
    {/foreach}
{/capture}

{capture name="popupsbox_content"}
    {if $smarty.capture.popupsbox|trim}
        <ul class="ty-popup-tabs">
            {$smarty.capture.popupsbox nofilter}
        </ul>
    {/if}
{/capture}

<div class="ty-cr-phone-number-link">
    <div class="ty-cr-phone"><span><bdi><span class="ty-cr-phone-prefix">{$phone_number.prefix}</span>{$phone_number.postfix}</bdi></span><span class="ty-cr-work">{__("call_request.work_time")}</span></div>
    <div class="ty-cr-link">
        {$obj_prefix = "block"}
        {$obj_id = $block.snapping_id|default:0}

        {if $smarty.request.company_id}
            {$href="call_requests.request?obj_prefix=`$obj_prefix`&obj_id=`$obj_id`&company_id=`$company_id`"}
        {else}
            {$href="call_requests.request?obj_prefix=`$obj_prefix`&obj_id=`$obj_id`"}
        {/if}

        {include file="common/popupbox.tpl"
            href=$href
            link_text=__("call_requests.request_call")
            text=__("call_requests.request_call")
            id="call_request_{$obj_prefix}{$obj_id}"
            content=""
        }
    </div>
</div>