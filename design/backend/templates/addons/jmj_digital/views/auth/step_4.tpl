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
				<!--<div class="outer_event buyer_reg">
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
				</div>-->
				<div class="open apply-reg" id="apply">
					<div style="margin-left:0;">
					<h3 class="sellerhub-form-title">bank details</h3>

						<form  method="POST" class="cm-processed-form" enctype="multipart/form-data">	
							<input type="hidden" name="step" value="4" />
							<input type="hidden" name="vendor_register_form_id" value="{$smarty.session.vendor_register_form_id}" />

							<!--<div class="form-group">
								<label for="bank_name" class="ty-control-group__title cm-required cm-trim">{__("bank_name")}</label> 
								<input type="text" id="bank_name" name="company_data[bank_name]" value="{$company_data.bank_name}" size="32" maxlength="128" class="form-control cm-required" required>
								
							</div>-->
							
							
							<div class="form-group">
								<label>{__('bank_name')}</label>
								<select id="bank_name" name="company_data[bank_name]" class="gst_type form-select">
									{foreach from=$bank_name_list item=bank_name}
										<option value="{$bank_name.value}" {if $company_data.bank_name == $bank_name.value}selected{/if}>{$bank_name.name}</option>
									{/foreach}    
								</select>
							</div>		
							
						
							
							<div class="form-group">
								<label for="account_number" class="ty-control-group__title cm-required cm-trim">{__("account_number")}</label>
								<input type="text" id="account_number" name="company_data[account_number]" value="{$company_data.account_number}" size="32" maxlength="32" class="form-control cm-required" required>
							</div>
							<div class="form-group">
								<label for="ifsc_code" class="ty-control-group__title cm-required cm-trim">{__("ifsc_code")}</label> 
								<input type="text" id="ifsc_code" name="company_data[ifsc_code]" value="{$company_data.ifsc_code}" size="32" maxlength="128" class="form-control cm-required" required>
							</div>
							
							<div class="form-group">
								<label for="cancel_cheque_copy_image" class="ty-control-group__title" style="width:40%;">{__("cancel_cheque_copy_image")}</label>
								<div class="input-group">
								  <input type="text" class="form-control" placeholder="Attach cancelled cheque copy*" readonly>
								  <label class="input-group-btn">
									  <span class="choose-file">
										  choose file <input type="file" style="display: none;" name="cancel_cheque_copy_image" id="cancel_cheque_copy_image" multiple>
									  </span>
								  </label>
							  </div>
								<p class="fileallow"><small>Only <strong>JPG</strong> is allowed. File size not to exceed <strong>2 MB</strong></small>
									{if $company_data.cancel_cheque_copy_image}
								<a class="fileallow" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.cancel_cheque_copy_image}">{__('check_uploaded')}</a>
								{/if}
								</p>
							  </div>


							<!--<div class="file-upload file-upload-cancel-cheque form-group">
								<div class="file-select">
									<label for="cancel_cheque_copy_image" class="ty-control-group__title" style="width:40%;">{__("cancel_cheque_copy_image")}</label>
									<div class="file-select-button" id="fileName">Choose File</div>
									<div class="file-select-name" id="noFile_cancel_cheque_copy_image" style="width:40%;">No file chosen...</div> 
									<input type="file" name="cancel_cheque_copy_image" id="cancel_cheque_copy_image">
								</div>
								{if $company_data.cancel_cheque_copy_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.cancel_cheque_copy_image}">{__('check_uploaded')}</a>
								{/if}
							</div>-->
							
							<div class="mb-4"><h3 class="sellerhub-form-title" style="margin-top:10px;">Company & Product Catalogue</h3></div>

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
									{if $company_data.company_profile_image}
								<a class="fileallow" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.company_profile_image}">{__('check_uploaded')}</a>
								{/if}
								</p>
							  </div>

							  <div class="form-group">
								<label for="product_catalogue_image" class="ty-control-group__title" style="width:40%;">{__("product_catalogue_image")}</label>
								<div class="input-group">
								  <input type="text" class="form-control" placeholder="Product Catalogue" readonly>
								  <label class="input-group-btn">
									  <span class="choose-file">
										  choose file <input type="file" style="display: none;" name="product_catalogue_image" id="product_catalogue_image" multiple>
									  </span>
								  </label>
							  </div>
							  <p class="fileallow"><small>Only <strong>JPG</strong> is allowed. File size not to exceed <strong>10 MB</strong></small>
								{if $company_data.product_catalogue_image}
								<a class="fileallow" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.product_catalogue_image}">{__('check_uploaded')}</a>
								{/if}
							</p>
								
							  </div>

							<!--<div class="file-upload file-upload-company-profile">
								<div class="file-select">
									<label for="company_profile_image" class="ty-control-group__title" style="width:40%;">{__("company_profile_image")}</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_company_profile_image" style="width:40%;">{__('choose_pdf_file_and_upload')}</div> 
									<input type="file" name="company_profile_image" id="company_profile_image">
								</div>
								{if $company_data.company_profile_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.company_profile_image}">{__('check_uploaded')}</a>
								{/if}
							</div>
							<div class="file-upload file-upload-product-catalogue">
								<div class="file-select">
									<label for="product_catalogue_image" class="ty-control-group__title" style="width:40%;">{__("product_catalogue_image")}</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_product_catalogue_image" style="width:40%;">{__('choose_jpg_file_and_upload')}</div> 
									<input type="file" name="product_catalogue_image" id="product_catalogue_image">
								</div>
								{if $company_data.product_catalogue_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.product_catalogue_image}">{__('check_uploaded')}</a>
								{/if}
							</div>-->

							<div class="mb-4"><h3 class="sellerhub-form-title" style="margin-top:10px;">Office / Factory Images</h3></div>
							
							
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
								{if $company_data.office_front_image}
								<a class="fileallow" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.office_front_image}">{__('check_uploaded')}</a>
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
								{if $company_data.office_inside_image}
								<a class="fileallow" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.office_inside_image}">{__('check_uploaded')}</a>
								{/if}
							</p>
							
							  </div>

							
							<!--<div class="file-upload file-upload-office-front">
								<div class="file-select">
									<label for="office_front_image" class="ty-control-group__title" style="width:40%;">{__("office_front_image")}</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_office_front_image" style="width:40%;">{__('upload_image_1000*1000')}</div> 
									<input type="file" name="office_front_image" id="office_front_image">
								</div>
								{if $company_data.office_front_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.office_front_image}">{__('check_uploaded')}</a>
								{/if}
							</div>
							<div class="file-upload file-upload-office-inside">
								<div class="file-select">
									<label for="office_inside_image" class="ty-control-group__title" style="width:40%;">{__("office_inside_image")}</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_office_inside_image" style="width:40%;">{__('upload_image_1000*1000')}</div> 
									<input type="file" name="office_inside_image" id="office_inside_image">
								</div>
								{if $company_data.office_inside_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.office_inside_image}">{__('check_uploaded')}</a>
								{/if}
							</div>-->


							<div class="mb-4"><h3 class="sellerhub-form-title" style="margin-top:10px;">Basic documents</h3></div>

							<div class="form-group">
								<label for="gstin_certificate_image" class="ty-control-group__title" style="width:40%;">{__("gstin_certificate_image")}</label>
								<div class="input-group">
								  <input type="text" class="form-control" placeholder="GSTIN Certificate*" readonly>
								  <label class="input-group-btn">
									  <span class="choose-file">
										  choose file <input type="file" style="display: none;" name="gstin_certificate_image" id="gstin_certificate_image" multiple>
									  </span>
								  </label>
							  </div>
							  <p class="fileallow"><small>Only <strong>PDF</strong> is allowed. File size not to exceed <strong>2 MB</strong></small>
								{if $company_data.gstin_certificate_image}
								<a class="fileallow" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.gstin_certificate_image}">{__('check_uploaded')}</a>
								{/if}
							</p>
								
							  </div>

							<!--<div class="file-upload file-upload-gstin-certificate">
								<div class="file-select">
									<label for="gstin_certificate_image" class="ty-control-group__title" style="width:40%;">{__("gstin_certificate_image")}</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_gstin_certificate_image" style="width:40%;">{__('choose_pdf_file_and_upload')}</div> 
									<input type="file" name="gstin_certificate_image" id="gstin_certificate_image">
								</div>
								{if $company_data.gstin_certificate_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.gstin_certificate_image}">{__('check_uploaded')}</a>
								{/if}
							</div>-->
							<div class="form-group">
								<label for="owners_pancard_image" class="ty-control-group__title" style="width:40%;">{__("owners_pancard_image")}</label>
								<div class="input-group">
								  <input type="text" class="form-control" placeholder="PAN Card of Owner’s*" readonly>
								  <label class="input-group-btn">
									  <span class="choose-file">
										  choose file <input type="file" style="display: none;" name="owners_pancard_image" id="owners_pancard_image">
									  </span>
								  </label>
							  </div>
							  <p class="fileallow"><small>Only <strong>PDF</strong> is allowed. File size not to exceed <strong>2 MB</strong></small>
								{if $company_data.owners_pancard_image}
								<a class="fileallow" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.owners_pancard_image}">{__('check_uploaded')}</a>
								{/if}
							</p>
							  </div>

							<!--<div class="file-upload file-upload-pan-card">
								<div class="file-select">
									<label for="owners_pancard_image" class="ty-control-group__title" style="width:40%;">{__("owners_pancard_image")}</label>
									<div class="file-select-button" id="fileName" style="margin-top: 1px;">Choose File</div>
									<div class="file-select-name" id="noFile_owners_pancard_image" style="width:40%;">{__('choose_pdf_file_and_upload')}</div> 
									<input type="file" name="owners_pancard_image" id="owners_pancard_image">
								</div>
								{if $company_data.owners_pancard_image}
									<a style="font-weight: bold;color: #038603;font-size: 13px;" target="_blank" href="images/sellers-additional-data/{$smarty.session.vendor_register_form_id}/{$company_data.owners_pancard_image}">{__('check_uploaded')}</a>
								{/if}
							</div>-->

							<!--<h4 class="request-otp-header" style="margin-top:10px;">Terms & Conditions </h4>
							<ul>
								<li>
									<p>If the Input Tax Credit of GST is not realized by JM Jain LLP due to Vendor's fault, then Vendor shall bear</p>
									<p> penalty imposed on JM Jain LLP.</p>
								</li>
								<li>
									<p>The Vendor shall not directly deal with any of the customers introduced by JM Jain LLP,</p>
									<p>without written consent of JMJain LLP, under any circumstances. In case of default,</p>
									<p>the Vendor shall be liable to paya penalty @ 10 % of total value of business done in the 12 months preceding</p>
									<p>last purchase by JM Jain LLP.</p>
								</li>
								<li>
									<p>Vendor shall arrange transit insurance of goods F.O.R. Consignee.</p>
								</li>
								<li>
									<p>All terms and conditions in Principal Customer's purchase order shall be binding.</p>
								</li>
								<li>
									<p>Notwithstanding any standard/specific term or condition contained in Vendor's Invoice/Bill,</p>
									<p> all disputes shall be subject to Delhi Jurisdiction and terms of this agreement shall prevail.</p>
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
								<a href="{fn_url('auth.seller_register&step=3')}" class="btn sellerbtn mycustom-btn" style="margin-right: 30px;">{__("back")}</a>
								<button class="btn  sellerbtn mycustom-btn" type="submit" name="dispatch[auth.seller_register]">{__("finish")}</button>
								<a href="{fn_url('auth.login_form')}"  class="btn  sellerbtn mycustom-btn" style="margin-left: 30px;">{__("cancel")}</a>
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
			$(".file-upload-inside-image").removeClass('active');
		}else {
			$(".file-upload-inside-image").addClass('active');
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