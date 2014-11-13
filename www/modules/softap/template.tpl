<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>
<script>
	function SaveSettings(){
		$("#softap_status").html('<img src="imgs/loader.gif">');

		var ssid = $("#ssid_value").val();
		var passphrase = $("#passphrase_value").val();

		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {ssid: ssid, passphrase: passphrase}, function(response, status, xhr) {
			if (status == "success") {
				$("#softap_status").html(response);
			}
			if (savestatus == "error") {
				$("#softap_status").html("%L_FAIL%");
			}
		});
	}

	function SaveSettings2(text){

		$("#softap_status2").html('<img src="imgs/loader.gif">');

		$.post("modules/{module_name}/save2.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#softap_status2").html(response);
			}
			if (savestatus == "error") {
				$("#softap_status2").html("%L_FAIL%");
			}
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_WLAN_AP%</a></h3>
	<div>

		<p>%M_SETUP_WLAN%</p>
		<p>%M_GOTO_UENV%</p>
		<p>%M_GOTO_NETWORK%</p>

	</div>

	<h3><a href="#">%M_WIFI_MODULE_CONFIG%</a></h3>
	<div>

	        <p>%M_SOFTAP_CONFIG%</p>

		<p class="bluetitle">%M_PARAMETERS%</p>

		<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_NETWORK_NAME%</div>
		<div style="display:inline;">
			<input type="text" id="ssid_value" value="{ssid_value}" style="width:100px;">
		</div>
		<p></p>
		<div style="display:inline-block; padding-left:40px; min-width:150px;">%L_LOGIN_PASS%</div>
		<div style="display:inline;">
			<input type="text" id="passphrase_value" value="{passphrase_value}" style="width:100px;">
		</div>

		<p><a class="buttonlink" href="#" onclick='SaveSettings(); return false;'>[ %L_SAVE% ]</a></p>
		<div id="softap_status"></div>

	</div>

	<h3><a href="#">%M_USB_WIFI_CONFIG%</a></h3>
	<div>

	        <p>%M_HOSTAPD_CONF%</p>

		<p class="bluetitle">%M_PARAMETERS%</p>

		<p><textarea id="hostapd" style="width: 90%; height: 300px;">{hostapd}</textarea></p>
		<p>
			<p><a class="buttonlink" href="#" onclick="var text = $('#hostapd').val(); SaveSettings2(text); return false;">[ %L_SAVE% ]</a></p>
		</p>


		<div id="softap_status2"></div>

	</div>


</div>

</div>
