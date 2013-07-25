<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>
	function SaveSettings(id, descr){
		$("#savestatus").html("saving...");
		$("#savestatus").load("modules/{module_name}/save.php?id=" + encodeURIComponent(id) + "&descr=" + encodeURIComponent(descr), function(response, status, xhr) {
			if (status == "success") {
				$("#savestatus").html(response);
			}
			if (status == "error") {
				$("#savestatus").html("error");
			}
		});
	}
</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Описание устройства</a></h3>
	<div>
					<p>Идентификатор устройства</p>
					<p><input type="text" id="deviceid" value="{deviceID}" class="textinput"></p>
					<p>Описание устройства</p>
					<p><textarea id="devicedescription">{deviceDescription}</textarea></p>
					<p>
						<input type="button" onclick="var text1 = $('#deviceid').val(); var text2 = $('#devicedescription').val(); SaveSettings(text1, text2); return false;" value="Сохранить">
						<span id="savestatus"></span>
					</p>

	</div>

</div>