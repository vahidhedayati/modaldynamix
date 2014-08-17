<g:render template="${attrs.modalDimension}" model="[attrs:attrs]" />
<g:javascript>
	//CloseModal Closes specific 
	function ${attrs.formId}CloseModal() {
		//Close modal window and remove backdrop
		$('#${attrs.id}').dialog().dialog('close');
  		$(".modal-backdrop").hide();
  		var domain="${attrs.domain }";
		var divId="${attrs.divId }";
		
		var fromPlugin="${attrs.fromPlugin }";
		
		var returnController="${attrs.returnController }";
		<g:if test="${attrs.clearckeditor}">
			if(CKEDITOR.instances["${attrs.clearckeditor }"]){
				CKEDITOR.remove(CKEDITOR.instances["${attrs.clearckeditor }"]); //Does the same as line below
			}
		</g:if>	
  		$.get('${createLink(controller:"${attrs.queryController}", action: "${attrs.queryAction}")}?domain=&templateType=Form&fromPlugin='+fromPlugin+'&divId='+divId+'&returnController='+returnController,function(data){
			$('#${attrs.divId}1').hide().append(data);
		});
  		// If disablecheck not set to true - the trigger queryController which is by default modaldynamix
  		// This calls getAjaxCall which lists the domain provided and sends it back to your original view       
		<g:if test="${!attrs.disablecheck.equals('true') }">
			
			$.get('${createLink(controller:"${attrs.queryController}", action: "${attrs.queryAction}")}?domain='+domain+'&fromPlugin='+fromPlugin+'&templateType=Display&divId='+divId+'&returnController='+returnController,function(data){
				$('#${attrs.divId}').hide().html(data).fadeIn('slow');
			});
		</g:if>	
	}
</g:javascript>
