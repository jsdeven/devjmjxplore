<style>
	@import url(https://fonts.googleapis.com/css?family=Montserrat);
	body {
		font-family: montserrat, arial, verdana;
	}
body {
  background-image: url('https://jmjxplore.com/design/themes/responsive/css/addons/jmj_digital/seller_page_assets/img/background.jpg');
  background-repeat: no-repeat;
}
.seller-hub-account-main + .modal{
 margin-left:0 !important;
 background-color:transparent !important;
 top:5% !important;
 height:90% !important;
 padding-bottom:50px !important;
}
</style>
<head>
  <title>buyer JMJ Xplore</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/design/themes/responsive/css/addons/jmj_digital/seller_page_assets/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="/design/themes/responsive/css/addons/jmj_digital/seller_page_assets/css/owl.carousel.min.css">
  <link rel="stylesheet" href="/design/themes/responsive/css/addons/jmj_digital/seller_page_assets/css/owl.theme.default.min.css">
  <link rel="stylesheet" href="/design/themes/responsive/css/addons/jmj_digital/seller_page_assets/css/owl.transitions.css">
  <link rel="stylesheet" href="/design/themes/responsive/css/addons/jmj_digital/seller_page_assets/css/style.css">
  <link rel="stylesheet" href="/design/themes/responsive/css/addons/jmj_digital/seller_page_assets/css/responsive.css">
</head>

<body>
	<section class="seller-hub-account-main">
		<div class="container-fluid">
		  <div class="container-jain">
		  <div class="row">
			<div class="col-md-5 col-lg-5">
				<div class="seller-hub-account-left">
				 {if $_REQUEST.step == '1' || !$_REQUEST.step}
					 <div id="phone_verification" {if $phone_verified} style="display:none;"{/if}>
					  <h1>Create your<br />buyer account</h1>
					  <div class="sellerhub-div">
						<p>Reach out to over lakhs of sellers, across brands, categories, styles and price points to grow your business. </p>
					  </div>
					  <div class="sellerhub-div">
					  <h4>What all you need to sell on Xplore?</h4>
					  <ul>
						<li>GST Information</li>
					  </ul>
					  <ul>
						<li>Active Bank Account to link for payments</li>
					  </ul>
					</div>
					<div class="sellerhub-div">
					  <h4>How will this information be used?</h4>
					  <p>Your email address or mobile number can be used as ‘Username’ to login to your Xplore Buyer Account.</p>
					</div>
				  </div>
					<!--step_1_content-->
					<div id=step_1_content_show {if $phone_verified} style="display:block;"{else}  style="display:none;"{/if}>
					  <h1>Sign up to <br />Xplore!</h1>
					  <div class="sellerhub-div">
						<h4>Enabled by people. Backed by technology</h4>
						<p>Enabling businesses of all sizes to access opportunity by harnessing the power of innovative technology to foster growth Join the community.</p>
					  </div>
					  <div class="sellerhub-div">
					  <h4>What all you need to buy on Xplore?</h4>
					  <ul>
						<li>GST Information </li>
					  </ul>
					  <ul>
						<li>Active Bank Account to link for payments</li>
					  </ul>
					</div>
					<div class="sellerhub-div">
					  <h4>How will this information be used?</h4>
					  <p>Your email address or mobile number can be used as ‘Username’ to login to your Xplore Buyer Account. 
					</p>
					</div>
					</div>
				
			   {elseif $_REQUEST.step == '2'}
			   <h1>Share your<br /> business<br /> details</h1>
			   <div class="sellerhub-div">
				 <p>You’re just 2 steps away to <br>start buying on Xplore.
					</p>
					<p>Authenticated Sellers | Access to over 1 lakh sellers</p>
			   </div>
			   <div class="sellerhub-div">
			   <h4>Don’t have a GSTIN?</h4>
			   <ul class="full-width">
				 <li>Go to official GST portal -  <a style="font-size: 18px;" target="_blank" href="https://www.gst.gov.in/">https://www.gst.gov.in/</a> and under the services tab, choose<br />  <strong>Services > Registration > New Registration</strong> </li>
				 <li>On the Registration page, enter all the  requested details (including your PAN  number), email address and mobile number.  After entering the details, click on proceed. </li>
			   </ul>
			 </div>
			 <div class="sellerhub-div">
			   <h4>How will this information be used?</h4>
			   <p>Your business details will be automatically fetched from GSTIN. To change any information, visit the government portal and update the information on your GSTIN.</p>
			 </div>
			 {elseif $_REQUEST.step == '3'}
				 <h1>Choose your<br>payment<br>mode</h1>
				<div class="sellerhub-div">
				  <p>You can either choose cash or credit option to pay the seller on complete fulfilment of your order.</p>
				</div>
				<div class="sellerhub-div">
				<h4>Don’t’ have a bank account to provide authentication?</h4>
				<p>Nothing to worry about. You can open a new bank account with any bank in your registered business name and make them guaranteer.</p>
				
				<p>P.S – Make sure that the bank account is in the same name as the GSTIN.</p>
			  </div>
			 {elseif $_REQUEST.step == '4'}
				<h1>Share your <br>bank <br>details</h1>
				<div class="sellerhub-div">
				  <p>An active bank account is required to deposit payments on completion of sales.</p>
				</div>
				<div class="sellerhub-div">
				<h4>Don’t’ have a bank account in the name of your business?</h4>
				<p>Nothing to worry about. You can open a new bank account with any bank in your registered business name. </p>
				<p><strong>P.S – Make sure that the bank account is in the same name as the GSTIN.</strong></p>
			  </div>
			 {elseif $_REQUEST.step == '5'}
			 <div class="seller-hub-account-left">
			  <h1>Welcome to <br />the buyer <br />Community</h1>
			  <div class="sellerhub-div">
				<p>Thank you for choosing Xplore as your  growth partner. We look forward to seeing  you accelerate and scale your business  online with us.</p>
			  </div>
		
			</div>
			 {/if}
			</div>
			</div>
			<div class=" col-md-7 col-lg-7">
				<div class="seller-hub-account-right">
					<div class="sellerhub-forms">	
					{if $_REQUEST.step == '1' || !$_REQUEST.step}
						{include file="addons/jmj_digital/views/jmj_profiles/step_1.tpl"}
					{elseif $_REQUEST.step == '2'}
						{include file="addons/jmj_digital/views/jmj_profiles/step_2.tpl"}
					{elseif $_REQUEST.step == '3'}
						{include file="addons/jmj_digital/views/jmj_profiles/step_3.tpl"}
					{elseif $_REQUEST.step == '4'}
						{include file="addons/jmj_digital/views/jmj_profiles/step_4.tpl"}
					{elseif $_REQUEST.step == '5'}
						{include file="addons/jmj_digital/views/jmj_profiles/success.tpl"}
					{/if}
				  </div>
				</div>
			</div>
		  </div>
		</div>
		</div>
	</section>
	<div class="modal fade" id="termcondition" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="padding-right:0 !important; z-index:99999 !important; background-color:none !important;">
		<div class="modal-dialog modal-lg" role="document" style="margin-top:0;">
		  <div class="modal-content ">
			<div class="closebtn"><a href="javascript:;" class="close-tc" data-dismiss="modal" aria-label="Close"><img src='/design/backend/css/addons/jmj_digital/seller_page_assets/img/close.png' alt='close icon' /></a></div>
			<div class="modal-body">
			  <div class="modla-tc">
				<h5 class="modal-title"><span>terms & conditions</span></h5>
				<ul>
				  <li>JM Jain LLP reserves the right to change Credit Limit, Credit Days, Interest Rate, etc. at any time.</li>
				  <li>Any change in the nature of ownership of the existing entity of the Customer shall be duly intimated to JM
					Jain LLP in writing and existing entity shall clear all existing dues of JM Jain LLP and it shall be discretion of
					JM Jain LLP whether to continue business with such newly formed entity, subject to signing of fresh
					agreement.</li>
				  <li>Any Goods Returned/Shortage/Claim by the Customer shall be credited to his account subject to the
					acceptance by the Principal Vendor, provided such information is intimated to JM Jain LLP in writing.</li>
				  <li>Any dispute or difference whatsoever arising between the parties out of or relating to the transactions
					between the parties shall be settled by arbitration in accordance with the Rules of Arbitration of the Indian
					Council of Arbitration, New Delhi. The venue of Arbitration shall be at Delhi</li>
				  <li>Notwithstanding any standard/specific term or condition contained in Customer's Purchase Order, all
					disputes shall be subject to Delhi Jurisdiction and terms of this agreement shall prevail.</li>
				</ul>
			  </div>
			</div>
		  </div>
		</div>
	  </div>

</body>



					  
		