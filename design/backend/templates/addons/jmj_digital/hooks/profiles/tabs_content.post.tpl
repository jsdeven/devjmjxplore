<!--<link rel="stylesheet" href="/design/backend/css/addons/jmj_digital/seller_page_assets/css/bootstrap.min.css">-->
<style>
   .row {
    display: -ms-flexbox;
    display: flex;
    -ms-flex-wrap: wrap;
    flex-wrap: wrap;
    margin-right: -15px;
    margin-left: -15px;
}
.col-md-6 {
    -ms-flex: 0 0 50%;
    flex: 0 0 50%;
    max-width: 50%;
}
.subheader {
    margin: 41px 0px 13px 20px;
}


</style>
<div class="row">
   <div class="col-md-6">
     <div class="form-group">
      {if $customer_additional_data}    {include file="common/subheader.tpl" title=__("customer_additional_data")}    
      <div class="control-group" style="margin-bottom: 0px;">        
      <label for="user_type" class="control-label" style="padding-top: 0px;">{__("company")}:</label>        
      <div class="controls">{$customer_additional_data.company}</div>    
      </div>    
      
      <div class="control-group" style="margin-bottom: 0px;">        
      <label for="user_type" class="control-label" style="padding-top: 0px;">{__("alter_phone")}:</label>        
      <div class="controls">{$customer_additional_data.phone_2}</div>    
      </div>    
      
      <div class="control-group" style="margin-bottom: 0px;">        
      <label for="user_type" class="control-label" style="padding-top: 0px;">{__("company_type")}:</label>        
      <div class="controls">{$customer_additional_data.company_type}</div>    
      </div>    
      
      <div class="control-group" style="margin-bottom: 0px;">        
      <label for="user_type" class="control-label" style="padding-top: 0px;">{__("nature_of_business")}:</label>        
      <div class="controls">{$customer_additional_data.nature_of_business}</div>    
      </div>    
      
      <div class="control-group" style="margin-bottom: 0px;">
      <label for="user_type" class="control-label" style="padding-top: 0px;">{__("company_year")}:</label>        
      <div class="controls">{$customer_additional_data.company_year}</div>    
      </div>    
      
      <div class="control-group" style="margin-bottom: 0px;">
      <label for="user_type" class="control-label" style="padding-top: 0px;">{__("gstin_number")}:</label>
      <div class="controls">{$customer_additional_data.gstin_number}</div>
      </div>
      
      <div class="control-group" style="margin-bottom: 0px;">
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("pan_number")}:</label>
         <div class="controls">{$customer_additional_data.pan_number}</div>
      </div>
      
      <div class="control-group" style="margin-bottom: 0px;">
      <label for="user_type" class="control-label" style="padding-top: 0px;">{__("gst_type")}:</label>
      <div class="controls">{$customer_additional_data.gst_type}</div>    
      </div>    
      
      <div class="control-group" style="margin-bottom: 0px;">
      <label for="user_type" class="control-label" style="padding-top: 0px;">{__("india_zone")}:</label>
      <div class="controls">{$customer_additional_data.india_zone}</div>    
      </div>    
     </div>
   </div>
   <div class="col-md-6">
      <div class="form-group">
         {include file="common/subheader.tpl" title=__("payment_mode")}    

         <div class="control-group" style="margin-bottom: 0px;">
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("payment_option")}:</label>
         <div class="controls">{$customer_additional_data.payment_option}</div>
         </div>    
         
         <div class="control-group" style="margin-bottom: 0px;">
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("committed_with_jmjain")}:</label>
         <div class="controls">{$customer_additional_data.committed_with_jmjain}</div>
         </div> 
         
         <div class="control-group" style="margin-bottom: 0px;">
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("expected_limit")}:</label>
         <div class="controls">{$customer_additional_data.expected_limit}</div>
         </div> 
         
         <div class="control-group" style="margin-bottom: 0px;">
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("reference_bank_garuntee")}:</label>        
         <div class="controls">{$customer_additional_data.reference_bank_garuntee}</div>
         </div>
         
         <div class="control-group" style="margin-bottom: 0px;">
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("monthly_turnover")}:</label>
         <div class="controls">{$customer_additional_data.monthly_turnover}</div>
         </div>    
         <div class="control-group" style="margin-bottom: 0px;">        
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("name_reference")}:</label>        
         <div class="controls">{$customer_additional_data.name_reference}</div>    
         </div>    
         
         <div class="control-group" style="margin-bottom: 0px;">
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("location")}:</label>        
         <div class="controls">{$customer_additional_data.location}</div>    
         </div>
         
         <div class="control-group" style="margin-bottom: 0px;">        
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("url")}:</label>        
         <div class="controls">{$customer_additional_data.url}</div>    
         </div>
         
         
         <div class="control-group" style="margin-bottom: 0px;">
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("reference_phone")}:</label>
         <div class="controls"><p>{$customer_additional_data.reference_phone}</p></div>    
         </div>    
         
         <div class="control-group" style="margin-bottom: 0px;">
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("background_info")}:</label>        
         <div class="controls">{$customer_additional_data.background_info}</div>    
         </div>    
         
         <div class="control-group" style="margin-bottom: 0px;">
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("company_advantage")}:</label>        
         <div class="controls"><p>{$customer_additional_data.company_advantage}</p></div>    
         </div>
      </div>
    </div>
