<div class='modal fade' id="${attrs.id }" tabindex='-1' role='dialog' aria-labelledby="${attrs.id}Label" aria-hidden='true'>
	 <div class="modal-dialog${attrs.id }" style="width:100%;height:100%; ">
      <div class="modal-content">
		<div class='modal-header'>
			<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>
			<div id='myModalLabel'><h3>${attrs?.title}</h3></div>
		</div>
		<div class="form-group">
			<div class="modal-body" >
    			<g:formRemote id="1" name="${attrs.formId}" class="form-horizontal" url="[controller:attrs.submitController, action:attrs.submitAction]"
            	  update="${id}"  onComplete="${attrs.formId}CloseModal()">
			
				<g:if test="${attrs.fromPlugin }">
					<g:loadATemplate fromPlugin="${attrs.fromPlugin }" template="${attrs.modalTemplatePage }"  model="[attrs:attrs, params:params, definedParams:definedParams]"/>
				</g:if>
				<g:else>
					<g:render template="${attrs.modalTemplatePage}" model="[attrs:attrs, params:params,definedParams:definedParams]"/>
				</g:else>
				
			 	<g:submitToRemote class="myformsubmit" url="[controller:attrs.submitController, action:attrs.submitAction]" update="${attrs.id}" onComplete="${attrs.formId}CloseModal()" value="${attrs.submitValue}" />
				</g:formRemote>
			</div>
			<div class="modal-footer">
				<g:if test="${attrs.modalFooterPage}">
					<g:render template="${attrs.modalFooterPage}"  model="[attrs:attrs]"/>
				</g:if>
				<g:else>
					${attrs.footer.encodeAsRaw() }
				</g:else>	
			</div>
		</div>
	</div>
</div>
</div>

<g:render template="${attrs.modalJsTemplate}" model="[attrs:attrs]" />