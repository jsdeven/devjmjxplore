<div class="control-group cm-no-hide-input">
    <label class="control-label" for="elm_product_full_descr_new_new">{__("full_description")}:</label>
    <div class="controls">
        {include file="buttons/update_for_all.tpl" display=$show_update_for_all object_id="full_description" name="update_all_vendors[full_description]"}
        <textarea style="width: 100%;" id="elm_product_full_descr_new"
                    name="product_data[full_description]"
                    cols="55"
                    rows="8"
                class="cm-wysiwyg input-large"
                data-ca-is-block-manager-enabled="{fn_check_view_permissions("block_manager.block_selection", "GET")|intval}"
    >{$product_data.full_description}</textarea>
    
    </div>
</div>