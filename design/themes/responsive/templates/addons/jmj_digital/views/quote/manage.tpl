{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}

{if $search.sort_order == "asc"}
{assign var="sort_sign" value="<i class=\"ty-icon-down-dir\"></i>"}
{else}
{assign var="sort_sign" value="<i class=\"ty-icon-up-dir\"></i>"}
{/if}
{include file="common/pagination.tpl"}
<table class="ty-reward-points-userlog ty-table">
<thead>
    <tr>
        <th class="ty-reward-points-userlog__date"><a class="cm-ajax" href="{"`$c_url`&sort_by=timestamp&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">{__("date")}</a>{if $search.sort_by == "timestamp"}{$sort_sign nofilter}{/if}</th>
        <th >{__("amount")}</th>
        <th>{__("product")}</th>
        <th>{__("message")}</th>
        <th>{__("prices")}</th>
        <th>{__("remark")}</th>
    </tr>
</thead>
{foreach from=$quotes item="ul"}
<tr>
    <td>{$ul.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}</td>
    <td>{$ul.enq_qty}</td>
    <td><a class="row-status" title="{$ul.product_name}" href="index.php?dispatch=products.view&product_id={$ul.product_id}" target="_blank">{$ul.product_name}</a></td>
    <td>{$ul.message_bulk}</td>
    <td>{if $ul.assign_tocustomer eq 1}{$ul.price}{/if}</td>
    <td>{if $ul.assign_tocustomer eq 1}{$ul.comment}{/if}</td>
</tr>
{foreachelse}
<tr class="ty-table__no-items">
    <td colspan="3"><p class="ty-no-items">{__("no_items")}</p></td>
</tr>
{/foreach}
</table>
{include file="common/pagination.tpl"}
{** / userlog description section **}

{capture name="mainbox_title"}{__("rqlist")}{/capture}
