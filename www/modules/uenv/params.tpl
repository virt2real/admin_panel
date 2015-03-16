<script>
  $(function() {
    $( "#btn1" ).buttonset();
    $( "#btn2" ).buttonset();
    $( "#btn3" ).buttonset();
    $( "#btn4" ).buttonset();
    $( "#btn5" ).buttonset();
    $( "#btn6" ).buttonset();
    $( "#btn7" ).buttonset();
    $( "#btn8" ).buttonset();
    $( "#btn9" ).buttonset();
    $( "#btn10" ).buttonset();
    $( "#btn11" ).buttonset();
    $( "#btn12" ).buttonset();
    $( "#btn14" ).buttonset();
    $( "#btn15" ).buttonset();
  });
</script>

<script>
	function SaveChanges() {
		var result = "bootargs= ";

		if( $("#btn10v1").attr("checked") == "checked") result += "davinci_enc_mngr.ch0_output=COMPOSITE";
		if( $("#btn10v2").attr("checked") == "checked") result += "davinci_enc_mngr.ch0_output=LCD";
		result += " ";
		if( $("#btn11v1").attr("checked") == "checked") result += "davinci_enc_mngr.ch0_mode=PAL";
		if( $("#btn11v2").attr("checked") == "checked") result += "davinci_enc_mngr.ch0_mode=NTSC";
		result += " ";
		result += "davinci_display.cont2_bufsize=" + $("#bufval1").val();
		result += " ";
		result += "vpfe_capture.cont_bufoffset=" + $("#bufval2").val();
		result += " ";
		result += "vpfe_capture.cont_bufsize=" + $("#bufval3").val();
		result += " ";
		result += "video=" + $("#osdval").val();
		result += " ";
		result += "console=" + $("#conval1").val() + "," + $("#conval2").val();
		result += " ";
		result += "dm365_imp.oper_mode=" + $("#operval").val();
		result += " ";
		result += "vpfe_capture.interface=" + $("#vpfeval").val();
		result += " ";
		result += "mem=" + $("#memval").val();
		result += " ";
		result += "root=" + $("#rootval").val();
		result += " ";
		result += "rootdelay=" + $("#delayval").val();
		result += " ";
		result += "rootfstype=" + $("#fsval").val();
		result += " ";
		result += "coherent_pool=" + $("#coherent_pool").val();
		result += " ";
		if( $("#btn4v1").attr("checked") == "checked") result += "pwrled=on";
		if( $("#btn4v2").attr("checked") == "checked") result += "pwrled=off";
		result += " ";
		if( $("#btn6v1").attr("checked") == "checked") result += "redled=none";
		if( $("#btn6v2").attr("checked") == "checked") result += "redled=heartbeat";
		if( $("#btn6v3").attr("checked") == "checked") result += "redled=mmc0";
		if( $("#btn6v4").attr("checked") == "checked") result += "redled=mmc1";
		if( $("#btn6v5").attr("checked") == "checked") result += "redled=cpu0";
		result += " ";
		if( $("#btn5v1").attr("checked") == "checked") result += "greenled=none";
		if( $("#btn5v2").attr("checked") == "checked") result += "greenled=heartbeat";
		if( $("#btn5v3").attr("checked") == "checked") result += "greenled=mmc0";
		if( $("#btn5v4").attr("checked") == "checked") result += "greenled=mmc1";
		if( $("#btn5v5").attr("checked") == "checked") result += "greenled=cpu0";
		result += " ";
		if( $("#btn1v1").attr("checked") == "checked") result += "wifi=on";
		if( $("#btn1v2").attr("checked") == "checked") result += "wifi=off";
		result += " ";
		if( $("#btn14v1").attr("checked") == "checked") result += "usbwifi=on";
		if( $("#btn14v2").attr("checked") == "checked") result += "usbwifi=off";
		result += " ";
		result += "wifi_ssid=" + $("#wifi_ssid").val() + " ";
		result += " ";
		result += "wifi_pass=" + $("#wifi_pass").val() + " ";
		result += " ";
		if( $("#btn3v1").attr("checked") == "checked") result += "lan0=on";
		if( $("#btn3v2").attr("checked") == "checked") result += "lan0=off";
		result += " ";

		if ($("#lan0mac").val()) {
			result += "ks8851.hwaddr=" + $("#lan0mac").val().replace(/:/g,"");
			result += " ";
		}

		if( $("#btn15v1").attr("checked") == "checked") result += "lan1=on";
		if( $("#btn15v2").attr("checked") == "checked") result += "lan1=off";
		result += " ";

		if ($("#lan1mac").val()) {
			result += "lan1hwaddr=" + $("#lan1mac").val().replace(/:/g,"");
			result += " ";
		}

		result += "1wire=" + $("#w1val1").val();
		result += " ";
		result += "1wirepullup=" + $("#w1val2").val();
		result += " ";
		if( $("#btn8v1").attr("checked") == "checked") result += "spi0=on";
		if( $("#btn8v2").attr("checked") == "checked") result += "spi0=off";
		result += " ";
		if( $("#btn2v1").attr("checked") == "checked") result += "ap=on";
		if( $("#btn2v2").attr("checked") == "checked") result += "ap=off";
		result += " ";
		if( $("#btn12v1").attr("checked") == "checked") result += "uart1=on";
		if( $("#btn12v2").attr("checked") == "checked") result += "uart1=off";
		result += " ";
		if( $("#btn9v2").attr("checked") == "checked") result += "quiet ";

		var wdtval1 = parseInt($("#wdtval1").val());
		if (!wdtval1) wdtval1 = 60;
		result += "davinci_wdt.heartbeat=" + wdtval1 + " ";

		var ghidval = $("#ghidval").val();
		result += "ghid=" + ghidval + " ";

		if ($("#hdmi_voffset").val()) {
			result += "dm365_ccdc.top_offset=" + $("#hdmi_voffset").val().replace(/:/g,"");
			result += " ";
		}

		if( $("#btn7v1").attr("checked") == "checked") result += "camera=off";
		if( $("#btn7v2").attr("checked") == "checked") result += "camera=ov2643";
		if( $("#btn7v3").attr("checked") == "checked") result += "camera=ov5642";
		if( $("#btn7v4").attr("checked") == "checked") result += "camera=ov5640";

		result += "\n";
		result += "uenvcmd=echo Running uenvcmd ...; run loaduimage;bootm 0x82000000";
		SaveSettings(result);

	}
