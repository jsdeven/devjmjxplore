{include file="views/profiles/components/profiles_scripts.tpl"}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="brands_form" id="brands_form">
<input type="hidden" name="fake" value="1" />

{include file="common/pagination.tpl" save_current_page=true save_current_url=true}

{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
{assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
{assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}

{assign var="return_url" value=$config.current_url|escape:"url"}

{if $result}
<div class="table-responsive-wrapper">
    <table width="100%" class="table table-middle table-responsive">
    <thead>
    <tr> 
    {if $user_type neq 'v'}       
        <th width="3%">{__("id")}</th>
        <th width="17%">{__("customer_info")}</th> 
        <th width="10%">{__("pincode")}</th>
    {/if}
        <th width="10%">{__("product")}</th>
        <th width="10%">{__("qty")}</th> 
        <th width="20%">{__("message")}</th>
    {if $user_type eq 'v'}
        <th width="20%">{__("price")}</th>
        <th width="10%">{__("comment")}</th>
        <th width="20%">{__("action")}</th>
    {else}
        <th width="15%">{__("assign")}</th>
        <th width="15%">{__("vendor_remark")}</th>
    {/if}
        
    </tr>
    </thead>
    {foreach from=$result item=row}
    
    <tr class="cm-row-status-{$row.status|lower}" data-ct-brand-id="{$row.id}">
    {if $user_type neq 'v'}
        <td class="row-status" data-th="{__("id")}"><span>{$row.id}</span></td>
        <td class="row-status" data-th="{__("id")}">
            <span>{$row.user_name}<br/>
            {$row.phone_num}<br/>
            {$row.email_bulk}
            </span>
        </td>
        <td class="row-status" data-th="{__("id")}"><span>{$row.pincode}</span></td>
    {/if}
        <td class="row-status" data-th="{__("id")}"><span>
<a class="row-status" title="{$row.product_name}" href="admin.php?dispatch=jmj_products.add&product_id={$row.product_id}">{$row.product_name}</a>
        </span></td>
        <td class="row-status" data-th="{__("id")}"><span>{$row.enq_qty}</span></td>
        <td class="row-status" data-th="{__("id")}"><span>{$row.message_bulk}</span></td>
    {if $user_type neq 'v'}<td>
            {if $row.assigned eq 1} 
                {__("assigned")}                
            {else}
        {btn type="list" class="cm-confirm" href="quotes.assign_vendor?id=`$row.id`" text=__("assign") method="GET"}{/if} | 
        {btn type="list" class="cm-confirm" href="quotes.delete?id=`$row.id`" text=__("delete") method="GET"}
    </td>
    <td>{if $row.price neq '0.00'}
            <div class="tooltip">{__("show_reply")}
              <span class="tooltiptext">Rs. {$row.price}<br/>{$row.comment}</span>
            </div> | {if $row.assign_tocustomer eq 1} 
                {__("assigned")}                
            {else}{btn type="list" class="cm-confirm" href="quotes.assign_tocustomer?id=`$row.id`" text=__("customer_assign") method="GET"}
            {/if}
        {/if}
    </td>
    {else}
    <td>
        {$row.price}
    </td>
    <td>
        {$row.comment}
    </td>
    <td>
        <input type="button" name="" class="btn ty-btn ty-btn__secondary " onclick="onbtn_click({$row.id});" value="{__("reply")}">
        
    </td>
    {/if}
    </td>
    </tr>

    {/foreach}
    </table>
</div>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}


{include file="common/pagination.tpl"}
</form>
<!-- The Modal -->
<div id="myModal" class="modal">
  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <span class="close">&times;</span>
      <span style="font-size: 24px;">Reply to admin</span>
    </div>
    <div class="modal-body">
      
        <form method="POST" action="{"quotes.reply"|fn_url}" class="form-padding-arrange-block">
            <input type="hidden" name="id" id="id" value="{$product.id}">
            

            <div class="ty-control-group">
                <label for="price" class="ty-control-group__title cm-integer cm-required">{__("price")}</label>
                <input id="price" class="ty-input-text cm-focus " size="50" type="text" name="price" value="" style="width: 100%">
            </div>

            <div class="ty-control-group">
                <label for="comment" class="ty-control-group__title">{__("comment")}</label>                
                <textarea id="comment" class="ty-input-text cm-focus " size="50" type="text" name="comment" style="width: 100%"></textarea>
            </div>                   
            

            <div class="ty-form-builder__buttons buttons-container">
                <button style="width:15%" class="ty-btn__secondary ty-btn" type="submit" name="dispatch[quotes.reply]"><span><span>Submit</span></span></button>
            </div>

        </form>
    </div>
  </div>
</div>
{/capture}




{include file="common/mainbox.tpl" title="{__("rqlist")}" content=$smarty.capture.mainbox buttons=$smarty.capture.buttons adv_buttons=$smarty.capture.adv_buttons sidebar=$smarty.capture.sidebar}


{literal}
<script>
// Get the modal
var modal = document.getElementById("myModal");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

function onbtn_click(id){
    document.getElementById('id').value = id;
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
        z-index: 9991; /* Sit on top */
        padding-top: 100px; /* Location of the box */
        left: 0;
        top: 25;
        width: 125%; /* Full width */
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
<style>
.tooltip {
  position: relative;
  display: inline-block;
  border-bottom: 1px dotted black;
  background:#1197d6cc;
  color: #060101;
}

.tooltip .tooltiptext {
  visibility: hidden;
  width: 250px;
  background-color: #4a9ef7;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 0;
  position: absolute;
  z-index: 1;
  bottom: 125%;
  left: 50%;
  margin-left: -160px;
  opacity: 0;
  transition: opacity 0.3s;
}

.tooltip .tooltiptext::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: #555 transparent transparent transparent;
}

.tooltip:hover .tooltiptext {
  visibility: visible;
  opacity: 1;
}
</style>
{/literal}