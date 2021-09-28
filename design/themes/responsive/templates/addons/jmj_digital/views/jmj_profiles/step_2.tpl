{style src="addons/jmj_digital/collapse.css"}
<div class="span16" style="padding:10px 0 10px 10px;margin-left:0;" >	
<div class="ty-mainbox-container clearfix">
     <div class="ty-mainbox-body">			
		<div class="ty-account">
			<div id="account_register">
				<div class="outer_event buyer_reg">
					<div class="all_cat onjtopancd"> 
						<div class="ty-column4 wizard links__active">
							<a><span class="tab_number_selected">1</span>{__("create_buyer_account")}</a>
						</div>
						<div class="ty-column4 wizard {if $_REQUEST.step >= 2}links__active{/if}">
							<a><span class="{if $_REQUEST.step >= 2}tab_number_selected{else}tab_number{/if}">2</span>{__("business_information")}</a>
						</div>
						<div class="ty-column4 wizard {if $_REQUEST.step >= 3}links__active{/if}">
							<a><span class="{if $_REQUEST.step >= 3}tab_number_selected{else}tab_number{/if}">3</span>{__("payment_mode")}</a>
						</div>
						<div class="ty-column4 wizard {if $_REQUEST.step >= 4}links__active{/if}">
							<a><span class="{if $_REQUEST.step >= 4}tab_number_selected{else}tab_number{/if}">4</span>{__("bank_information")}</a>
						</div>
					</div>
				</div>
				
				<div class="open apply-reg" id="apply">
					<div class="content">
						<div id="gstn_verification" {if $gstn_verified} style="display:none;"{/if}>
							<h5 id="request-otp-success">{__('gstn_successfully_verified')}</h5>
							<div class="container new-login-area">
								<div id='sign-in' class='login-setup-section'>
									<h4 class="request-otp-header">{__('heading_verify_gstn')}</h4>
									<div class="form-group login-label">
										<label for="gstn" class="cm-required">{__('gstn')}</label>
										<input type="text" class="form-control input-edit" placeholder="{__('enter_gst_number')}" id="gstn">
										<h6 id="mobile-error">{__('gstn_required')}</h6>
									</div>
									<button type="button" class="btn btn-default btn-lg btn-b_block request-otp request-verify-gstin" id="request-otp">{__('verify_gstn')}</button>
								</div>
							</div>
						</div>	
						<div id="step_2_content" {if $gstn_verified} style="display:b_block;"{else}  style="display:none;"{/if}>
							<form  method="POST" class="cm-processed-form">	
								<input type="hidden" name="step" value="2" />
								<input type="hidden" name="customer_register_form_id" value="{$smarty.session.customer_register_form_id}" />

								<div id="b_address_fields">
									<div class="ty-control-group">
										<label for="gstin_number" class="ty-control-group__title cm-required cm-name cm-trim">{__("gstin_number")}</label> 
										<input type="text" id="gstin_number" name="customer_data[gstin_number]" value="{$customer_data.gstin_number}" size="32" maxlength="128"  class="ty-input-text  cm-required" placeholder="GSTIN Number" required>
									</div>
									<div class="ty-control-group">
										<label for="pan_number" class="ty-control-group__title cm-required">{__("pan_number")}</label>
										<input type="text" id="pan_number" name="customer_data[pan_number]" value="{$customer_data.pan_number}" size="32" maxlength="32"  class="ty-input-text cm-autocomplete-off" autocomplete="off">
									</div>
									<div class="ty-control-group">
										<label for="b_name" class="ty-control-group__title cm-required cm-name cm-trim">{__("b_name")}</label> 
										<input type="text" id="b_name" name="customer_data[b_name]" value="{$customer_data.b_name}" size="32" maxlength="128"  class="ty-input-text  cm-required" required>
									</div>
									<div class="ty-control-group">
										<label for="b_address" class="ty-control-group__title cm-required cm-name cm-trim">{__("b_address")}</label> 
										<input type="text" id="b_address" name="customer_data[b_address]" value="{$customer_data.b_address}" size="32" class="ty-input-text cm-required" required>
									</div>
									<div class="ty-control-group">
										<label for="b_address_2" class="ty-control-group__title cm-trim cm-required">{__("b_address_2")}</label> 
										<input type="text" id="b_address_2" name="customer_data[b_address_2]" value="{$customer_data.b_address_2}" size="32" class="ty-input-text cm-focus" autocomplete="off" required />
									</div>
									<div class="ty-control-group">
										<label for="b_city" class="ty-control-group__title cm-trim cm-required">{__("b_city")}</label> 
										<input type="text" id="b_city" name="customer_data[b_city]" value="{$customer_data.b_city}" size="32" maxlength="128" class="ty-input-text cm-focus autocomplete="off" required />
									</div>
									<div class="ty-control-group">
        								<label for="b_state" class="cm-required">{__('b_state')}</label>
        								<select id="b_state" name="customer_data[b_state]" class="b_state">
        									{foreach from=$states item=state}
        										<option value="{$state.code}" {if $customer_data.b_state == $state.code}selected{/if}>{$state.state}</option>
        									{/foreach}    
        								</select>
        						    </div>	
									
									<div class="ty-control-group">
										<label for="b_zipcode" class="ty-control-group__title cm-required">{__("b_zipcode")}</label>
										<input type="text" id="b_zipcode" name="customer_data[b_zipcode]" value="{$customer_data.b_zipcode}" size="32" maxlength="32"  class="ty-input-text cm-autocomplete-off" autocomplete="off" required>
									</div>
									<div class="ty-control-group">
										<label for="b_country" class="ty-control-group__title cm-required">{__("b_country")}</label>
										<input type="text" id="b_country" name="customer_data[b_country]" value="{$customer_data.b_country}" size="32" maxlength="32"  class="ty-input-text cm-autocomplete-off" autocomplete="off" required />
									</div>
									<div class="ty-control-group">
        								<label for="gst_type" s class="cm-required">{__('gst_type')}</label>
        								<select id="gst_type" name="customer_data[gst_type]" class="gst_type">
        									{foreach from=$gst_types item=gst_type}
        										<option value="{$gst_type.value}" {if $customer_data.gst_type == $gst_type.value}selected{/if}>{$gst_type.name}</option>
        									{/foreach}    
        								</select>
        						    </div>	
        						    <div class="ty-control-group">
        								<label for="india_zone"  class="cm-required">{__('india_zone')}</label>
        								<select id="india_zone" name="customer_data[india_zone]" class="gst_type">
        									{foreach from=$india_zones item=india_zone}
        										<option value="{$india_zone.value}" {if $customer_data.india_zone == $india_zone.value}selected{/if}>{$india_zone.name}</option>
        									{/foreach}    
        								</select>
        						    </div>	
								</div>

								<div class="shipping-flag" style="float:none;">
									<span class="shipping-flag-title">
										Shipping from same as Billing Address?
									</span>
									<label class="radio inline">
										<input class="cm-switch-availability" type="radio" name="customer_data[ship_to_another]" value="0" id="sw_sa_suffix_yes" {if $customer_data.ship_to_another == 0} checked="checked" {/if}>Yes
									</label>
									
									<label class="radio inline">
										<input class="cm-switch-availability" type="radio" name="customer_data[ship_to_another]" value="1" id="sw_sa_suffix_no" {if $customer_data.ship_to_another == 1} checked="checked" {/if}>No
									</label>
								</div>
								<div id="s_address_fields">
								
									<div class="ty-control-group">
										<label for="s_name" class="ty-control-group__title cm-required cm-name cm-trim">{__("s_name")}</label> 
										<input type="text" id="s_name" name="customer_data[s_name]" value="{$customer_data.s_name}" size="32" maxlength="128" class="ty-input-text s_address_field cm-required" required>
									</div>
									<div class="ty-control-group">
										<label for="s_address" class="ty-control-group__title cm-required cm-name cm-trim">{__("s_address")}</label> 
										<input type="text" id="s_address" name="customer_data[s_address]" value="{$customer_data.s_address}" size="32" maxlength="128" class="ty-input-text s_address_field cm-required" required>
									</div>
									<div class="ty-control-group">
										<label for="s_address_2" class="ty-control-group__title cm-trim cm-required">{__("s_address_2")}</label> 
										<input type="text" id="s_address_2" name="customer_data[s_address_2]" value="{$customer_data.s_address_2}" size="32" class="ty-input-text cm-focus s_address_field cm-required" autocomplete="off" required />
									</div>
									<div class="ty-control-group">
										<label for="s_city" class="ty-control-group__title cm-trim cm-required">{__("s_city")}</label> 
										<input type="text" id="s_city" name="customer_data[s_city]" value="{$customer_data.s_city}" size="32" maxlength="128" class="ty-input-text s_address_field cm-focus autocomplete="off" required>
									</div>
									<div class="ty-control-group">
        								<label for="s_state" class="cm-required">{__('s_state')}</label>
        								<select id="s_state" name="customer_data[b_state]" class="s_state">
        									{foreach from=$states item=state}
        										<option value="{$state.code}" {if $customer_data.s_state == $state.code}selected{/if}>{$state.state}</option>
        									{/foreach}    
        								</select>
        						    </div>	
									
									<div class="ty-control-group">
										<label for="s_zipcode" class="ty-control-group__title cm-required">{__("s_zipcode")}</label>
										<input type="text" id="s_zipcode" name="customer_data[s_zipcode]" value="{$customer_data.s_zipcode}" size="32" maxlength="32" class="ty-input-text s_address_field cm-autocomplete-off" autocomplete="off" required>
									</div>
									<div class="ty-control-group">
										<label for="s_country" class="ty-control-group__title cm-required">{__("s_country")}</label>
										<input type="text" id="s_country" name="customer_data[s_country]" value="{$customer_data.s_country}" size="32" maxlength="32" class="ty-input-text s_address_field cm-autocomplete-off" autocomplete="off" required>
									</div>
							
								</div>	
								
								<div class="ty-profile-field__buttons" style="text-align:center;">
									<a href="{fn_url('jmj_profiles.add')}" class="ty-btn__primary ty-btn" style="padding: 8px 7px;margin-right: 30px;">{__("back")}</a>
									<button class="ty-btn__secondary ty-btn" type="submit" name="dispatch[profiles.add]">{__("next")}</button>
									<a href="{fn_url('jmj_profiles.add')}" class="ty-btn__primary ty-btn" style="padding: 8px 7px;margin-left: 30px;">{__("cancel")}</a>
								</div>
								
							</form>
						</div>		
					</div>
				</div>	
			</div>	
		</div>
    </div>
