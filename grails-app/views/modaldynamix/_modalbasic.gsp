<div class="modal fade" id="${attrs.id}" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<g:if test="${flash.message}">
				<div class="message" role="status">
					${flash.message}
				</div>
			</g:if>

	        <div class="modal-header">
		        <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>
		        <h3>${attrs?.title}</h3>
	        </div>

	        <div class="modal-body">
    	        <div class="form-group">
			        <div class="divDialogElements">
				        <div class="divPopupMenu">
					        <g:render template="${attrs.modalTemplatePage}"
						        model="[attrs:attrs,params:params,definedParams:definedParams]" />
				        </div>
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
</div>
<g:render template="${attrs.modalDimension}" model="[attrs:attrs]" />
<g:javascript>
  $('a.btn').on('click', function(e) {
    e.preventDefault();
    var url = $(this).attr('href');
    $(".modal-body").html('<iframe width="100%" height="100%" frameborder="0" scrolling="no" allowtransparency="true" src="'+url+'"></iframe>');
  });
</g:javascript>
