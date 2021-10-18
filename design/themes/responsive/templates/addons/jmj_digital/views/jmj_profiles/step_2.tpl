{style src="addons/jmj_digital/collapse.css"}
<style>
    .change-button{
        font-size: 14px;
        line-height: 5px;
        font-weight: 500;
        font-family: "Montserrat";
        text-align: center;
        background: #139d17;
        border: 0px;
        margin-top: -35px;
        border-radius: 5px;
        color: #ffffff;
        padding: 15px 15px;
        text-transform: uppercase;
        display: inline-block;
        transition: all 0.7s;
    }
</style>
<div >	
	<div class="ty-mainbox-container clearfix">
		<div class="ty-mainbox-body"><!-- Inline script moved to the bottom of the page -->
		   <div class="ty-account">		
			   <div id="account_register" style="margin:0;">
				<!--<div class="outer_event buyer_reg">
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
				</div>-->
				
				<div class="open apply-reg" id="apply">
					<div style="margin-left:0;">
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

									<button type="button" class="btn btn-default btn-primary sellerbtn mycustom-btn request-otp request-verify-gstin" id="request-otp">{__('verify_gstn')}</button>
								</div>
							</div>
						</div>	
						<div id="step_2_content" {if $gstn_verified} style="display:b_block;"{else}  style="display:none;"{/if}>
							<form  method="POST" class="cm-processed-form">	
								<input type="hidden" name="step" value="2" />
								<input type="hidden" name="customer_register_form_id" value="{$smarty.session.customer_register_form_id}" />

								<div id="b_address_fields">
									<div class="form-group">
										<label for="gstin_number" class="ty-control-group__title cm-required cm-name cm-trim">{__("gstin_number")}</label> 
										<input type="text" id="gstin_number" name="customer_data[gstin_number]" value="{$customer_data.gstin_number}" size="32" maxlength="128"  class="form-control  cm-required" placeholder="GSTIN Number" required disabled>
									</div>
									<a id="change_gstin" class="btn change-button">{__("change")}</a>
									<div class="form-group">
										<label for="pan_number" class="ty-control-group__title cm-required">{__("pan_number")}</label>
										<input type="text" id="pan_number" name="customer_data[pan_number]" value="{$customer_data.pan_number}" size="32" maxlength="32"  class="form-control cm-autocomplete-off" autocomplete="off">
									</div>
									<div class="form-group">
										<label for="b_name" class="ty-control-group__title cm-required cm-name cm-trim">{__("b_name")}</label> 
										<input type="text" id="b_name" name="customer_data[b_name]" value="{$customer_data.b_name}" size="32" maxlength="128"  class="form-control  cm-required" required>
									</div>
									<div class="form-group">
										<label for="b_address" class="ty-control-group__title cm-required cm-name cm-trim">{__("b_address")}</label> 
										<input type="text" id="b_address" name="customer_data[b_address]" value="{$customer_data.b_address}" size="32" class="form-control cm-required" required>
									</div>
									<div class="form-group" style="display: none;">
										<label for="b_address_2" class="ty-control-group__title cm-trim cm-required">{__("b_address_2")}</label> 
										<input type="text" id="b_address_2" name="customer_data[b_address_2]" value="{$customer_data.b_address_2}" size="32" class="form-control cm-focus" autocomplete="off" required />
									</div>

								
									<div class="row">
										<div class="col-md-6">
									<div class="form-group">
										<label for="b_city" class="ty-control-group__title cm-required cm-trim">{__("b_city")}</label> 
										<input type="text" id="b_city" name="customer_data[b_city]" value="{$customer_data.b_city}" size="32" maxlength="128"  class="form-control cm-focus" required  autocomplete="off" >
									</div>
									</div>
									<div class="col-md-6">
									<div class="form-group">
        								<label for="b_state" class="ty-control-group__title cm-required">{__('b_state')}</label>
        								<select id="b_state" name="customer_data[b_state]" class="gst_type form-select">
        									{foreach from=$states item=state}
        										<option indiazone="{$state.indiazone}" value="{$state.code}" {if $customer_data.b_state == $state.code}selected{/if}>{$state.state}</option>
        									{/foreach}    
        								</select>
        						    </div>	
									</div>
									</div>

									<div class="row">
										<div class="col-md-6">
									<div class="form-group">
										<label for="b_zipcode" class="ty-control-group__title cm-required">{__("b_zipcode")}</label>
										<input type="text" id="b_zipcode" name="customer_data[b_zipcode]" value="{$customer_data.b_zipcode}" size="32" maxlength="32"  class="form-control cm-autocomplete-off" autocomplete="off" required>
									</div>
									</div>
									<div class="col-md-6">
									<div class="form-group">
										<label for="b_country" class="ty-control-group__title cm-required">{__("b_country")}</label>
										<!--<input type="text" id="b_country" name="customer_data[b_country]" value="{$customer_data.b_country}" size="32" maxlength="32"  class="form-control cm-autocomplete-off" autocomplete="off" required />-->
										<select id="b_country" name="customer_data[b_country]" class="gst_type form-select">
											{foreach from=$countries item=country}
												<option value="{$country.code}" {if $customer_data.b_country == $country.code}selected{/if}>{$country.country}</option>
											{/foreach}    
										</select>
									</div>
									</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label for="gst_type" s class="cm-required">{__('gst_type')}</label>
												<select id="gst_type" name="customer_data[gst_type]" class="gst_type form-select">
													{foreach from=$gst_types item=gst_type}
														<option value="{$gst_type.value}" {if $customer_data.gst_type == $gst_type.value}selected{/if}>{$gst_type.name}</option>
													{/foreach}    
												</select>
											</div>	
										</div>

										<div class="col-md-6">
        						    <div class="form-group">
        								<label for="india_zone"  class="cm-required">{__('india_zone')}</label>
        								<!--<select id="india_zone" name="customer_data[india_zone]" class="gst_type form-select">
        									{foreach from=$india_zones item=india_zone}
        										<option value="{$india_zone.value}" {if $customer_data.india_zone == $india_zone.value}selected{/if}>{$india_zone.name}</option>
        									{/foreach}    
        								</select>-->
										<select id="india_zone" name="customer_data[india_zone]" class="gst_type form-select">
											<option value="{$customer_data.india_zone}" selected>{$customer_data.india_zone}</option>
										</select>

        						    </div>	
								</div>
								</div>
								<div class="shiping-group">
								<div class="shipping-flag" style="float:none; margin-top:0;">
									<div class="form-group">
									<label >Shipping from same as billing address?</label>
									<div class="input-group">
									<div class="radiobtn">
									<input class="cm-switch-availability" type="radio" name="customer_data[ship_to_another]" value="0" id="sw_sa_suffix_yes" {if $customer_data.ship_to_another == 0} checked="checked" {/if}>
									<label class="inline">
										Yes
									</label>
									</div>
									<div class="radiobtn">
										<input class="cm-switch-availability" type="radio" name="customer_data[ship_to_another]" value="1" id="sw_sa_suffix_no" {if $customer_data.ship_to_another == 1} checked="checked" {/if}>
										<label class="inline">
											No
										</label>
									</div>
									</div>
									</div>
								</div>
								</div>	

								<div id="s_address_fields">
								
									<div class="form-group">
										<label for="s_name" class="ty-control-group__title cm-required cm-name cm-trim">{__("s_name")}</label> 
										<input type="text" id="s_name" name="customer_data[s_name]" value="{$customer_data.s_name}" size="32" maxlength="128" class="form-control s_address_field cm-required" required>
									</div>
									<div class="form-group">
										<label for="s_address" class="ty-control-group__title cm-required cm-name cm-trim">{__("s_address")}</label> 
										<input type="text" id="s_address" name="customer_data[s_address]" value="{$customer_data.s_address}" size="32" maxlength="128" class="form-control s_address_field cm-required" required>
									</div>
									<div class="form-group" style="display: none;">
										<label for="s_address_2" class="ty-control-group__title cm-trim cm-required">{__("s_address_2")}</label> 
										<input type="text" id="s_address_2" name="customer_data[s_address_2]" value="{$customer_data.s_address_2}" size="32" class="form-control cm-focus s_address_field cm-required" autocomplete="off" required />
									</div>
									<div class="row">
												<div class="col-md-6">
											<div class="form-group">
												<label for="s_city" class="ty-control-group__title cm-trim cm-required">{__("s_city")}</label> 
												<input type="text" id="s_city" name="customer_data[s_city]" value="{$customer_data.s_city}" size="32" maxlength="128" class="form-control s_address_field cm-focus autocomplete="off" required>
											</div>
												</div>
												<div class="col-md-6">
											<div class="form-group">
												<label for="s_state" class="ty-control-group__title cm-required">{__('s_state')}</label>
												<!--<select id="s_state" name="customer_data[b_state]" class="s_state form-select mobile-block">
													{foreach from=$states item=state}
														<option value="{$state.code}" {if $customer_data.s_state == $state.code}selected{/if}>{$state.state}</option>
													{/foreach}    
												</select>-->
												<select id="s_state" name="customer_data[s_state]" class="s_state form-select mobile-block">
													{foreach from=$states item=state}
														<option indiazone="{$state.indiazone}" value="{$state.code}" {if $customer_data.s_state == $state.code}selected{/if}>{$state.state}</option>
													{/foreach}    
												</select>
											</div>	
										</div>
									</div>

									<div class="row">
									<div class="col-md-6">
									<div class="form-group">
										<label for="s_zipcode" class="ty-control-group__title cm-required">{__("s_zipcode")}</label>
										<input type="text" id="s_zipcode" name="customer_data[s_zipcode]" value="{$customer_data.s_zipcode}" size="32" maxlength="32" class="form-control s_address_field cm-autocomplete-off" autocomplete="off" required>
									</div>
									</div>
									<div class="col-md-6">
									<div class="form-group">
										<label for="s_country" class="ty-control-group__title cm-required">{__("s_country")}</label>
										<!--<input type="text" id="s_country" name="customer_data[s_country]" value="{$customer_data.s_country}" size="32" maxlength="32" class="form-control s_address_field cm-autocomplete-off" autocomplete="off" required>-->
										<select id="s_country" name="customer_data[s_country]" class="gst_type form-select">
											{foreach from=$countries item=country}
												<option value="{$country.code}" {if $customer_data.s_country == $country.code}selected{/if}>{$country.country}</option>
											{/foreach}    
										</select>

									</div>
									</div>
									</div>
								</div>	
								
								<div class="ty-profile-field__buttons" style="text-align:center;">
									<a href="{fn_url('jmj_profiles.add')}" class="btn sellerbtn mycustom-btn" style="margin-right: 30px;">{__("back")}</a>
									<button class="btn  sellerbtn mycustom-btn" type="submit" name="dispatch[profiles.add]">{__("next")}</button>
									<a href="{fn_url('jmj_profiles.add')}" class="btn  sellerbtn mycustom-btn"  style="margin-left: 30px;">{__("cancel")}</a>
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

		$("#b_state").change(function(){ 
            var element = $(this).find('option:selected'); 
            var indiazone = element.attr("indiazone"); 
            
            var option = '<option value='+indiazone+' selected>'+indiazone+'</option>';
            $('#india_zone').html(option);
            
        }); 
        
        $('#change_gstin').on('click', function(){
            $('#step_2_content').hide();
             $('#gstn_verification').show();
        });

		$('.request-verify-gstin').on('click',function(){
		
			var gstin = $('#gstn').val();
			if(!gstin){
				$('#mobile-error').show();
				return false;
			}
			var data = {
				gstin: gstin
			}
		
			$.ceAjax('request', fn_url('jmj_profiles.verify_gstin'), {
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
                    	$('#b_address').val(restext.data.bno+' '+restext.data.st+' '+restext.data.loc);
                    	$('#b_address_2').val(restext.data.bno);
                    	$('#b_zipcode').val(restext.data.pncd);
                    	var str = restext.gstin;
						$('#pan_number').val(str.substring(2, 12))

                    	var city = '';
                    	if(restext.data.city == ''){
                    	    city = restext.data.dst;
                    	}else{
                    	    city = restext.data.city;
                    	}
                    	$('#b_city').val(city);
                    	var state_name = restext.data.stcd;
                    	$("#b_state option:contains('"+state_name+"')").attr('selected', 'selected');

						var element = $('#b_state').find('option:selected'); 
                        var indiazone = element.attr("indiazone"); 
                        
                        var option = '<option value='+indiazone+' selected>'+indiazone+'</option>';
                        $('#india_zone').html(option);

                    	
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

	