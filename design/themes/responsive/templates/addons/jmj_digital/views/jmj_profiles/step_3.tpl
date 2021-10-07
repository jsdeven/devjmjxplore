<style>
*{
	margin:0; padding: 0; outline: 0; box-sizing: border-box;
}
.payment-option{
	margin:0;padding:0; list-style: none;
}
.payment-option li{
	display:inline-block; margin-right:20px; position:relative;     width: 100%;
	max-width:100%;
}

.payment-option .checkbox-custom, .radio-custom {
    opacity: 0;
    position: absolute;   
}
.payment-option li .radio-custom{
	width:100%;
	height:100%;
	position:absolute;
	z-index: 999;
}
.payment-option .radio-custom, .radio-custom-label {
    display: inline-block;
    vertical-align: middle;
    cursor: pointer;
}

.payment-option .radio-custom-label {
    position: relative;
    border-radius: 36px;
    border: 1px solid #cccccc;
	    max-width: 100%;
    width: 100%;
	height:59px;
}
.payment-option .radio-custom-label h3{
	background-color: transparent !important;
	border:none !important;
}

.payment-option .radio-custom + .radio-custom-label:before {
    content: '';
    display: inline-block;
    vertical-align: middle;
    width: 25px;
    height: 25px;
    padding: 2px;
    margin-right: 10px;
    text-align: center;
    position: fixed;
    left: 0;
}



.payment-option .radio-custom + .radio-custom-label:before {
    border-radius: 50%;
}

.payment-option .radio-custom:checked + .radio-custom-label:before {
    content: "\f00c";
    font-family: 'FontAwesome';
    color: #Fff;
    /* border: 2px solid #ddd; */
    background: #ff0064;
    padding: 12px;
    font-size: 28px;
    position: absolute;
    left: 0;
    width: 57px;
    height: 57px;
}

.payment-option .radio-custom:focus + .radio-custom-label {
  outline: 1px solid #ddd; /* focus style */
}

.payment-option label h3{
    width: 100%;
	max-width:100%;
    height: 20px;
	font-size: 15px;
    line-height: 20px;
	text-align:center;
    text-align: center;
    text-transform: uppercase;
}
.payment-option .active label h3{
	color:#fff;
}
.payment-option .active{
	background: #023b5b; color: #FFF;border-radius: 36px;  
	}
#paymentContainer{
	width:100%;
	display: block;
}	
#paymentContainer .payment-option{
display:flex;
justify-content: space-between;
}
</style>
<script src="https://use.fontawesome.com/6fac2730d4.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

//$(document).ready(function() {
    //$("input:radio:checked").next('label').addClass("active");
//});
$(document).ready(function() {
 $('.payment-option input').click(function () {
        $('.payment-option input:not(:checked)').parent().removeClass("active");
        $('.payment-option input:checked').parent().addClass("active");
    }); });   

