<div class="modal fade" id="${attrs.id}" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">${attrs.close}</button>
			<h3>${attrs.title }</h3>
		</div>
		<div class="form-group">
			
    		<g:formRemote id="1" name="${attrs.formId}" class="form-horizontal" url="[controller:attrs.submitController, action:attrs.submitAction]"
              update="${id}"  onComplete="${attrs.formId}CloseModal()">
              
				<g:render template="${attrs.modalTemplatePage}"/>
			
			 	<g:submitToRemote class="myformsubmit" url="[controller:attrs.submitController, action:attrs.submitAction]" update="${attrs.id}" onComplete="${attrs.formId}CloseModal()" value="${attrs.submitValue}" />
								
			</g:formRemote>
		</div>
	</div>
	</div>
</div>
<g:render template="${attrs.modalJsTemplate}" model="[attrs:attrs]" />
	