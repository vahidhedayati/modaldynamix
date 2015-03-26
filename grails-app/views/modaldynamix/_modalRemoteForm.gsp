<div class="modal fade" id="${attrs.id}" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<g:if test="${flash.message}">
				<div class="message" role="status">
					${flash.message}
				</div>
			</g:if>
			
			<g:formRemote id="1" name="${attrs.formId}" class="form-horizontal"
				url="[controller:attrs.submitController, action:attrs.submitAction]"
				update="${id}" onComplete="${attrs.formId}CloseModal()">
				
				<div class="modal-header">
					<button type='button' class='close' data-dismiss='modal'
						aria-hidden='true'>×</button>
					<h3>
						${attrs?.title}
					</h3>
				</div>

				<div class="modal-body">
				
					<div class="form-group">
						<g:if test="${attrs.fromPlugin}">
							<g:loadATemplate fromPlugin="${attrs.fromPlugin}"
								template="${attrs.modalTemplatePage}"
								model="[attrs:attrs, params:params, definedParams:definedParams]" />
						</g:if>
						<g:else>
							<g:render template="${attrs.modalTemplatePage}"
								model="[attrs:attrs, params:params,definedParams:definedParams]" />
						</g:else>

						<g:submitToRemote class="myformsubmit"
							url="[controller:attrs.submitController, action:attrs.submitAction]"
							update="${attrs.id}" onComplete="${attrs.formId}CloseModal()"
							value="${attrs.submitValue}" />
					</div>
					
				</div>
				
				<div class="modal-footer">
				
					<g:if test="${attrs.modalFooterPage}">
						<g:render template="${attrs.modalFooterPage}"
							model="[attrs:attrs]" />
					</g:if>
					<g:else>
						${attrs.footer.encodeAsRaw()}
					</g:else>
					
				</div>

	</g:formRemote>		

		</div>
	</div>
</div>

<g:render template="${attrs.modalJsTemplate}" model="[attrs:attrs]" />