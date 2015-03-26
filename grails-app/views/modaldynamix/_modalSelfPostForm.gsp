<div class='modal fade' id="${attrs.id }" tabindex='-1' role='dialog'
	aria-labelledby="${attrs.id}Label" aria-hidden='true'>
	<div class="modal-dialog">
		<div class="modal-content">

			<div class='modal-header'>
				<button type='button' class='close' data-dismiss='modal'
					aria-hidden='true'>×</button>
				<h3>
					${attrs?.title}
				</h3>
			</div>

			<div class="modal-body">
				<div class="form-group">
					<g:if test="${attrs.fromPlugin }">
						<g:loadATemplate fromPlugin="${attrs.fromPlugin }"
							template="${attrs.modalTemplatePage }" />
					</g:if>
					<g:else>
						<g:render template="${attrs.modalTemplatePage}"
							model="[attrs:attrs,params:params,definedParams:definedParams]" />
					</g:else>
				</div>
			</div>

			<div class="modal-footer">
				<g:if test="${attrs.modalFooterPage}">
					<g:render template="${attrs.modalFooterPage}"
						model="[attrs:attrs,params:params,definedParams:definedParams]" />
				</g:if>
				<g:else>
					${attrs.footer.encodeAsRaw() }
				</g:else>
			</div>

		</div>
	</div>
</div>



<g:render template="${attrs.modalDimension}" model="[attrs:attrs]" />
<g:javascript>
	// Self submitting form calls closeModal Below
	$("#${attrs.formId}").submit(function() {
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
		
		var fromPlugin="${attrs.fromPlugin }";
		
		
		var returnController="${attrs.returnController }";	
  		$.get('${createLink(controller:"${attrs.queryController}", action: "${attrs.queryAction}")}?domain=&templateType=Form&fromPlugin='+fromPlugin+'&divId='+divId+'&returnController='+returnController,function(data){
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

			$.get('${createLink(controller:"${attrs.queryController}", action: "${attrs.queryAction}")}?domain='+domain+'&fromPlugin='+fromPlugin+'&templateType=Display&divId='+divId+'&returnController='+returnController,function(data){
				$('#${attrs.divId}').hide().html(data).fadeIn('slow');
			});
		</g:if>	
	}
</g:javascript>
