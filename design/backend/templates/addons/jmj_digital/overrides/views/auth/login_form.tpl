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

{literal}
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
        color: #ffffff;
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
    }
    input[type="submit"].btn {
    height: 54px;
}
.forget-password a
{
    text-decoration:none;
    font-size: 15px;
}

    </style>
{/literal}
<body>
{if $basename == 'admin.php'}
    {hook name="auth:login_form"}
    <section class="seller-hub-account-main">
        <div class="container-fluid">
          <div class="container-jain">
            <div class="row">
              <div class="col-md-5">
                <div class="seller-hub-account-left">
                  <h1>Login to <br />your Admin<br />panel</h1>
                  <div class="sellerhub-div">
                    <p>You’re just a step away to <span><b>Xplore</b></span> a  world of limitless possibilites!</p>
                  </div>
                </div>
              </div>
              <div class="col-md-7">
                <div class="seller-hub-account-right">
                  <div class="sellerhub-forms">
                      <form action="{""|fn_url}" method="post" name="main_login_form" >
                          <input type="hidden" name="return_url" value="{$smarty.request.return_url|fn_url:"A":"rel"|fn_query_remove:"return_url"}">
                          <!--<div class="modal-header">
                              <h4>{__("administration_panel")}</h4>
                          </div>-->
                    
                              <div class="form-group">
                                 <!--<label for="username" class="cm-trim cm-required cm-email">{__("email")}:</label>-->
                                 <label for="username" class="cm-trim cm-required cm-email">Login ID</label>
                                  <input id="username"  class="form-control" type="text" name="user_login" size="20" value="{if $stored_user_login}{$stored_user_login}{else}{$config.demo_username}{/if}" class="cm-focus" tabindex="1" placeholder="Login ID">
                              </div>
                          
                              <div class="form-group">
                                  <label for="form_password" class="cm-required">{__("password")}:</label>
                                  <input type="password" class="form-control" id="form_password" name="password" size="20" value="{$config.demo_password}" tabindex="2" maxlength="32" placeholder="Password">
                              </div>
                        
                          <div class="form-group mb-0">
                              <div class="input-group align-items-center">
                                {include file="buttons/sign_in.tpl" but_name="dispatch[auth.login]" but_meta="ty-btn float-right ty-btn__secondary sellerbtn" but_role="button_main" tabindex="3"}
                                <div class="forget-password"><a href="{"auth.recover_password"|fn_url}" class="pull-right">{__("forgot_password_question")}</a>
                                </div>
                              </div>
                          </div>
                      </form>
                </div>
              </div>
            </div>
          </div>
          </div>
        </div>
      </section>
    {/hook}
{else}
    {include file="addons/jmj_digital/views/auth/components/vendor_login_page.tpl"}
{/if}


<!----------------------- code by onj start for otp process--------------------------->

<div class="modal-otp myModal-otp" style="display: none;">
    <!-- Modal content -->
    <div class="modal-content-otp">
        <span class="close-otp">×</span>
        {include file="common/notification.tpl"}

        <div class="otp_from">
            <form name="{$id}_form" action="{"auth.jmj_otp_login"|fn_url}" method="post" class="cm-ajax">
                <input type="hidden" name="user_code" value="" id="otp_form_user_code" class="ty-login__input cm-focus" />
                <input type="hidden" name="password" value="" id="otp_form_password" class="ty-login__input cm-focus" />
                <input type="hidden" name="return_url" value="{$REQUEST.return_url|default:$config.current_url}" />

                <div class="ty-control-group">
                    <label for="login_otp" class="ty-login__filed-label ty-control-group__label">{__("enter_otp")}</label>
                    <input type="text" id="login_otp" name="otp_login" size="10" value="" class="ty-login__input cm-focus" />
                </div>

                <div class="buttons-container clearfix">
                    <div class="float-left">
                        <input class="ty-btn__secondary" type="submit" value="Sign in" tabindex="3">
                    </div>
                    <div class="float-right">
                        <a id="resend_otp" class="request_otp ty-btn ty-btn__primary" rel="nofollow" data-resend="1">RESEND</a>
                    </div>
                </div>

            </form>
        </div>  
    </div>
</div>
</body>
<!-- Login by OTP code start here -->
<script>
    $(".request_otp").on('click', function(){
        var resend = $(this).attr('data-resend');
        var customer_type = 'V';
        $('.otp-success').text('');
        if(resend==0){
            var user_code = $('#form_user_code').val();
            var password = $('#form_password').val();
        }else{
            var user_code = $('#otp_form_user_code').val();
            var password = $('#otp_form_password').val();
        }
        
        var data = {
            user_code: user_code,
            password: password,
            resend:resend,
            customer_type:customer_type
        }
        
        $.ceAjax('request', fn_url('auth.request_otp'), {
            cache: false,
            data: data,
            callback: function(response) {
                var restext = $.parseJSON(response.text);
                if(restext.status == 1){
                    $(".myModal-otp").show();
                    setTimeout(function() {
                        $('#otp_form_password').val(password);
                        $('#otp_form_user_code').val(restext.user_code);
                    }, 1000);
                }
            }
        });
    });
    $(document).delegate(".close-otp", "click", function () {
        $(this).closest(".myModal-otp").hide();
    });
</script>
<!-- Login by OTP code end here -->