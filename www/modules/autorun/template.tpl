<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>

<script>
	function SaveAutostartScript(text){
		$("#saveautostartscriptstatus").html("saving...");
		$("#saveautostartscriptstatus").load("modules/{module_name}/save.php?text=" + encodeURIComponent(text), function(response, status, xhr) {
			if (status == "success") {
				$("#saveautostartscriptstatus").html("success");
			}
			if (status == "error") {
				$("#saveautostartscriptstatus").html("error");
			}
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Автозапуск</a></h3>
	<div>
					<p>Автозапуск управляющего скрипта /etc/virt2real/autostart.sh</p>
					<p><textarea id="autostartscript">{autostartscript}</textarea></p>
					<p>
						<input type="button" onclick="var text = $('#autostartscript').val(); SaveAutostartScript(text); return false;" value="Сохранить">
						<span id="saveautostartscriptstatus"></span>
					</p>

					<p>Так как железка, в первую очередь, предназначена для установки на различных девайсах вроде танков, самолётов, тележек, роботов, и т.д., и т.п.,
					требуется автономная работа.</p>
					<p>При включении железки начинает выполнение какого-то конкретного пользовательского управляющего скрипта. Запуск реализован с помощью командного файла с фиксированным именем /etc/virt2real/autostart.sh</p>
					<p>Содержимое именно этого файла доступно для редактирования в текстовом поле слева.</p>

	</div>

</div>