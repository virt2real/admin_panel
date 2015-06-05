<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		check_wlan();
		//scan_wlan();
	}


	function check_wlan(){
		$("#wlanstate").html('<img src="imgs/loader.gif">');
		$.get("modules/{module_name}/check.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#wlanstate").html(response);
			}
		});
	}

	function scan_wlan(){
		$("#scan_result").html('<img src="imgs/loader.gif">');
		$.get("modules/{module_name}/scan.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#scan_result").html(response);
			}
			if (status == "error") {
				$("#scan_result").html("%L_FAIL%");
			}
		});
	}

	function SaveSettings(text){

		$("#wpa_status").html('<img src="imgs/loader.gif">');

		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#wpa_status").html(response);
			}
			if (savestatus == "error") {
				$("#wpa_status").html("%L_FAIL%");
			}
		});
	}

	function RunConnect(state, iface) {

		$("#connect_status").html('<img src="imgs/loader.gif">');

		$.post("modules/{module_name}/connect.php?rnd=" + Math.random(), {state: state, iface:iface}, function(response, status, xhr) {
			if (status == "success") {
				$("#connect_status").html(response);
			}
			if (savestatus == "error") {
				$("#connect_status").html("%L_FAIL%");
			}
		});
	}


</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_CURRENT_STATUS%</a></h3>
	<div>
		<p> <a href="#" class="buttonlink" onclick='check_wlan(); return false;'>[ %M_UPDATE% ]</a>
		<div id="wlanstate"></div>
	</div>

	<h3><a href="#">%M_WLAN_SETTINGS%</a></h3>
	<div>

		<p class="bluetitle">%M_TURN_IT_ON_AND_OFF%</p>
		<p>
	        <p><input type="text" value="wlan0" id="wlan_iface"></p>

			<a class="buttonlink" href="#" onclick="var iface = $('#wlan_iface').val(); RunConnect(1, iface); return false;">[ %M_TURN_IT_ON% ]</a>
			<a class="buttonlink" href="#" onclick="var iface = $('#wlan_iface').val(); RunConnect(0, iface); return false;">[ %M_TURN_IT_OFF% ]</a>
		</p>

		<div id="connect_status"></div>

		<p>&nbsp;</p>

		<p class="bluetitle">%M_WLAN_AP_SETTINGS%</p>

		<p>
			<a class="buttonlink" href="#" onclick="var iface = $('#wlan_iface').val(); RunConnect(2, iface); return false;">[ %M_RECONNECT% ]</a>
		</p>

		<p><textarea id="wpa_config" style="width: 90%; height: 400px;">{wpa_config}</textarea></p>
		<p></p>
		<p><a class="buttonlink" href="#" onclick="var text = $('#wpa_config').val(); SaveSettings(text); return false;">[ %L_SAVE% ]</a></p>

		<div id="wpa_status"></div>
	</div>

	<h3><a href="#">%M_WLAN_SCAN%</a></h3>
	<div style="width:100%;">
		<p class="bluetitle">%M_FOUND_PILE_OF_WLANS%</a>  <a href="#" class="buttonlink" onclick='scan_wlan(); return false;'>[ %M_UPDATE% ]</a>
		<div id="scan_result" style="width:80%; overflow-y:auto;"></div>
	</div>


</div>

</div>
