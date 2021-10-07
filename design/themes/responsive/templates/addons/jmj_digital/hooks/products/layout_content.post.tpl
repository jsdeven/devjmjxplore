
<!-- The Modal -->
<div id="myModal" class="modal">
  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <span class="close">&times;</span>
      <span style="font-size: 24px;">{$product.product nofilter}</span>
    </div>
    <div class="modal-body">
        
        <form method="POST" action="index.php?dispatch=products.product_enquiry_bulk" class="form-padding-arrange-block">
            <input type="hidden" name="product_id" value="{$product.product_id}">
            <input type="hidden" name="product_name" value="{$product.product}">
            <input type="hidden" name="product_code" value="{$product.product_code}">
            <input type="hidden" name="product_price" value="{$product.price}">
            <input type="hidden" name="company_id" value="{$company_id}" />
           
            <input type="hidden" name="user_id" value="{$smarty.session.auth.user_id}">
         
            <input type="hidden" name="cus_dispatch" value="products.product_enquiry_bulk">
            
            <div class="ty-control-group">
                <label for="quote_qunatity" class="ty-control-group__title cm-integer cm-required">{__("quote_qunatity")}</label>
                <input id="quote_qunatity" class="ty-input-text cm-focus " size="50" type="number" name="quote_qunatity" value={$product.min_qty}>
            </div>
            
            <div class="ty-control-group">
                <label for="quote_price" class="ty-control-group__title cm-value-decimal cm-required">{__("quote_price")}</label>
                <input id="quote_price" class="ty-input-text cm-focus" size="50" type="number" name="quote_price" value={$product.price|round:2}>
            </div>
            
            <div class="ty-control-group">
                <label for="dispatch_date" class="ty-control-group__title cm-required">{__("dispatch_date")}</label>
                <input id="dispatch_date" class="ty-input-text cm-focus" size="50" type="date" name="dispatch_date" />
            </div>

            <!--<div class="ty-control-group">
                <label for="first_name" class="ty-control-group__title cm-required">{__("first_name")}</label>
                <input id="first_name" class="ty-input-text cm-focus " size="50" type="text" name="first_name" value={$user_info.first_name}>
            </div>
                    
            <div class="ty-control-group">
                <label for="last_name" class="ty-control-group__title cm-required">{__("last_name")}</label>
                <input id="last_name" class="ty-input-text cm-focus " size="50" type="text" name="last_name" value={$user_info.last_name}>
            </div>
                    
            <div class="ty-control-group">
                <label for="phone" class="ty-control-group__title cm-required cm-phone">{__("phone")}</label>
                <input id="phone" class="ty-input-text cm-focus " size="50" type="text" name="mobile_num" value={$user_info.phone}>
            </div>

            <div class="ty-control-group">
                <label for="email" class="ty-control-group__title cm-required cm-email ">{__("email")}</label>
                <input id="email" class="ty-input-text cm-focus " size="50" type="text" name="email_bulk" value={$user_info.email}>
            </div>

            <div class="ty-control-group">
                <label for="pincode" class="ty-control-group__title cm-integer cm-required">{__("pincode")}</label>
                <input id="pincode" class="ty-input-text cm-focus " size="50" type="text" name="pincode" value={$user_info.pincode}>
            </div>
                    
            <div class="ty-control-group">
                <label for="comment" class="ty-control-group__title cm-required ">{__('comment')}</label>
                <textarea id="comment" class="ty-form-builder__textarea" name="message_bulk" cols="67" rows="10"></textarea>
            </div>-->

            <div class="ty-form-builder__buttons buttons-container">
                <button style="width:15%" class="ty-btn__primary ty-btn" type="submit" name="dispatch[products.product_enquiry_bulk]"><span><span>Submit</span></span></button>
                <a style="width:15%" class="ty-btn__secondary ty-btn reset-quote-field">Reset</a>
            </div>

        </form>
    </div>
  </div>
</div>
{literal}
<script>
// Get the modal
var modal = document.getElementById("myModal");

// Get the button that opens the modal
var btn = document.getElementById("buy_bluk_button");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
btn.onclick = function() {
  modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
</script>
<style>
    .paddings{
        float: left;
        padding: 10px;
    }

    /* The Modal (background) */
    .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        padding-top: 100px; /* Location of the box */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }

    /* Modal Content */
    .modal-content {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        border: 1px solid #888;
        width: 40%;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animatetop;
        -webkit-animation-duration: 0.4s;
        animation-name: animatetop;
        animation-duration: 0.4s;
        height: auto;
        overflow: scroll;
    }

    /* Add Animation */
    @-webkit-keyframes animatetop {
        from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
    }

    @keyframes animatetop {
        from {top:-300px; opacity:0}
        to {top:0; opacity:1}
    }

    /* The Close Button */
    .close {
        color: white;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }

    .modal-header {
        padding: 2px 16px;
        background-color: #1d365d;
        color: white;
    }
    .modal-body {padding: 2px 30px;}
</style>
{/literal}
