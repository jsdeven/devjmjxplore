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

	
<div class="ty-mainbox-container clearfix"> 
    <div class="ty-mainbox-body">
		<div class="ty-account">
			<div id="account_register"  style="margin:0;">
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
					<div style="margin-left:0;">
						<h3 class="sellerhub-form-title">Which brands do you wish to  sell on Xplore? <small>(Maximum 3)</small></h3>
						<form  method="POST" class="cm-processed-form">	
							<input type="hidden" name="step" value="3" />
							<input type="hidden" name="vendor_register_form_id" value="{$smarty.session.vendor_register_form_id}" />

							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
										<label for="brand_1" class="ty-control-group__title cm-required cm-trim">{__("brand_1")}</label> 
										<input type="text" id="brand_1" name="company_data[brand_1]" value="{$company_data.brand_1}" size="32" maxlength="128" class="form-control cm-required" required>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label for="brand_2" class="ty-control-group__title cm-trim">{__("brand_2")}</label>
										<input type="text" id="brand_2" name="company_data[brand_2]" value="{$company_data.brand_2}" size="32" maxlength="32" class="form-control cm-autocomplete-off">
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label for="brand_3" class="ty-control-group__title cm-trim">{__("brand_3")}</label> 
										<input type="text" id="brand_3" name="company_data[brand_3]" value="{$company_data.brand_3}" size="32" maxlength="128" class="form-control">
									</div>
								</div>
							</div>

							
							<div class="table-responsive-wrapper my-custom-table-form">

								<h3 class="sellerhub-form-title">What product categories do you deal in?</h3>
								
								<table class="table table-middle table--relative table-responsive" width="100%">
								<!-- <thead class="cm-first-sibling">
								<tr>
									<th width="20%">{__("categories")}</th>
									<th width="20%">{__("sub_categories")}</th>
									<th width="20%">{__("sub_sub_categories")}</th>
									<th width="15%">{__("product_range")}</th>
								</tr>
								</thead> -->
								<tbody>
								{assign var="_key" value="0"}
								{foreach from=$categories item="category" key="lower_limit" name="company_data_cat"}
								<tr class="cm-row-item">
									
									<td width="48%">
										<div class="form-group">
											<label>{__("categories")}</label>
										<select id="main_category_{$_key}" name="company_data[categories][{$_key}][main_category_id]" class="main_category form-select" data-key="{$_key}">
											<option value="0" >{__('choose_category')}</option>
											{foreach from=$main_categories item=main_category}
												<option value="{$main_category.category_id}" {if $main_category.category_id == $category.main_category_id}selected="selected"{/if}>{$main_category.category}</option>
											{/foreach}    
										</select>
										</div>
									</td>
									<td width="48%">
										<div class="form-group">
											<label>{__("sub_categories")}</label>
										<select id="sub_category_{$_key}" name="company_data[categories][{$_key}][sub_category_id]" class="sub_category form-select" data-key="{$_key}">
											{if $category.sub_categories}
												{foreach from=$category.sub_categories item=sub_category}
													<option value="{$sub_category.category_id}" {if $sub_category.category_id == $category.sub_category_id}selected="selected"{/if}>{$sub_category.category}</option>
													
												{/foreach}  
											{else}
												<option value="0">{__('choose_main_category')}</option>
											{/if}
										</select>
										</div>
									</td>
									<td width="48%">
										<div class="form-group">
										<label>{__("sub_sub_categories")}</label>	
										<select id="sub_sub_category_{$_key}" name="company_data[categories][{$_key}][sub_sub_category_id]" class="sub_sub_category form-select" data-key="{$_key}">
											{if $category.sub_sub_categories}
												{foreach from=$category.sub_sub_categories item=sub_sub_category}
													<option value="{$sub_sub_category.category_id}" {if $sub_sub_category.category_id == $category.sub_sub_category_id}selected="selected"{/if}>{$sub_sub_category.category}</option>
												{/foreach}  
											{else}
												<option value="0">{__('choose_sub_category')}</option>
											{/if}
										</select>
									</div>
									</td>
									<td width="48%">
										<div class="form-group">
											<label>{__("product_range")}</label>	
										<input type="text" name="company_data[categories][{$_key}][product_range]" value="{$category.product_range}" size="10" class="input-change form-control input-medium" />
									</div>
									</td>
									<td width="48%" class="nowrap {$no_hide_input_if_shared_product} right">
										{if $lower_limit == "1"}
										&nbsp;{else}
										{include file="buttons/clone_delete.tpl" dummy_href=true microformats="cm-delete-row" no_confirm=true}
										{/if}
									</td>
								</tr>
								
								{$_key = $_key+1}
								{/foreach}
								
								{math equation="x+1" x=$_key|default:0 assign="new_key"}
								<tr class="{cycle values="table-row , " reset=1}" id="box_add_qty_discount">
							
									<td width="48%">
										<div class="form-group">
											<label>{__("categories")}</label>
										<select id="main_category_{$new_key}" name="company_data[categories][{$new_key}][main_category_id]" class="main_category form-select">
											<option value="0">{__('choose_category')}</option>
											{foreach from=$main_categories item=main_category}
												<option value="{$main_category.category_id}">{$main_category.category}</option>
											{/foreach}    
										</select>
										</div>
									</td>
									<td width="50%">
										<div class="form-group">
											<label>{__("sub_categories")}</label>
										<select id="sub_category_{$new_key}" name="company_data[categories][{$new_key}][sub_category_id]" class="sub_category form-select">
											<option value="0">{__('choose_main_category')}</option>
										</select>
										</div>
									</td>
									<td width="20%">
										<div class="form-group">
											<label>{__("sub_sub_categories")}</label>
										<select id="sub_sub_category_{$new_key}" name="company_data[categories][{$new_key}][sub_sub_category_id]" class="sub_sub_category form-select">
											<option value="0">{__('choose_sub_category')}</option>
										</select>
										</div>
									</td>
									<td width="20%">
										<div class="form-group">
											<label>{__("product_range")}</label>
										<input type="text" name="company_data[categories][{$new_key}][product_range]" value="" size="10" class="input-change form-control input-medium" />
										</div>
									</td>
									<td width="15%" class="right">
										{include file="buttons/multiple_buttons.tpl" item_id="add_qty_discount"}
									</td>
								</tr>
								</tbody>
								</table>
							</div>

							<div class="form-group">
								<label >Can you work for private label?</label><br/>

									<div class="input-group new-cs-radio">
									<div class="radiobtn">
									<input class="cm-switch-availability" type="radio" name="company_data[private_label]" value="Y" id="sw_sa_suffix_yes" {if $company_data.private_label == 'Y'}checked{/if}>
									<label class="radio inline">Yes</label>
									</div>
								
									<div class="radiobtn">
									<input class="cm-switch-availability" type="radio" name="company_data[private_label]" value="N" id="sw_sa_suffix_no"  {if $company_data.private_label == 'N'}checked{/if}>
								<label class="radio inline">No</label>
								</div>
								</div>
							</div>
       
							<h4 class="request-otp-header sellerhub-form-title" style="margin-top:10px;">Main Market Coverage</h4>
							<p id="market_covrage_error" style="color:red; {if count($company_data.main_market_coverage)>=2 || count($company_data.main_market_coverage)<=5}display:none{/if}">Minimum 2 and Maximum 5 Required</p>
							
							
							<div class="form-group checkbox-group cs-responsive-check">
								<div class="row">
								{assign var="i" value="1"}	
								{foreach from=$states item="state"}
								{if $i==4}{$i=1}
								
									<div class="col-md-6">
											<div class="cust-checkbox" style="margin-left:10px;">
											<input class="market_coverage" id="{$state.code}" name="company_data[states][]" type="checkbox" value="{$state.code}" {if in_array($state.code, $company_data.main_market_coverage)}checked{/if}>
											<label for="{$state.code}">{$state.state}</label>
										</div>
										</div>
								
							    {else}
								
									<div class="col-md-6">
									<div class="cust-checkbox" style="margin-left:10px;">
										<input class="market_coverage" id="{$state.code}" type="checkbox" value="{$state.code}" name="company_data[states][]" {if in_array($state.code, $company_data.main_market_coverage)}checked{/if}>
										<label for="{$state.code}">{$state.state}</label>
									</div>
								
									</div>
								{/if}{$i = $i+1}		
							{/foreach}	
							
							</div>
							</div>

							<div class="mb-3">
								<h3 class="sellerhub-form-title">Production & Turnover</h3>
							  </div>
							<div class="row">
									<div class="col-md-6">
								<div class="form-group">
									<label>{__('total_emp')}</label>
									<select id="total_emp" name="company_data[total_emp]" class="form-select" aria-label="Default select example">
										{foreach from=$total_emp item=_emp}
											<option value="{$_emp.value}" {if $company_data.total_emp == $_emp.value}selected{/if}>{$_emp.name}</option>
										{/foreach}    
									</select>
						    </div>		
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>{__('annual_turnover')}</label>
										<select id="annual_turnover" name="company_data[annual_turnover]" class="form-select" aria-label="Default select example">
											{foreach from=$annual_turn_over item=_turnover}
												<option value="{$_turnover.value}" {if $company_data.annual_turnover == $_turnover.value}selected{/if}>{$_turnover.name}</option>
											{/foreach}    
										</select>
									</div>		
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>{__("average_monthly_production")}</label> 
									<input type="number" id="average_monthly_production" name="company_data[average_monthly_production]" value="{$company_data.average_monthly_production}" class="form-control">
								</div>
							</div>
							</div>
							<div class="form-group">
								<label for="company_advantage" class="ty-control-group__title" style="width:200px;">{__("company_advantage")}</label> 
								<textarea id="company_advantage" name="company_data[company_advantage]" style="width:100%;">{$company_data.company_advantage}</textarea>
							</div>

							<div class="ty-profile-field__buttons" style="text-align:center;">
								<a href="{fn_url('auth.seller_register&step=2')}" class="btn sellerbtn mycustom-btn" style="margin-right: 30px;">{__("back")}</a>
								<button class="btn sellerbtn mycustom-btn" type=" submit" id="submit-button" name="dispatch[auth.seller_register]" {if count($company_data.main_market_coverage)<2 || count($company_data.main_market_coverage)>5}disabled{/if}>{__("next")}</button>
								<a href="{fn_url('auth.login_form')}"  class="btn  sellerbtn mycustom-btn" style="margin-left: 30px;">{__("cancel")}</a>
							</div>
							
						</form>
						
					</div>
				</div>	
			</div>	
		</div>
    </div>
