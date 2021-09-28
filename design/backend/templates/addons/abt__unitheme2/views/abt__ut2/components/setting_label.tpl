<label for="{$f_id}">
{$label = __("`$ls`.`$section`.`$f_group``$s@key`")}
{$label}
{include file="common/tooltip.tpl" tooltip={__("`$ls`.`$section`.`$f_group``$s@key`.tooltip")}}
{if $s.is_addon_dependent and $s.is_addon_dependent == "YesNo::YES"|enum}<i class="icon-is-addon"></i>{/if}
</label>
{if $s.deprecated}
<p class="muted">{__("abt__ut2.settings.deprecated")}</p>
{/if}