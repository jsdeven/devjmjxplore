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
					<div class="content">
						<form  method="POST" class="cm-processed-form" enctype="multipart/form-data">	
							<input type="hidden" name="step" value="4" />
							<input type="hidden" name="customer_register_form_id" value="{$smarty.session.customer_register_form_id}" />

							<div class="ty-control-group">
								<label for="bank_name" class="cm-required ty-control-group__title cm-trim">{__("bank_name")}</label> 
								<input type="text" id="bank_name" name="customer_data[bank_name]" value="{$customer_data.bank_name}" size="32" maxlength="128" class="ty-input-text" required>
							</div>
							<div class="ty-control-group">
								<label for="account_number" class="cm-required ty-control-group__title cm-trim">{__("account_number")}</label>
								<input type="text" id="account_number" name="customer_data[account_number]" value="{$customer_data.account_number}" size="32" maxlength="32" class="ty-input-text" required>
							</div>
							<div class="ty-control-group">
								<label for="ifsc_code" class="cm-required ty-control-group__title cm-trim">{__("ifsc_code")}</label> 
								<input type="text" id="ifsc_code" name="customer_data[ifsc_code]" value="{$customer_data.ifsc_code}" size="32" maxlength="128" class="ty-input-text" required>
							</div>
							<div class="file-upload file-upload-cancel-cheque">
								<div class="file-select">
									<label for="cancel_cheque_copy_image" class="ty-control-group__title" style="width:40%;">{__("cancel_cheque_copy_image")}</label>
									<div class="file-select-button" id="fileName">Choose File</div>
									<div class="file-select-name" id="noFile_cancel_cheque_copy_image" style="width:40%;">No file chosen...</div> 
									<input type="file" name="cancel_cheque_copy_image" id="cancel_cheque_copy_image" required />
								</div>
								{if $customer_data.cancel_cheque_copy_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.cancel_cheque_copy_image}">{__('check_uploaded')}</a>
								{/if}
							</div>
							<h4 class="request-otp-header" style="margin-top:10px;">Company Profile & Aadhar Card</h4>
							<div class="file-upload file-upload-company-profile">
								<div class="file-select">
									<label for="company_profile_image" class="ty-control-group__title" style="width:40%;">{__("company_profile_image")}</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_company_profile_image" style="width:40%;">{__('choose_pdf_file_and_upload')}</div> 
									<input type="file" name="company_profile_image" id="company_profile_image" required />
								</div>
								{if $customer_data.company_profile_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.company_profile_image}">{__('check_uploaded')}</a>
								{/if}
							</div>
							<div class="file-upload file-upload-product-catalogue" >
								<div class="file-select">
									<label for="product_catalogue_image" class="ty-control-group__title" style="width:40%;">Aadhar Card</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_product_catalogue_image" style="width:40%;">{__('choose_jpg_file_and_upload')}</div> 
									<input type="file" name="product_catalogue_image" id="product_catalogue_image" required />
								</div>
								{if $customer_data.product_catalogue_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/customer-additional-data/{$smarty.session.customer_register_form_id}/{$customer_data.product_catalogue_image}">{__('check_uploaded')}</a>
								{/if}
							</div>
							<h4 class="request-otp-header" style="margin-top:10px;">Office / Factory Images</h4>
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
							</div>

							<h4 class="request-otp-header" style="margin-top:10px;">Basic Documents</h4>
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
							</div>

							<h4 class="request-otp-header" style="margin-top:10px;">Terms & Conditions </h4>
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
							</ul>

							<div class="tacbox">
								<input id="checkbox" name="accept_terms_and_contitions" type="checkbox" required/>
								<label for="checkbox" class="cm-required">I have read carefully and accept terms and conditions.</label>
							</div>

							<div class="ty-profile-field__buttons" style="text-align:center;">
								<a href="{fn_url('profiles.add&step=3')}" class="ty-btn__primary ty-btn" style="padding: 8px 7px;margin-right: 30px;">{__("back")}</a>
								<button class="ty-btn__secondary ty-btn" type="submit" name="dispatch[profiles.add]">{__("finish")}</button>
								<a href="{fn_url('profiles.add')}" class="ty-btn__primary ty-btn" style="padding: 8px 7px;margin-left: 30px;">{__("cancel")}</a>
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
			$(".file-upload-office-front").removeClass('active');
		}else {
			$(".file-upload-office-front").addClass('active');
			$("#noFile_office_front_image").text(filename.replace("C:\\fakepath\\", "")); 
		}
	});
	
</script>

