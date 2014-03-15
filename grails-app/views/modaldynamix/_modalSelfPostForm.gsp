
<div class="modal fade" id="${attrs.id}" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
    			<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">${attrs.close}</button>
					<h3>${attrs.title }</h3>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<g:render template="${attrs.modalTemplatePage}" model="[attrs:attrs]"/>
					</div>
				</div>
		</div>
	</div>
</div>



<g:javascript>
	// Self submitting form calls closeModal Below
	$('#${attrs.formId}').submit(function() {
 		$.ajax({ 
        	data: $(this).serialize(), 
        	type: $(this).attr('method'),
        	url: $(this).attr('action'), 
        	success: function(response) { 
            	$('#${attrs.formId}').html(response);
            	
            	${attrs.formId}CloseModal(); 
        	}
    	});
    	return false; 
	});		
	

	//CloseModal Closes specific 
	function ${attrs.formId}CloseModal() {
		//Close modal window and remove backdrop
		$('#${attrs.id}').dialog().dialog('close');
  		$(".modal-backdrop").hide();
  		var domain="${attrs.domain }";
		var divId="${attrs.divId }";
		var returnController="${attrs.returnController }";	
  		$.get('${createLink(controller:"${attrs.queryController}", action: "${attrs.queryAction}")}?domain=&templateType=Form&divId='+divId+'&returnController='+returnController,function(data){
			$('#${attrs.divId}1').hide().append(data);
		});
  		
   		<g:if test="${attrs.clearckeditor}">
			if(CKEDITOR.instances["${attrs.clearckeditor }"]){
				CKEDITOR.remove(CKEDITOR.instances["${attrs.clearckeditor }"]); //Does the same as line below
			}
		</g:if>
			
  		// If disablecheck not set to true - the trigger queryController which is by default modaldynamix
  		// This calls getAjaxCall which lists the domain provided and sends it back to your original view       
		<g:if test="${!attrs.disablecheck.equals('true') }">
			var returnController="${attrs.returnController }";
			$.get('${createLink(controller:"${attrs.queryController}", action: "${attrs.queryAction}")}?domain='+domain+'&templateType=Display&divId='+divId+'&returnController='+returnController,function(data){
				$('#${attrs.divId}').hide().html(data).fadeIn('slow');
			});
		</g:if>	
	}
</g:javascript>
