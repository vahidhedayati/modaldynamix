<g:javascript>
	$('#${attrs.id}2').on('click', function(e) {
		e.preventDefault();
		<g:if test="${attrs.position}">
        	$(".modal").css('position','${attrs.position}');
        </g:if>	
        <g:if test="${attrs.margintop}">
			$(".modal").css('top','${attrs.top}');
		</g:if>
		<g:if test="${attrs.margintop}">
			$(".modal").css('margin-top','${attrs.margintop}');
		</g:if>
		<g:if test="${attrs.left}">
			$(".modal").css('left','${attrs.left}');
		</g:if>
		<g:if test="${attrs.right}">
			$(".modal").css('right','${attrs.right}');
		</g:if>
		<g:if test="${attrs.marginright}">
			$(".modal").css('margin-right','${attrs.marginright}');
		</g:if>
		<g:if test="${attrs.left}">
			$(".modal").css('margin-left','${attrs.marginleft}');
		</g:if>
		<g:if test="${attrs.height}">
		<g:if test="${((attrs.height.indexOf('px')>-1)||(attrs.height.indexOf('em')>-1)||(attrs.height.indexOf('auto')>-1))}">
			$(".modal").css('height','${attrs.height }');
		</g:if>
		<g:else>
			$(".modal").css('height',$( window ).height()${attrs.calctype}${attrs.height });
		</g:else>
		</g:if>
		<g:if test="${attrs.width}">
		<g:if test="${((attrs.width.indexOf('px')>-1)||(attrs.width.indexOf('em')>-1)||(attrs.width.indexOf('auto')>-1))}">
			$(".modal").css('width','${attrs.width }');
		</g:if>
		<g:else>
			$(".modal").css('width',$( window ).width()${attrs.calctype}${attrs.width });
		</g:else>
		</g:if>
		<g:if test="${attrs.overflow}">
			$(".modal").css('overflow','${attrs.overflow}');
		</g:if>
		<g:if test="${attrs.bodyheight}">
		<g:if test="${((attrs.bodyheight.indexOf('px')>-1)||(attrs.bodyheight.indexOf('em')>-1)||(attrs.bodyheight.indexOf('auto')>-1))}">
			$(".modal-body").css('height','${attrs.bodyheight }');
		</g:if>
		<g:else>
			$(".modal-body").css('height',$( window ).height()${attrs.calctype}${attrs.bodyheight });
		</g:else>
		</g:if>
		<g:if test="${attrs.bodywidth}">
			$(".modal-body").css('width','${attrs.bodywidth}');
		</g:if>
	});
	</g:javascript>