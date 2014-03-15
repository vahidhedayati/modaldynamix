<div class="modal fade" id="${attrs.id}" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
   			<div class="modal-header">
   			
				 <button type="button" class="close" data-dismiss="modal"  onClick="${attrs.formId}CloseModal()" aria-hidden="true">${attrs.close}</button>
				<h3>${attrs.title }</h3>
				
			</div>
			
			<div class="modal-body">
				<iframe width="100%" height="100%" frameborder="0" scrolling="no" allowtransparency="false" src="${attrs.url}"></iframe>
			</div>
			
				 <button type="button" class="close" data-dismiss="modal"  onClick="${attrs.formId}CloseModal()" aria-hidden="true">${attrs.close}</button>
		</div>
	</div>
</div>

<g:render template="${attrs.modalJsTemplate}" model="[attrs:attrs]" />