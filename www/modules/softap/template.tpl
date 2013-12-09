<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>
<script>
	function SaveSettings(){		$("#softap_status").html('<img src="/imgs/loader.gif">');

		var ssid = $("#ssid_value").val();
		var passphrase = $("#passphrase_value").val();

		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {ssid: ssid, passphrase: passphrase}, function(response, status, xhr) {
			if (status == "success") {				$("#softap_status").html(response);
			}
			if (savestatus == "error") {
				$("#softap_status").html(":-)");
			}
		});
	}
</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Точка доступа</a></h3>
	<div>

		<p>В данном разделе можно произвести настройки параметров точки доступа контроллера virt2real</p>
		<p>Включение/выключение режима "Точка доступа" можно произвести в разделе <a href="?uenv">uEnv</a></p>
		<p>Настройку IP адреса можно произвести в разделе <a href="?network">Сеть</a></p>

		<p class="bluetitle">Параметры</p>

		<div style="display:inline-block; padding-left:40px; min-width:150px;">Имя сети</div>
		<div style="display:inline;">
			<input type="text" id="ssid_value" value="{ssid_value}" style="width:100px; background-color:#b0b0b0; border: none;">
		</div>
		<p></p>
		<div style="display:inline-block; padding-left:40px; min-width:150px;">Пароль</div>
		<div style="display:inline;">
			<input type="text" id="passphrase_value" value="{passphrase_value}" style="width:100px; background-color:#b0b0b0; border: none;">
		</div>

		<p><a class="buttonlink" href="#" onclick='SaveSettings(); return false;'>[ Сохранить ]</a></p>
		<div id="softap_status"></div>

	</div>
</div>

</div>