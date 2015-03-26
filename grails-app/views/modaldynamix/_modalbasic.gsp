<div id="${attrs.id}" class="modal hide fade">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">
			${attrs.close }
		</button>
		<h3 id="prompt">
			${attrs.title }
		</h3>
	</div>
	<div class="form-group">
		<div class="modal-body">
			<div class="divDialogElements">
				<div class="divPopupMenu">
					<g:render template="${attrs.modalTemplatePage}"
						model="[attrs:attrs,params:params,definedParams:definedParams]" />
				</div>
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

<g:render template="${attrs.modalDimension}" model="[attrs:attrs]" />
<g:javascript>
  $('a.btn').on('click', function(e) {
    e.preventDefault();
    var url = $(this).attr('href');
    $(".modal-body").html('<iframe width="100%" height="100%"
		frameborder="0" scrolling="no" allowtransparency="true" src="'+url+'"></iframe>');
  });
</g:javascript>
