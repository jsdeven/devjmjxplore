{literal}
    <style>
        .object-container .notification-content {
            top: 11px!important;
            right: 15px!important;
            left: 15px!important;
            min-width: 350px!important;
            position: absolute!important;
            z-index: 1510!important;
        }
    </style>
{/literal}

<div>
    <form id="product_image_update_form" action="{"jmj_products.update"|fn_url}" method="post" name="product_image_update_form" class="form-horizontal form-edit  cm-disable-empty-files" enctype="multipart/form-data">
        <input type="hidden" name="current_step" value="9" />
        <input type="hidden" name="fake" value="1" />
        <input type="hidden" name="product_id" value="{$product_data.product_id}" />
        {include file="addons/jmj_digital/views/jmj_products/components/step_2.tpl"}
        <div>
            <input type="submit" class="ty-btn float-right ty-btn__secondary" name="dispatch[jmj_products.update]" value="upload" />
        </div>
    </form>     
</div>
<script type="text/javascript">
    $(document).ready(function(){
        $('.ui-icon-closethick').hide(); 
        $('.ui-dialog-titlebar').append("<a id='close_pop' class='float-right ty-btn__close'>X</a>");
        $('#close_pop').on('click', function(){
           window.location.reload();
        });
    });
   
</script>
