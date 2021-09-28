{literal}
    <style>
        .signin-modal .modal-footer a {
            height: 32px;
        }
    </style>
{/literal}

{if $basename == 'admin.php'}
    {hook name="auth:login_form"}
    <div class="modal signin-modal">
        <form action="{""|fn_url}" method="post" name="main_login_form" class=" cm-skip-check-items cm-check-changes">
            <input type="hidden" name="return_url" value="{$smarty.request.return_url|fn_url:"A":"rel"|fn_query_remove:"return_url"}">
            <div class="modal-header">
                <h4>{__("administration_panel")}</h4>
            </div>
            <div class="modal-body">
                <div class="control-group">
                    <label for="username" class="cm-trim cm-required cm-email">{__("email")}:</label>
                    <input id="username" type="text" name="user_login" size="20" value="{if $stored_user_login}{$stored_user_login}{else}{$config.demo_username}{/if}" class="cm-focus" tabindex="1">
                </div>
            
                <div class="control-group">
                    <label for="form_password" class="cm-required">{__("password")}:</label>
                    <input type="password" id="form_password" name="password" size="20" value="{$config.demo_password}" tabindex="2" maxlength="32">
                </div>
            </div>
            <div class="modal-footer">
                
                {include file="buttons/sign_in.tpl" but_name="dispatch[auth.login]" but_role="button_main" tabindex="3"}
                <a href="{"auth.recover_password"|fn_url}" class="pull-right">{__("forgot_password_question")}</a>
            </div>
        </form>
    </div>
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