<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}

	function mpegts_run(){
		var clients = $("#clients").val();
		var bitrate = $("#bitrate").val();

		$("#mpegts_status").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/run.php?rnd=" + Math.random(), {clients: clients, bitrate: bitrate}, function(response, status, xhr) {
			if (status == "success") {
				$("#mpegts_status").html(response);
			}
			if (savestatus == "error") {
				$("#mpegts_status").html("%L_FAIL%");
			}
		});
	}

	function mpegts_stop(){
		$("#mpegts_status").html('<img src="imgs/loader.gif">');
		$.get("modules/{module_name}/stop.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#mpegts_status").html(response);
			}
			if (status == "error") {
				$("#mpegts_status").html("%L_FAIL%");
			}
		});
	}


	function SaveMPEGTSSettings(text){
		$("#mpegtssavestatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#mpegtssavestatus").html(response);
			}
			if (savestatus == "error") {
				$("#mpegtssavestatus").html("%L_FAIL%");
			}
		});
	}

	function mpegts_save_common_settings() {
		var autorun = ($("#inautorun").attr("checked") == "checked") ? 1 : 0;
		$("#mpegts_status").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/saveparams.php?rnd=" + Math.random(), {autorun:autorun}, function(response, status, xhr) {
			if (status == "success") {
				$("#mpegts_status").html('%M_SETTINGSSAVED%');
			}
			if (savestatus == "error") {
				$("#mpegts_status").html("%L_FAIL%");
			}
		});
	}

</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>

	<table width="100%">
		<tr valign="top">
		<td width="450">

			<p class="bluetitle">%L_SETTINGS%</p>
			<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_HOST%</div>
			<div style="display:inline;">
				<input type="text" id="clients" value="{clients}" style="width:200px;">
			</div>
			<p></p>
			<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_BITRATE%</div>
			<div style="display:inline;">
				<input type="text" id="bitrate" value="{bitrate}" style="width:200px;">
			</div>
			<p></p>

			<p>&nbsp;</p>
			<p><input type="checkbox" id="inautorun" {inautorun} onclick="mpegts_save_common_settings();"><label for="inautorun" class="graytext">%M_AUTORUN%</label></p>
			<p>&nbsp;</p>

			<div>
				<a href="" class="buttonlink" onclick='mpegts_run(); return false;'>[ %M_START_BROADCAST% ]</a>
				<a href="" class="buttonlink" onclick='mpegts_stop(); return false;'>[ %M_STOP_BROADCAST% ]</a>
			</div>
			<p></p>
      		<div id="mpegts_status"></div>

		</td>
		<td>
			<p class="bluetitle">%M_DESCRIPTION%</p>
			<p class="graytext">%M_START_RDP_UDP%</p>
			<p>&nbsp;</p>
			<p>%M_READWIKI%</p>
		</td>
		</tr>
	</table>


	</div>

	<h3><a href="#">%M_BROADCAST_SCRIPT%</a></h3>
	<div>
		<p><textarea id="mpegtstemplate" style="height: 300px;">{mpegtstemplate}</textarea></p>
		<p style="float:right;"><a href="#" onclick="noWrap($('#mpegtstemplate')); return false;">%M_LINE_WRAPPING%</a></p>
		<p>
			<p><a class="buttonlink" href="#" onclick="var text = $('#mpegtstemplate').val(); SaveMPEGTSSettings(text); return false;">[ %L_SAVE% ]</a></p>
			<span id="mpegtssavestatus"></span>
		</p>
	</div>

</div>

</div>
