<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>

<script>
	function mjpeg_udp_run(){
		var host = $("#host").val();
		var port = $("#port").val();
		var quality = $("#quality").val();
		var fps = $("#fps").val();
		$("#mjpeg_udp_status").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/run.php?rnd=" + Math.random(), {host: host, port: port, quality: quality, fps:fps}, function(response, status, xhr) {
			if (status == "success") {
				$("#mjpeg_udp_status").html(response);
			}
			if (savestatus == "error") {
				$("#mjpeg_udp_status").html(":-(");
			}
		});

	}


	function mjpeg_udp_stop(){
		$("#mjpeg_udp_status").html('<img src="/imgs/loader.gif">');
		$.get("modules/{module_name}/stop.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#mjpeg_udp_status").html(response);
			}
			if (status == "error") {
				$("#mjpeg_udp_status").html("error");
			}
		});
	}


	function SaveMJPEG_UDPSettings(text){ 
		$("#mjpeg_udp_savestatus").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#mjpeg_udp_savestatus").html(response);
			}
			if (savestatus == "error") {
				$("#mjpeg_udp_savestatus").html(":-(");
			}
		});
	}

</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">MJPEG udp</a></h3>
	<div>

	<table width="100%">
	<tr valign="top">
	<td width="700">

	<p class="bluetitle">Настройки</p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">хост</div>
	<div style="display:inline;">
		<input type="text" id="host" value="{host}" style="width:200px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">порт</div>
	<div style="display:inline;">
		<input type="text" id="port" value="3000" style="width:200px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">качество</div>
	<div style="display:inline;">
		<input type="text" id="quality" value="40" style="width:200px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">кадров в секунду</div>
	<div style="display:inline;">
		<input type="text" id="fps" value="30" style="width:200px;">
	</div>
	<p></p>


		<div>
			<a href="" class="buttonlink" onclick='mjpeg_udp_run(); return false;'>[ запустить трансляцию ]</a>
			<a href="" class="buttonlink" onclick='mjpeg_udp_stop(); return false;'>[ остановить трансляцию ]</a>
		</div>
		<p></p>
      		<div id="mjpeg_udp_status"></div>

	</td>
	<td>
		<p class="bluetitle">Описание</p>
		<p class="graytext">В этом разделе можно запустить трансляцию MJPEG с использованием UDP транспорта на указанный хост и порт. </p>

		<p>&nbsp;</p>
		<p>Подробнее про передачу и приём видео можно прочитать в <a href="http://wiki.virt2real.ru/wiki/Примеры_цепочек_GStreamer" target="_blank">этом разделе Wiki</a></p>
	</td>
	</tr>
	</table>

	</div>

	<h3><a href="#">Скрипт трансляции</a></h3>
	<div>
		<p><textarea id="mjpeg_udptemplate" style="height: 300px;">{mjpeg_udptemplate}</textarea></p>
		<p>
			<p><a class="buttonlink" href="#" onclick="var text = $('#mjpeg_udptemplate').val(); SaveMJPEG_UDPSettings(text); return false;">[ Сохранить ]</a></p>
			<span id="mjpeg_udp_savestatus"></span>
		</p>
	</div>

</div>

</div>