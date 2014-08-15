<button href="#${attrs.id}"	
	class="${attrs.style}" 	
	role="button"  
	id="${attrs.id}2"
	data-toggle="modal" 
	onclick="run${attrs.id}()" 
	title="${attrs.title}">
	${attrs.value}</button>

<script type="text/javascript">
	function run${attrs.id}() {
 		$('#${attrs.divId}').show();
 	 }
</script>
