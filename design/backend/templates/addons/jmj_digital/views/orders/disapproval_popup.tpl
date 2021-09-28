<div class="form-horizontal form-edit">
	<div class="control-group">
		<label class="control-label" for="{$name}">{__("reason")}:</label>
	    <div class="controls">
	    	<input type="hidden" name="{$name}[company_id]" value="{$company_id}" />
	    	<input type="hidden" name="{$name}[order_id]" value="{$order_id}" />
	    	<textarea name="{$name}[reason]" id="{$name}" cols="50" rows="4" class="input-text input-large"></textarea>
	    </div>
	</div>
	
	<div class="control-group cm-toggle-button">
		<label class="control-label" for="notify_user_{$order_id}">{__("notify_to_customer")}</label>
	    <div class="controls">
	    	<input type="checkbox" name="{$name}[notify_user_{$status}]" id="notify_user_{$order_id}" value="Y" checked="checked">
	    </div>
	</div>
</div>