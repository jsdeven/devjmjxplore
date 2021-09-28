<div class="control-group">
    <label class="control-label cm-required" for="elm_feature_group_{$id}">{__("feature_variant_design")}</label>
    <div class="controls">
        <select name="feature_data[feature_variant_design]" id="elm_feature_group_{$id}" data-ca-feature-id="{$id}" class="cm-feature-group">
            <option value="0">-{__("none")}-</option>
            <option value="1" {if $feature.feature_variant_design == 1}selected="selected"{/if}>{__('image_in_popup')} (Dropdown List)</option>
            <option value="2" {if $feature.feature_variant_design == 2}selected="selected"{/if}>{__('perc_in_popup')} (Multiple Checkbox)</option>
        </select>
    </div>
</div>
<div class="control-group">
    <label class="control-label cm-required" for="elm_feature_group_{$id}">{__("multi_colors_filter")}</label>
    <div class="controls">
        <select name="feature_data[multi_colors_filter]" id="elm_feature_group_{$id}" data-ca-feature-id="{$id}" class="cm-feature-group">
            <option value="0">No</option>
            <option value="1" {if $feature.multi_colors_filter == 1}selected="selected"{/if}>Yes</option>
        </select>
    </div>
</div>