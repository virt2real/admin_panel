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
					<p class="bluetitle">Идентификатор устройства</p>
					<p><input type="text" id="deviceid" value="{deviceID}" class="textinput"></p>
					<p class="bluetitle">Описание устройства</p>
					<p><textarea id="devicedescription" style="height: 300px;">{deviceDescription}</textarea></p>
					<p>
						<p><a class="buttonlink" href="#" onclick="var text1 = $('#deviceid').val(); var text2 = $('#devicedescription').val(); SaveSettings(text1, text2); return false;">[ Сохранить ]</a></p>
						<span id="savestatus"></span>
					</p>

	</div>

</div>