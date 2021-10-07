
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
					<div style="margin-left:0;">
						<h4 class="sellerhub-form-title margin-topnill">bank details</h4>
						<form  method="POST" class="cm-processed-form" enctype="multipart/form-data">	
							<input type="hidden" name="step" value="4" />
							<input type="hidden" name="customer_register_form_id" value="{$smarty.session.customer_register_form_id}" />
							<div class="form-group">
								<label class="cm-required">{__('bank_name')}</label>
								<select id="bank_name" name="customer_data[bank_name]" class="gst_type form-select" required>
									<option value="">Select Bank Name</option>
									{foreach from=$bank_name_list item=bank_name}
										<option value="{$bank_name.value}" {if $customer_data.bank_name == $bank_name.value}selected{/if}>{$bank_name.name}</option>
									{/foreach}    
								</select>
							</div>		

							<!--<div class="form-group">
								<label for="bank_name" class="cm-required ty-control-group__title cm-trim">{__("bank_name")}</label> 
								<input type="text" id="bank_name" name="customer_data[bank_name]" value="{$customer_data.bank_name}" size="32" maxlength="128" class="form-control" required>
							</div>-->
							
							<div class="form-group">
								<label for="account_number" class="cm-required ty-control-group__title cm-trim">{__("account_number")}</label>
								<input type="text" id="account_number" name="customer_data[account_number]" value="{$customer_data.account_number}" size="32" maxlength="32" class="form-control" required>
							</div>
							<div class="form-group">
								<label for="ifsc_code" class="cm-required ty-control-group__title cm-trim">{__("ifsc_code")}</label> 
								<input type="text" id="ifsc_code" name="customer_data[ifsc_code]" value="{$customer_data.ifsc_code}" size="32" maxlength="128" class="form-control" required>
							</div>

							<div class="form-group">
								<label for="cancel_cheque_copy_image" class="ty-control-group__title cm-required" style="width:40%;">{__("cancel_cheque_copy_image")}</label>
									<div class="input-group">
										<input type="text" class="form-control"  placeholder="Attach cancelled cheque copy*" readonly>
										<label class="input-group-btn">
											<span class="choose-file">
												choose file <input type="file" style="display: none;" name="cancel_cheque_copy_image" id="cancel_cheque_copy_image" required />
											</span>
										</label>
								</div>
								<p class="fileallow"><small>Only <strong>JPG</strong> is allowed. File size not to exceed <strong>2 MB</strong></small>
									{if $customer_data.cancel_cheque_copy_image}
								<a class="fileallow" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.cancel_cheque_copy_image}">{__('check_uploaded')}</a>
								{/if}
								</p>
							  </div>
							  

							<!--<div class="file-upload file-upload-cancel-cheque">
								<div class="file-select">
									<label for="cancel_cheque_copy_image" class="ty-control-group__title" style="width:40%;">{__("cancel_cheque_copy_image")}</label>
									<div class="file-select-button" id="fileName">Choose File</div>
									<div class="file-select-name" id="noFile_cancel_cheque_copy_image" style="width:40%;">No file chosen...</div> 
									<input type="file" name="cancel_cheque_copy_image" id="cancel_cheque_copy_image" required />
								</div>
								{if $customer_data.cancel_cheque_copy_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.cancel_cheque_copy_image}">{__('check_uploaded')}</a>
								{/if}
							</div>-->
							<!--<div class="mb-4"><h3 class="sellerhub-form-title" style="margin-top:10px;">Company Profile & Aadhar Card</h3></div>-->
							<h4 class="sellerhub-form-title margin-topnill">Company Profile & Aadhar Card</h4>
							<!--<div class="file-upload file-upload-company-profile">
								<div class="file-select">
									<label for="company_profile_image" class="ty-control-group__title" style="width:40%;">{__("company_profile_image")}</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_company_profile_image" style="width:40%;">{__('choose_pdf_file_and_upload')}</div> 
									<input type="file" name="company_profile_image" id="company_profile_image" required />
								</div>
								{if $customer_data.company_profile_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.company_profile_image}">{__('check_uploaded')}</a>
								{/if}
							</div>-->

							<div class="form-group">
								<label for="company_profile_image" class="ty-control-group__title" style="width:40%;">{__("company_profile_image")}</label>
								<div class="input-group">
								  <input type="text" class="form-control" placeholder="Company Profile" readonly>
								  <label class="input-group-btn">
									  <span class="choose-file">
										  choose file <input type="file" style="display: none;" name="company_profile_image" id="company_profile_image" multiple>
									  </span>
								  </label>
							  </div>
							  	<p class="fileallow"><small>Only <strong>PDF</strong> is allowed. File size not to exceed <strong>2 MB</strong></small>
									{if $customer_data.company_profile_image}
								<a class="fileallow" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.company_profile_image}">{__('check_uploaded')}</a>
								{/if}
								</p>
							  </div>


							
							<!--<div class="file-upload file-upload-product-catalogue" >
								<div class="file-select">
									<label for="product_catalogue_image" class="ty-control-group__title" style="width:40%;">Aadhar Card</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_product_catalogue_image" style="width:40%;">{__('choose_jpg_file_and_upload')}</div> 
									<input type="file" name="product_catalogue_image" id="product_catalogue_image" required />
								</div>
								{if $customer_data.product_catalogue_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.product_catalogue_image}">{__('check_uploaded')}</a>
								{/if}
							</div>-->

							<div class="form-group">
								<label for="product_catalogue_image" class="cm-required ty-control-group__title" style="width:40%;">Aadhar Card</label>
								<div class="input-group">
								  <input type="text" class="form-control" placeholder="Aadhar Card" readonly>
								  <label class="input-group-btn">
									  <span class="choose-file">
										  choose file <input type="file" style="display: none;" name="product_catalogue_image" id="product_catalogue_image" multiple>
									  </span>
								  </label>
							  </div>
							  <p class="fileallow"><small>Only <strong>JPG</strong> is allowed. File size not to exceed <strong>10 MB</strong></small>
								{if $customer_data.product_catalogue_image}
								<a class="fileallow" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.product_catalogue_image}">{__('check_uploaded')}</a>
								{/if}
							</p>
								
							  </div>


							<!--<h4 class="request-otp-header" style="margin-top:10px;">Office / Factory Images</h4>
							<div class="file-upload file-upload-office-front">
								<div class="file-select">
									<label for="office_front_image" class="ty-control-group__title" style="width:40%;">{__("office_front_image")}</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_office_front_image" style="width:40%;">{__('upload_image_1000*1000')}</div> 
									<input type="file" name="office_front_image" id="office_front_image" required />
								</div>
								{if $customer_data.office_front_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.office_front_image}">{__('check_uploaded')}</a>
								{/if}
							</div>
							<div class="file-upload file-upload-office-inside">
								<div class="file-select">
									<label for="office_inside_image" class="ty-control-group__title" style="width:40%;">{__("office_inside_image")}</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_office_inside_image" style="width:40%;">{__('upload_image_1000*1000')}</div> 
									<input type="file" name="office_inside_image" id="office_inside_image" required />
								</div>
								{if $customer_data.office_inside_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.office_inside_image}">{__('check_uploaded')}</a>
								{/if}
							</div>-->
							<!--<div class="mb-4"><h3 class="sellerhub-form-title" style="margin-top:10px;">Office / Factory Images</h3></div>-->
							<h4 class="sellerhub-form-title margin-topnill">Office / Factory Images</h4>
							<div class="form-group">
								<label for="office_front_image" class="ty-control-group__title" style="width:40%;">{__("office_front_image")}</label>
								<div class="input-group">
								  <input type="text" class="form-control" placeholder="Front Image*" readonly>
								  <label class="input-group-btn">
									  <span class="choose-file">
										  choose file <input type="file" style="display: none;" name="office_front_image" id="office_front_image">
									  </span>
								  </label>
							  </div>
							  <p class="fileallow"><small>Only <strong>JPG</strong> is allowed. File size not to exceed <strong>2 MB</strong></small>
								{if $customer_data.office_front_image}
								<a class="fileallow" target="_blank"href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.office_front_image}">{__('check_uploaded')}</a>
								{/if}
							</p>
							
							  </div>


							  <div class="form-group">
								<label for="office_inside_image" class="ty-control-group__title" style="width:40%;">{__("office_inside_image")}</label>
								<div class="input-group">
								  <input type="text" class="form-control" placeholder="Inside Image*" readonly>
								  <label class="input-group-btn">
									  <span class="choose-file">
										  choose file <input type="file" style="display: none;" name="office_inside_image" id="office_inside_image">
									  </span>
								  </label>
							  </div>
							  <p class="fileallow"><small>Only <strong>JPG</strong> is allowed. File size not to exceed <strong>2 MB</strong></small>
								{if $customer_data.office_inside_image}
								<a class="fileallow" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.office_inside_image}">{__('check_uploaded')}</a>
								{/if}
							</p>
							</div>


							<!--<h4 class="request-otp-header" style="margin-top:10px;">Basic Documents</h4>
							<div class="file-upload file-upload-gstin-certificate">
								<div class="file-select">
									<label for="gstin_certificate_image" class="ty-control-group__title" style="width:40%;">{__("gstin_certificate_image")}</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_gstin_certificate_image" style="width:40%;">{__('choose_pdf_file_and_upload')}</div> 
									<input type="file" name="gstin_certificate_image" id="gstin_certificate_image" required />
								</div>
								{if $customer_data.gstin_certificate_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.gstin_certificate_image}">{__('check_uploaded')}</a>
								{/if}
							</div>
							<div class="file-upload file-upload-pan-card">
								<div class="file-select">
									<label for="owners_pancard_image" class="ty-control-group__title" style="width:40%;">{__("owners_pancard_image")}</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_owners_pancard_image" style="width:40%;">{__('choose_pdf_file_and_upload')}</div> 
									<input type="file" name="owners_pancard_image" id="owners_pancard_image" required />
								</div>
								{if $customer_data.owners_pancard_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.owners_pancard_image}">{__('check_uploaded')}</a>
								{/if}
							</div>-->

							<!--<div class="mb-4"><h3 class="sellerhub-form-title" style="margin-top:10px;">Basic documents</h3></div>-->
							<h4 class="sellerhub-form-title margin-topnill">Basic documents</h4>
							<div class="form-group">
								<label for="gstin_certificate_image" class="cm-required ty-control-group__title" style="width:40%;">{__("gstin_certificate_image")}</label>
								<div class="input-group">
								  <input type="text" class="form-control" placeholder="GSTIN Certificate*" readonly>
								  <label class="input-group-btn">
									  <span class="choose-file">
										  choose file <input type="file" style="display: none;" name="gstin_certificate_image" id="gstin_certificate_image" multiple>
									  </span>
								  </label>
							  </div>
							  <p class="fileallow"><small>Only <strong>PDF</strong> is allowed. File size not to exceed <strong>2 MB</strong></small>
								{if $customer_data.gstin_certificate_image}
								<a class="fileallow" target="_blank"href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.gstin_certificate_image}">{__('check_uploaded')}</a>
								{/if}
							</p>
							  </div>
							  <div class="form-group">
								<label for="owners_pancard_image" class="cm-required ty-control-group__title" style="width:40%;">{__("owners_pancard_image")}</label>
								<div class="input-group">
								  <input type="text" class="form-control" placeholder="PAN Card of Owner’s*" readonly>
								  <label class="input-group-btn">
									  <span class="choose-file">
										  choose file <input type="file" style="display: none;" name="owners_pancard_image" id="owners_pancard_image">
									  </span>
								  </label>
							  </div>
							  <p class="fileallow"><small>Only <strong>PDF</strong> is allowed. File size not to exceed <strong>2 MB</strong></small>
								{if $customer_data.owners_pancard_image}
								<a class="fileallow" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.owners_pancard_image}">{__('check_uploaded')}</a>
								{/if}
							</p>
							  </div>


							<!--<h4 class="request-otp-header" style="margin-top:10px;">Terms & Conditions </h4>
							<ul>
								<li>
									<p>JM Jain LLP reserves the right to change Credit Limit, Credit Days, Interest Rate, etc. at any time.</p>
								</li>
								<li>
									<p>Any change in the nature of ownership of the existing entity of the Customer shall be duly intimated to JM
									Jain LLP in writing and existing entity shall clear all existing dues of JM Jain LLP and it shall be discretion of
									JM Jain LLP whether to continue business with such newly formed entity, subject to signing of fresh
									agreement.
									</p>
								</li>
								<li>
									<p>Any Goods Returned/Shortage/Claim by the Customer shall be credited to his account subject to the
									acceptance by the Principal Vendor, provided such information is intimated to JM Jain LLP in writing.
									</p>
								</li>
								<li>
									<p>Any dispute or difference whatsoever arising between the parties out of or relating to the transactions
									between the parties shall be settled by arbitration in accordance with the Rules of Arbitration of the Indian
									Council of Arbitration, New Delhi. The venue of Arbitration shall be at Delhi</p>
								</li>
								<li>
									<p>Notwithstanding any standard/specific term or condition contained in Customer's Purchase Order, all
									disputes shall be subject to Delhi Jurisdiction and terms of this agreement shall prevail</p>
								</li>
							</ul>-->
							
							<div class="form-group mb-3 termcondition checkbox-group">
								<div class="cust-checkbox">
								  <input type="checkbox" name="" id="tandc" />
								  <label for="tandc">I have read carefully and accpet <a data-toggle="modal" data-target="#termcondition" href="javascript:;"> Terms & Conditions.</a></label>
								</div>
							  </div>


							<!--<div class="tacbox">
								<input id="checkbox" name="accept_terms_and_contitions" type="checkbox" required/>
								<label for="checkbox" class="cm-required">I have read carefully and accept terms and conditions.</label>
							</div>-->

							<div class="ty-profile-field__buttons" style="text-align:center;">
								<a href="{fn_url('profiles.add&step=3')}" class="btn sellerbtn mycustom-btn" style="margin-right: 30px;">{__("back")}</a>
								<button  class="btn  sellerbtn mycustom-btn" type="submit" name="dispatch[profiles.add]">{__("finish")}</button>
								<a href="{fn_url('profiles.add')}" class="btn  sellerbtn mycustom-btn" style="margin-left: 30px;">{__("cancel")}</a>
							</div>
							
						</form>
						
					</div>
				</div>	
			</div>	
		</div>
    </div>
