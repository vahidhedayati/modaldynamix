

<div class='modal fade' id="${attrs.id }" tabindex='-1' role='dialog' aria-labelledby="${attrs.id}Label" aria-hidden='true'>
	 <div class="modal-dialog${attrs.id }" style="width:100%;height:100%; ">
      <div class="modal-content">
		<div class='modal-header'>
			<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>
			<div id='myModalLabel'><h3>${attrs?.title} bbbbbbbb</h3></div>
		</div>
		<div class="modal-body" >
			<div class="form-group">
			
    		<g:formRemote id="1" name="${attrs.formId}" class="form-horizontal" url="[controller:attrs.submitController, action:attrs.submitAction]"
              update="${id}"  onComplete="${attrs.formId}CloseModal()">
           
			
			<g:if test="${attrs.fromPlugin }">
					<g:loadATemplate fromPlugin="${attrs.fromPlugin }" template="${attrs.modalTemplatePage }"/>
				</g:if>
				<g:else>
					<g:render template="${attrs.modalTemplatePage}" model="[attrs:attrs]"/>
				</g:else>
				
				
			 	<g:submitToRemote class="myformsubmit" url="[controller:attrs.submitController, action:attrs.submitAction]" update="${attrs.id}" onComplete="${attrs.formId}CloseModal()" value="${attrs.submitValue}" />
								
			</g:formRemote>
		</div>
	</div>
	</div>
</div>
</div>


<script type="text/javascript">
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
			var returnController="${attrs.returnController }";
			$.get('${createLink(controller:"${attrs.queryController}", action: "${attrs.queryAction}")}?domain='+domain+'&fromPlugin='+fromPlugin+'&templateType=Display&divId='+divId+'&returnController='+returnController,function(data){
				$('#${attrs.divId}').hide().html(data).fadeIn('slow');
			});
		</g:if>	
	}
</script>	