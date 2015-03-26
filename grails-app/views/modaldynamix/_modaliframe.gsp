<div class='modal fade' id="${attrs.id }" tabindex='-1' role='dialog'
	aria-labelledby="${attrs.id}Label" aria-hidden='true'>
	<div class="modal-dialog">
		<div class="modal-content">

			<div class='modal-header'>
				<button type="button" class="close" data-dismiss="modal"
					onClick="${attrs.formId}CloseModal()" aria-hidden="true">
					${attrs.close}
				</button>
				<h3>
					${attrs.title }
				</h3>
			</div>

			<div class="modal-body">
				<iframe
					style="zoom=${attrs.iframezoom };width: ${attrs.iframewidth }; height: ${attrs.iframeheight }; margin:${attrs.iframemargin }; padding:${attrs.iframepadding };"
					frameborder="0" scrolling="auto"
					allowtransparency="${attrs.iframetransparency }" src="${attrs.url}"></iframe>
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
			<button type="button" class="close" data-dismiss="modal"
				onClick="${attrs.formId}CloseModal()" aria-hidden="true">
				${attrs.close}
			</button>
		</div>

	</div>

</div>

<g:render template="${attrs.modalJsTemplate}"
	model="[attrs:attrs,params:params,definedParams:definedParams]" />