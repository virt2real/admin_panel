<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>

<script type="text/javascript" src="js/swfobject.js"></script>
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
				$("#mjpeg_status").html("%L_FAIL%");
			}
		});

	}

	function mjpeg_stop(){
		$.get("modules/{module_name}/stop.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#mjpeg_status").html(response);
			}
			if (status == "error") {
				$("#mjpeg_status").html("%L_FAIL%");
			}
		});
	}

	function SaveMJPEGSettings(text){
		$("#mjpegsavestatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#mjpegsavestatus").html(response);
			}
			if (savestatus == "error") {
				$("#mjpegsavestatus").html("%L_FAIL%");
			}
		});
	}

	function mjpeg_save_common_settings() {
		var autorun = ($("#inautorun").attr("checked") == "checked") ? 1 : 0;
		$("#mjpeg_status").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/saveparams.php?rnd=" + Math.random(), {autorun:autorun}, function(response, status, xhr) {
			if (status == "success") {
				$("#mjpeg_status").html('%M_SETTINGSSAVED%');
			}
			if (savestatus == "error") {
				$("#mjpeg_status").html("%L_FAIL%");
			}
		});
	}

</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_MJPEG%</a></h3>
	<div>

	<table width="100%">
	<tr valign="top">
	<td width="700">

	<p class="bluetitle">%L_SETTINGS%</p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_PORT%</div>
	<div style="display:inline;">
		<input type="text" id="port" value="{mjpeg_port}" style="width:100px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_QUALITY%</div>
	<div style="display:inline;">
		<input type="text" id="quality" value="{mjpeg_quality}" style="width:100px;">
	</div>
	<p></p>

	<p><input type="checkbox" id="inautorun" {inautorun} onclick="mjpeg_save_common_settings();"><label for="inautorun" class="graytext">%M_AUTORUN%</label></p>

		<div>
			<a href="" class="buttonlink" onclick='mjpeg_run(); return false;'>[ %M_START_SERVER% ]</a>
			<a href="" class="buttonlink" onclick='mjpeg_stop(); return false;'>[ %M_STOP_SERVER% ]</a>
		</div>
		<p></p>

      	<div id="mjpeg_status"></div>

		<p class="graytext">%M_REFRESH_PAGE%</p>
		<p></p>
	        <div id="flashContent">
        	    <p>
	                %M_NO_FLASH%
        	    </p>
	        </div>
		<p></p>

	</td>
	<td>
		<p class="bluetitle">%M_DESCRIPTION%</p>
		<p class="graytext">%M_START_SERVER_HERE%</p>
		<p class="graytext">%M_WHY_FLASH%</p>
		<p class="graytext">%M_WHY_LAGGING%</p>
	</td>
	</tr>
	</table>


	</div>


	<h3><a href="#">%M_SERVER_SCRIPT%</a></h3>
	<div>
		<p><textarea id="mjpegtemplate" style="height: 300px;">{mjpegtemplate}</textarea></p>
		<p style="float:right;"><a href="#" onclick="noWrap($('#mjpegtemplate')); return false;">%M_LINE_WRAPPING%</a></p>
		<p>
			<p><a class="buttonlink" href="#" onclick="var text = $('#mjpegtemplate').val(); SaveMJPEGSettings(text); return false;">[ %L_SAVE% ]</a></p>
			<span id="mjpegsavestatus"></span>
		</p>
	</div>

</div>

</div>
