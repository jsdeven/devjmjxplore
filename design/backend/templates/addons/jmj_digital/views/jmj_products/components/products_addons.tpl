{if $runtime.company_id && "ULTIMATE"|fn_allowed_for || "MULTIVENDOR"|fn_allowed_for}
    {include file="common/subheader.tpl" title=__("comments_and_reviews") target="#discussion_product_setting"}
    <div id="discussion_product_setting" class="in collapse">
    	<fieldset>
			{$no_hide_input = false}
			{if "ULTIMATE"|fn_allowed_for}
				{$no_hide_input = true}
			{/if}

            {include file="addons/discussion/views/discussion_manager/components/allow_discussion.tpl"
                prefix="product_data"
                object_id=$product_data.product_id
                object_type="Addons\\Discussion\\DiscussionObjectTypes::PRODUCT"|enum
                title=__("discussion_title_product")
                no_hide_input=$no_hide_input
                discussion_default_type=$addons.discussion.product_discussion_type
            }
    	</fieldset>
    </div>
{/if}
{*
{include file="common/subheader.tpl" title=__("rma") target="#acc_addon_rma"}
<div id="acc_addon_rma" class="collapse in">
<div class="control-group">
    <label class="control-label" for="is_returnable">{__("returnable")}:</label>
    <div class="controls">
        <label class="checkbox">
        <input type="hidden" name="product_data[is_returnable]" id="is_returnable" value="N" />
        <input type="checkbox" name="product_data[is_returnable]" value="Y" {if $product_data.is_returnable == "Y" || $runtime.mode == "add"}checked="checked"{/if} onclick="Tygh.$.disable_elms(['return_period'], !this.checked);" />
        </label>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="return_period">{__("return_period_days")}:</label>
    <div class="controls">
        <input type="text" id="return_period" name="product_data[return_period]" value="{$product_data.return_period|default:"10"}" size="10"  {if $product_data.is_returnable != "Y" && $runtime.mode != "add"}disabled="disabled"{/if} />
    </div>
</div>
*}
</div>
