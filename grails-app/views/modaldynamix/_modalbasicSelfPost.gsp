<div class="modal fade" id="BuildModal${id}" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
    			<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">x</button>
					<h3>${title }</h3>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<g:render template="/${controller }/${callPage }"  model="[ccontroller: controller, formId:formId]"/>
					</div>
				</div>
		
				
		</div>
	</div>
</div>




<g:javascript>

	$('#${formId}').submit(function() {
 		$.ajax({ 
        	data: $(this).serialize(), 
        	type: $(this).attr('method'),
        	url: $(this).attr('action'), 
        	success: function(response) { 
            	$('#${formId}').html(response);
            	
            	${controller}CloseModal(); 
        	}
    	});
    	return false; 
	});		
	
	function ${controller}CloseModal() {
		$('#BuildModal${id}').dialog().dialog('close');
  		$(".modal-backdrop").hide();
  		
  		// CKEDITOR specific call - oh what a pain
    	if(CKEDITOR.instances['myCKEditor']){
			CKEDITOR.remove(CKEDITOR.instances['myCKEditor']); //Does the same as line below
			
			// This does not work due to cloning - returns two boxes
			//CKEDITOR.replace('myCKEditor');
			// Instead were going to do a call to the page via controller

			$.get('${createLink(controller:"${controller }", action: "ajaxupload")}',function(data){
				$('#${divId}1').hide().append(data);
			});
			
   		}
   		else{
   			// Do the default action of returning cloned information
   			$('#${divId}1').hide().append(myClone${divId});
   		}
   	
  		<g:if test="${!disablecheck.equals('true') }">
			var controller="${controller }";
			var divId="${divId }";
			$.get('${createLink(controller:"${getController}", action: "${getPage}")}?ccontroller='+controller+'&divId='+divId,function(data){
				$('#${divId}').hide().html(data).fadeIn('slow');
			});
		</g:if>	
	}

</g:javascript>