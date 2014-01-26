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
		if( $("#btn3v1").attr("checked") == "checked") result += "lan0=on";
		if( $("#btn3v2").attr("checked") == "checked") result += "lan0=off";
		result += " ";
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
		if( $("#btn9v2").attr("checked") == "checked") result += "quiet";
		result += " ";
		if( $("#btn7v1").attr("checked") == "checked") result += "camera=off";
		if( $("#btn7v2").attr("checked") == "checked") result += "camera=ov2643";

		result += "\n";
		result += "uenvcmd=echo Running uenvcmd ...; run loaduimage;bootm 0x82000000";
		SaveSettings(result);

	}
</script>


<h3><a href="#">Сетевые интерфейсы</a></h3>
<div>

	<p><a class="buttonlink" href="#" onclick='SaveChanges(); return false;'>[ Сохранить ]</a></p>
	<div class="uenv_status"></div>

	<p class="bluetitle">Беспроводная связь</p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">V2R Wi-Fi модуль </div>
	<div id="btn1" style="display:inline;">
	    <input type="radio" id="btn1v1" name="btn1" {wifiselected1}><label for="btn1v1">Вкл</label>
	    <input type="radio" id="btn1v2" name="btn1" {wifiselected2}><label for="btn1v2">Выкл</label>
	</div>
	<p class="bluetitle" style="display: inline; padding-left: 20px;"></p>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">USB Wi-Fi модуль </div>
	<div id="btn14" style="display:inline;">
	    <input type="radio" id="btn14v1" name="btn14" {usbwifiselected1}><label for="btn14v1">Вкл</label>
	    <input type="radio" id="btn14v2" name="btn14" {usbwifiselected2}><label for="btn14v2">Выкл</label>
	</div>
	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">Точка доступа </div>
	<div id="btn2" style="display:inline;">
	    <input type="radio" id="btn2v1" name="btn2" {apselected1}><label for="btn2v1">Вкл</label>
	    <input type="radio" id="btn2v2" name="btn2" {apselected2}><label for="btn2v2">Выкл</label>
	</div>
	<p class="bluetitle" style="display: inline; padding-left: 20px;">
	<p></p>

	<p class="bluetitle">Локальная сеть</p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">LAN</div>
	<div id="btn3" style="display:inline;">
	    <input type="radio" id="btn3v1" name="btn3" {lanselected1}><label for="btn3v1">Вкл</label>
	    <input type="radio" id="btn3v2" name="btn3" {lanselected2}><label for="btn3v2">Выкл</label>
	</div>

</div>

<h3><a href="#">Периферия</a></h3>

<div>

	<p><a href="#" class="buttonlink" onclick='SaveChanges(); return false;'>[ Сохранить ]</a></p>
	<div class="uenv_status"></div>

	<p class="bluetitle">Светодиоды</p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">Синий</div>
	<div id="btn4" style="display:inline;">
	    <input type="radio" id="btn4v1" name="btn4" {blueselected1}><label for="btn4v1">Вкл</label>
	    <input type="radio" id="btn4v2" name="btn4" {blueselected2}><label for="btn4v2">Выкл</label>
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">Зелёный </div>
	<div id="btn5" style="display:inline;">
	    <input type="radio" id="btn5v1" name="btn5" {greenselected1}><label for="btn5v1">Выкл</label>
	    <input type="radio" id="btn5v2" name="btn5" {greenselected2}><label for="btn5v2">heartbeat</label>
	    <input type="radio" id="btn5v3" name="btn5" {greenselected3}><label for="btn5v3">mmc0</label>
	    <input type="radio" id="btn5v4" name="btn5" {greenselected4}><label for="btn5v4">mmc1</label>
	    <input type="radio" id="btn5v5" name="btn5" {greenselected5}><label for="btn5v5">cpu0</label>
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">Красный </div>
	<div id="btn6" style="display:inline;">
	    <input type="radio" id="btn6v1" name="btn6" {redselected1}><label for="btn6v1">Выкл</label>
	    <input type="radio" id="btn6v2" name="btn6" {redselected2}><label for="btn6v2">heartbeat</label>
	    <input type="radio" id="btn6v3" name="btn6" {redselected3}><label for="btn6v3">mmc0</label>
	    <input type="radio" id="btn6v4" name="btn6" {redselected4}><label for="btn6v4">mmc1</label>
	    <input type="radio" id="btn6v5" name="btn6" {redselected5}><label for="btn6v5">cpu0</label>
	</div>

	<p class="bluetitle">Консоль</p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">Устройство</div>
	<div style="display:inline;">
		<input type="text" id="conval1" value="{conval1}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">Параметры</div>
	<div style="display:inline;">
		<input type="text" id="conval2" value="{conval2}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>
	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">Вывод ядра</div>
	<div id="btn9" style="display:inline;">
	    <input type="radio" id="btn9v1" name="btn9" {quietselected1}><label for="btn9v1">Вкл</label>
	    <input type="radio" id="btn9v2" name="btn9" {quietselected2}><label for="btn9v2">Выкл</label>
	</div>

	<p class="bluetitle">Порты</p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">SPI0</div>
	<div id="btn8" style="display:inline;">
	    <input type="radio" id="btn8v1" name="btn8" {spi0selected1}><label for="btn8v1">Вкл</label>
	    <input type="radio" id="btn8v2" name="btn8" {spi0selected2}><label for="btn8v2">Выкл</label>
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">UART1</div>
	<div id="btn12" style="display:inline;">
	    <input type="radio" id="btn12v1" name="btn12" {uart1selected1}><label for="btn12v1">Вкл</label>
	    <input type="radio" id="btn12v2" name="btn12" {uart1selected2}><label for="btn12v2">Выкл</label>
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">1-wire пин</div>
	<div style="display:inline;">
		<input type="text" id="w1val1" value="{w1val1}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>
	<div style="display:inline; padding-left:20px; padding-right:20px;"> пин питания</div>
	<div style="display:inline;">
		<input type="text" id="w1val2" value="{w1val2}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>