</div>



<div class="row">
   <div class="col-md-6">
     <div class="form-group">
         {include file="common/subheader.tpl" title=__("bank_information")}    

         <div class="control-group" style="margin-bottom: 0px;">
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("bank_name")}:</label>
         <div class="controls">{$customer_additional_data.bank_name}</div>    
         </div>    
         
         <div class="control-group" style="margin-bottom: 0px;">        
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("account_number")}:</label>        
         <div class="controls">{$customer_additional_data.account_number}</div>
         </div>    

         <div class="control-group" style="margin-bottom: 0px;">
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("ifsc_code")}:</label>
         <div class="controls">{$customer_additional_data.ifsc_code}</div>
         </div>    
     </div>
   </div>

   <div class="col-md-6">
      <div class="form-group">
         {include file="common/subheader.tpl" title=__("attached_document")}    

         <div class="control-group" style="margin-bottom: 0px;">        
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("cancel_cheque_copy_image")}:</label>        
         <div class="controls">
         {if $customer_additional_data.cancel_cheque_copy_image}
         <a target="_blank" href="images/customer-additional-data/{$customer_additional_data.id}/{$customer_additional_data.cancel_cheque_copy_image}">{__('click_to_show')}</a>
         {else}                
         {__('no_image_uploaded')}            
         {/if}        
         </div>    
         </div>    
         
         <div class="control-group" style="margin-bottom: 0px;">        
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("company_profile_image")}:</label>        
         <div class="controls">            
         {if $customer_additional_data.company_profile_image}
         <a target="_blank" href="images/customer-additional-data/{$customer_additional_data.id}/{$customer_additional_data.company_profile_image}">{__('click_to_show')}</a>            
         {else}                
         {__('no_image_uploaded')}            
         {/if}        
         </div>    
         </div>    

         <div class="control-group" style="margin-bottom: 0px;">        
         <label for="user_type" class="control-label" style="padding-top: 0px;">Aadhar Card:</label>        
         <div class="controls">
         {if $customer_additional_data.product_catalogue_image}                
         <a target="_blank" href="images/customer-additional-data/{$customer_additional_data.id}/{$customer_additional_data.product_catalogue_image}">{__('click_to_show')}</a>            
         {else}                
         {__('no_image_uploaded')}            
         {/if}        
         </div>    
         </div>   

         <div class="control-group" style="margin-bottom: 0px;">        
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("office_front_image")}:</label>        
         <div class="controls">            
         {if $customer_additional_data.office_front_image}                
         <a target="_blank" href="images/customer-additional-data/{$customer_additional_data.id}/{$customer_additional_data.office_front_image}">{__('click_to_show')}</a>            
         {else}                
         {__('no_image_uploaded')}            
         {/if}        
         </div>    
         </div>    

         <div class="control-group" style="margin-bottom: 0px;">        
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("office_inside_image")}:</label>        
         <div class="controls">            
         {if $customer_additional_data.office_inside_image}                
         <a target="_blank" href="images/customer-additional-data/{$customer_additional_data.id}/{$customer_additional_data.office_inside_image}">{__('click_to_show')}</a>            
         {else}               
         {__('no_image_uploaded')}            
         {/if}        
         </div>    
         </div>    

         <div class="control-group" style="margin-bottom: 0px;">        
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("owners_pancard_image")}:</label>        
         <div class="controls">            
         {if $customer_additional_data.owners_pancard_image}                
         <a target="_blank" href="images/customer-additional-data/{$customer_additional_data.id}/{$customer_additional_data.owners_pancard_image}">{__('click_to_show')}</a>            
         {else}                
         {__('no_image_uploaded')}            
         {/if}        
         </div>    
         </div>  

         <div class="control-group" style="margin-bottom: 0px;">        
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("gstin_certificate_image")}:</label>       
         <div class="controls">            
         {if $customer_additional_data.gstin_certificate_image}                
         <a target="_blank" href="images/customer-additional-data/{$customer_additional_data.id}/{$customer_additional_data.gstin_certificate_image}">{__('click_to_show')}</a>            
         {else}                
         {__('no_image_uploaded')}            
         {/if}        
         </div>    
         </div>

         <div class="control-group" style="margin-bottom: 0px;">        
         <label for="user_type" class="control-label" style="padding-top: 0px;">{__("bank_document")}:</label>       
         <div class="controls">            
         {if $customer_additional_data.bank_document}                
         <a target="_blank" href="images/customer-additional-data/{$customer_additional_data.id}/{$customer_additional_data.bank_document}">{__('click_to_show')}</a>            
         {else}                
         {__('no_image_uploaded')}            
         {/if}       
         </div>    
         </div>

         {/if}
      </div>
   </div>
</div>    