<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Макет платы</a></h3>
	<div>
		<div>
			<img src="modules/{module_name}/board.png">
		</div>

		<div>
			<table width="600">
				{pintable}
			</table>
		</div>

	</div>


</div>