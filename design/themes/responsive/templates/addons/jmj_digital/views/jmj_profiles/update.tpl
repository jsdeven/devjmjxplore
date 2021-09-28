
{if $_REQUEST.step == '1' || !$_REQUEST.step}
	{include file="addons/jmj_digital/views/jmj_profiles/step_1.tpl"}
{elseif $_REQUEST.step == '2'}
	{include file="addons/jmj_digital/views/jmj_profiles/step_2.tpl"}
{elseif $_REQUEST.step == '3'}
	{include file="addons/jmj_digital/views/jmj_profiles/step_3.tpl"}
{elseif $_REQUEST.step == '4'}
	{include file="addons/jmj_digital/views/jmj_profiles/step_4.tpl"}
{elseif $_REQUEST.step == '5'}
	{include file="addons/jmj_digital/views/jmj_profiles/success.tpl"}
{/if}


					  
		