<script type="text/javascript" src="js/ajaxupload.js"></script>

<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		LoadAutostartScripts();
	}

	function LoadAutostartScripts(){
		$("#loadautostartscriptstatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/load.php?rnd=" + Math.random(), {}, function(response, status, xhr) {
			$("#loadautostartscriptstatus").empty();
			if (status == "success") {

				var json;

				try {
					json = JSON.parse(response);

					var result = "";
					for (var i in json.active) {
						result += json.active[i] + ' <a href="#" onclick=\'MoveFiles("' + json.active[i] + '", 1); return false;\'><img src="modules/{module_name}/imgs/arrow_right.png"></a>' + '<br>';
					}

					$("#list").html(result);

					result = "";
					for (var i in json.inactive) {
						result += ' <a href="#" onclick=\'MoveFiles("' + json.inactive[i] + '", 2); return false;\'><img src="modules/{module_name}/imgs/arrow_left.png"></a> ' + json.inactive[i] + '<br>';
					}

					$("#list2").html(result);

				} catch (err) {}

			}
			if (savestatus == "error") {
				$("#autostartscriptlist").html("%L_FAIL%");
			}
		});

	}


	function MoveFiles(filename, action){
		$("#loadautostartscriptstatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/move.php?rnd=" + Math.random(), {filename:filename, action:action}, function(response, status, xhr) {
			$("#loadautostartscriptstatus").empty();
			LoadAutostartScripts();
		});

	}


	function SaveAutostartScript(text){
		$("#saveautostartscriptstatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#saveautostartscriptstatus").html(response);
			}
			if (savestatus == "error") {
				$("#saveautostartscriptstatus").html("%L_FAIL%");
			}
		});

	}

	$(function() {
		$( "#configtypeselect" ).buttonset();
	});

	function SaveRCboardSettings(){
		var autorun = ($("#inautorun").attr("checked") == "checked") ? 1 : 0;
		var config = ($("#radio2").attr("checked") == "checked") ? "remote" : "local";
		var user = $("#userid").val();
		var hash = $("#hash").val();
		var address = $("#address").val();

		$(".rcboardsavestatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {
			autorun:autorun,config:config,user:user,hash:hash,address:address
			}, function(response, status, xhr) {
			if (status == "success") {
				$(".rcboardsavestatus").html(response);
			}
			if (savestatus == "error") {
				$(".rcboardsavestatus").html("%L_FAIL%");
			}
		});
	}

	function SaveRCboardLocalConfig(text) {
		$("#rcboardsavelocalconfig").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/savelocal.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#rcboardsavelocalconfig").html(response);
			}
			if (savestatus == "error") {
				$("#rcboardsavelocalconfig").html("%L_FAIL%");
			}
		});
	}

	function RCboardStart(action) {

		$("#actionstatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/run.php?rnd=" + Math.random(), {action:action}, function(response, status, xhr) {
			if (status == "success") {
				$("#actionstatus").html(response);
			}
			if (savestatus == "error") {
				$("#actionstatus").html("%L_FAIL%");
			}
		});
	}

	function RCboardExport(){
		$("#exportstatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/export.php?rnd=" + Math.random(), null, function(response, status, xhr) {
			if (status == "success") {
				$("#exportstatus").html(response);

				$("#exportstatus").html('<a href="modules/{module_name}/exportpage.php"><img src="modules/{module_name}/imgs/download.png" width=50></a>');
			}
			if (savestatus == "error") {
				$("#exportstatus").html("%L_FAIL%");
			}

		});
	}

	function ActivateImport() {
		$.ajax_upload($('#uploadButton'), {
			action : 'modules/{module_name}/upload.php',
			name : 'myfile',
			onSubmit : function(file, ext) {
				RCboardStart(0);
				$("img#load").css("width", "126");
				$("img#load").attr("src", "imgs/loader.gif");
				this.disable();
			},
			onComplete : function(file, response) {
				$("img#load").css("width", "50");
				$("img#load").attr("src", "modules/{module_name}/imgs/upload.png");
				this.enable();
				$("#importstatus").html("Загрузка завершена");
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

	<h3><a href="#">%M_TITLE%</a></h3>
	<div>

		<div style="text-align:center;">
			<span style="margin-right:50px;">
				<a href="#" onclick="RCboardStart(1); return false;" title="запустить сейчас"><img src="modules/{module_name}/imgs/play.png" alt="запустить сейчас"></a>
			</span>
			<span>
				<a href="#" onclick="RCboardStart(0); return false;" title="остановить"><img src="modules/{module_name}/imgs/stop.png" alt="остановить"></a>
			</span>
		</div>

		<p id="actionstatus"></p>

	</div>

	<h3><a href="#">%M_COMMONTITLE%</a></h3>
	<div>
		<table>
			<tr valign="top">
				<td width="350">

					<p><input type="checkbox" id="inautorun" {inautorun}><label for="inautorun">Запускать при включении питания</label></p>
					<p>&nbsp;</p>

					<p>Использовать</p>
					<div id="configtypeselect">
						<input type="radio" id="radio1" name="radio" {config_selected1}><label for="radio1">Локальный конфиг</label>
						<input type="radio" id="radio2" name="radio" {config_selected2}><label for="radio2">Удалённый конфиг</label>
					</div>

					<p>&nbsp;</p>

					<p>
						<p><a class="buttonlink" href="#" onclick="SaveRCboardSettings(); return false;">[ %L_SAVE% ]</a></p>
					</p>
					<p class="rcboardsavestatus"></p>

				</td>
				<td>
					<p class="graytext"><span class="bluetitle">Запускать при включении питания</span><br> значит поместить скрипт запуска в автозагрузку </p> 
				</td>
			</tr>
		</table>

	</div>

	<h3><a href="#">%M_MODULESTITLE%</a></h3>
	<div>
		<div id="loadautostartscriptstatus" style="height:20px;"></div>

		<table width="100%">
			<tr valign=top>
				<td width=200><p class="bluetitle">%M_ACTIVE_SCRIPTS%</p></td>
				<td width=200><p class="bluetitle">%M_INACTIVE_SCRIPTS%</p></td>
				<td>&nbsp;</td>
			</tr>
			<tr valign=top>
				<td><div id="list"></div></td>
				<td><div id="list2"></div></td>
			</tr>
		</table>
	</div>

	<h3><a href="#">%M_LOCALCONFIGTITLE%</a></h3>
	<div>
		<p>
			<textarea id="localconfigfile">{localconfigfile}</textarea>

			<p style="float:right;"><a href="#" onclick="noWrap($('#localconfigfile')); return false;">%M_LINE_WRAPPING%</a></p>
			<p>
				<p><a class="buttonlink" href="#" onclick="var text = $('#localconfigfile').val(); SaveRCboardLocalConfig(text); return false;">[ %L_SAVE% ]</a></p>
				<span id="rcboardsavelocalconfig"></span>
			</p>
		</p>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
	</div>

	<h3><a href="#">%M_REMOTECONFIGTITLE%</a></h3>
	<div>
		<table>
			<tr valign="top">
				<td width=350>
					<p class="graytext">Использовать конфигурационный файл <br>на удалённом сервере <br>(обычно используется если недоступна <br> локальная панель управления)</p>
					<div style="min-width:200px;">%M_USERID%</div>
					<div style="display:inline;">
						<input type="text" id="userid" value="{user_id}" style="width:300px;">
					</div>
					<p></p>
					<div style="min-width:200px;">%M_HASH%</div>
					<div style="display:inline;">
						<input type="text" id="hash" value="{hash}" style="width:300px;">
					</div>
					<p></p>
					<div style="min-width:200px;">%M_ADDRESS%</div>
					<div style="display:inline;">
						<input type="text" id="address" value="{address}" style="width:300px;">
					</div>
					<p></p>

					<p>
						<p style="float:right;"><a class="buttonlink" href="#" onclick="SaveRCboardSettings(); return false;">[ %L_SAVE% ]</a></p>
						<span class="rcboardsavestatus"></span>
					</p>

				</td>
				<td>
					<p class="graytext"><span class="bluetitle">Идентификатор пользователя</span><br> число, уникальное для каждого пользователя </p> <p class="graytext"><span class="bluetitle">Хэш - строка</span> <br> идентификатор конфигурации</p> <p class="graytext"><span class="bluetitle">Адрес сервера</span> <br><a href="http://rc.virt2real.ru/getconfig">http://rc.virt2real.ru/getconfig</a></p> 
				</td>
			</tr>
		</table>
		
	</div>

	<h3 onClick="ActivateImport();"><a href="#">%M_EXPORTTITLE%</a></h3>
	<div>
		<p class="bluetitle">Полный экспорт rcboard (сохранение архива)</p>
		<p><a class="buttonlink" href="#" onclick="RCboardExport(); return false;">[ %L_EXPORT% ]</a></p>
		<div id="exportstatus"></div>

		<p>&nbsp;</p>

		<p class="bluetitle">Полный импорт rcboard (загрузить архив)</p>

        <div id="uploadButton" class="button">
            <img id="load" src="modules/{module_name}/imgs/upload.png" width=50>
        </div>

		<div id="importstatus"></div>

	</div>

</div>
