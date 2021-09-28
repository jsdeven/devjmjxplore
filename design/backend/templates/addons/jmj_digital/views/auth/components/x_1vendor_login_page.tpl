<!DOCTYPE html>
<html lang="en">
  <head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <title>JMJXPLORE - Seller</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="design/backend/css/addons/jmj_digital/vendor_login_page_assets/vendor/bootstrap/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <!-- Google Fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
    <!-- MDB -->
    <link rel="stylesheet" href="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/css/mdb.min.css">

    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/css/fontawesome.css">
    <link rel="stylesheet" href="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/css/templatemo-space-dynamic.css?v6">
    <link rel="stylesheet" href="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/css/animated.css">
    <link rel="stylesheet" href="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/css/owl.css">
	  <link rel="stylesheet" href="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/css/aks.style.css">
  </head>

<body>    
   
    <!-- ***** Preloader Start ***** -->
  <div id="js-preloader" class="js-preloader loaded">
    <div class="preloader-inner">
      <span class="dot"></span>
      <div class="dots">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div>
  </div>
  <!-- ***** Preloader End ***** -->


  <!-- ***** Header Area Start ***** -->
  <header class="header-area header-sticky wow slideInDown" data-wow-duration="0.75s" data-wow-delay="0s">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <nav class="main-nav">
            <!-- ***** Logo Start ***** -->
            <a href="/" class="logo">
              <h4><img class="ty-pict  ty-logo-container__image cm-image" src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/img/logo.jpg" height="62px" width="auto"></h4>
            </a>
            <!-- ***** Logo End ***** -->
            <!-- ***** Menu Start ***** -->
            <ul class="nav">
              <li class="scroll-to-section"><a href="blockchains.php">WHY XPLORE</a></li>
              <li class="scroll-to-section"><a href="nft-market.php">HOW TO SELL</a></li>
              <li class="scroll-to-section"><a href="wallets.php">SUCCESS STORIES</a></li>
              <li class="scroll-to-section"><a href="#blog">FAQs</a></li> 
               <li>
              <div class="dropdown">
              <button id="btnUserLogin" class="btn btn-default main-top-button dropdown-toggle d-none d-md-block" data-bs-toggle="dropdown" aria-expanded="false"><i class="fa fa-user"></i> Login for existing sellers</button>
              <ul class="dropdown-menu" aria-labelledby="btnUserLogin">
                <!-- ***** Login ***** -->
                  <div class="vendor-login-form">
                    <form action="{""|fn_url}" method="post">
                        <div class="input-cont">
                            <input type="text" id="form_user_code">
                            <label id="form_user_code">Username</label>
                            <div class="border1"></div>
                        </div>
                        <div class="input-cont">
                            <input type="password" id="form_password">
                            <label id="form_password">Password</label>
                            <div class="border2"></div>
                        </div>
                        <a href="{"auth.recover_password"|fn_url}" target="_blank" class="forgot-link">Forgot Password</a>
                        <div class="clear"></div>
                        <span data-resend="0" class="request_otp btn btn-primary mr-lg-2">{__('request_otp')}</span>
                        <div class="text-center">Register for a new seller's account <a class="register-link" href="{'auth.seller_register'|fn_url}">click here</a></div>
                    </form>
                  </div><!--//vendor-login-form-->
                <!-- ***** Login End ***** -->
            </ul>   

              <div class="dropdown">
              <a id="btnMobileLogin" class="btn-mob-login dropdown-toggle d-md-none" data-bs-toggle="dropdown" aria-expanded="false"><i class="fa fa-user"></i></a>
              <ul class="dropdown-menu" aria-labelledby="btnMobileLogin">
                <!-- ***** Login ***** -->
                  <div class="vendor-login-form">
                    <form action="{""|fn_url}" method="post">
                        <div class="input-cont">
                            <input type="text" id="form_user_code">
                            <label id="form_user_code">Username</label>
                            <div class="border1"></div>
                        </div>
                        <div class="input-cont">
                            <input type="password" id="form_password">
                            <label id="form_password">Password</label>
                            <div class="border2"></div>
                        </div>
                        <a href="{"auth.recover_password"|fn_url}" target="_blank" class="forgot-link">Forgot Password</a>
                        <div class="clear"></div>
                        <span data-resend="0" class="request_otp btn btn-primary mr-lg-2">{__('request_otp')}</span>
                        <div class="text-center">Register for a new seller's account <a class="register-link" href="{'auth.seller_register'|fn_url}">click here</a></div>
                    </form>
                  </div><!--//vendor-login-form-->
                <!-- ***** Login End ***** -->
              </ul>
            </div>

            <a class='menu-trigger'>
                <span>Menu</span>
            </a>
            <!-- ***** Menu End ***** -->
          </nav>
        </div>
      </div>
    </div>
  </header>
  <!-- ***** Header Area End ***** -->
  

   <!-- ***** Login ***** -->
   
     <div class="col-6 col-md-5 mb-5" style="padding-top: 3rem;">
				    <div class="book-cover-holder">
					    <div class="vendor-login-form" style="border:solid">
                            <h2>Login</h2>
                            <form action="{""|fn_url}" method="post">
                                <div class="input-cont">
                                    <input type="text" id="form_user_code">
                                    <label id="form_user_code">Username</label>
                                    <div class="border1"></div>
                                </div>
                                <div class="input-cont">
                                    <input type="password" id="form_password">
                                    <label id="form_password">Password</label>
                                    <div class="border2"></div>
                                </div>
                                <a href="{"auth.recover_password"|fn_url}" target="_blank" class="pull-right" style="margin-bottom: 10px;padding-right: 2rem;">Forgot Password</a>
                                <div class="clear"></div>
                                <span data-resend="0" class="request_otp btn btn-primary mr-lg-2">{__('request_otp')}</span>
								                <div class="text-center">Register for a seller's new account &nbsp<a class="theme-link" href="{'auth.seller_register'|fn_url}" target="_blank">click here</a></div>
                            </form>
							
                        </div>
				    </div><!--//book-cover-holder-->
			    </div><!--col-->
 
 <!-- ***** Login End ***** -->


  <div class="main-banner wow fadeIn" id="top" data-wow-duration="1s" data-wow-delay="0.5s">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <div class="row">
            <div class="col-lg-6 align-self-center">
              <div class="left-content header-text wow fadeInLeft" data-wow-duration="1s" data-wow-delay="1s">
                <h2>XPLORE enhanced <em>authentication</em></h2>
                <p>We do an in-depth verification of every buyer & seller and limit product information access to relevant customers only, so that you can explore with confidence.</p>
                <button type="button" class="btn btn-default main-button">Register Now</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div id="reasons" class="reasons section">
    <div class="container">
      <div class="row">
        <div class="section-heading mb-5">
          <h2 class="text-center"> why sell on <em>xplore</em></h2>
          <p>As a simple, secure and single unified platform, Xplore not only helps businesses to maximize their potential but also empowers them with industry data, insights, innovative technology and in-depth knowledge to create a name for their brand and products.</p>
        </div>
        <div class="col-md-6">
          <div class="card shadow-none">
            <img src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/img/card1-bg.jpg" class="card-image" alt="...">
            <div class="card-img-overlay">
              <div class="card-body">
                <h5 class="card-title">NETWORK ADVANTAGE</h5>
                <p class="card-text">As a seller on Xplore you connect with thousands of retailers and have access to a strong network of markets and logistics. Hence you are not confined to one selling region or one type of customer</p>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="card shadow-none">
            <img src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/img/card2-bg.jpg" class="card-image" alt="...">
            <div class="card-img-overlay">
              <div class="card-body">
                <h5 class="card-title">HIGH PROFITABILITY</h5>
                <p class="card-text">With Xplore’s online selling platform, you are open for business  24X7, 365 days a year - thus not being impacted by seasonality or geographic limits</p>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="card shadow-none">
            <img src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/img/card3-bg.jpg" class="card-image" alt="...">
            <div class="card-img-overlay">
              <div class="card-body">
                <h5 class="card-title">ZERO COST SET-UP</h5>
                <p class="card-text">Registering on Xplore is FREE. Your product listings are active and LIVE till they sell. Once you make a sale, you only pay a small commission fee</p>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="card shadow-none">
            <img src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/img/card4-bg.jpg" class="card-image" alt="...">
            <div class="card-img-overlay">
              <div class="card-body">
                <h5 class="card-title">CONVENIENCE & FLEXIBILITY</h5>
                <p class="card-text">Run your business from anywhere with the Xplore app and manage orders, update items and respond to customers on the go, seamlessly</p>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="card shadow-none">
            <img src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/img/card5-bg.jpg" class="card-image" alt="...">
            <div class="card-img-overlay">
              <div class="card-body">
                <h5 class="card-title">POWERFUL PLATFORM</h5>
                <p class="card-text">Accelerate your digital sales using our technology, and marketing strengths to get detailed insights on sales, returns, inventory & other aspects of business</p>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="card shadow-none">
            <img src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/img/card6-bg.jpg" class="card-image" alt="...">
            <div class="card-img-overlay">
              <div class="card-body">
                <h5 class="card-title">SELLER SUPPORT</h5>
                <p class="card-text">Run your business from anywhere with the Xplore app and manage orders, update items and respond to customers on the go, seamlessly</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div id="howto" class="howto section">
    <div class="container">
      <div class="row">
        <div class="section-heading mb-5">
          <h2 class="text-center"> how to sell on <em>xplore</em></h2>
          <p>Step by Step Guide on how to create a Seller Account on Xplore</p>
        </div>
        <div class="col-md-4">
          <div class="card shadow-none">
              <div class="card-body">
                <h5 class="card-title">STEP 1</h5>
                <p class="card-text"><b>Download Xplore App</b>, enter mobile number and verify using OTP</p>
              </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card shadow-none">
              <div class="card-body">
                <h5 class="card-title">STEP 2</h5>
                <p class="card-text"><b>Add personal and business details</b> and verify</p>
              </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card shadow-none">
              <div class="card-body">
                <h5 class="card-title">STEP 3</h5>
                <p class="card-text"><b>Enter brand and product</b>category details</p>
              </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-4">
          <div class="card shadow-none">
              <div class="card-body">
                <h5 class="card-title">STEP 4</h5>
                <p class="card-text"><b>Upload shop images</b> and necessary business documents</p>
              </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card shadow-none">
              <div class="card-body">
                <h5 class="card-title">STEP 5</h5>
                <p class="card-text"><b>Our team will verify the details</b> & get back to you</p>
              </div>
          </div>
        </div>
        <div class="col-md-2"></div>
      </div>
    </div>
  </div>

  <div id="success" class="success section">
    <div class="container">
      <div class="row">
        <div class="section-heading mb-5">
          <h2 class="text-center">SUCCESS STORIES</h2>
          <p>Xplore is a transformative and a single unified platform, backed by innovative technology and industry insights, which empowers you to run, scale & grow your business seamlessly. But don’t take our word for it. Hear stories from our sellers about how Xplore has made a difference for them.</p>
        </div>
      </div>

      <div class="owl-carousel owl-theme">
        <div class="item">
            <div class="row gx-0">
              <div class="col-md-6 grey-bg">
                <p class="slide-no">1/3</p>
                <p class="tes-text">I did not expect much at first in terms of sales results, but thten I started to receive serious inquiries and messages for our products.</p>
                <p class="tes-name">Suman Kapoor</p>
                <p class="tes-desg">Owner, Delhi</p>
              </div>
              <div class="col-md-6">
                <img src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/img/testi1.jpg" class="img-responsive">
              </div>
            </div>
        </div>
        <div class="item">
            <div class="row gx-0">
              <div class="col-md-6 grey-bg">
                <p class="slide-no">1/3</p>
                <p class="tes-text">I did not expect much at first in terms of sales results, but thten I started to receive serious inquiries and messages for our products.</p>
                <p class="tes-name">Suman Kapoor</p>
                <p class="tes-desg">Owner, Delhi</p>
              </div>
              <div class="col-md-6">
                <img src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/img/testi1.jpg" class="img-responsive">
              </div>
            </div>
        </div>
        <div class="item">
            <div class="row gx-0">
              <div class="col-md-6 grey-bg">
                <p class="slide-no">2/3</p>
                <p class="tes-text">I did not expect much at first in terms of sales results, but thten I started to receive serious inquiries and messages for our products.</p>
                <p class="tes-name">Suman Kapoor</p>
                <p class="tes-desg">Owner, Delhi</p>
              </div>
              <div class="col-md-6">
                <img src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/img/testi1.jpg" class="img-responsive">
              </div>
            </div>
        </div>
        <div class="item">
            <div class="row gx-0">
              <div class="col-md-6 grey-bg">
                <p class="slide-no">3/3</p>
                <p class="tes-text">I did not expect much at first in terms of sales results, but thten I started to receive serious inquiries and messages for our products.</p>
                <p class="tes-name">Suman Kapoor</p>
                <p class="tes-desg">Owner, Delhi</p>
              </div>
              <div class="col-md-6">
                <img src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/img/testi1.jpg" class="img-responsive">
              </div>
            </div>
        </div>
        <div class="item">
            <div class="row gx-0">
              <div class="col-md-6 grey-bg">
                <p class="slide-no">1/3</p>
                <p class="tes-text">I did not expect much at first in terms of sales results, but thten I started to receive serious inquiries and messages for our products.</p>
                <p class="tes-name">Suman Kapoor</p>
                <p class="tes-desg">Owner, Delhi</p>
              </div>
              <div class="col-md-6">
                <img src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/img/testi1.jpg" class="img-responsive">
              </div>
            </div>
        </div>
    </div>

    </div>
  </div>

  <div id="faq" class="faq section">
    <div class="container">
      <div class="row">
        <div class="section-heading mb-5">
          <h2 class="text-center">FAQs</h2>
          <p>Here are some common questions about selling on Xplore</p>
        </div>
      </div>
      <div class="accordion accordion-flush" id="faqs">
        <div class="accordion-item">
        <h2 class="accordion-header" id="headingOne">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseTwo">
            What can I sell on Xplore?
          </button>
        </h2>
        <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <strong>This is the first item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
          </div>
        </div>
      </div>
      <div class="accordion-item">
        <h2 class="accordion-header" id="headingTwo">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
            What is the cost to sell items on Xplore?
          </button>
        </h2>
        <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
          </div>
        </div>
      </div>
      <div class="accordion-item">
        <h2 class="accordion-header" id="headingThree">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
            How can I decide my listing price?
          </button>
        </h2>
        <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
          </div>
        </div>
      </div>
      <div class="accordion-item">
        <h2 class="accordion-header" id="headingFour">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
            What is the best way to ship my product?
          </button>
        </h2>
        <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#accordionExample">
          <div class="collapseFour-body">
            <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
          </div>
        </div>
      </div>
      <div class="accordion-item">
        <h2 class="accordion-header" id="headingFive">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
            Does Xplore protect sellers? How?
          </button>
        </h2>
        <div id="collapseFive" class="accordion-collapse collapse" aria-labelledby="headingFive" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
          </div>
        </div>
      </div>
      <div class="accordion-item">
        <h2 class="accordion-header" id="headingSix">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
            How do I get paid for my sale?
          </button>
        </h2>
        <div id="collapseSix" class="accordion-collapse collapse" aria-labelledby="headingSix" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
          </div>
        </div>
      </div>
      <div class="accordion-item">
        <h2 class="accordion-header" id="headingSeven">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven">
            Will my designs and patters get copied by other sellers or buyers?
          </button>
        </h2>
        <div id="collapseSeven" class="accordion-collapse collapse" aria-labelledby="headingSeven" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12 text-center">
        <p class="mt-4 mb-4">Still have more questions? Feel free to contact us.</p>
        <button type="button" class="btn btn-default contactx-button">Contact Xplore</button>
      </div>
    </div>

    </div>
  </div>

    <footer class="footer">

	    <div class="footer-bottom text-center py-5">
            <small class="copyright">JMJ Xplopre © 2020</small>
	    </div>
	    
    </footer>
       
    <!-- Javascript -->        
    {script src="addons/jmj_digital/vendor_login_page_assets/plugins/popper.min.js"}
    {script src="addons/jmj_digital/vendor_login_page_assets/plugins/bootstrap/js/bootstrap.min.js"}
    {script src="addons/jmj_digital/vendor_login_page_assets/plugins/jquery.scrollTo.min.js"} 
    {script src="addons/jmj_digital/vendor_login_page_assets/plugins/back-to-top.js"}
    
    {script src="addons/jmj_digital/vendor_login_page_assets/js/main.js"}

  <script src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/js/mdb.min.js"></script>
  <script src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/js/owl-carousel.js"></script>
  <script src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/js/animation.js"></script>
  <script src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/js/imagesloaded.js"></script>
  <!--<script src="design/backend/css/addons/jmj_digital/vendor_login_page_assets/assets/js/templatemo-custom.js"></script>-->
 <script>
    $('.owl-carousel').owlCarousel({
      items:1,
      loop:true,
      center: true,
      items: 1,
      margin: 0,
      dots: true,
      nav: true,
      autoplay: true
    });
  </script>

</body>
</html>