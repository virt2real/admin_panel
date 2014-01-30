<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>

<script type="text/javascript" src="/js/swfobject.js"></script>
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
		var playpath = $("#playpath").val();
		var bitrate = $("#bitrate").val();

		$.post("modules/{module_name}/run.php?rnd=" + Math.random(), {location: location, playpath: playpath, bitrate: bitrate}, function(response, status, xhr) {
			if (status == "success") {
				$("#rtmp_status").html(response);
			}
			if (savestatus == "error") {
				$("#rtmp_status").html(":-(");
			}
		});

	}

	function rtmp_stop(){
		$.get("modules/{module_name}/stop.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#rtmp_status").html(response);
			}
			if (status == "error") {
				$("#rtmp_status").html("error");
			}
		});
	}

	function SaveRTMPSettings(text){ 
		$("#rtmpsavestatus").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#rtmpsavestatus").html(response);
			}
			if (savestatus == "error") {
				$("#rtmpsavestatus").html(":-(");
			}
		});
	}


</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">RTMP</a></h3>
	<div>

	<p class="bluetitle">Настройки</p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">URL</div>
	<div style="display:inline;">
		<input type="text" id="location" value="rtmp://localhost/live/" style="width:200px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">stream</div>
	<div style="display:inline;">
		<input type="text" id="playpath" value="v2r" style="width:200px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:100px;">битрейт</div>
	<div style="display:inline;">
		<input type="text" id="bitrate" value="600000" style="width:200px;">
	</div>
	<p></p>


		<div>
			<a href="" class="buttonlink" onclick='rtmp_run(); return false;'>[ запустить трансляцию ]</a>
			<a href="" class="buttonlink" onclick='rtmp_stop(); return false;'>[ остановить трансляцию ]</a>
		</div>
		<p></p>
	        <div id="flashContent">
        	    <p>
	                To view this page ensure that Adobe Flash Player version
                	11.1.0 or greater is installed.
        	    </p>
	        </div>
		<p></p>
      		<div id="rtmp_status"></div>
	</div>

	<h3><a href="#">Скрипт трансляции</a></h3>
	<div>
		<p><textarea id="rtmptemplate" style="height: 300px;">{rtmptemplate}</textarea></p>
		<p>
			<p><a class="buttonlink" href="#" onclick="var text = $('#rtmptemplate').val(); SaveRTMPSettings(text); return false;">[ Сохранить ]</a></p>
			<span id="rtmpsavestatus"></span>
		</p>
	</div>

</div>

</div>