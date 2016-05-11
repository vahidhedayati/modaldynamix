<g:if test="${fromPlugin }">
	<md:loadATemplate fromPlugin="${fromPlugin }" template="${modalTemplatePage}"/>
</g:if>
<g:else>
	<g:render template="${modalTemplatePage}"  model="[attrs:attrs]"/>
</g:else>
