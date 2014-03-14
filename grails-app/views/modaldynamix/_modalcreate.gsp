<g:render template="/modaldynamix/${attrs.formType }" model="[attrs:attrs]" />
  				
<g:javascript>
function ${attrs.submitController}CloseModal() {
	$('#ModalDynamix${attrs.id}').dialog().dialog('close');
  	$(".modal-backdrop").hide();
  	$('#${attrs.divId}1').hide().append(myClone${attrs.divId});
        
	<g:if test="${!attrs.disablecheck.equals('true') }">
		var domain="${attrs.domain }";
		var divId="${attrs.divId }";
		$.get('${createLink(controller:"${attrs.queryController}", action: "${attrs.queryAction}")}?domain='+domain+'&divId='+divId,function(data){
			$('#${attrs.divId}').hide().html(data).fadeIn('slow');
		});
	</g:if>	
}
</g:javascript>