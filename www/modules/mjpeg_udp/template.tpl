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
				$("#mjpeg_udp_status").html("%L_FAIL%");
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
				$("#mjpeg_udp_status").html("%L_FAIL%");
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
				$("#mjpeg_udp_savestatus").html("%L_FAIL%");
			}
		});
	}

</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>

	<table width="100%">
	<tr valign="top">
	<td width="700">

	<p class="bluetitle">%L_SETTINGS%</p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_HOST%</div>
	<div style="display:inline;">
		<input type="text" id="host" value="{host}" style="width:200px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_PORT%</div>
	<div style="display:inline;">
		<input type="text" id="port" value="3000" style="width:200px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_QUALITY%</div>
	<div style="display:inline;">
		<input type="text" id="quality" value="40" style="width:200px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_FPS%</div>
	<div style="display:inline;">
		<input type="text" id="fps" value="30" style="width:200px;">
	</div>
	<p></p>


		<div>
			<a href="" class="buttonlink" onclick='mjpeg_udp_run(); return false;'>[ %M_START_BROADCAST% ]</a>
			<a href="" class="buttonlink" onclick='mjpeg_udp_stop(); return false;'>[ %M_STOP_BROADCAST% ]</a>
		</div>
		<p></p>
      		<div id="mjpeg_udp_status"></div>

	</td>
	<td>
		<p class="bluetitle">%M_DESCRIPTION%</p>
		<p class="graytext">%M_START_MJPEGUDP_HERE%</p>

		<p>&nbsp;</p>
		<p>%M_READ_WIKI%</p>
	</td>
	</tr>
	</table>

	</div>

	<h3><a href="#">%M_BROADCAST_SCRIPT%</a></h3>
	<div>
		<p><textarea id="mjpeg_udptemplate" style="height: 300px;">{mjpeg_udptemplate}</textarea></p>
		<p style="float:right;"><a href="#" onclick="noWrap($('#mjpeg_udptemplate')); return false;">%M_LINE_WRAPPING%</a></p>
		<p>
			<p><a class="buttonlink" href="#" onclick="var text = $('#mjpeg_udptemplate').val(); SaveMJPEG_UDPSettings(text); return false;">[ %L_SAVE% ]</a></p>
			<span id="mjpeg_udp_savestatus"></span>
		</p>
	</div>

</div>

</div>