</div>


<script type="text/javascript">

	$('body').on('change','.main_category', function(){
	
		var category_id = $(this).val();
		var id = $(this).attr('id');
		var key = id.split("main_category_");
		var new_key = key[1];
		var url = "{"auth.get_sub_categories"|fn_url}";
	
		var data = {
			category_id: category_id
		}
   
		if(category_id != '0'){
			$.ceAjax('request', url, {
    			cache: false,
    			data:data,
    			callback: function(response) {
    				var restext = $.parseJSON(response.text);
    				if(response){
    					$('#sub_category_'+new_key).html(restext.str);
    				}  
    			}
		    });
		}else{
		    
		    var str =" <option value='0'>Select Sub-Category</option> <br>";
		    $('#sub_category_'+new_key).html(str);
		    var str_1 =" <option value='0'>Select Sub-Sub-Category</option> <br>";
		    $('#sub_sub_category_'+new_key).html(str_1);
		} 
	});

	$('body').on('change','.sub_category', function(){
		var category_id = $(this).val();
		var id = $(this).attr('id');
		var key = id.split("sub_category_");
		var new_key = key[1];
		
		var url = "{"auth.get_sub_categories"|fn_url}";
	
		var data = {
			category_id: category_id
		}

		if(category_id != '0'){
			$.ceAjax('request', url, {
    			cache: false,
    			data:data,
    			callback: function(response) {
    				var restext = $.parseJSON(response.text);
    				if(response){
    					$('#sub_sub_category_'+new_key).html(restext.str);
    				}  
    			}
    		});
		}else{
		    var str =" <option value='0'>Select Sub-Sub-Category</option> <br>";
		    $('#sub_sub_category_'+new_key).html(str);
		}
	});
	
	$('.market_coverage').on('click', function(){
	     var count=0;
	   $('.market_coverage').each(function(){
	      if($(this).is(":checked")){
	        count += 1;
	      }
	   });
	   if(count>= 2 && count <= 5){
	       $('#market_covrage_error').hide();
	       $('#submit-button').prop('disabled', false);
	   }else{
	      $('#market_covrage_error').show(); 
	      $('#submit-button').prop('disabled', true);
	   }
	});
	
</script>
