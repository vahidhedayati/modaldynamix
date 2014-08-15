<div class="modal fade" id="${attrs.id}" role="dialog">
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

	
  $('a.btn').on('click', function(e) {
    e.preventDefault();
    var url = $(this).attr('href');
    $(".modal-body").html('<iframe width="100%" height="100%" frameborder="0" scrolling="no" allowtransparency="true" src="'+url+'"></iframe>');
  });
</g:javascript>			