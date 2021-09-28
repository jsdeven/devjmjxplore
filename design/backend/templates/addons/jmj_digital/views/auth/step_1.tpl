<style>
@import url(https://fonts.googleapis.com/css?family=Montserrat);
body {
	font-family: montserrat, arial, verdana;
}
</style>

<head>
  <title>Seller JMJ Xplore</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
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
<body>
<div>	
	<div class="ty-mainbox-container clearfix">
	     <div class="ty-mainbox-body"><!-- Inline script moved to the bottom of the page -->
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
					<div id="create" class="open create-reg">
					  <div>
							  <div id="phone_verification" {if $phone_verified} style="display:none;"{/if}>
							      <h5 id="phone_exist" style="color:red;display:none">{__('phone_already_exist')}</h5>
							  	<h5 id="request-otp-success">{__('otp_successfully_sent')}</h5>
								<div class="container new-login-area">
									<div id='sign-in' class='login-setup-section'>
										<!--<h4 class="request-otp-header">{__('heading_verify_number')}</h4>-->
										<div class="form-group">
											<label for="inputnumber" class="cm-required">{__('mobile_number')}</label>
											  <div class="input-group">
												<div class="input-group-prepend">
												  <div class="input-group-text">+91</div>
												</div>
												<input type="number" class="form-control input-edit" placeholder="{__('enter_mobile_number')}" id="number">
												<h6 id="mobile-error">{__('phone_required')}</h6>
											  </div>
										  </div>
										  <div class="form-group">
											<button type="button" class="btn btn-primary sellerbtn request-otp request-otp-send" id="request-otp">{__('get_otp')}</button>
										  </div>

										<!--div class="form-group login-label">
											<label for="inputnumber" class="cm-required">{__('mobile_number')}</label>
											<input type="number" class="form-control input-edit" placeholder="{__('enter_mobile_number')}" id="number">
											<h6 id="mobile-error">{__('phone_required')}</h6>
										</div>
										<button type="button" class="btn btn-default btn-lg btn-block request-otp request-otp-send" id="request-otp">{__('get_otp')}</button-->
									</div>

									<div class="form-septator"></div>

									<div id='verify-otp' class="login-setup-section">
										<div class="form-group otp-group">
											<!--<h4 class="request-otp-header">{__('verify_otp')}</h4>-->
											<label for="inputnumber" class="cm-required">{__('one_time_password')}</label>
											<input type="number" class="form-control input-edit" placeholder="{__('enter_otp')}" id="otp">
											<h6 id="otp-error">{__('otp_required')}</h6>
											<h6 id="otp-invalid">{__('otp_invalid')}</h6>
											<label class="pull-right request-otp-send">Resend otp</label>
										</div>
										<div class="form-group mb-0">
										  <button type="button" class="btn btn-default btn-primary sellerbtn request-otp verify-otp-send">{__('verify')}</button>
										</div>


									<!--	<h4 class="request-otp-header">{__('verify_otp')}</h4>
										<div class="form-group login-label">
											<label for="inputnumber" class="cm-required">{__('one_time_password')}</label>
											<input type="number" class="form-control input-edit" placeholder="{__('enter_otp')}" id="otp">
											<h6 id="otp-error">{__('otp_required')}</h6>
											<h6 id="otp-invalid">{__('otp_invalid')}</h6>
											<label class="pull-right request-otp-send">Resend otp</label>
										</div>
										<button type="button" class="btn btn-default btn-lg btn-block request-otp verify-otp-send">{__('verify')}</button>
									-->
									</div>
								</div>
						</div>

						
					  		<div id="step_1_content" {if $phone_verified} style="display:block;"{else}  style="display:none;"{/if}>
								<h3 class="sellerhub-form-title margin-topnill">basic information</h3>
								<form  method="POST" class="cm-processed-form">	
								    <input type="hidden" name="step" value="1" />
									<input type="hidden" name="vendor_register_form_id" value="{$smarty.session.vendor_register_form_id}" />

									<div class="form-group">
										<label for="name" class="ty-control-group__title cm-required cm-name cm-trim">{__("first_text_name")}</label> 
										<input type="text" id="name" name="company_data[firstname]" value="{$company_data.firstname}" size="32" maxlength="128"  class="form-control  cm-required" placeholder="First Name" required>
									</div>

									<div class="form-group">
										<label for="name" class="ty-control-group__title cm-required cm-name cm-trim">{__("last_text_name")}</label> 
										<input type="text" id="name" name="company_data[lastname]" value="{$company_data.lastname}" size="32" maxlength="128"  class="form-control  cm-required" placeholder="Last Name" required>
									</div>
									<div class="form-group">
										<label for="email" class="ty-control-group__title cm-required cm-email cm-trim">{__("your_email_address")}</label> 
										<input type="text" id="email" name="company_data[email]" value="{$company_data.email}" size="32" maxlength="128"  class="form-control cm-focus cm-required" placeholder="Email" required autocomplete="off" >
									</div>
									<div class="form-group">
										<label for="email" class="ty-control-group__title cm-trim">{__("alternative_phone_no")}</label> 
										<input type="number" id="email" name="company_data[phone_2]" value="{$company_data.phone_2}" size="32" maxlength="128"  class="form-control cm-focus " placeholder="Phone Number" autocomplete="off" >
									</div>
									<div class="form-group">
										<label for="website" class="ty-control-group__title">{__("website")}</label>
										<input type="text" id="website" name="company_data[url]" value="{$company_data.url}" size="32" maxlength="32"  class="form-control cm-autocomplete-off" autocomplete="off">
									</div>
									<div class="mb-3">
										<h3 class="sellerhub-form-title">business information</h3>
									  </div>

									<div class="form-group">
										<label for="website" class="ty-control-group__title cm-required">{__("company")}</label>
										<input type="text" id="company" name="company_data[company]" value="{$company_data.company}" size="32" maxlength="32"  class="form-control cm-autocomplete-off" autocomplete="off">
									</div>
									<div class="form-group radio-group">
										<p class="labelish">{__("company_type")}</p>
										<div id="paymentContainer" class="paymentOptions input-group">

											<div id="ltd" class="radiobtn">
												<input name="company_data[company_type]" type="radio"  value="ltd" aria-label="ltd" {if $company_data.company_type == 'ltd'}checked{/if} />
												<label for="ltd"> Ltd.</label>
											</div>

											<div id="pvt" class="radiobtn">
												<input id="pvt" name="company_data[company_type]" type="radio" value="pvt ltd" {if $company_data.company_type == 'pvt ltd'}checked{/if} />
												<label for="pvt" class="company_type"> Pvt. Ltd.</label>
											</div>

											<div id="llp" class="radiobtn">
												<input id="llp" name="company_data[company_type]" type="radio" value="llp" {if $company_data.company_type == 'llp'}checked{/if} />
												<label for="llp" class="company_type"> LLP</label>
											</div>

											<div id="partnership" class="radiobtn">
												<input id="partnership" name="company_data[company_type]" type="radio" value="partnership" {if $company_data.company_type == 'partnership'}checked{/if} />
												<label for="partnership" class="company_type">Partnership</label>
											</div>

											<div id="proprietorship" class="radiobtn">
												<input id="proprietorship" name="company_data[company_type]" type="radio" value="proprietorship" {if $company_data.company_type == 'proprietorship'}checked{/if} />
												<label for="proprietorship" class="company_type">Proprietorship</label>
											</div>

											<div id="huf" class="radiobtn">
												<input id="huf" name="company_data[company_type]" type="radio" value="huf" {if $company_data.company_type == 'huf'}checked{/if} />
												<label for="huf" class="company_type"> H.U.F.</label>
											</div>

										</div>
									</div>
									<div class="form-group radio-group">
										<p class="labelish">{__("nature_of_business")}</p>
										<div id="paymentContainer" class="paymentOptions input-group">

											<div id="manufacturer" class="radiobtn">
												<input name="company_data[nature_of_business]" type="radio" value="manufacturer" {if $company_data.nature_of_business == 'manufacturer'}checked{/if} />
												<label for="manufacturer" class="company_type">Manufacturer</label>
											</div>

											<div id="distributor" class="radiobtn">
												<input id="distributor" name="company_data[nature_of_business]" type="radio" value="distributor" {if $company_data.nature_of_business == 'distributor'}checked{/if} />
												<label for="distributor" class="company_type"> Distributor</label>
											</div>

											<div id="trader" class="radiobtn">
												<input id="trader" name="company_data[nature_of_business]" type="radio" value="trader" {if $company_data.nature_of_business == 'trader'}checked{/if} />
												<label for="trader" class="company_type"> Trader</label>
											</div>

											<div id="imp_exp" class="radiobtn">
												<input id="imp_exp" name="company_data[nature_of_business]" type="radio" value="imp_exp" {if $company_data.nature_of_business == 'imp_exp'}checked{/if} />
												<label for="imp_exp" class="company_type"> Import/Export</label>
											</div>
										</div>
									</div>
								  
									<div class="form-group">
										<label for="company_type" class="ty-control-group__title">{__("company_year")}</label>
										<input id="datepicker1" class="form-control" type="text" name="company_data[company_year]" value="{$company_data.company_year}"/>
									</div>
									<div class="form-group mb-0" style="text-align:center;">
										<button class="btn btn-primary sellerbtn" type="submit" name="dispatch[auth.seller_register]">{__("sign_up")}</button>
										<a href="{fn_url('auth.login_form')}" class="btn btn-primary sellerbtn" style="margin-left: 30px;">{__("cancel")}</a>
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
</body>
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
			
			$.ceAjax('request', fn_url('auth.otp_for_company_register'), {
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
					    
					    $('#phone_exist').show();
					    setTimeout(function() {
							$('#phone_exist').hide();
                    	}, 1000);
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
			
			$.ceAjax('request', fn_url('auth.verify_otp_for_company_register'), {
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