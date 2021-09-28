<!--<div class="control-group">
    <label for="elm_product_image_count" class="control-label cm-required">{__("product_image_count")}:</label>
    <div class="controls">
        <input type="number" name="category_data[product_image_count]" id="elm_product_image_count" size="3" value="{$category_data.product_image_count}" class="input-small" {if $is_trash}readonly="readonly"{/if} />
    </div>
</div>-->
<div class="control-group">
    <label class="control-label cm-required">{__("product_image_count")}:</label>
    <div class="controls" id="product_row">
        <div style="border: 1px solid #CCCCCC;border-radius: 3px;width: 200px;overflow: scroll;padding: 8px;">
            <label class="control-label" style = "width: 100%;float: none;text-align: left;"><input type = "checkbox" value = "front" name = "category_data[product_image_type][]" {if in_array('front',$category_data.product_image_type)} checked {/if} /><b style="padding: 5px;">{__('front_side')}</b><br /></label>
            <label class="control-label" style = "width: 100%;float: none;text-align: left;"><input type = "checkbox" value = "top" name = "category_data[product_image_type][]" {if in_array('top',$category_data.product_image_type)} checked {/if} /><b style="padding: 5px;">{__('top_side')}</b><br /></label>
            <label class="control-label" style = "width: 100%;float: none;text-align: left;"><input type = "checkbox" value = "left" name = "category_data[product_image_type][]" {if in_array('left',$category_data.product_image_type)} checked {/if} /><b style="padding: 5px;">{__('left_side')}</b><br /></label>
            <label class="control-label" style = "width: 100%;float: none;text-align: left;"><input type = "checkbox" value = "back" name = "category_data[product_image_type][]" {if in_array('back',$category_data.product_image_type)} checked {/if} /><b style="padding: 5px;">{__('back_side')}</b><br /></label>
            <label class="control-label" style = "width: 100%;float: none;text-align: left;"><input type = "checkbox" value = "bottom" name = "category_data[product_image_type][]" {if in_array('bottom',$category_data.product_image_type)} checked {/if} /><b style="padding: 5px;">{__('bottom_side')}</b><br /></label>
            <label class="control-label" style = "width: 100%;float: none;text-align: left;"><input type = "checkbox" value = "right" name = "category_data[product_image_type][]" {if in_array('right',$category_data.product_image_type)} checked {/if} /><b style="padding: 5px;">{__('right_side')}</b><br /></label>
        </div>
    </div>
</div>
<div class="control-group" id="product_main_image_data">
    <label class="control-label">{__('allowed_not_allowed_image')}:</label>
    <div class="controls">
        {include file="common/attach_images.tpl"
            image_name="cat_allowed_not_allowed"
            image_object_type="cat_allowed_not_allowed"
            image_type="M"
            image_pair=$category_data.cat_allowed_not_allowed
            no_detailed=true
            hide_titles=true
        }
    </div>
</div>

<div class="control-group" id="product_main_image_data_new">
    <label class="control-label">{__('guideline_image')}:</label>
    <div class="controls">
        {include file="common/attach_images.tpl"
            image_name="cat_guideline_image"
            image_object_type="cat_guideline_image"
            image_type="M"
            image_pair=$category_data.cat_guideline_image
            no_detailed=true
            hide_titles=true
        }
    </div>
</div>