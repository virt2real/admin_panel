<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>

<script>
	function SaveAutostartScript(text){
		$("#saveautostartscriptstatus").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#saveautostartscriptstatus").html(response);
			}
			if (savestatus == "error") {
				$("#saveautostartscriptstatus").html(":-(");
			}
		});

	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Автозапуск</a></h3>
	<div>
					<p class="bluetitle">Автозапуск управляющего скрипта /etc/virt2real/autostart.sh</p>
					<p><textarea id="autostartscript">{autostartscript}</textarea></p>
					<p>
						<p><a class="buttonlink" href="#" onclick="var text = $('#autostartscript').val(); SaveAutostartScript(text); return false;">[ Сохранить ]</a></p>
						<span id="saveautostartscriptstatus"></span>
					</p>

					<p class="bluetitle">Так как железка, в первую очередь, предназначена для установки на различных девайсах вроде танков, самолётов, тележек, роботов, и т.д., и т.п.,
					требуется автономная работа.</p>
					<p class="bluetitle">При включении железки начинает выполнение какого-то конкретного пользовательского управляющего скрипта. Запуск реализован с помощью командного файла с фиксированным именем /etc/virt2real/autostart.sh</p>
					<p class="bluetitle">Содержимое именно этого файла доступно для редактирования в текстовом поле слева.</p>

	</div>

</div>