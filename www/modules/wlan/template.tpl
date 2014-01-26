<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}

</script>

<script>
	function SaveSettings(text){

		$("#wpa_status").html('<img src="/imgs/loader.gif">');

		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#wpa_status").html(response);
			}
			if (savestatus == "error") {
				$("#wpa_status").html(":-(");
			}
		});
	}
</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Настройка Wi-Fi</a></h3>
	<div>
	        <p>Файл /etc/wpa_supplicant.conf</p>

		<p class="bluetitle">Настройки подключения Wi-Fi к точкам доступа</p>

		<p><textarea id="wpa_config" style="width: 90%; height: 400px;">{wpa_config}</textarea></p>
		<p>
			<p><a class="buttonlink" href="#" onclick="var text = $('#wpa_config').val(); SaveSettings(text); return false;">[ Сохранить ]</a></p>
		</p>


		<div id="wpa_status"></div>
	</div>


</div>

</div>