</script>


<h3><a href="#">%M_NETWORK_INTERFACES%</a></h3>
<div>

	<p><a class="buttonlink" href="#" onclick='SaveChanges(); return false;'>[ %L_SAVE% ]</a></p>
	<div class="uenv_status"></div>

	<p class="bluetitle">%M_WIFI%</p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_WIFI_MODULE%</div>
	<div id="btn1" style="display:inline;">
	    <input type="radio" id="btn1v1" name="btn1" {wifiselected1}><label for="btn1v1">%L_ON%</label>
	    <input type="radio" id="btn1v2" name="btn1" {wifiselected2}><label for="btn1v2">%L_OFF%</label>
	</div>
	<p class="bluetitle" style="display: inline; padding-left: 20px;"></p>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_USB_WIFI%</div>
	<div id="btn14" style="display:inline;">
	    <input type="radio" id="btn14v1" name="btn14" {usbwifiselected1}><label for="btn14v1">%L_ON%</label>
	    <input type="radio" id="btn14v2" name="btn14" {usbwifiselected2}><label for="btn14v2">%L_OFF%</label>
	</div>
	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_WLAN_AP%</div>
	<div id="btn2" style="display:inline;">
	    <input type="radio" id="btn2v1" name="btn2" {apselected1}><label for="btn2v1">%L_ON%</label>
	    <input type="radio" id="btn2v2" name="btn2" {apselected2}><label for="btn2v2">%L_OFF%</label>
	</div>
	<p class="bluetitle" style="display: inline; padding-left: 20px;">
	<p></p>


	<p class="bluetitle">%M_WLAN_OVERRIDE%</p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_WLAN_SSID%</div>
	<div style="display:inline;">
		<input type="text" id="wifi_ssid" value="{wifi_ssid}" style="width:100px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_WLAN_PASS%</div>
	<div style="display:inline;">
		<input type="text" id="wifi_pass" value="{wifi_pass}" style="width:100px;">
	</div>


	<p class="bluetitle">%M_LOCAL_NET%</p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_LAN%</div>
	<div id="btn3" style="display:inline;">
	    <input type="radio" id="btn3v1" name="btn3" {lanselected1}><label for="btn3v1">%L_ON%</label>
	    <input type="radio" id="btn3v2" name="btn3" {lanselected2}><label for="btn3v2">%L_OFF%</label>
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:100px; min-width:150px;">%M_LAN0MAC%</div>
	<div style="display:inline;">
		<input type="text" id="lan0mac" value="{lan0mac}" style="width:100px;" maxlength=17>
	</div>

	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_LAN1%</div>
	<div id="btn15" style="display:inline;">
	    <input type="radio" id="btn15v1" name="btn15" {lan1selected1}><label for="btn15v1">%L_ON%</label>
	    <input type="radio" id="btn15v2" name="btn15" {lan1selected2}><label for="btn15v2">%L_OFF%</label>
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:100px; min-width:150px;">%M_LAN1MAC%</div>
	<div style="display:inline;">
		<input type="text" id="lan1mac" value="{lan1mac}" style="width:100px;" maxlength=17>
	</div>
	<p></p>

