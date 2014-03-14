<div class="modal fade" id="ModalDynamix${attrs.id}" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
    			<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">${attrs.close }</button>
					<h3>${attrs.title }</h3>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<g:render template="${attrs.modalTemplatePage}"  model="[attrs:attrs]"/>
					</div>
				</div>
		
				
		</div>
	</div>
</div>


<g:javascript>
  $('a.btn').on('click', function(e) {
    e.preventDefault();
    var url = $(this).attr('href');
    $(".modal-body").html('<iframe width="100%" height="100%" frameborder="0" scrolling="no" allowtransparency="true" src="'+url+'"></iframe>');
  });
</g:javascript>			