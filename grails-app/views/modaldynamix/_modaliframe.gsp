
<div class='modal fade' id="${attrs.id }" tabindex='-1' role='dialog' aria-labelledby="${attrs.id}Label" aria-hidden='true'>
	 <div class="modal-dialog${attrs.id }" style="width:100%;height:100%; ">
      <div class="modal-content">
		<div class='modal-header'>
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