</script>

	<div>	
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
					<div>
						<h4 class="sellerhub-form-title margin-topnill">Payment Mode</h4>
						<form  method="POST" class="cm-processed-form" enctype="multipart/form-data">	
							<input type="hidden" name="step" value="3" />
							<input type="hidden" name="customer_register_form_id" value="{$smarty.session.customer_register_form_id}" />
							<div class="row">
								<div class="col-md-6">
							<div class="form-group">
								<label for="monthly_turnover" class="cm-required" style="width:300px;">{__('monthly_turnover')}</label>
								<select id="monthly_turnover" name="customer_data[monthly_turnover]" class="monthly_turnover form-select">
									{foreach from=$monthly_turn_over item=_turnover}
										<option value="{$_turnover.value}" {if $customer_data.monthly_turnover == $_turnover.value}selected{/if}>{$_turnover.name}</option>
									{/foreach}    
								</select>
						    </div>	
						</div>
							</div>

							<div class="form-group">
								<label class="labelish cm-required">{__("payment_option")}</label>
								<div id="paymentContainer" class="paymentOptions">
									<ul class="payment-option">
									<li id="online" class="floatBlock">
										<div {if $customer_data.payment_option == 'online'}class="active""{/if}{if $customer_data.payment_option == ''}class="active"{/if}>
											<input id="radio-1" class="payment_option radio-custom" name="customer_data[payment_option]" type="radio" value="online" {if $customer_data.payment_option == 'online'}checked{/if}{if $customer_data.payment_option == ''}checked{/if} />
											<label for="online" class="radio-custom-label company_type"><h3> {__('online_payment')}</h3></label>
										</div>
										<!-- <label for="online" class="company_type"> <input class="payment_option" name="customer_data[payment_option]" type="radio" value="online" {if $customer_data.payment_option == 'online'}checked{/if}{if $customer_data.payment_option == ''}checked{/if} />{__('online_payment')}</label> -->
									</li>
									<li id="credit_limit" class="floatBlock">
										<div {if $customer_data.payment_option == 'credit_limit'}class="active""{/if}>
											<input class="payment_option radio-custom" id="credit_limit" name="customer_data[payment_option]" type="radio" value="credit_limit" {if $customer_data.payment_option == 'credit_limit'}checked{/if} />
											<label for="online" class="radio-custom-label company_type"><h3> {__('credit_limit')}</h3></label>
										</div>

										<!-- <label for="credit_limit" class="company_type"> <input class="payment_option" id="credit_limit" name="customer_data[payment_option]" type="radio" value="credit_limit" {if $customer_data.payment_option == 'credit_limit'}checked{/if} />{__('credit_limit')}</label> -->
									</li>
									</ul>
								</div>
							</div>
                            
							<div id="credit_payment_option" {if $customer_data.payment_option == 'online' || $customer_data.payment_option == ''}style="display:none;" {/if}>
								<div class="row">
									<div class="col-md-6">
								<div class="form-group">
									<label for="expected_limit" class="cm-required form-group__title">{__("expected_limit")}</label> 
									<input type="number" id="expected_limit" name="customer_data[expected_limit]" value="{$customer_data.expected_limit}" size="32" class="form-control">
								</div>
									</div>
									<div class="col-md-6">
								<div class="form-group">
									<label for="committed_with_jmjain" class="cm-required form-group__title">{__("committed_with_jmjain")}</label> 
									<input type="number" id="committed_with_jmjain" name="customer_data[committed_with_jmjain]" value="{$customer_data.committed_with_jmjain}" size="32" class="form-control">
								</div>
									</div>
								</div>
						    </div>		
							<div class="shiping-group">
							<div class="form-group">
								<label class="labelish cm-required"><span style="font-weight: 600;">{__("reference_bank_garuntee")}</span></label>
								<div id="paymentContainer" class="paymentOptions">
									<div class="input-group">
										<div class="radiobtn">
										<div id="bank_guarantee">
										<input class="reference_bank_garuntee" id="bank_guarantee_1" name="customer_data[reference_bank_garuntee]" type="radio" value="bank_guarantee" {if $customer_data.reference_bank_garuntee == 'bank_guarantee'}checked{/if}{if $customer_data.reference_bank_garuntee == ''}checked{/if} />
										<label for="bank_guarantee_1" class="inline"> 
										{__('bank_guarantee')}
										</label>
										</div>
										</div>
									<div class="radiobtn">
									<div {if $customer_data.payment_option == 'online' || $customer_data.payment_option == '' }style="display:none;" {/if} id="reference" class="floatBlock">
										<input class="reference_bank_garuntee" name="customer_data[reference_bank_garuntee]" type="radio" value="reference" {if $customer_data.reference_bank_garuntee == 'reference'}checked{/if} />
										<label for="reference" class="inline"> 
										{__('reference')}
										</label>
									</div>
									</div>
									
								</div>
								</div>
							</div>
						
							<div id="check_bank_guarantee" {if $customer_data.reference_bank_garuntee == 'bank_guarantee' || $customer_data.reference_bank_garuntee == ''}style="display:none;" {/if}>
								<div class="row">
									<div class="col-md-6">
								<div class="form-group">
									<label for="name_reference" class="form-group__title cm-required">{__("name_reference")}</label> 
									<input type="text" id="name_reference" name="customer_data[name_reference]" value="{$customer_data.name_reference}" size="32" class="form-control">
								</div>
									</div>
									<div class="col-md-6">
								<div class="form-group">
									<label for="background_info" class="form-group__title cm-required">{__("background_info")}</label> 
									<input type="text" id="background_info" name="customer_data[background_info]" value="{$customer_data.background_info}" size="32" class="form-control">
								</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
								<div class="form-group">
									<label for="reference_phone" class="form-group__title cm-required">{__("reference_phone")}</label> 
									<input type="number" id="reference_phone" name="customer_data[reference_phone]" value="{$customer_data.reference_phone}" size="32" class="form-control">
								</div>
									</div>
								</div>
						    </div>	

						    <div id="bank_documents" {if $customer_data.reference_bank_garuntee == 'reference'}style="display:none;" {/if}>
						        <!--<div class="file-upload file-upload-bank-document">
    								<div class="file-select" style="border:none">
    									<label for="bank_document" class="form-group__title" style="width:40%;">{__("bank_document")}</label>
    									<div class="file-select-button" id="fileName">Choose File</div>
    									<div class="file-select-name" id="noFile_bank_document" style="width:40%;">No file chosen...</div> 
    									<input type="file" name="bank_document" id="bank_document" />
    								</div>
    								{if $customer_data.bank_document}
    									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.bank_document}">{__('check_uploaded')}</a>
    								{/if}
							    </div>-->

								<div class="form-group">
									<label for="bank_document" class="cm-required ty-control-group__title" style="width:50%;">{__("bank_document")}</label>
									<div class="input-group">
									  <input type="text" class="form-control" placeholder="Bank Guarantee Document's*" readonly>
									  <label class="input-group-btn">
										  <span class="choose-file">
											  choose file <input type="file" style="display: none;" name="bank_document" id="bank_document" required>
										  </span>
									  </label>
								  </div>
								  <p class="fileallow"><small>Only <strong>PDF/JPG</strong> is allowed. File size not to exceed <strong>2 MB</strong></small>
									{if $customer_data.bank_document}
									<a class="fileallow" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.bank_document}">{__('check_uploaded')}</a>
									{/if}
								</p>
								  </div>

								  
						    </div>
						</div>
							<h4 class="request-otp-header sellerhub-form-title" style="margin-top:10px;">Buying Locations</h4>
							<p id="locations_covrage_error" style="color:red;{if count($customer_data.location)>=2 || count($customer_data.location)<=5}display:none{/if}">Minimum 2 and Maximum 5 Required</p>
							<div class="form-group checkbox-group cs-responsive-check">
								<div class="row">
							{assign var="i" value="1"}
							{foreach from=$locations item="location"}
								{if $i==4}{$i=1}
								<div class="col-md-6">
										<div class="cust-checkbox" style="width: 300px;margin-left:10px;">
											<input id="{$location.city}" class="locationsname" name="customer_data[location][]" type="checkbox" value="{$location.id}" {if in_array($location.id, $customer_data.location)}checked{/if}>
											<label for="{$location.city}">{$location.city}</label>
										</div>
									</div>
							    {else}
								<div class="col-md-6">
									<div class="cust-checkbox" style="width: 300px;margin-left:10px;">
										<input id="{$location.city}" class="locationsname" type="checkbox" value="{$location.id}" name="customer_data[location][]" {if in_array($location.id, $customer_data.location)}checked{/if}>
										<label for="{$location.city}">{$location.city}</label>
									</div>
								</div>
								{/if}{$i = $i+1}		
							{/foreach}	
							
								</div>
							</div>

							
							<div class="form-group">
								<label for="company_advantage" class="cm-required form-group__title" style="width:200px;">{__("company_advantage")}</label> 
								<textarea id="company_advantage" name="customer_data[company_advantage]" style="width:100%;" required>{$customer_data.company_advantage}</textarea>
							</div>
							<div class="ty-profile-field__buttons" style="text-align:center;">
								<a href="{fn_url('jmj_profiles.add&step=2')}" class="btn sellerbtn mycustom-btn" style="margin-right: 30px;">{__("back")}</a>
								<button class="btn sellerbtn mycustom-btn" type=" submit" id="submit-button" name="dispatch[jmj_profiles.add]" {if count($customer_data.locations)<2 || count($customer_data.locations)>5}disabled{/if}>{__("next")}</button>
								<a href="{fn_url('jmj_profiles.add')}" class="btn sellerbtn mycustom-btn" style="margin-left: 30px;">{__("cancel")}</a>
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

    $(document).ready(function(){
        var count=0;
	    $('.locationsname').each(function(){
	      if($(this).is(":checked")){
	        count += 1;
	      }
	    });
	    if(count>= 2 && count <= 5){
	       $('#locations_covrage_error').hide();
	       $('#submit-button').prop('disabled', false);
	    }else{
	      $('#locations_covrage_error').show(); 
	      $('#submit-button').prop('disabled', true);
	    }
	   
        if($("#bank_guarantee_1").prop('checked') == true){
            $('#bank_document').prop('required',true);
        }else{
            $('#bank_document').prop('required',false);
        }
        
        if($("#credit_limit").prop('checked') == true){
            $('#expected_limit').prop('required',true);
            $('#committed_with_jmjain').prop('required',true);
        }else{
            $('#expected_limit').prop('required',false);
            $('#committed_with_jmjain').prop('required',false);
        }
    });
	$('.reference_bank_garuntee').change(function() {
		if (this.value == 'reference') {
			$("#check_bank_guarantee").show();
			$('#bank_documents').hide();
			$('#bank_document').prop('required',false);
			
		}else {
			$("#check_bank_guarantee").hide();
			$('#bank_documents').show();
		}
	});

	$('.payment_option').change(function() {
		if (this.value == 'online') {
			$("#credit_payment_option").hide();
			$("#reference").hide();
			$('#check_bank_guarantee').hide();
			if($("#bank_guarantee_1").prop('checked') == true){
                $('#bank_documents').show();
            }else{
                $('#bank_documents').hide();
                $('#bank_document').prop('required',false);
            }
            $('#expected_limit').prop('required',false);
            $('#committed_with_jmjain').prop('required',false);
            
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
	
	$('.locationsname').on('click', function(){
	     var count=0;
	   $('.locationsname').each(function(){
	      if($(this).is(":checked")){
	        count += 1;
	      }
	   });
	   if(count>= 2 && count <= 5){
	       $('#locations_covrage_error').hide();
	       $('#submit-button').prop('disabled', false);
	   }else{
	      $('#locations_covrage_error').show(); 
	      $('#submit-button').prop('disabled', true);
	   }
	});

</script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
<script>
$(function() {

  // This code will attach `fileselect` event to all file inputs on the page
  $(document).on('change', ':file', function() {
    var input = $(this),
        numFiles = input.get(0).files ? input.get(0).files.length : 1,
        label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
    input.trigger('fileselect', [numFiles, label]);
  });

  $(document).ready( function() {
//below code executes on file input change and append name in text control
      $(':file').on('fileselect', function(event, numFiles, label) {

          var input = $(this).parents('.input-group').find(':text'),
              log = numFiles > 1 ? numFiles + ' files selected' : label;

          if( input.length ) {
              input.val(log);
          } else {
              if( log ) alert(log);
          }

      });
  });

});
</script>
