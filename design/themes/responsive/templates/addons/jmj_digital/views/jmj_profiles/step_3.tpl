<div class="span16" style="padding:10px 0 10px 10px;margin-left:0;min-height:350px;"  >	
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
					<div class="content" style="margin-left:60px;">
						<form  method="POST" class="cm-processed-form" enctype="multipart/form-data">	
							<input type="hidden" name="step" value="3" />
							<input type="hidden" name="customer_register_form_id" value="{$smarty.session.customer_register_form_id}" />

							<h4 class="request-otp-header">Payment Mode</h4>
							<div class="ty-control-group">
								<label for="monthly_turnover" class="cm-required" style="width:200px;">{__('monthly_turnover')}</label>
								<select id="monthly_turnover" name="customer_data[monthly_turnover]" class="monthly_turnover">
									{foreach from=$monthly_turn_over item=_turnover}
										<option value="{$_turnover.value}" {if $customer_data.monthly_turnover == $_turnover.value}selected{/if}>{$_turnover.name}</option>
									{/foreach}    
								</select>
						    </div>	

							<div class="ty-control-group">
								<label class="labelish cm-required">{__("payment_option")}</label>
								<div id="paymentContainer" class="paymentOptions">

									<div id="online" class="floatBlock">
										<label for="online" class="company_type"> <input class="payment_option" name="customer_data[payment_option]" type="radio" value="online" {if $customer_data.payment_option == 'online'}checked{/if}{if $customer_data.payment_option == ''}checked{/if} />{__('online_payment')}</label>
									</div>

									<div id="credit_limit" class="floatBlock">
										<label for="credit_limit" class="company_type"> <input class="payment_option" id="credit_limit" name="customer_data[payment_option]" type="radio" value="credit_limit" {if $customer_data.payment_option == 'credit_limit'}checked{/if} />{__('credit_limit')}</label>
									</div>
								</div>
							</div>
                            
							<div id="credit_payment_option" {if $customer_data.payment_option == 'online' || $customer_data.payment_option == ''}style="display:none;" {/if}>
								<div class="ty-control-group">
									<label for="expected_limit" class="ty-control-group__title">{__("expected_limit")}</label> 
									<input type="number" id="expected_limit" name="customer_data[expected_limit]" value="{$customer_data.expected_limit}" size="32" class="ty-input-text">
								</div>
								<div class="ty-control-group">
									<label for="committed_with_jmjain" class="ty-control-group__title">{__("committed_with_jmjain")}</label> 
									<input type="number" id="committed_with_jmjain" name="customer_data[committed_with_jmjain]" value="{$customer_data.committed_with_jmjain}" size="32" class="ty-input-text">
								</div>
						    </div>		

							<div class="ty-control-group">
								<label class="labelish cm-required">{__("reference_bank_garuntee")}</label>
								<div id="paymentContainer" class="paymentOptions">
								    
                                    <div id="bank_guarantee" class="floatBlock">
										<label for="bank_guarantee" class="company_type"> <input class="reference_bank_garuntee" id="bank_guarantee" name="customer_data[reference_bank_garuntee]" type="radio" value="bank_guarantee" {if $customer_data.reference_bank_garuntee == 'bank_guarantee'}checked{/if}{if $customer_data.reference_bank_garuntee == ''}checked{/if} />{__('bank_guarantee')}</label>
									</div>
									<div style="display:none" id="reference" class="floatBlock">
										<label for="reference" class="company_type"> <input class="reference_bank_garuntee" name="customer_data[reference_bank_garuntee]" type="radio" value="reference" {if $customer_data.reference_bank_garuntee == 'reference'}checked{/if} />{__('reference')}</label>
									</div>

								</div>
							</div>

							<div id="check_bank_guarantee" {if $customer_data.reference_bank_garuntee == 'bank_guarantee' }style="display:none;" {/if}>
								<div class="ty-control-group">
									<label for="name_reference" class="ty-control-group__title cm-required">{__("name_reference")}</label> 
									<input type="text" id="name_reference" name="customer_data[name_reference]" value="{$customer_data.name_reference}" size="32" class="ty-input-text">
								</div>
								<div class="ty-control-group">
									<label for="background_info" class="ty-control-group__title cm-required">{__("background_info")}</label> 
									<input type="text" id="background_info" name="customer_data[background_info]" value="{$customer_data.background_info}" size="32" class="ty-input-text">
								</div>
								<div class="ty-control-group">
									<label for="reference_phone" class="ty-control-group__title cm-required">{__("reference_phone")}</label> 
									<input type="number" id="reference_phone" name="customer_data[reference_phone]" value="{$customer_data.reference_phone}" size="32" class="ty-input-text">
								</div>
						    </div>	
						    <div id="bank_documents" {if $customer_data.reference_bank_garuntee == 'reference' || $customer_data.reference_bank_garuntee == '' }style="display:none;" {/if}>
						        <div class="file-upload file-upload-bank-document">
    								<div class="file-select" style="border:none">
    									<label for="bank_document" class="ty-control-group__title" style="width:40%;">{__("bank_document")}</label>
    									<div class="file-select-button" id="fileName">Choose File</div>
    									<div class="file-select-name" id="noFile_bank_document" style="width:40%;">No file chosen...</div> 
    									<input type="file" name="bank_document" id="bank_document" required />
    								</div>
    								{if $customer_data.bank_document}
    									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.bank_document}">{__('check_uploaded')}</a>
    								{/if}
							    </div>
						    </div>
       
							<h4 class="request-otp-header" style="margin-top:10px;">Buying Locations</h4>
							
							{assign var="i" value="1"}
							<fieldset style="display: flex;margin-top: 10px;">
							{foreach from=$locations item="location"}
								{if $i==4}{$i=1}
									</fieldset>
									<fieldset style="display: flex;margin-top: 10px;">
										<div class="item" style="width: 300px;margin-left:10px;">
											<input id="{$location.id}" name="customer_data[location][]" type="checkbox" value="{$location.id}" {if in_array($location.id, $customer_data.locations)}checked{/if}>
											<label for="{$location.id}">{$location.city}</label>
										</div>
							    {else}
									<div class="item" style="width: 300px;margin-left:10px;">
										<input id="{$location.id}" type="checkbox" value="{$location.id}" name="customer_data[locations][]" {if in_array($location.id, $customer_data.locations)}checked{/if}>
										<label for="{$location.id}">{$location.city}</label>
									</div>
								{/if}{$i = $i+1}		
							{/foreach}	
							</fieldset>

							<div class="ty-control-group">
								<label for="company_advantage" class="cm-required ty-control-group__title" style="width:200px;">{__("company_advantage")}</label> 
								<textarea id="company_advantage" name="customer_data[company_advantage]" style="width:100%;" required>{$customer_data.company_advantage}</textarea>
							</div>

							<div class="ty-profile-field__buttons" style="text-align:center;">
								<a href="{fn_url('jmj_profiles.add&step=2')}" class="ty-btn__primary ty-btn" style="padding: 8px 7px;margin-right: 30px;">{__("back")}</a>
								<button class="ty-btn__secondary ty-btn" type="submit" name="dispatch[jmj_profiles.add]">{__("next")}</button>
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

<script type="text/javascript">

	$('.reference_bank_garuntee').change(function() {
		if (this.value == 'reference') {
			$("#check_bank_guarantee").show();
		}else {
			$("#check_bank_guarantee").hide();
		}
	});

	$('.payment_option').change(function() {
		if (this.value == 'online') {
			$("#credit_payment_option").hide();
			$("#reference").hide();
		}else {
			$("#credit_payment_option").show();
			$("#reference").show();
		}	
	});
	
	var _URL = window.URL || window.webkitURL;

	$("#bank_document").change(function (e) {
		var filename = $("#bank_document").val();
		if (/^\s*$/.test(filename)) {
			$(".file-upload-bank-document").removeClass('active');
		}else {
			$(".file-upload-bank-document").addClass('active');
			$("#noFile_bank_document").text(filename.replace("C:\\fakepath\\", "")); 
		}
	});
	
</script>