</div>

<h3><a href="#">Ядро</a></h3>

<div>

	<p><a href="#" class="buttonlink" onclick='SaveChanges(); return false;'>[ Сохранить ]</a></p>
	<div class="uenv_status"></div>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">Память</div>
	<div style="display:inline;">
		<input type="text" id="memval" value="{memval}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>
	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">Непрерывный пул</div>
	<div style="display:inline;">
		<input type="text" id="coherent_pool" value="{coherent_pool}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>
	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">Корневой раздел</div>
	<div style="display:inline;">
		<input type="text" id="rootval" value="{rootval}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">Пауза загрузки</div>
	<div style="display:inline;">
		<input type="text" id="delayval" value="{delayval}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">Тип фс</div>
	<div style="display:inline;">
		<input type="text" id="fsval" value="{fsval}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>

</div>

<h3><a href="#">Видео</a></h3>

<div>

	<p><a href="#" class="buttonlink" onclick='SaveChanges(); return false;'>[ Сохранить ]</a></p>
	<div class="uenv_status"></div>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">Камера</div>
	<div id="btn7" style="display:inline;">
	    <input type="radio" id="btn7v1" name="btn7" {cameraselected1}><label for="btn7v1">Выкл</label>
	    <input type="radio" id="btn7v2" name="btn7" {cameraselected2}><label for="btn7v2">OV2643</label>
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">Видеовыход</div>
	<div id="btn10" style="display:inline;">
	    <input type="radio" id="btn10v1" name="btn10" {ch0val1}><label for="btn10v1">Композит</label>
	    <input type="radio" id="btn10v2" name="btn10" {ch0val2}><label for="btn10v2">LCD</label>
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">Видеорежим</div>
	<div id="btn11" style="display:inline;">
	    <input type="radio" id="btn11v1" name="btn11" {btn11val1}><label for="btn11v1">PAL</label>
	    <input type="radio" id="btn11v2" name="btn11" {btn11val2}><label for="btn11v2">NTSC</label>
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">OSD</div>
	<div style="display:inline;">
		<input type="text" id="osdval" value="{osdval}" style="width:350px; background-color:#b0b0b0; border: none;">
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">Интерфейс захвата</div>
	<div style="display:inline;">
		<input type="text" id="vpfeval" value="{vpfeval}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">Режим IPIPE</div>
	<div style="display:inline;">
		<input type="text" id="operval" value="{operval}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>

	<p></p>

	<div style="display:inline-block; padding-left:40px; min-width:150px;">Буфер cont2_bufsize</div>
	<div style="display:inline;">
		<input type="text" id="bufval1" value="{bufval1}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">bufoffset</div>
	<div style="display:inline;">
		<input type="text" id="bufval2" value="{bufval2}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>
	<p></p>
	<div style="display:inline-block; padding-left:40px; min-width:150px;">Буфер cont_bufsize</div>
	<div style="display:inline;">
		<input type="text" id="bufval3" value="{bufval3}" style="width:100px; background-color:#b0b0b0; border: none;">
	</div>

</div>
