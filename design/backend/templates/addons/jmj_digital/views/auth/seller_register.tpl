
{style src="addons/jmj_digital/vendor_login_page_assets/css/theme.css"}
{style src="addons/jmj_digital/collapse.css"}
<link rel="stylesheet" href="design/backend/css/addons/jmj_digital/seller_page_assets/css/aks.style.css">
<style>
body {
  background-image: url('https://jmjxplore.com/design/backend/css/addons/jmj_digital/seller_page_assets/img/background.jpg');
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

<header class="header">	    
    <div class="branding">
        <div class="container-fluid position-relative py-3" style="padding-left: 3rem;"> 
            <div class="logo-wrapper">
                <div class="site-logo"><img class="ty-pict  ty-logo-container__image cm-image" src="design/backend/css/addons/jmj_digital/seller_page_assets/img/logo.png" height="62px" width="auto"></div>    
            </div><!--//docs-logo-wrapper-->
        </div><!--//container-->
    </div><!--//branding-->
</header>


<section class="seller-hub-account-main">
<div class="container-fluid">
  <div class="container-jain">
  <div class="row">
    <div class="col-md-5 col-lg-5">
        <div class="seller-hub-account-left">
         {if $_REQUEST.step == '1' || !$_REQUEST.step}
             <div id="phone_verification" {if $phone_verified} style="display:none;"{/if}>
              <h1>Start your <br /> seller account devendra</h1>
              <div class="sellerhub-div">
                <p>Reach out to over thousands of new customers, near or far and grow your business.</p>
              </div>
              <div class="sellerhub-div">
              <h4>What all you need to sell on Xplore?</h4>
              <ul>
                <li>GST Information </li>
                <li>Active Bank Account</li>
                <li>Products to Sell</li>
                <li>Photos of Store/Shop</li>
              </ul>
            </div>
            <div class="sellerhub-div">
              <h4>How will this information be used?</h4>
              <p>our email address or mobile number can be used as ‘Username’ to login to your Xplore Seller Account. </p>
            </div>
          </div>

            <!--step_1_content-->
            <div id=step_1_content_show {if $phone_verified} style="display:block;"{else}  style="display:none;"{/if}>
              <h1>Sign up to <br />Xplore!</h1>
              <div class="sellerhub-div">
                <h4>Enabled by people. Backed by technology</h4>
                <p>Enabling businesses of all sizes to access  opportunity by harnessing the power of  innovative technology to foster growth. Join the community.</p>
              </div>
              <div class="sellerhub-div">
              <h4>What all you need to sell on Xplore?</h4>
              <ul>
                <li>GST Information </li>
                <li>Active Bank Account</li>
                <li>Products to Sell</li>
                <li>Photos of Store/Shop</li>
              </ul>
            </div>
            <div class="sellerhub-div">
              <h4>How will this information be used?</h4>
              <p>our email address or mobile number can be used as ‘Username’ to login to your Xplore Seller Account. </p>
            </div>
            </div>
        
       {elseif $_REQUEST.step == '2'}
       <h1>Share your<br /> business<br /> details</h1>
       <div class="sellerhub-div">
         <h4>Enabled by people. Backed by technology</h4>
         <p>You’re just 2 steps away to get your  business up and running on Xplore.</p>
         <ul class="full-width">
           <li>Zero Listing Fees</li>
           <li>Powerful Tools and Insights</li>
           <li>Access to Over 1 Lakh Buyer</li>
         </ul>
       </div>
       <div class="sellerhub-div">
       <h4>Don’t have a GSTIN?</h4>
       <ul class="full-width">
         <li>Go to official GST portal -  <a target="_blank" href="https://www.gst.gov.in/">https://www.gst.gov.in/</a> and under the services tab, choose<br />  <strong>Services > Registration > New Registration</strong> </li>
         <li>On the Registration page, enter all the  requested details (including your PAN  number), email address and mobile number.  After entering the details, click on proceed. </li>
       </ul>
     </div>
     <div class="sellerhub-div">
       <h4>How will this information be used?</h4>
       <p>Your business details will be automatically  fetched from GSTIN. To change any  information, visit the government portal  and update the information on your GSTIN.</p>
     </div>
     {elseif $_REQUEST.step == '3'}
        <h1>List down your<br />Brands & <br />Categories</h1>
        <div class="sellerhub-div">
          <p>One or more, you can add unlimited  brands and product categories that you wish to sell on Xplore. </p>
        </div>
        <div class="sellerhub-div">
        <h4>Manage your business on the go with Xplore App</h4>
        <p>Use the app to manage orders or respond to buyers' messages with just one tap.</p>
      </div>
     {elseif $_REQUEST.step == '4'}
        <h1>Share your <br />bank details</h1>
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
      <h1>Welcome to <br />the Seller <br />Community</h1>
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
            {include file="addons/jmj_digital/views/auth/step_1.tpl"}
            {elseif $_REQUEST.step == '2'}
                {include file="addons/jmj_digital/views/auth/step_2.tpl"}
            {elseif $_REQUEST.step == '3'}
                {include file="addons/jmj_digital/views/auth/step_3.tpl"}
            {elseif $_REQUEST.step == '4'}
                {include file="addons/jmj_digital/views/auth/step_4.tpl"}
            {elseif $_REQUEST.step == '5'}
                {include file="addons/jmj_digital/views/auth/success.tpl"}
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
			  <li>If the Input Tax Credit of GST is not realized by JM Jain LLP due to Vendor's fault, then Vendor shall bear penalty imposed on JM Jain LLP.</li>
			  <li>The Vendor shall not directly deal with any of the customers introduced by JM Jain LLP, without written consent of JM Jain LLP, under any circumstances. In case of default, the Vendor shall be liable to pay a penalty @ 10 % of total value of business done in the 12 months preceding last purchase by JM Jain LLP.</li>
			  <li>Vendor shall arrange transit insurance of goods F.O.R. Consignee.</li>
			  <li>All terms and conditions in Principal Customer's purchase order shall be binding.</li>
			  <li>Notwithstanding any standard/specific term or condition contained in Vendor's Invoice/Bill, all disputes shall be subject to Delhi Jurisdiction and terms of this agreement shall prevail.</li>
			</ul>
		  </div>
		</div>
	  </div>
	</div>
  </div>



</body>

					  
		