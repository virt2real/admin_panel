<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>

<script type="text/javascript" src="js/swfobject.js"></script>
<script type="text/javascript">
	var swfVersionStr = "11.1.0";
	var xiSwfUrlStr = "playerProductInstall.swf";
	var flashvars = {};
	flashvars.host = "rtmp://{deviceHost}/live";
	flashvars.stream = "v2r";
	flashvars.width = 640;
	flashvars.height = 480;
	var params = {};
	params.quality = "high";
	params.bgcolor = "#000000";
	params.allowscriptaccess = "sameDomain";
	params.allowfullscreen = "true";
	var attributes = {};
	attributes.id = "rtmp_easy_viewer";
	attributes.name = "rtmp_easy_viewer";
	attributes.align = "middle";
	swfobject.embedSWF(
		"modules/{module_name}/rtmp_easy_viewer.swf", "flashContent",
                "640", "480",
                swfVersionStr, xiSwfUrlStr,
                flashvars, params, attributes);
	swfobject.createCSS("#flashContent", "display:block;text-align:left;");
</script>

<script>
	function rtmp_run(){
		var location = $("#location").val();
		var bitrate = $("#bitrate").val();
		var enablesound = $("#enablesound").attr("checked") == "checked" ? 1 : 0;

		$.post("modules/{module_name}/run.php?rnd=" + Math.random(), {location: location, bitrate: bitrate, enablesound: enablesound}, function(response, status, xhr) {
			if (status == "success") {
				$("#rtmp_status").html(response);
			}
			if (savestatus == "error") {
				$("#rtmp_status").html("%L_FAIL%");
			}
		});

	}

	function rtmp_stop(){
		$.get("modules/{module_name}/stop.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#rtmp_status").html(response);
			}
			if (status == "error") {
				$("#rtmp_status").html("%L_FAIL%");
			}
		});
	}

	function SaveRTMPSettings(text){
		$("#rtmpsavestatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#rtmpsavestatus").html(response);
			}
			if (savestatus == "error") {
				$("#rtmpsavestatus").html("%L_FAIL%");
			}
		});
	}

	function rtmp_save_common_settings() {
		var autorun = ($("#inautorun").attr("checked") == "checked") ? 1 : 0;
		$("#rtmp_status").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/saveparams.php?rnd=" + Math.random(), {autorun:autorun}, function(response, status, xhr) {
			if (status == "success") {
				$("#rtmp_status").html('%M_SETTINGSSAVED%');
			}
			if (savestatus == "error") {
				$("#rtmp_status").html("%L_FAIL%");
			}
		});
	}

</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>

	<p class="bluetitle">%L_SETTINGS%</p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_URL%</div>
	<div style="display:inline;">
		<input type="text" id="location" value="{location}" style="width:200px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_BITRATE%</div>
	<div style="display:inline;">
		<input type="text" id="bitrate" value="{bitrate}" style="width:200px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_SOUND%</div>
	<input type="checkbox" id="enablesound"><label for="enablesound" class="graytext">%M_SOUND2%</label>

	<p><input type="checkbox" id="inautorun" {inautorun} onclick="rtmp_save_common_settings();"><label for="inautorun" class="graytext">%M_AUTORUN%</label></p>
	<p>&nbsp;</p>

		<div>
			<a href="" class="buttonlink" onclick='rtmp_run(); return false;'>[ %M_START_BROADCAST% ]</a>
			<a href="" class="buttonlink" onclick='rtmp_stop(); return false;'>[ %M_STOP_BROADCAST% ]</a>
		</div>
		<p></p>
	        <div id="flashContent">
        	    <p>
	                %M_NO_FLASH%
        	    </p>
	        </div>
		<p></p>
      		<div id="rtmp_status"></div>
	</div>

	<h3><a href="#">%M_BROADCAST_SCRIPT%</a></h3>
	<div>
		<p><textarea id="rtmptemplate" style="height: 300px;">{rtmptemplate}</textarea></p>
		<p style="float:right;"><a href="#" onclick="noWrap($('#rtmptemplate')); return false;">%M_LINE_WRAPPING%</a></p>
		<p>
			<p><a class="buttonlink" href="#" onclick="var text = $('#rtmptemplate').val(); SaveRTMPSettings(text); return false;">[ %L_SAVE% ]</a></p>
			<span id="rtmpsavestatus"></span>
		</p>
	</div>

</div>

</div>
