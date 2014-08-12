<!--  This simply loads in the bootstrap css and js - css modified chunk at top removed 
to stop meddling with existing body/p tags from default grails or any other site  -->


<g:if test="${gfolder.equals("resources") }">
	<link rel="stylesheet" href="${createLink(uri: '/css/bootstrap-combined.min-md-mod.css')}" type="text/css">
	<script src="${createLink(uri: '/js/bootstrap.min.js')}" type="text/javascript"></script>
</g:if>
<g:else>
 	<asset:stylesheet href="bootstrap-combined.min-md-mod.css" />
	<asset:javascript src="bootstrap.min.js"/>
</g:else>
