<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>

<script type="text/javascript" src="/js/swfobject.js"></script>
<script type="text/javascript">
	var swfVersionStr = "9.0.0";
	var flashvars = {};
	flashvars.host = "{deviceHost}";
	flashvars.file = "/";
	flashvars.port = "{mjpeg_port}";
	flashvars.user = "";
	flashvars.pass = "";
	var params = {};
	params.quality = "high";
	params.allowscriptaccess = "always";
	params.allowfullscreen = "true";
	params.wmode = "transparent";
	var attributes = {};
	attributes.id = "camera";
	attributes.name = "camera";
	attributes.align = "middle";
	swfobject.embedSWF("modules/{module_name}/camera.swf", "flashContent", "640", "480", swfVersionStr, "", flashvars, params, attributes);
</script>

<script>
	function mjpeg_run(){
		var port = $("#port").val();
		var quality = $("#quality").val();

		$.post("modules/{module_name}/run.php?rnd=" + Math.random(), {port:port, quality: quality}, function(response, status, xhr) {
			if (status == "success") {
				$("#mjpeg_status").html(response);
			}
			if (savestatus == "error") {
				$("#mjpeg_status").html(":-(");
			}
		});

	}

	function mjpeg_stop(){
		$.get("modules/{module_name}/stop.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#mjpeg_status").html(response);
			}
			if (status == "error") {
				$("#mjpeg_status").html("error");
			}
		});
	}

	function SaveMJPEGSettings(text){ 
		$("#mjpegsavestatus").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#mjpegsavestatus").html(response);
			}
			if (savestatus == "error") {
				$("#mjpegsavestatus").html(":-(");
			}
		});
	}


</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">MJPEG</a></h3>
	<div>

	<table width="100%">
	<tr valign="top">
	<td width="700">

	<p class="bluetitle">Настройки</p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">Порт</div>
	<div style="display:inline;">
		<input type="text" id="port" value="8888" style="width:100px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">Качество</div>
	<div style="display:inline;">
		<input type="text" id="quality" value="40" style="width:100px;">
	</div>
	<p></p>


		<div>
			<a href="" class="buttonlink" onclick='mjpeg_run(); return false;'>[ запустить сервер ]</a>
			<a href="" class="buttonlink" onclick='mjpeg_stop(); return false;'>[ остановить сервер ]</a>
		</div>
		<p></p>
		<p class="graytext">После запуска сервера <a href="?mjpeg">обновите страницу</a></p>
		<p></p>
	        <div id="flashContent">
        	    <p>
	                To view this page ensure that Adobe Flash Player version
                	9.0.0 or greater is installed.
        	    </p>
	        </div>
		<p></p>
      		<div id="mjpeg_status"></div>

	</td>
	<td>
		<p class="bluetitle">Описание</p>
		<p class="graytext">В этом разделе можно запустить видеосервер MJPEG на указанном порту. Для предварительного просмотра в страницу встроен flash-плеер, который берёт поток с фиксированного порта 8888, так что если хотите увидеть в нём видео - необходимо запустить сервер именно с указанием этого порта.  </p>
		<p class="graytext">Flash-плеер используется из-за того что в браузерах MJPEG поток некорректно отображается (или не отображается вообще)</p>
		<p class="graytext">Картинка может дёргаться, т.к. flash-плеер может пропускать кадры.</p>
	</td>
	</tr>
	</table>


	</div>


	<h3><a href="#">Скрипт сервера</a></h3>
	<div>
		<p><textarea id="mjpegtemplate" style="height: 300px;">{mjpegtemplate}</textarea></p>
		<p style="float:right;"><a href="#" onclick="noWrap($('#mjpegtemplate')); return false;">переносы строк</a></p>
		<p>
			<p><a class="buttonlink" href="#" onclick="var text = $('#mjpegtemplate').val(); SaveMJPEGSettings(text); return false;">[ Сохранить ]</a></p>
			<span id="mjpegsavestatus"></span>
		</p>
	</div>

</div>

</div>