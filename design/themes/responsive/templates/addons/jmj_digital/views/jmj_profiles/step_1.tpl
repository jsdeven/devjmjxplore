<div class="span16" style="padding:10px 0 10px 10px;margin-left:0;" >	
	<div class="ty-mainbox-container clearfix">
	     <div class="ty-mainbox-body"><!-- Inline script moved to the bottom of the page -->
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
					<div id="create" class="open create-reg">
					  <div class="content">
					  		<div id="phone_verification" {if $phone_verified} style="display:none;"{/if}>
							  	<h5 id="request-otp-success">{__('otp_successfully_sent')}</h5>
								<div class="container new-login-area">
									<div id='sign-in' class='login-setup-section'>
										<h4 class="request-otp-header">{__('heading_verify_number')}</h4>
										<div class="form-group login-label">
											<label for="inputnumber" class="cm-required">{__('mobile_number')}</label>
											<input type="number" class="form-control input-edit" placeholder="{__('enter_mobile_number')}" id="number">
											<h6 id="mobile-error">{__('phone_required')}</h6>
										</div>
										<button type="button" class="ty-btn ty-btn__secondary request-otp request-otp-send" id="request-otp">{__('get_otp')}</button>
									</div>
									<div id='verify-otp' class="login-setup-section" style="display:none;">
										<h4 class="request-otp-header">{__('verify_otp')}</h4>
										<div class="form-group login-label">
											<label for="inputnumber" class="cm-required">{__('one_time_password')}</label>
											<input type="number" class="form-control input-edit" placeholder="{__('enter_otp')}" id="otp">
											<h6 id="otp-error">{__('otp_required')}</h6>
											<h6 id="otp-invalid">{__('otp_invalid')}</h6>
											<label class="pull-right request-otp-send" style="cursor: pointer;">Resend otp</label>
										</div>
										<button type="button" class="ty-btn ty-btn__secondary request-otp verify-otp-send">{__('verify')}</button>
									</div>
								</div>
						    </div>	
					  		<div id="step_1_content" {if $phone_verified} style="display:block;"{else}  style="display:none;"{/if}>
								<form  method="POST" class="cm-processed-form">	
								    <input type="hidden" name="step" value="1" />
									<input type="hidden" name="customer_register_form_id" value="{$smarty.session.customer_register_form_id}" />

									<div class="ty-control-group">
										<label for="name" class="ty-control-group__title cm-required cm-name cm-trim">{__("first_text_name")}</label> 
										<input type="text" id="name" name="customer_data[firstname]" value="{$customer_data.firstname}" size="32" maxlength="128"  class="ty-input-text  cm-required" placeholder="First Name" required>
									</div>
									<div class="ty-control-group">
										<label for="name" class="ty-control-group__title cm-required cm-name cm-trim">{__("last_text_name")}</label> 
										<input type="text" id="name" name="customer_data[lastname]" value="{$customer_data.lastname}" size="32" maxlength="128"  class="ty-input-text  cm-required" placeholder="Last Name" required>
									</div>
									<div class="ty-control-group">
										<label for="email" class="ty-control-group__title cm-required cm-email cm-trim">{__("your_email_address")}</label> 
										<input type="text" id="email" name="customer_data[email]" value="{$customer_data.email}" size="32" maxlength="128"  class="ty-input-text cm-focus cm-required" placeholder="Email" required autocomplete="off" >
									</div>
									<div class="ty-control-group">
										<label for="email" class=" cm-required ty-control-group__title cm-trim">{__("alternative_phone_no")}</label> 
										<input type="number" id="email" name="customer_data[phone_2]" value="{$customer_data.phone_2}" size="32" maxlength="128"  class="ty-input-text cm-focus " placeholder="Phone Number" autocomplete="off" required />
									</div>
									<div class="ty-control-group">
										<label for="website" class=" cm-required ty-control-group__title">{__("website")}</label>
										<input type="text" id="website" name="customer_data[url]" value="{$customer_data.url}" size="32" maxlength="32"  class="ty-input-text cm-autocomplete-off" autocomplete="off" required />
									</div>
									<div class="ty-control-group">
										<label for="company" class="ty-control-group__title cm-required">{__("company")}</label>
										<input type="text" id="company" name="customer_data[company]" value="{$customer_data.company}" size="32" maxlength="32"  class="ty-input-text cm-autocomplete-off" autocomplete="off" required />
									</div>
									<div class="ty-control-group">
										<label class="labelish cm-required">{__("company_type")}</label>
										<div id="paymentContainer" class="paymentOptions">

											<div id="ltd" class="floatBlock">
												<label for="ltd" class="company_type"> <input name="customer_data[company_type]" type="radio" value="ltd" {if $customer_data.company_type == 'ltd'}checked{/if}{if $customer_data.company_type == ''}checked{/if} />Ltd.</label>
											</div>

											<div id="pvt" class="floatBlock">
												<label for="pvt" class="company_type"> <input id="pvt" name="customer_data[company_type]" type="radio" value="pvt" {if $customer_data.company_type == 'pvt'}checked{/if} />Pvt.</label>
											</div>

											<div id="partnership" class="floatBlock">
												<label for="partnership" class="company_type"> <input id="partnership" name="customer_data[company_type]" type="radio" value="partnership" {if $customer_data.company_type == 'partnership'}checked{/if} />Partnership</label>
											</div>

											<div id="proprietorship" class="floatBlock">
												<label for="proprietorship" class="company_type"> <input id="proprietorship" name="customer_data[company_type]" type="radio" value="proprietorship" {if $customer_data.company_type == 'proprietorship'}checked{/if} />Proprietorship</label>
											</div>

											<div id="huf" class="floatBlock">
												<label for="huf" class="company_type"> <input id="huf" name="customer_data[company_type]" type="radio" value="huf" {if $customer_data.company_type == 'huf'}checked{/if} />H.U.F.</label>
											</div>

										</div>
									</div>
									<div class="ty-control-group">
										<label class="labelish cm-required">{__("nature_of_business")}</label>
										<div id="paymentContainer" class="paymentOptions">

											<div id="retail" class="floatBlock">
												<label for="retail" class="company_type"> <input name="customer_data[nature_of_business]" type="radio" value="retail" {if $customer_data.nature_of_business == 'retail'}checked{/if}{if $customer_data.nature_of_business == ''}checked{/if} />Retail</label>
											</div>

											<div id="retail" class="floatBlock">
												<label for="retail" class="company_type"> <input id="retail" name="customer_data[nature_of_business]" type="radio" value="wholesale" {if $customer_data.nature_of_business == 'wholesale'}checked{/if} />Wholesale</label>
											</div>

											<div id="retail_chain" class="floatBlock">
												<label for="retail_chain" class="company_type"> <input id="retail_chain" name="customer_data[nature_of_business]" type="radio" value="retail_chain" {if $customer_data.nature_of_business == 'retail_chain'}checked{/if} />Retail Chain</label>
											</div>

										</div>
									</div>
									<div class="ty-control-group">
										<label for="customer_type" class="cm-required ty-control-group__title">{__("company_year")}</label>
										<input id="datepicker1" type="text" name="customer_data[company_year]" value="{$customer_data.company_year}" required />
									</div>
									<div class="ty-profile-field__buttons" style="text-align:center;">
										<button class="ty-btn__secondary ty-btn" type="submit" name="dispatch[jmj_profiles.add]">{__("sign_up")}</button>
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
		
		$('#datepicker1').datepicker( {
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			dateFormat: 'MM yy',
			onClose: function(dateText, inst) { 
				var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
				var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
				$(this).datepicker('setDate', new Date(year, month, 1));
			}
		});
		
		$('.request-otp-send').on('click',function(){
		
			var phone = $('#number').val();
			if(!phone){
				$('#mobile-error').show();
				return false;
			}
			var data = {
				phone: phone
			}
			
			$.ceAjax('request', 'https://jmjxplore.com/?dispatch=jmj_profiles.otp_for_customer_register', {
				cache: false,
				data: data,
				callback: function(response) {
					var restext = $.parseJSON(response.text);
					if(restext.status == 1){
						$('#request-otp-success').show();
						setTimeout(function() {
							$('#request-otp-success').hide();
                    	}, 1000);
						
						$('#verify-otp').show();
						$('#request-otp').hide();
					}else{
						$('#verify-otp').hide();
						$('#request-otp').show();
					}
				}
			});
		
		});

		$('.verify-otp-send').on('click',function(){
		
			var phone = $('#number').val();
			var otp = $('#otp').val();
			if(!phone){
				$('#mobile-error').show();
				return false;
			}
			if(!otp){
				$('#otp-error').show();
				return false;
			}
			var data = {
				phone: phone,
				otp: otp
			}
			
			$.ceAjax('request', 'https://jmjxplore.com/?dispatch=jmj_profiles.verify_otp_for_customer_register', {
				cache: false,
				data: data,
				callback: function(response) {
					var restext = $.parseJSON(response.text);
					if(restext.status == 1){
						$('#phone_verification').hide();
						$('#step_1_content').show();
					}else{
						$('#otp-invalid').show();
					}
				}
			});
		
		});
	</script>
{/literal}