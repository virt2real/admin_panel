<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Консоль</a></h3>
	<div style="text-align: center;">
	    <iframe src="modules/{module_name}/console.php" style="background-color:#000000; width: 99%; height: 800px; border: none;">
	</div>

</div>