</div>
</div>
  <style>
	p{
		margin-top: 0;
		margin-bottom: 0rem;
	}
	li {
		line-height: 20px;
		margin-bottom: 10px;
	}
</style>


<script type="text/javascript">
	var _URL = window.URL || window.webkitURL;

	$("#cancel_cheque_copy_image").change(function (e) {
		var filename = $("#cancel_cheque_copy_image").val();
		if (/^\s*$/.test(filename)) {
			$(".file-upload-cancel-cheque").removeClass('active');
		}else {
			$(".file-upload-cancel-cheque").addClass('active');
			$("#noFile_cancel_cheque_copy_image").text(filename.replace("C:\\fakepath\\", "")); 
		}
	});

	$("#product_catalogue_image").change(function (e) {
		var filename = $("#product_catalogue_image").val();
		var file, img;
		var file = this.files[0];
		if(file.type != 'image/jpeg'){
			$("#noFile_product_catalogue_image").text('Please choose jpeg image!'); 
			return false;
		}
		if (/^\s*$/.test(filename)) {
			$(".file-upload-product-catalogue").removeClass('active');
		}else {
			$(".file-upload-product-catalogue").addClass('active');
			$("#noFile_product_catalogue_image").text(filename.replace("C:\\fakepath\\", "")); 
		}
	});

	$("#company_profile_image").change(function (e) {
		var filename = $("#company_profile_image").val();
		var file, img;
		var file = this.files[0];
		if(file.type != 'application/pdf'){
			$("#noFile_company_profile_image").text('Please choose pdf file!'); 
			return false;
		}
		if (/^\s*$/.test(filename)) {
			$(".file-upload-company-profile").removeClass('active');
		}else {
			$(".file-upload-company-profile").addClass('active');
			$("#noFile_company_profile_image").text(filename.replace("C:\\fakepath\\", "")); 
		}
	});

	$("#gstin_certificate_image").change(function (e) {
		var filename = $("#gstin_certificate_image").val();
		var file, img;
		var file = this.files[0];
		if(file.type != 'application/pdf'){
			$("#noFile_gstin_certificate_image").text('Please choose pdf file!'); 
			return false;
		}
		if (/^\s*$/.test(filename)) {
			$(".file-upload-gstin-certificate").removeClass('active');
		}else {
			$(".file-upload-gstin-certificate").addClass('active');
			$("#noFile_gstin_certificate_image").text(filename.replace("C:\\fakepath\\", "")); 
		}
	});

	$("#owners_pancard_image").change(function (e) {
		var filename = $("#owners_pancard_image").val();
		var file, img;
		var file = this.files[0];

		if(file.type != 'application/pdf'){
			$("#noFile_owners_pancard_image").text('Please choose pdf file!'); 
			return false;
		}
		if (/^\s*$/.test(filename)) {
			$(".file-upload-pan-card").removeClass('active');
		}else {
			$(".file-upload-pan-card").addClass('active');
			$("#noFile_owners_pancard_image").text(filename.replace("C:\\fakepath\\", "")); 
		}
	});

	$("#office_inside_image").change(function (e) {
		var filename = $("#office_inside_image").val();
		var file, img;
		if ((file = this.files[0])) {
			img = new Image();
			var objectUrl = _URL.createObjectURL(file);
			img.onload = function () {
				if(this.width != 1000 || this.height != 1000){
					$("#noFile_office_inside_image").text('Please choose 1000*1000 image!'); 
					return false;
				}
				_URL.revokeObjectURL(objectUrl);
			};
			img.src = objectUrl;
		}

		if (/^\s*$/.test(filename)) {
			$(".file-upload-office-inside").removeClass('active');
		}else {
			$(".file-upload-office-inside").addClass('active');
			$("#noFile_office_inside_image").text(filename.replace("C:\\fakepath\\", "")); 
		}
	});

	$("#office_front_image").change(function (e) {
		var filename = $("#office_front_image").val();
		var file, img;
		if ((file = this.files[0])) {
			img = new Image();
			var objectUrl = _URL.createObjectURL(file);
			img.onload = function () {
				if(this.width != 1000 || this.height != 1000){
					$("#noFile_office_front_image").text('Please choose 1000*1000 image!'); 
					return false;
				}
				_URL.revokeObjectURL(objectUrl);
			};
			img.src = objectUrl;
		}

		if (/^\s*$/.test(filename)) {
			$(".file-upload-front-image").removeClass('active');
		}else {
			$(".file-upload-front-image").addClass('active');
			$("#noFile_office_front_image").text(filename.replace("C:\\fakepath\\", "")); 
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

