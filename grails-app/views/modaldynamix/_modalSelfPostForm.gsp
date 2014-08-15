<div class='modal fade' id="${attrs.id }" tabindex='-1' role='dialog' aria-labelledby="${attrs.id}Label" aria-hidden='true'>
	 <div class="modal-dialog${attrs.id }" style="width:100%;height:100%; ">
      <div class="modal-content">
		<div class='modal-header'>
			<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>
			<div id='myModalLabel'><h3>${attrs?.title}</h3></div>
		</div>
		<div class="modal-body" >
			<div class="form-group">
				<g:if test="${attrs.fromPlugin }">
					<g:loadATemplate fromPlugin="${attrs.fromPlugin }" template="${attrs.modalTemplatePage }"/>
				</g:if>
				<g:else>
					<g:render template="${attrs.modalTemplatePage}" model="[attrs:attrs]"/>
				</g:else>
			</div>
		</div>
	</div>
	</div>
</div>


<script type="text/javascript">
	$('#${attrs.id}2').on('click', function(e) {
		e.preventDefault();
        	$(".modal").css('position','${attrs.position}');
		$(".modal").css('top','${attrs.top}');
		$(".modal").css('margin-top','${attrs.margintop}');
		$(".modal").css('left','${attrs.left}');
		$(".modal").css('right','${attrs.right}');
		$(".modal").css('margin-right','${attrs.marginright}');
		$(".modal").css('height',$( window ).height()${attrs.calctype}${attrs.height });
		$(".modal").css('width',$( window ).width()${attrs.calctype}${attrs.width });
		$(".modal").css('overflow','${attrs.overflow}');
		$(".modal-body").css('height',$( window ).height()${attrs.calctype}${attrs.bodyheight });
		$(".modal-body").css('width','${attrs.bodywidth}');
	});



	// Self submitting form calls closeModal Below
	$("#${attrs.formId}").submit(function() {
 		$.ajax({ 
        	data: $(this).serialize(), 
        	type: $(this).attr('method'),
        	url: $(this).attr('action'), 
        	success: function(response) { 
            	$('#${attrs.formId}').html(response);
            	
            	${attrs.formId}CloseModal(); 
        	}
    	});
    	return false; 
	});		
	

	//CloseModal Closes specific 
	function ${attrs.formId}CloseModal() {
	
		//Close modal window and remove backdrop
		$('#${attrs.id}').dialog().dialog('close');
  		$(".modal-backdrop").hide();
  		var domain="${attrs.domain }";
		var divId="${attrs.divId }";
		var fromPlugin="${attrs.fromPlugin }";
		var returnController="${attrs.returnController }";	
  		$.get('${createLink(controller:"${attrs.queryController}", action: "${attrs.queryAction}")}?domain=&templateType=Form&fromPlugin='+fromPlugin+'&divId='+divId+'&returnController='+returnController,function(data){
			$('#${attrs.divId}1').hide().append(data);
		});
  		
   		<g:if test="${attrs.clearckeditor}">
			if(CKEDITOR.instances["${attrs.clearckeditor }"]){
				CKEDITOR.remove(CKEDITOR.instances["${attrs.clearckeditor }"]); //Does the same as line below
			}
		</g:if>
			
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
