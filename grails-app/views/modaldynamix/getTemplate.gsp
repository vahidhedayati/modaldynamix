
	<g:if test="${fromPlugin }">
		<g:loadATemplate fromPlugin="${fromPlugin }" template="/${returnController }/${divId}${templateType }"/>
	</g:if>
	<g:else>
		<g:render template="/${returnController }/${divId}${templateType }"/>
	</g:else>