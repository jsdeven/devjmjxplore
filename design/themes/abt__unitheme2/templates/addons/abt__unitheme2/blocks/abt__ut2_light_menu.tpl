{strip}
    {$menu_type = "Tygh\Addons\Abt_unitheme2\LMRepository::ITEM_TYPE_MENU"|constant}
    {$block_type = "Tygh\Addons\Abt_unitheme2\LMRepository::ITEM_TYPE_BLOCK"|constant}
    {$delimiter_type = "Tygh\Addons\Abt_unitheme2\LMRepository::ITEM_TYPE_DELIMITER"|constant}

    {**
        ut2-sw-w -- ut2-swipe-wrapper
        ut2-sw   -- ut2-swipe-parent
        ut2-sp-n -- ut2-swiper-on
        ut2-sp-f -- ut2-swiper-off
        ut2-st   -- ut2-swipe-title
        ac       -- active
        ut2-sw-b -- ut2-swipe-bolster
    **}
    {if $items}
        <div class="ut2-sw-b"></div>
        <div class="ut2-sw-w{** if isset($hide_wrapper)} cm-hidden-wrapper{/if **}{**{if $hide_wrapper} hidden{/if **}{if $block.user_class} {$block.user_class}{/if}{if $content_alignment == "RIGHT"} swipe-right{elseif $content_alignment == "LEFT"} swipe-left{/if}">
            <div class="ut2-st">
                {if $block.properties.abt__ut2_show_title == 'Y'}
                    {if $smarty.capture.title|trim}
                        {$smarty.capture.title nofilter}
                    {else}
                        {$title nofilter}
                    {/if}
                {/if}
                <div class="ut2-sp-f"><i class="ut2-icon-baseline-close"></i></div>
            </div>
            <div class="ut2-sp-n"><i class="ut2-icon-outline-menu"></i></div>
            <div class="ut2-scroll">
                <div class="ut2-sw">
                    {foreach $items as $item}
                        {if $item.type == $menu_type}
                            {*{include file="addons/abt__unitheme2/blocks/abt__ut2_light_menu/{$settings.abt__device}.tpl"}*}
                        {elseif $item.type == $block_type}
                            {render_block block_id=$item.block_id}
                        {/if}
                    {/foreach}
                </div>
            </div>
        </div>
    {/if}
{/strip}