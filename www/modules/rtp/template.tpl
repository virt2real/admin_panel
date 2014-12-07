<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}

	$(function() {
		$( "#inputselect" ).buttonset();
	});

	function rtp_run(){
		var clients = $("#clients").val();
		var bitrate = $("#bitrate").val();
		var type = "GST";
		if ($("#type1").attr("checked") == "checked") type = "GST";
		if ($("#type2").attr("checked") == "checked") type = "ANDROID";
		if ($("#type3").attr("checked") == "checked") type = "IOS";

		$("#rtp_status").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/run.php?rnd=" + Math.random(), {clients: clients, bitrate: bitrate, type: type}, function(response, status, xhr) {
			if (status == "success") {
				$("#rtp_status").html(response);
			}
			if (savestatus == "error") {
				$("#rtp_status").html("%L_FAIL%");
			}
		});
	}

	function rtp_stop(){
		$("#rtp_status").html('<img src="imgs/loader.gif">');
		$.get("modules/{module_name}/stop.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#rtp_status").html(response);
			}
			if (status == "error") {
				$("#rtp_status").html("%L_FAIL%");
			}
		});
	}


	function SaveRTPSettings(text){
		$("#rtpsavestatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#rtpsavestatus").html(response);
			}
			if (savestatus == "error") {
				$("#rtpsavestatus").html("%L_FAIL%");
			}
		});
	}

	function rtp_save_common_settings() {
		var autorun = ($("#inautorun").attr("checked") == "checked") ? 1 : 0;
		$("#rtp_status").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/saveparams.php?rnd=" + Math.random(), {autorun:autorun}, function(response, status, xhr) {
			if (status == "success") {
				$("#rtp_status").html('%M_SETTINGSSAVED%');
			}
			if (savestatus == "error") {
				$("#rtp_status").html("%L_FAIL%");
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

			<div style="display:inline-block; padding-left:40px; min-width:100px;">%M_TYPE%</div>
			<p></p>
			<div style="width:100%; text-align:center;">
				<div id="inputselect">
					<input type="radio" id="type1" name="radio" {type1}><label for="type1">%M_INPUT1%</label>
					<input type="radio" id="type2" name="radio" {type2}><label for="type2">%M_INPUT2%</label>
					<input type="radio" id="type3" name="radio" {type3}><label for="type3">%M_INPUT3%</label>
				</div>
			</div>

			<p>&nbsp;</p>
			<p><input type="checkbox" id="inautorun" {inautorun} onclick="rtp_save_common_settings();"><label for="inautorun" class="graytext">%M_AUTORUN%</label></p>
			<p>&nbsp;</p>

			<div>
				<a href="" class="buttonlink" onclick='rtp_run(); return false;'>[ %M_START_BROADCAST% ]</a>
				<a href="" class="buttonlink" onclick='rtp_stop(); return false;'>[ %M_STOP_BROADCAST% ]</a>
			</div>
			<p></p>
      		<div id="rtp_status"></div>

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
		<p><textarea id="rtptemplate" style="height: 300px;">{rtptemplate}</textarea></p>
		<p style="float:right;"><a href="#" onclick="noWrap($('#rtptemplate')); return false;">%M_LINE_WRAPPING%</a></p>
		<p>
			<p><a class="buttonlink" href="#" onclick="var text = $('#rtptemplate').val(); SaveRTPSettings(text); return false;">[ %L_SAVE% ]</a></p>
			<span id="rtpsavestatus"></span>
		</p>
	</div>

</div>

</div>
