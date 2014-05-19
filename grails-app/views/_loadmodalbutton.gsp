
	<button href="#${attrs.id}" 
		class="btn btn-success" 
		role="button" data-toggle="modal"  
		onclick="run${attrs.id}()" 
		title="${attrs.title}">
		
 	${attrs.value}
 	
 	</button>

<script type="text/javascript">
	function run${attrs.id}() {
 		$('#${attrs.divId}').show();
 	 }
</script>
