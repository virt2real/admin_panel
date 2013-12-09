<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>
	function SaveInterfaces(text){
		$("#saveinterfaces").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/saveinterfaces.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#saveinterfaces").html(response);
			}
			if (savestatus == "error") {
				$("#saveinterfaces").html(":-(");
			}
		});

	}


</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Сеть</a></h3>
	<div>
		<p class="bluetitle">Активные сетевые интерфейсы</p>
		<div id="currentlanconnection">
		{currentstate}
		</div>

		<p class="bluetitle">Настройка сетевых интерфейсов</p>
		<p><textarea id="interfaces">{interfaces}</textarea></p>
		<p>
			<p><a href="#" class="buttonlink" onclick="var text = $('#interfaces').val(); SaveInterfaces(text); return false;">[ Сохранить ]</a></p>
			<span id="saveinterfaces"></span>
		</p>

	</div>

</div>