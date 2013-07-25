<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>
	function SaveInterfaces(text){
		$("#saveinterfaces").html("saving...");
		$("#saveinterfaces").load("modules/{module_name}/saveinterfaces.php?text=" + encodeURIComponent(text), function(response, status, xhr) {
			if (status == "success") {
				$("#saveinterfaces").html("success");
			}
			if (status == "error") {
				$("#saveinterfaces").html("error");
			}
		});
	}


</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Сеть</a></h3>
	<div>
		<p>Настройка сетевых интерфейсов</p>
		<div id="currentlanconnection">
		{currentstate}
		</div>

		<p>Активные сетевые интерфейсы</p>
		<p><textarea id="interfaces">{interfaces}</textarea></p>
		<p>
			<input type="button" onclick="var text = $('#interfaces').val(); SaveInterfaces(text); return false;" value="Сохранить">
			<span id="saveinterfaces"></span>
		</p>

	</div>

</div>