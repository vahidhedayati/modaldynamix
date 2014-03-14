<div class="modal fade" id="BuildModal${id}" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
   			<div class="modal-header">
				 <button type="button" class="close" data-dismiss="modal"  onClick="${controller}CloseModal()" aria-hidden="true">CLOSE</button>
				<h3>${title }</h3>
			</div>
			<div class="modal-body">
				<iframe width="100%" height="100%" frameborder="0" scrolling="no" allowtransparency="false" src="${url}"></iframe>
				 <button type="button" class="close" data-dismiss="modal"  onClick="${controller}CloseModal()" aria-hidden="true">CLOSE</button>
	
			</div>	
		</div>
	</div>
</div>
	
 		
<g:javascript>
	function ${controller}CloseModal() {
		$('#BuildModal${id}').dialog().dialog('close');
  		$(".modal-backdrop").hide();
  		$('#${divId}1').hide().append(myClone${divId});
        
		<g:if test="${!disablecheck.equals('true') }">
			var controller="${controller }";
			var divId="${divId }";
			$.get('${createLink(controller:"MailingListEmail", action: "getAjaxCall")}?ccontroller='+controller+'&divId='+divId,function(data){
				$('#${divId}').hide().html(data).fadeIn('slow');
			});
		</g:if>	
	}	
</g:javascript>

	