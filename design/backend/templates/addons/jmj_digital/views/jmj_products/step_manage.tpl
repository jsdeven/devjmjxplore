{capture name="mainbox"}

    <form action="{""|fn_url}" method="post" name="step_update_form">

        <div class="table-responsive-wrapper" id="profile_fields">
            <table width="100%" class="table table-middle table--relative table-responsive profile-fields__section">
                <thead>
                <tr>
                    <th width="30%">{__("step_number")}</th>
                    <th width="40%">{__("step_name")}</th>
                    <th width="30%">{__("show")}</th>
                    <th class="mobile-hide">&nbsp;</th>
                </tr>
                </thead>
                <tbody id="section_fields_{$section}" {if $is_deprecated}class="hidden"{/if}>
                    {foreach $steps as $step}
                        <tr>
                            <td data-th="{__("step_number")}">
                                {$step.step_number}
                            </td>
                            <td data-th="{__("step_name")}">
                                <input class="input-large" type="text" size="30" name="step_data[{$step.id}][step_name]" value="{$step.step_name}"/>
                            </td>
                        
                            <td data-th="{__("status")}">
                                <input type="checkbox" name="step_data[{$step.id}][status]" value="Y" {if $step.status == "Y"}checked="checked"{/if} class="cm-switch-availability"  {if $step.step_number == 1} disabled {/if}  />
                            </td>
                        </tr>
                    {/foreach}
        
                </tbody>
            </table>
           
        </div>
    </form>
    {capture name="adv_buttons"}

    {/capture}

    {capture name="buttons"}
        {include file="buttons/save.tpl" but_name="dispatch[jmj_products.steps_update]" but_role="action" but_target_form="step_update_form" but_meta="cm-submit"}
    {/capture}
{/capture}

{include file="common/mainbox.tpl" title=__("product_steps") content=$smarty.capture.mainbox buttons=$smarty.capture.buttons adv_buttons=$smarty.capture.adv_buttons select_languages=true}