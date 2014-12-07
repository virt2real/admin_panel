<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}

</script>

<script>
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


</div>

</div>
