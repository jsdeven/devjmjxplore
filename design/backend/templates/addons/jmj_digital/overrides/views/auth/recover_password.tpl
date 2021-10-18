
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="design/backend/css/addons/jmj_digital/seller_page_assets/images/fevicon.png" sizes="64x64" type="image/png">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="design/backend/css/addons/jmj_digital/seller_page_assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="design/backend/css/addons/jmj_digital/seller_page_assets/css/style.css">
    <link rel="stylesheet" href="design/backend/css/addons/jmj_digital/seller_page_assets/css/responsive.css">
  </head>
  
      <style>
          .signin-modal .modal-footer a {
              height: 32px;
          }
  
          #main_column_login {
      height: 0%;
  }
  body {
    background-image: url('https://jmjxplore.com/design/backend/css/addons/jmj_digital/seller_page_assets/img/background.jpg');
    background-repeat: no-repeat;
  }
  
  .sellerbtn{
          font-size: 14px;
          line-height: 30px;
          color: #ffffff;
          font-weight: 600;
          font-family: "Montserrat";
          text-align: center;
          background-color: #ff0064;
          border: 0px;
          border-radius: 0;
          padding: 15px 46px;
          text-transform: uppercase;
          display: inline-block;
          height: 54px;
  }
     span
     {
        color: #ff0064;
     }
      .sellerbtn:hover {
          background: #124062;
          border: 1px solid #124062;
          transition: all 0.7s;
          color: #ffffff;
      }
      input[type="submit"].btn {
      height: 54px;
  }
  .forget-password a
  {
      text-decoration:none;
  }
  .mb-3, .my-3 {
    margin-bottom: 5rem!important;
}
</style>
<body>
    <section class="seller-hub-account-main">
    <div class="container-fluid">
      <div class="container-jain">
        <div class="row">
          <div class="col-md-5">
            <div class="seller-hub-account-left">
              <h1>Recover to <br /> your Forgot<br />password</h1>
              <div class="sellerhub-div">
                <p>Enter your <b><span>email address</span></b> to receive a new login key and a link to sign in and change your password.</p>
              </div>
              <div class="sellerhub-div">
                <p>You’re just a step away to Xplore a  world of limitless possibilites!</p>
              </div>
            </div>

          </div>
          <div class="col-md-7">
            <div class="seller-hub-account-right">
              <div class="sellerhub-forms">
                <form action="{""|fn_url}" method="post" name="recover_form">
        <!-- <div class="modal-header">
            <h4>{__("recover_password")}</h4>
        </div>-->
        {if $action == "request"}
            <div  class="form-group">
                <!--<p>{__("text_recover_password_notice")}</p>-->
                <label for="user_login" class="cm-trim cm-required cm-email">{__("email")}:</label>
                <input type="text" name="user_email" id="user_login" class="form-control" size="20" value="" placeholder="Email address"/>
            </div>
            <div class="form-group mb-3">
                <div class="pull-left"> 
                {include file="buttons/button.tpl" but_text=__("reset_password") but_name="dispatch[auth.recover_password]" but_role="button_main" but_meta="ty-btn float-right ty-btn__secondary sellerbtn"}
                </div>
            </div>
            <div class="form-group">
                {elseif $action == "recover"}<input type="hidden" class="form-control" name="ekey" value="{$ekey}" />
            </div>
            <div class="form-group">
                <p>{__("press_continue_to_recover_password")}</p>
            </div>

            <div class="form-group mb-3">
                <div class="pull-left"> 
                {include file="buttons/button.tpl" but_text=__("continue")
                but_name="dispatch[auth.recover_password]"
                 but_role="button_main" but_meta="ty-btn float-right ty-btn__secondary sellerbtn"}
                </div>
            </div>
        {/if}
    </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

</body>