</div>

<h3><a href="#">%L_PERIPHERY%</a></h3>

<div>

	<p><a href="#" class="buttonlink" onclick='SaveChanges(); return false;'>[ %L_SAVE% ]</a></p>
	<div class="uenv_status"></div>

	<p class="bluetitle">%M_LEDS%</p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_BLUE%</div>
	<div id="btn4" style="display:inline;">
	    <input type="radio" id="btn4v1" name="btn4" {blueselected1}><label for="btn4v1">%L_ON%</label>
	    <input type="radio" id="btn4v2" name="btn4" {blueselected2}><label for="btn4v2">%L_OFF%</label>
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_GREEN%</div>
	<div id="btn5" style="display:inline;">
	    <input type="radio" id="btn5v1" name="btn5" {greenselected1}><label for="btn5v1">%L_OFF%</label>
	    <input type="radio" id="btn5v2" name="btn5" {greenselected2}><label for="btn5v2">%M_HEARTBEAT%</label>
	    <input type="radio" id="btn5v3" name="btn5" {greenselected3}><label for="btn5v3">%M_MMC0%</label>
	    <input type="radio" id="btn5v4" name="btn5" {greenselected4}><label for="btn5v4">%M_MMC1%</label>
	    <input type="radio" id="btn5v5" name="btn5" {greenselected5}><label for="btn5v5">%M_CPU0%</label>
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_RED%</div>
	<div id="btn6" style="display:inline;">
	    <input type="radio" id="btn6v1" name="btn6" {redselected1}><label for="btn6v1">%L_OFF%</label>
	    <input type="radio" id="btn6v2" name="btn6" {redselected2}><label for="btn6v2">%M_HEARTBEAT%</label>
	    <input type="radio" id="btn6v3" name="btn6" {redselected3}><label for="btn6v3">%M_MMC0%</label>
	    <input type="radio" id="btn6v4" name="btn6" {redselected4}><label for="btn6v4">%M_MMC1%</label>
	    <input type="radio" id="btn6v5" name="btn6" {redselected5}><label for="btn6v5">%M_CPU0%</label>
	</div>

	<p class="bluetitle">%M_CONSOLE%</p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_DEVICE%</div>
	<div style="display:inline;">
		<input type="text" id="conval1" value="{conval1}" style="width:100px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_PARAMETERS%</div>
	<div style="display:inline;">
		<input type="text" id="conval2" value="{conval2}" style="width:100px;">
	</div>
	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_KERNEL_OUTPUT%</div>
	<div id="btn9" style="display:inline;">
	    <input type="radio" id="btn9v1" name="btn9" {quietselected1}><label for="btn9v1">%L_ON%</label>
	    <input type="radio" id="btn9v2" name="btn9" {quietselected2}><label for="btn9v2">%L_OFF%</label>
	</div>

	<p class="bluetitle">%M_PORTS%</p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_SPI0%</div>
	<div id="btn8" style="display:inline;">
	    <input type="radio" id="btn8v1" name="btn8" {spi0selected1}><label for="btn8v1">%L_ON%</label>
	    <input type="radio" id="btn8v2" name="btn8" {spi0selected2}><label for="btn8v2">%L_OFF%</label>
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_UART1%</div>
	<div id="btn12" style="display:inline;">
	    <input type="radio" id="btn12v1" name="btn12" {uart1selected1}><label for="btn12v1">%L_ON%</label>
	    <input type="radio" id="btn12v2" name="btn12" {uart1selected2}><label for="btn12v2">%L_OFF%</label>
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_1WIRE_PIN%</div>
	<div style="display:inline;">
		<input type="text" id="w1val1" value="{w1val1}" style="width:100px;">
	</div>
	<div style="display:inline; padding-left:20px; padding-right:20px;">%M_POWER_PIN%</div>
	<div style="display:inline;">
		<input type="text" id="w1val2" value="{w1val2}" style="width:100px;">
	</div>

	<p class="bluetitle">%M_WATCHDOG%</p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_WDTTIMEOUT%</div>
	<div style="display:inline;">
		<input type="text" id="wdtval1" value="{wdtval1}" style="width:100px;">
	</div>
	<p></p>

	<p class="bluetitle">%M_GHID_TITLE%</p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_GHID%</div>
	<div style="display:inline;">
		<input type="text" id="ghidval" value="{ghidval}" style="width:100px;">
	</div>
	<p></p>

