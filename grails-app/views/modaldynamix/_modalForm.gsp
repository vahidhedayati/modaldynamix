<div class="modal fade" id="ModalDynamix${attrs.id}" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
		<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
		</g:if>
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">x</button>
			<h3>${title }</h3>
		</div>
		<div class="form-group">
			
    		<g:formRemote id="1" name="${attrs.submitController}" class="form-horizontal" url="[controller:attrs.submitController, action:attrs.submitAction]"
              update="BuildModal${id}"  onComplete="${attrs.submitController}CloseModal()">
              
				<g:render template="/${attrs.templateFolder}/${templateFile }"/>
			
			 	<g:submitToRemote class="myformsubmit" url="[controller:attrs.submitController, action:attrs.submitAction]" update="ModalDynamix${attrs.id}" onComplete="${attrs.submitController}CloseModal()" value="${attrs.submitValue}" />
								
			</g:formRemote>
		</div>
	</div>
	</div>
</div>
		
<script type="text/javascript">
$(document).ready(function() {
 $('a').on('click', function(e) {
	 alert(e);
		e.preventDefault();
		var url = $(this).attr('href');
		$(".modal-body").html('<iframe width="100%" height="100%" frameborder="0" scrolling="no" allowtransparency="false" src="'+url+'"></iframe>');
  });
});
</script>