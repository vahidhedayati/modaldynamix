
	<g:if test="${fromPlugin }">
		<md:loadATemplate fromPlugin="${fromPlugin }" template="/${returnController }/${divId}${templateType }"/>
	</g:if>
	<g:else>
		<g:render template="/${returnController }/${divId}${templateType }"/>
	</g:else>
