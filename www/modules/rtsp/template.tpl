<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>

<script>
	function rtsp_run(){
		var bitrate = $("#bitrate").val();
		var port = $("#port").val();
		var path = $("#path").val();
		var type = $("#type").val();

		$("#rtsp_link").html('<a href="rtsp://{deviceHost}:' + port + path + '">rtsp://{deviceHost}:' + port + path + '</a>');

		$("#rtsp_status").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/run.php?rnd=" + Math.random(), {port:port,path:path,type:type,bitrate:bitrate}, function(response, status, xhr) {
			if (status == "success") {
				$("#rtsp_status").html(response);
			}
			if (savestatus == "error") {
				$("#rtsp_status").html("%L_FAIL%");
			}
		});

	}


	function rtsp_stop(){
		$("#rtsp_status").html('<img src="/imgs/loader.gif">');
		$.get("modules/{module_name}/stop.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#rtsp_status").html(response);
			}
			if (status == "error") {
				$("#rtsp_status").html("%L_FAIL%");
			}
		});
	}


	function SaveRTSPSettings(text){
		$("#rtspsavestatus").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#rtspsavestatus").html(response);
			}
			if (savestatus == "error") {
				$("#rtspsavestatus").html("%L_FAIL%");
			}
		});
	}

</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>

	<table width="100%">
	<tr valign="top">
	<td width="500">

	<p class="bluetitle">%L_SETTINGS%</p>
	<p></p>

	<p class="graytext">%M_SERVERLINK% <span id="rtsp_link"><a href="rtsp://{deviceHost}:554/test">rtsp://{deviceHost}:554/test</a></span></p>

	<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_PORT%</div>
	<div style="display:inline;">
		<input type="text" id="port" value="554" style="width:200px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_PATH%</div>
	<div style="display:inline;">
		<input type="text" id="path" value="/video" style="width:200px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_TYPE%</div>
	<div style="display:inline;">
		<input type="text" id="type" value="1" style="width:200px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_BITRATE%</div>
	<div style="display:inline;">
		<input type="text" id="bitrate" value="600000" style="width:200px;">
	</div>
	<p></p>

		<div>
			<a href="" class="buttonlink" onclick='rtsp_run(); return false;'>[ %M_START_BROADCAST% ]</a>
			<a href="" class="buttonlink" onclick='rtsp_stop(); return false;'>[ %M_STOP_BROADCAST% ]</a>
		</div>
		<p></p>
      		<div id="rtsp_status"></div>

	</td>
	<td>
		<p class="bluetitle">%M_DESCRIPTION%</p>
		<p class="graytext">%M_START_RTSP_UDP%</p>
		<p>&nbsp;</p>
		<p>%M_READWIKI%</p>
	</td>
	</tr>
	</table>


	</div>

	<h3><a href="#">%M_BROADCAST_SCRIPT%</a></h3>
	<div>
		<p><textarea id="rtsptemplate" style="height: 300px;">{rtsptemplate}</textarea></p>
		<p style="float:right;"><a href="#" onclick="noWrap($('#rtsptemplate')); return false;">%M_LINE_WRAPPING%</a></p>
		<p>
			<p><a class="buttonlink" href="#" onclick="var text = $('#rtsptemplate').val(); SaveRTSPSettings(text); return false;">[ %L_SAVE% ]</a></p>
			<span id="rtspsavestatus"></span>
		</p>
	</div>

</div>

</div>