</div>
</div>
{literal}
	<script>
		$('.request-verify-gstin').on('click',function(){
		
			var gstin = $('#gstn').val();
			if(!gstin){
				$('#mobile-error').show();
				return false;
			}
			var data = {
				gstin: gstin
			}
		
			$.ceAjax('request', fn_url('auth.verify_gstin'), {
				cache: false,
				data: data,
				callback: function(response) {
					var restext = $.parseJSON(response.text);
					if(restext.status == 1){
					    
					    $('#gstin_found_error').hide();
						$('#request-otp-success').show();
						setTimeout(function() {
							$('#request-otp-success').hide();
							$('#gstn_verification').hide();
						    $('#step_2_content').show();
                    	    //$('#gstin_number').prop('disabled', true);
                    	
                    	}, 1000);
                    	
                    	
                    	$('#gstin_number').val(restext.gstin);
                    	$('#b_name').val(restext.data.b_name);
                    	$('#b_address').val(restext.data.st);
                    	$('#b_address_2').val(restext.data.bno);
                    	$('#b_zipcode').val(restext.data.pncd);
                    	
                    	var city = '';
                    	if(restext.data.city == ''){
                    	    city = restext.data.dst;
                    	}else{
                    	    city = restext.data.city;
                    	}
                    	$('#b_city').val(city);
                    	var state_name = restext.data.stcd;
                    	$("#b_state option:contains('"+state_name+"')").attr('selected', 'selected');
                    	
					}else{
					    $('#gstin_found_error').show();
						
						$('#gstn_verification').show();
						$('#step_2_content').hide();
					}
				}
			});
		
		});

		$('.cm-switch-availability').change(function(){
	
			if($(this).is(':checked') && $(this).val() == '0') {
				$('.s_address_field').each(function(){
					$(this).prop('disabled', true);
				});
				
				var b_state = $('#b_state').val();
			
				$('#s_name').val($('#b_name').val());
				$('#s_address').val($('#b_address').val());
				$('#s_address_2').val($('#b_address_2').val());
				$('#s_city').val($('#b_city').val());
				$('#s_zipcode').val($('#b_zipcode').val());
				$('#s_country').val($('#b_country').val());
				$("#s_state option[value='"+b_state+"']").attr("selected","selected");
			
			}else{

				$('.s_address_field').each(function(){
					$(this).prop('disabled', false);
				});
				
				$('#s_name').val('');
				$('#s_address').val('');
				$('#s_address_2').val('');
				$('#s_city').val('');
				$('#s_zipcode').val('');
				$('#s_country').val('');
				//$("#s_state option[value='AN']").attr("selected","selected");
			}
		});
	</script>
{/literal}

	