<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){

		LoadAutostartScripts();

	}


	function LoadAutostartScripts(){
		$("#loadautostartscriptstatus").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/load.php?rnd=" + Math.random(), {}, function(response, status, xhr) {
			$("#loadautostartscriptstatus").empty();
			if (status == "success") {

				var json;

				try {
					json = JSON.parse(response);

					var result = "";
					for (var i in json.active) {
						result += json.active[i] + ' <a href="#" onclick=\'MoveFiles("' + json.active[i] + '", 1); return false;\'><img src="modules/{module_name}/arrow_right.png"></a>' + '<br>';
					}

					$("#list").html(result);

					result = "";
					for (var i in json.inactive) {
						result += ' <a href="#" onclick=\'MoveFiles("' + json.inactive[i] + '", 2); return false;\'><img src="modules/{module_name}/arrow_left.png"></a> ' + json.inactive[i] + '<br>';
					}

					$("#list2").html(result);

				} catch (err) {}

			}
			if (savestatus == "error") {
				$("#autostartscriptlist").html(":-(");
			}
		});

	}


	function MoveFiles(filename, action){
		$("#loadautostartscriptstatus").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/move.php?rnd=" + Math.random(), {filename:filename, action:action}, function(response, status, xhr) {
			$("#loadautostartscriptstatus").empty();
			LoadAutostartScripts();
		});

	}


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

<style>

#list, #list2 {
  font-family: "Lucida Console", Monaco, monospace;
  font-size:1.4em;
}

</style>

<div id="accordion" style="margin:0; padding:0;">
	<h3><a href="#">Системные скрипты загрузки</a></h3>
	<div>
		<div id="loadautostartscriptstatus" style="height:20px;"></div>


		<table width="100%">
			<tr valign=top>
				<td width=200><p class="bluetitle">Активные скрипты</p></td>
				<td width=200><p class="bluetitle">Неактивные скрипты</p></td>
				<td>&nbsp;</td>
			</tr>
			<tr valign=top>
				<td><div id="list"></div></td>
				<td><div id="list2"></div></td>
				
				<td>
					<p>Левый столбец - активные скрипты в каталоге /etc/init.d, выполняются в алфавитном порядке при старте системы.</p>
					<p>Правый столбец - неактивные скрипты в каталоге /etc/init.d.sample, при запуске системы НЕ выполняются, но хранятся на всякий случай.</p>
					<p>Путём перемещения файлов из одного списка в другой можно настраивать запуск нужных компонентов при загрузке системы. </p>
				</td>
			</tr>
		</table>

	</div>

	<h3><a href="#">Скрипт автозапуска virt2real</a></h3>
	<div>
		<p><textarea id="autostartscript">{autostartscript}</textarea></p>
		<p>
			<p><a class="buttonlink" href="#" onclick="var text = $('#autostartscript').val(); SaveAutostartScript(text); return false;">[ Сохранить ]</a></p>
			<span id="saveautostartscriptstatus"></span>
		</p>

	</div>

</div>
