{if $show_add_to_cart}
    <div class="ut2-vl__control">
        {if $show_qty}
            <div class="ut2-vl__qty">
                {assign var="qty" value="qty_`$obj_id`"}
                {$smarty.capture.$qty nofilter}
            </div>
        {/if}
        <div class="button-container">
            <button id="button_cart_{$obj_id}" class="ty-btn__primary ty-btn__add-to-cart ty-btn" type="submit" name="dispatch[checkout.add..{$obj_id}]"><span><i class="ut2-icon-outline-cart"></i><span>Add to cart</span></span></button>
        </div>
    </div>
{/if}