</div>

<h3><a href="#">%M_KERNEL%</a></h3>

<div>

	<p><a href="#" class="buttonlink" onclick='SaveChanges(); return false;'>[ %L_SAVE% ]</a></p>
	<div class="uenv_status"></div>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_MEMORY%</div>
	<div style="display:inline;">
		<input type="text" id="memval" value="{memval}" style="width:100px;">
	</div>
	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_CONTINUOUS_POOL%</div>
	<div style="display:inline;">
		<input type="text" id="coherent_pool" value="{coherent_pool}" style="width:100px;">
	</div>
	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_ROOT_DIRECTORY%</div>
	<div style="display:inline;">
		<input type="text" id="rootval" value="{rootval}" style="width:100px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_BOOT_TIMEOUT%</div>
	<div style="display:inline;">
		<input type="text" id="delayval" value="{delayval}" style="width:100px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_FS_TYPE%</div>
	<div style="display:inline;">
		<input type="text" id="fsval" value="{fsval}" style="width:100px;">
	</div>

</div>

<h3><a href="#">%L_VIDEO%</a></h3>

<div>

	<p><a href="#" class="buttonlink" onclick='SaveChanges(); return false;'>[ %L_SAVE% ]</a></p>
	<div class="uenv_status"></div>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%L_CAMERAS%</div>
	<div id="btn7" style="display:inline;">
	    <input type="radio" id="btn7v1" name="btn7" {cameraselected1}><label for="btn7v1">%L_OFF%</label>
	    <input type="radio" id="btn7v2" name="btn7" {cameraselected2}><label for="btn7v2">%M_OV2643%</label>
	    <input type="radio" id="btn7v3" name="btn7" {cameraselected3}><label for="btn7v3">%M_OV5642%</label>
	    <input type="radio" id="btn7v4" name="btn7" {cameraselected4}><label for="btn7v4">%M_OV5640%</label>
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_VIDEO_OUT%</div>
	<div id="btn10" style="display:inline;">
	    <input type="radio" id="btn10v1" name="btn10" {ch0val1}><label for="btn10v1">%M_COMPOSITE%</label>
	    <input type="radio" id="btn10v2" name="btn10" {ch0val2}><label for="btn10v2">%M_LCD%</label>
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_VIDEO_MODE%</div>
	<div id="btn11" style="display:inline;">
	    <input type="radio" id="btn11v1" name="btn11" {btn11val1}><label for="btn11v1">%M_PAL%</label>
	    <input type="radio" id="btn11v2" name="btn11" {btn11val2}><label for="btn11v2">%M_NTSC%</label>
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_OSD%</div>
	<div style="display:inline;">
		<input type="text" id="osdval" value="{osdval}" style="width:350px;">
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_CAPTURE_INTERFACE%</div>
	<div style="display:inline;">
		<input type="text" id="vpfeval" value="{vpfeval}" style="width:100px;">
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_IPIPE_MODE%</div>
	<div style="display:inline;">
		<input type="text" id="operval" value="{operval}" style="width:100px;">
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_CONTSIZE_BUFFER_2%</div>
	<div style="display:inline;">
		<input type="text" id="bufval1" value="{bufval1}" style="width:100px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_BUFF_OFFSET%</div>
	<div style="display:inline;">
		<input type="text" id="bufval2" value="{bufval2}" style="width:100px;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_CONTSIZE_BUFFER%</div>
	<div style="display:inline;">
		<input type="text" id="bufval3" value="{bufval3}" style="width:100px;">
	</div>

	<p class="bluetitle">%M_HDMI%</p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">%M_HDMI_VOFFSET%</div>
	<div style="display:inline;">
		<input type="text" id="hdmi_voffset" value="{hdmi_voffset}" style="width:100px;">
	</div>

</div>
