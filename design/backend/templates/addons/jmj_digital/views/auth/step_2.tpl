{style src="addons/jmj_digital/collapse.css"}
<head>
	<title>Seller JMJ Xplore</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="images/fevicon.png" sizes="64x64" type="image/png">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="/design/backend/css/addons/jmj_digital/seller_page_assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="/design/backend/css/addons/jmj_digital/seller_page_assets/css/owl.carousel.min.css">
	<link rel="stylesheet" href="/design/backend/css/addons/jmj_digital/seller_page_assets/css/owl.theme.default.min.css">
	<link rel="stylesheet" href="/design/backend/css/addons/jmj_digital/seller_page_assets/css/owl.transitions.css">
	<link rel="stylesheet" href="/design/backend/css/addons/jmj_digital/seller_page_assets/css/style.css">
	<link rel="stylesheet" href="/design/backend/css/addons/jmj_digital/seller_page_assets/css/responsive.css">
  </head>

<div>
		
<div class="ty-mainbox-container clearfix">
     <div class="ty-mainbox-body">			
		<div class="ty-account">
			<div id="account_register" style="margin:0;">
				<!-- <div class="outer_event buyer_reg">
					<div class="all_cat onjtopancd"> 
						<div class="ty-column4 wizard links__active">
							<a><span class="tab_number_selected">1</span>{__("create_seller_account")}</a>
						</div>
						<div class="ty-column4 wizard {if $_REQUEST.step >= 2}links__active{/if}">
							<a><span class="{if $_REQUEST.step >= 2}tab_number_selected{else}tab_number{/if}">2</span>{__("business_information")}</a>
						</div>
						<div class="ty-column4 wizard {if $_REQUEST.step >= 3}links__active{/if}">
							<a><span class="{if $_REQUEST.step >= 3}tab_number_selected{else}tab_number{/if}">3</span>{__("brand_and_category")}</a>
						</div>
						<div class="ty-column4 wizard {if $_REQUEST.step >= 4}links__active{/if}">
							<a><span class="{if $_REQUEST.step >= 4}tab_number_selected{else}tab_number{/if}">4</span>{__("bank_information")}</a>
						</div>
					</div>
				</div> -->
				
				<div class="open apply-reg" id="apply">
					<div>
						<div id="gstn_verification" {if $gstn_verified} style="display:none;"{/if}>
							
							<h5 id="request-otp-success">{__('gstn_successfully_verified')}</h5>
							<h5 id="gstin_found_error">{__('gstn_not_found')}</h5>
							<div class="container new-login-area">
								<div id='sign-in' class='login-setup-section'>
									<h4 class="request-otp-header">{__('heading_verify_gstn')}</h4>
									<div class="form-group login-label">
										<label for="gstn" class="cm-required">{__('gstn')}</label>
										<input type="text" class="form-control input-edit" placeholder="{__('enter_gst_number')}" id="gstn">
										<h6 id="mobile-error">{__('gstn_required')}</h6>
									</div>
									<button type="button" class="btn btn-default btn-primary sellerbtn mycustom-btn  request-verify-gstin request-otp" id="request-otp">{__('verify_gstn')}</button>
								</div>
							</div>
						</div>	
						<div id="step_2_content" {if $gstn_verified} style="display:b_block;"{else}  style="display:none;"{/if}>
							<form  method="POST" class="cm-processed-form">	
								<input type="hidden" name="step" value="2" />
								<input type="hidden" name="vendor_register_form_id" value="{$smarty.session.vendor_register_form_id}" />

								<div id="b_address_fields">
									<div class="form-group">
										<label for="gstin_number" class="ty-control-group__title cm-required cm-name cm-trim">{__("gstin_number")}</label> 
										<input type="text" id="gstin_number" name="company_data[gstin_number]" value="{$company_data.gstin_number}" size="32" maxlength="128"  class="form-control  cm-required" placeholder="GSTIN Number" required disabled>
									</div>
									<div class="form-group">
										<label for="pan_number" class="ty-control-group__title cm-required">{__("pan_number")}</label>
										<input type="text" id="pan_number" name="company_data[pan_number]" value="{$company_data.pan_number}" size="32" maxlength="32"  class="form-control cm-autocomplete-off" autocomplete="off">
									</div>
									<div class="form-group">
										<label for="b_name" class="ty-control-group__title cm-required cm-name cm-trim">{__("b_name")}</label> 
										<input type="text" id="b_name" name="company_data[b_name]" value="{$company_data.b_name}" size="32" maxlength="128"  class="form-control  cm-required" required>
									</div>
									<div class="form-group">
										<label for="b_address" class="ty-control-group__title cm-required cm-name cm-trim">{__("b_address")}</label> 
										<input type="text" id="b_address" name="company_data[b_address]" value="{$company_data.b_address}" size="32" class="form-control cm-required" required>
									</div>
									<div class="form-group" style="display: none;">
										<label for="b_address_2" class="ty-control-group__title  cm-trim" style="display: none;">{__("b_address_2")}</label> 
										<input type="text" id="b_address_2" name="company_data[b_address_2]" value="{$company_data.b_address_2}" size="32" class="form-control cm-focus"  autocomplete="off" >
									</div>


									<div class="row">
										<div class="col-md-6">
									<div class="form-group">
										<label for="b_city" class="ty-control-group__title cm-required cm-trim">{__("b_city")}</label> 
										<input type="text" id="b_city" name="company_data[b_city]" value="{$company_data.b_city}" size="32" maxlength="128"  class="form-control cm-focus" required  autocomplete="off" >
									</div>
									</div>
									<div class="col-md-6">
									<div class="form-group">
        								<label for="b_state" class="cm-required">{__('b_state')}</label>
        								<select id="b_state" name="company_data[b_state]" class="gst_type form-select">
        									{foreach from=$states item=state}
        										<option indiazone="{$state.indiazone}" value="{$state.code}" {if $company_data.b_state == $state.code}selected{/if}>{$state.state}</option>
        									{/foreach}    
        								</select>
        						    </div>	
								</div>
									</div>


									<div class="row">
										<div class="col-md-6">
									<div class="form-group">
										<label for="b_pincode" class="ty-control-group__title cm-required">{__("b_pincode")}</label>
										<input type="text" id="b_pincode" name="company_data[b_pincode]" value="{$company_data.b_pincode}" size="32" maxlength="32"  class="form-control cm-autocomplete-off" autocomplete="off">
									</div>
									</div>
									<div class="col-md-6">
									<!--<div class="form-group">
										<label for="b_country" class="ty-control-group__title cm-required">{__("b_country")}</label>
										<input type="text" id="b_country" name="company_data[b_country]" value="{$company_data.b_country}" size="32" maxlength="32"  class="form-control cm-autocomplete-off" autocomplete="off">
									</div>-->
									<label for="b_country" class="cm-required">{__('b_country')}</label>
									<select id="b_country" name="company_data[b_country]" class="gst_type form-select">
										{foreach from=$countries item=country}
											<option value="{$country.code}" {if $company_data.b_country == $country.code}selected{/if}>{$country.country}</option>
										{/foreach}    
									</select>
								</div>
								</div>

								<div class="row">
									<div class="col-md-6">
    									<div class="form-group">
            								<label for="gst_type" s class="cm-required">{__('gst_type')}</label>
            								<select id="gst_type" name="company_data[gst_type]" class="gst_type form-select">
            									{foreach from=$gst_types item=gst_type}
            										<option value="{$gst_type.value}" {if $company_data.gst_type == $gst_type.value}selected{/if}>{$gst_type.name}</option>
            									{/foreach}    
            								</select>
            						    </div>	
									</div>
									<!--<div class="col-md-6">
            						    <div class="form-group">
            								<label for="india_zone"  class="cm-required">{__('india_zone')}</label>
            								<select id="india_zone" name="company_data[india_zone]" class="gst_type form-select">
            									{foreach from=$india_zones item=india_zone}
            										<option value="{$india_zone.value}" {if $company_data.india_zone == $india_zone.value}selected{/if}>{$india_zone.name}</option>
            									{/foreach}    
            								</select>
            						    </div>	
								    </div>-->
								    <div class="col-md-6">
            						    <div class="form-group">
            								<label for="india_zone"  class="cm-required">{__('india_zone')}</label>
            								<select id="india_zone" name="company_data[india_zone]" class="gst_type form-select">
            							<option value="{$company_data.india_zone}" selected>{$company_data.india_zone}</option>
            								</select>
            						    </div>	
								    </div>
								</div>
								</div>

								<div class="shiping-group">
									<div class="shipping-flag" style="float:none; margin-top:0;">
										<div class="form-group">
											<label >Shipping from same as billing address?</label>
											<div class="input-group">
											  <div class="radiobtn">
												<input class="cm-switch-availability" type="radio" name="company_data[ship_to_another]" value="0" id="sw_sa_suffix_yes"  {if $company_data.ship_to_another == '0'} checked="checked" {/if}>
												<label class="inline">
													Yes
												</label>
											  </div>
											  <div class="radiobtn">
												<input class="cm-switch-availability" type="radio" name="company_data[ship_to_another]" value="1" id="sw_sa_suffix_no" {if $company_data.ship_to_another == '1'} checked="checked" {/if}>
												<label class="inline">
													No
												</label>

											  </div>
											</div>
											</div>

								</div>
								<div id="s_address_fields">
								
									<div class="form-group">
										<label for="s_name" class="ty-control-group__title cm-required cm-name cm-trim">{__("s_name")}</label> 
										<input type="text" id="s_name" name="company_data[s_name]" value="{$company_data.s_name}" size="32" maxlength="128" class="form-control s_address_field cm-required" required>
									</div>


									
									<div class="form-group">
										<label for="s_address" class="ty-control-group__title cm-required cm-name cm-trim">{__("s_address")}</label> 
										<input type="text" id="s_address" name="company_data[s_address]" value="{$company_data.s_address}" size="32" maxlength="128" class="form-control s_address_field cm-required" required>
									</div>
									
									<div class="col-md-6" style="display: none;">
									<div class="form-group">
										<label for="s_address_2" class="ty-control-group__title cm-trim">{__("s_address_2")}</label> 
										<input type="text" id="s_address_2" name="company_data[s_address_2]" value="{$company_data.s_address_2}" size="32" class="form-control cm-focus s_address_field cm-required" autocomplete="off" >
									</div>
									</div>
									


									<div class="row">
										<div class="col-md-6">
									<div class="form-group">
										<label for="s_city" class="ty-control-group__title cm-required cm-trim">{__("s_city")}</label> 
										<input type="text" id="s_city" name="company_data[s_city]" value="{$company_data.s_city}" size="32" maxlength="128" class="form-control s_address_field cm-focus" required autocomplete="off" >
									</div>
									</div>
									<div class="col-md-6">
									<div class="form-group">
        								<label for="s_state" class="cm-required mobile-block">{__('s_state')}</label>
        								<select id="s_state" name="company_data[s_state]" class="s_state form-select mobile-block">
        									{foreach from=$states item=state}
        										<option indiazone="{$state.indiazone}" value="{$state.code}" {if $company_data.s_state == $state.code}selected{/if}>{$state.state}</option>
        									{/foreach}    
        								</select>
        						    </div>	
									</div>
									</div>


									<div class="row">
										<div class="col-md-6">
									<div class="form-group">
										<label for="s_pincode" class="ty-control-group__title cm-required">{__("s_pincode")}</label>
										<input type="text" id="s_pincode" name="company_data[s_pincode]" value="{$company_data.s_pincode}" size="32" maxlength="32" class="form-control s_address_field cm-autocomplete-off" autocomplete="off">
									</div>
									</div>
									<div class="col-md-6">
									<div class="form-group">
										<!--<label for="s_country" class="ty-control-group__title cm-required">{__("s_country")}</label>
										<input type="text" id="s_country" name="company_data[s_country]" value="{$company_data.s_country}" size="32" maxlength="32" class="form-control s_address_field cm-autocomplete-off" autocomplete="off">-->
										<label for="s_country" class="cm-required">{__('s_country')}</label>
										<select id="s_country" name="company_data[s_country]" class="gst_type form-select">
											{foreach from=$countries item=country}
												<option value="{$country.code}" {if $company_data.s_country == $country.code}selected{/if}>{$country.country}</option>
											{/foreach}    
										</select>

									</div>
									</div>
									</div>


							
								</div>	
							</div>
								
								<div class="ty-profile-field__buttons" style="text-align:center;">
									<a href="{fn_url('auth.seller_register')}" class="btn sellerbtn mycustom-btn" style="margin-right: 30px;">{__("back")}</a>
									<button class="btn  sellerbtn mycustom-btn" type="submit" name="dispatch[auth.seller_register]">{__("next")}</button>
									<a href="{fn_url('auth.login_form')}" class="btn  sellerbtn mycustom-btn" style="margin-left: 30px;">{__("cancel")}</a>
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
                    	$('#b_address').val(restext.data.bno+' '+restext.data.st+' '+restext.data.loc);
                    	$('#b_address_2').val(restext.data.bno);
                    	$('#b_pincode').val(restext.data.pncd);
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
				$('.s_state').prop('disabled', true);
				var b_state = $('#b_state').val();
			
				$('#s_name').val($('#b_name').val());
				$('#s_address').val($('#b_address').val());
				$('#s_address_2').val($('#b_address_2').val());
				$('#s_city').val($('#b_city').val());
				$('#s_pincode').val($('#b_pincode').val());
				$('#s_country').val($('#b_country').val());
				$("#s_state option[value='"+b_state+"']").attr("selected","selected");
				
			    
			    
			}else{

				$('.s_address_field').each(function(){
					$(this).prop('disabled', false);
				});
				
				$('.s_state').prop('disabled', false);
				$('#s_name').val('');
				$('#s_address').val('');
				$('#s_address_2').val('');
				$('#s_city').val('');
				$('#s_zipcode').val('');
				$('#s_country').val('');
				
			}
		});
	</script>
{/literal}

	