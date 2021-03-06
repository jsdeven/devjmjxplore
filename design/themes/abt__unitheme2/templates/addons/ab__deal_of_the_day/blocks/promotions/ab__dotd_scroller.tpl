{** block-description:ab__dotd_scroller **}

{$image_height="200"}
{$image_width="330"}

{if $items}
    {assign var="obj_prefix" value="`$block.block_id`000"}
    {if $block.properties.outside_navigation == "Y"}
        <div class="owl-theme ty-owl-controls">
            <div class="owl-controls clickable owl-controls-outside" id="owl_outside_nav_{$block.block_id}">
                <div class="owl-buttons">
                    <div id="owl_prev_{$obj_prefix}" class="owl-prev"><i class="ty-icon-left-open-thin"></i></div>
                    <div id="owl_next_{$obj_prefix}" class="owl-next"><i class="ty-icon-right-open-thin"></i></div>
                </div>
            </div>
        </div>
    {/if}
    
    <div class="ab__dotd_promotions scroller">
        <div id="scroll_list_{$block.block_id}" class="owl-carousel ty-scroller-list">
            {foreach from=$items item="promotion"}
	            {if $promotion.status == "A"}
	                <div class="ab__dotd_promotions-item">
                        <div class="ab__dotd_promotions-item_image">
                            <a href="{"promotions.view?promotion_id=`$promotion.promotion_id`"|fn_url}" title="">
                                {include file="common/image.tpl" images=$promotion.image image_height=$image_height image_width=$image_width no_ids=true}
                            </a>
                        </div>

                        {if $promotion.ab__dotd_active && $promotion.to_date}
                            {assign var="days_left" value=(($promotion.to_date-$smarty.now)/86400)|ceil}
                            <div class="ab__dotd_promotions-item_days_left{if $days_left <= $addons.ab__deal_of_the_day.highlight_when_left} ab__dotd_highlight{/if}">
                                {if $days_left > 1}
                                    {__('ab__dotd.days_left', [$days_left])}
                                {else}
                                    {__('ab__dotd.today_only')}
                                {/if}
                            </div>
                        {elseif $promotion.ab__dotd_awaited}
                            {assign var="days_left" value=(1-($smarty.now-$promotion.from_date)/86400)|floor}
                            <div class="ab__dotd_promotions-item_days_left">
                                {__('ab__dotd.days_to_start', [$days_left])}
                            </div>
                        {elseif $promotion.ab__dotd_expired}
                            <div class="ab__dotd_promotions-item_days_left">
                                {__('ab__dotd.promotion_expired')}
                            </div>
                        {/if}

                        <div class="ab__dotd_promotions-item_title">
                            <a href="{"promotions.view?promotion_id=`$promotion.promotion_id`"|fn_url}" title="">{$promotion.name nofilter}</a>
                            <div class="ab__dotd_promotions-item_date">
                                {if $promotion.from_date}
                                    {__('ab__dotd.from')} {$promotion.from_date|date_format:"`$settings.Appearance.date_format`"}
                                {/if}
                                {if $promotion.to_date}
                                    {__('ab__dotd.to')} {$promotion.to_date|date_format:"`$settings.Appearance.date_format`"}
                                {/if}
                            </div>
                        </div>
	                </div>
	             {/if}
            {/foreach}
        </div>
    
    {include file="common/scroller_init_with_quantity.tpl" prev_selector="#owl_prev_`$obj_prefix`" next_selector="#owl_next_`$obj_prefix`"}

    <div class="all-promotions__button"{if $block.properties.outside_navigation != "Y"} style="right: 0;"{/if}><a href="{"promotions.list"|fn_url}" class="ty-btn ty-btn__primary" title="">{__("ab__dotd.all_promotions_list")}</a></div>
    </div>

{/if}