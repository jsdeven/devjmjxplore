{if $cat_guideline_image}
    <div class="controls">
        <a class="show_guideline_image"><h5>{__('guideline_image')}<i class="ty-icon-help-circle"></i></h5></a>
    </div>
{/if}    
{if $product_data.main_pair}
    {assign var="used_image_pair" value=array()}
    
    {if $ProductImagesType}
        {assign var="image_name" value="{$ProductImagesType.0}"}
         {$used_image_pair[] = $image_name}
    {else}
        {assign var="image_name" value="{__("image")}"}
    {/if}
    <div class="control-group" id="product_main_image_data">
        <label class="control-label cm-required">{$image_name|ucfirst}:</label>
        <div class="controls">
            {include file="addons/jmj_digital/views/common/attach_images.tpl"
                image_name="product_main"
                image_object_type="product"
                image_type="M"
                image_pair=$product_data.main_pair
                image_object_id=$id
                no_detailed=false
                no_thumbnail=true
                hide_titles=true
            }
        </div>
    </div>
    {if !$product_data.image_pairs}
        {for $i=2 to $ProductImagesCount}
            {assign var="ind" value="{$i-1}"}
            {if $ProductImagesType}
                {assign var="image_name" value="{$ProductImagesType.$ind}"}
            {else}
                {assign var="image_name" value="{__("image")}"}
            {/if}
            <div class="control-group" id="product_main_image_data">
                <label class="control-label cm-required">{$image_name|ucfirst}:</label>
                <div class="controls">
                    {include file="addons/jmj_digital/views/common/attach_images.tpl"
                        image_name="product_additional"
                        image_object_type="product"
                        image_key=$ind
                        image_type="A"
                        image_pair=$image_pair
                        image_object_id=$id
                        no_detailed=false
                        no_thumbnail=true
                        hide_titles=true
                    }
                </div>
            </div>
        {/for}
    {/if}
    {if $product_data.image_pairs}
   
        {assign var="i" value="1"}
        {assign var="op" value="1"}
        {foreach $product_data.image_pairs as $image_pair}
            {if $ProductImagesType}
                {assign var="image_name" value="{$ProductImagesType.$i}"}
                {$used_image_pair[] = $image_name}
                {if $image_name == ''}
                    {assign var="image_name" value="Optional-$op"}
                    {$op = $op+1}
                {/if}
                    
            {else}
                {assign var="image_name" value="{__("image")}"}
            {/if}

            <div class="control-group" id="product_main_image_data">
                <label class="control-label {if $op<2}cm-required{/if}">{$image_name|ucfirst}: </label>
                <div class="controls">
                    {include file="addons/jmj_digital/views/common/attach_images.tpl"
                        image_name="product_additional"
                        image_object_type="product"
                        image_type="A"
                        image_key=$i
                        image_pair=$image_pair
                        image_object_id=$id
                        no_detailed=false
                        no_thumbnail=true
                        hide_titles=true
                    }
                </div>
            </div>
            {$i = $i+1}
        {/foreach}
        {if $ProductImagesCount}
            {assign var="total_image_paires" value="{$ProductImagesCount-1}"}
            {assign var="left_image_paires" value="{$total_image_paires-count($product_data.image_pairs)}"}
            
            {assign var="empty_image_pair" value=array()}
            {if $left_image_paires}
                {if $ProductImagesType && $used_image_pair}
                    {assign var="ProductImagesType" value=array_diff($ProductImagesType, $used_image_pair)} 
                {/if}
                
                {for $i=1 to $left_image_paires}
                    {assign var="image_key" value="{$total_image_paires+$i}"}
                    {assign var="j" value=$i-1}
                    {assign var="newProductImagesType" value=array_values($ProductImagesType)}
                    {assign var="image_name" value="{$newProductImagesType.$j}"}
                    {$used_image_pair[] = $image_name}
                   
                    <div class="control-group" id="product_main_image_data">
                        <label class="control-label cm-required">{$image_name|ucfirst}: </label>
                        <div class="controls">
                            {include file="addons/jmj_digital/views/common/attach_images.tpl"
                                image_name="product_additional"
                                image_object_type="product"
                                image_type="A"
                                image_key=$image_key
                                image_pair=$empty_image_pair
                                image_object_id=$id
                                no_detailed=false
                                no_thumbnail=true
                                hide_titles=true
                            }
                        </div>
                    </div>
                {/for}
            {/if}
        {/if}
    {/if}  
{else}
   
    {for $i=1 to $ProductImagesCount}
        {assign var="ind" value="{$i-1}"}
        {if $ProductImagesType}
            {assign var="image_label_name" value="{$ProductImagesType.$ind}"}
        {else}
            {assign var="image_label_name" value="{__("image")}"}
        {/if}
        {if $i == 1}
            {assign var="image_name" value="product_main"}
            {assign var="image_type" value="M"}
        {else}
            {assign var="image_name" value="product_additional"}
             {assign var="image_type" value="A"}
        {/if}
        <div class="control-group" id="product_main_image_data">
            <label class="control-label cm-required">{$image_label_name|ucfirst}: </label>
            <div class="controls">
                {include file="addons/jmj_digital/views/common/attach_images.tpl"
                    image_name="{$image_name}"
                    image_object_type="product"
                    image_type=$image_type
                    image_key=$i
                    image_pair=$image_pair
                    image_object_id=$id
                    no_detailed=false
                    no_thumbnail=true
                    hide_titles=true
                }
            </div>
        </div>
    {/for}
    
    <div class="control-group" id="product_main_image_data">
        <label class="control-label">Optional-1:</label>
        <div class="controls">
            {include file="addons/jmj_digital/views/common/attach_images.tpl"
                image_name="product_additional"
                image_object_type="product"
                image_key=$ind+2
                image_type="A"
                image_pair=$image_pair
                image_object_id=$id
                no_detailed=false
                no_thumbnail=true
                hide_titles=true
            }
        </div>
    </div>
    
    <div class="control-group" id="product_main_image_data">
        <label class="control-label">Optional-2</label>
        <div class="controls">
            {include file="addons/jmj_digital/views/common/attach_images.tpl"
                image_name="product_additional"
                image_object_type="product"
                image_key=$ind+3
                image_type="A"
                image_pair=$image_pair
                image_object_id=$id
                no_detailed=false
                no_thumbnail=true
                hide_titles=true
            }
        </div>
    </div>
    
    <div class="control-group" id="product_main_image_data">
        <label class="control-label">Optional-3:</label>
        <div class="controls">
            {include file="addons/jmj_digital/views/common/attach_images.tpl"
                image_name="product_additional"
                image_object_type="product"
                image_key=$ind+4
                image_type="A"
                image_pair=$image_pair
                image_object_id=$id
                no_detailed=false
                no_thumbnail=true
                hide_titles=true
            }
        </div>
    </div>
{/if} 



<div class="jmj-modal">
    <span class="jmj-close">&times;</span>
    <img src="{$cat_guideline_image}" class="jmj-modalImage" id="modalImage01">
    <div id="jmj-modal-caption">{__('guideline_image')}</div>
</div>

<script>
    var modalEle = document.querySelector(".jmj-modal");
    var modalImage = document.querySelector(".jmj-modalImage");
    let wow;
    
    document.querySelector('.show_guideline_image').addEventListener('click',(event)=>{
        modalEle.style.display = "block";
    });
    
    document.querySelector(".jmj-close").addEventListener('click',()=>{
        modalEle.style.display = "none";
    });
</script>




