{literal}
    <style>
        .object-container .notification-content {
            top: 11px;
            right: 24px;
            min-width: 236px!important;
            position: absolute;
            z-index: 1510;
        }
        
    </style>
{/literal}
{assign var="id" value=$id|default:"main_login"}

{capture name="login"}
    <form name="{$id}_form" action="{"auth.request_otp"|fn_url}" method="post" class="cm-ajax cm-ajax-full-render">
        {if $style == "popup"}
            <input type="hidden" name="result_ids" value="{$id}_login_popup_form_container" />
            <input type="hidden" name="login_block_id" value="{$id}" />
            <input type="hidden" name="quick_login" value="1" />
        {/if}

        <input type="hidden" name="return_url" value="{$smarty.request.return_url|default:$config.current_url}" />
        <input type="hidden" name="redirect_url" value="{$redirect_url|default:$config.current_url}" />

        {if $style == "checkout"}
            <div class="ty-checkout-login-form">{include file="common/subheader.tpl" title=__("returning_customer")}
        {/if}

        <div class="ty-control-group">
            <label for="form_user_code" class="ty-login__filed-label ty-control-group__label cm-required cm-trim">{__("email")}</label>
            <input type="text" id="form_user_code" name="email" size="30" value="{if $stored_user_login}{$stored_user_login}{else}{$config.demo_username}{/if}" class="ty-login__input cm-focus" />
        </div>

        <div class="ty-control-group ty-password-forgot">
            <label for="form_password" class="ty-login__filed-label ty-control-group__label ty-password-forgot__label cm-required">{__("password")}</label><a href="{"auth.recover_password"|fn_url}" class="ty-password-forgot__a"  tabindex="5">{__("forgot_password_question")}</a>
            <input type="password" id="form_password" name="password" size="30" value="{$config.demo_password}" class="ty-login__input" maxlength="32" />
        </div>

        {if $style == "popup"}
            {if $login_error}
                <div class="ty-login-form__wrong-credentials-container">
                    <span class="ty-login-form__wrong-credentials-text ty-error-text">{__("error_incorrect_login")}</span>
                </div>
            {/if}

            <div class="ty-login-reglink ty-center">
                <a class="ty-login-reglink__a" href="{"profiles.add"|fn_url}" rel="nofollow">{__("register_new_account")}</a>
            </div>
        {/if}

        {include file="common/image_verification.tpl" option="login" align="left"}

        {if $style == "checkout"}
            </div>
        {/if}

        {hook name="index:login_buttons"}
            <div class="buttons-container clearfix">
                <!-- <div class="ty-float-right">
                    {include file="buttons/login.tpl" but_name="dispatch[auth.login]" but_role="submit"}
                </div> -->
                <div class="ty-login__by_otp ty-float-right">
                    <a data-resend="0" class="request_otp ty-btn float-left ty-btn__secondary">{__('request_otp')}</a>
                </div>
            </div>
        {/hook}
    </form>
{/capture}

{if $style == "popup"}
    <div id="{$id}_login_popup_form_container">
        {$smarty.capture.login nofilter}
    <!--{$id}_login_popup_form_container--></div>
{else}
    <div class="ty-login">
        {$smarty.capture.login nofilter}
    </div>

    {capture name="mainbox_title"}{__("sign_in")}{/capture}
{/if}

<!----------------------- code by onj start for otp process--------------------------->

<div class="modal-otp myModal-otp" style="display: none;">
    <!-- Modal content -->
    <div class="modal-content-otp">
        <span class="close-otp">×</span>

        <div class="otp_from">
            <form name="{$id}_form" action="{"auth.jmj_otp_login"|fn_url}" method="post" class="cm-ajax">
                <input type="hidden" name="user_code" value="" id="otp_form_user_code" class="ty-login__input cm-focus" />
                <input type="hidden" name="password" value="" id="otp_form_password" class="ty-login__input cm-focus" />
                <input type="hidden" name="return_url" value="{$REQUEST.return_url|default:$config.current_url}" />

                <div class="ty-control-group">
                    <label for="login_otp" class="ty-login__filed-label ty-control-group__label">{__("enter_otp")}</label>
                    <input type="text" id="login_otp" name="otp_login" size="10" value="" class="ty-login__input cm-focus" />
                </div>

                <div class="clearfix">
                    <div class="ty-float-left">
                        {include file="buttons/login.tpl" but_name="dispatch[auth.login]" but_role="submit"}
                    </div>
                    <div class="ty-float-right">
                        <a id="resend_otp" class="request_otp ty-btn ty-btn__primary" rel="nofollow" data-resend="1">RESEND</a>
                    </div>
                </div>

            </form>
        </div>  
    </div>
</div>

<!-- Login by OTP code start here -->
<script>
    $(".request_otp").off().on('click', function(){
        var resend = $(this).attr('data-resend');
        var customer_type = 'C';
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
        
        $.ceAjax('request', 'https://jmjxplore.com/?dispatch=auth.request_otp', {
            cache: false,
            data: data,
            callback: function(response) {
                var restext = $.parseJSON(response.text);
                if(restext.status == 1){
                    $(".myModal-otp").show();
                    setTimeout(function() {
                        $('#otp_form_password').val(password);
                        $('#otp_form_user_code').val(user_code);
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
