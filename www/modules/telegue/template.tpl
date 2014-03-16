<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script type="text/javascript" src="/js/swfobject.js"></script>
<script type="text/javascript">
	var swfVersionStr = "9.0.0";
	var flashvars = {};
	flashvars.host = "{deviceHost}";
	flashvars.file = "/";
	flashvars.port = 8888;
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
	swfobject.embedSWF("modules/mjpeg/camera.swf", "flashContent", "480", "390", swfVersionStr, "", flashvars, params, attributes);
</script>

<script>

	/* flag for prevent double connections */
	var alreadyloaded;

	/* if opened second time - redirect on direct module link */
	if (alreadyloaded) document.location.href = "?{module_name}";
	alreadyloaded = true;

	/* direction value for keyboard control */
	var direction = 0;
	var olddirection = 0;

	/* old key value for prevent keyboard control repeat commands */
	var prevKeyUp;
	var prevKeyDown;

	/* old axis values for prevent repeat commands */
	var oldX, oldY;
	var oldPanX, oldPanY;

	/* neutral analog position */
	var NEUTRAL = 127;

	/* speed value for keyboard control */
	var speed = parseInt(NEUTRAL / 2);

	/* speed values */
	var speed1 = 0, speed2 = 0;

	/* values for analog control */
	var pantilt_x = NEUTRAL, pantilt_y = NEUTRAL;
	var analogX = NEUTRAL, analogY = NEUTRAL;

	/* flags for activate analog control */
	var joystickactive = false;
	var pantiltactive = false;

	/* timer for sending commands */
	var sendTimer;

	/* timer for check alive */
	var aliveTimer;


	/*************************************************************************
	websockets
	*************************************************************************/

	if(typeof(WebSocket)=="undefined") {
		/* no websockets in this browser */
		alert("Your browser does not support WebSockets. Try to use Chrome or Safari.");

	} else {

		/* start websockets connection */
		var ws = new WebSocket("ws://{deviceHost}:1083");

		ws.onmessage = function(event) {
			ParseCmd(event.data);
		}

		ws.onopen = function(event) {
			$("#connectionstatus").html("подключено");

			/* stop all motors */
			ParseSpeed();
		}

		ws.onerror = function(e) {
			$("#connectionstatus").html("ошибка");
		};

		ws.onclose = function() {
			$("#connectionstatus").html("отключено");
		};
	}


	/* make UI elements*/

	/*************************************************************************
	light button
	*************************************************************************/
	$("#lightstate").buttonset();

	$("#light_on").click(function () {
		ws.send('{"cmd":"light","v1":1}');
	});

	$("#light_off").click(function () {
		ws.send('{"cmd":"light","v1":2}');
	});

	/**************************************************************************
	speed slider
	**************************************************************************/
	$("#speedslider").slider({
		value: 63,
		min: 0,
		max: 127,
		animate: true,
		orientation: "horizontal"
	});

	$("#speedslider").on("slide", function( event, ui ) {
		speed = $(this).slider("option", "value");
		$("#speed").val(speed);
		ParseSpeed();
	});

	/**************************************************************************
	camera tilt slider
	**************************************************************************/
	$("#cameravslider").slider({
		value: 90,
		min: 0,
		max: 180,
		animate: true,
		orientation: "vertical"
	});

	$("#cameravslider").on("slidestop", function( event, ui ) {
		pantilt_y = 180 - $(this).slider("option", "value");
		ParsePanTilt(pantilt_x, pantilt_y);
	});


	/**************************************************************************
	camera pan slider
	**************************************************************************/
	$("#camerahslider").slider({
		value: 90,
		min: 0,
		max: 180,
		animate: true,
		orientation: "horizontal"
	});

	$("#camerahslider").on("slidestop", function( event, ui ) {
		pantilt_x = $(this).slider("option", "value");
		ParsePanTilt(pantilt_x, pantilt_y);
	});


	/**************************************************************************
	parse functions
	**************************************************************************/

	/* parse pan&tilt analog commands */
	function ParsePanTilt(x, y) {
		var json = new Object();
		json.cmd = "pantilt";
		json.v1 = parseInt(x);
		json.v2 = parseInt(y);
		ws.send(JSON.stringify(json));
	}

	/* make speed values from pressed keys */
	function ParseSpeed () {
		speed1 = NEUTRAL;
		speed2 = NEUTRAL;

		if (direction & 1) {
			speed1 = NEUTRAL + speed;
			speed2 = NEUTRAL + speed;
		}

		if (direction & 2) {
			speed1 = NEUTRAL - speed;
			speed2 = NEUTRAL - speed;
		}

		if (direction & 4) {
			if (speed1 == NEUTRAL) {
				speed1 = speed1 - speed;
			} else
			if (speed1 > NEUTRAL)
				speed1 = speed1 - speed;
			else speed1 = speed1 + speed;

			if (speed2 == NEUTRAL) {
				speed2 = speed2 + speed;
			} else
			if (speed2 > NEUTRAL)
				speed2 = speed2 - speed / 4;
			else speed2 = speed2 + speed / 4;
		}

		if (direction & 8) {
			if (speed1 == NEUTRAL) {
				speed1 = speed1 + speed;
			} else
			if (speed1 > NEUTRAL)
				speed1 = speed1 - speed / 4;
			else speed1 = speed1 + speed / 4;

			if (speed2 == NEUTRAL) {
				speed2 = speed2 - speed;
			} else
			if (speed2 > NEUTRAL)
				speed2 = speed2 - speed;
			else speed2 = speed2 + speed;
		}

		/* show direction value */
		$("#direction").html(direction);

		/* send JSON command to board */
		var json = new Object();
		json.cmd = "drive";
		json.v1 = parseInt(speed1);
		json.v2 = parseInt(speed2);
		ws.send(JSON.stringify(json));
	}

	/* parse "analog" values from virtual JS joystick */
	function ParseAnalog(val1, val2) {
		var json = new Object();
		json.cmd = "adrive";
		json.v1 = val1;
		json.v2 = val2;
		ws.send(JSON.stringify(json));
	}


	/* parse incoming status commands from board */
	function ParseCmd(cmd) {
		var json = JSON.parse(cmd);
		$("#voltage").html(json.vol);
		$("#wifi").html(json.lnk + "/70 " + json.lev + " dBm");
	}


	/**************************************************************************
	UI functions
	**************************************************************************/

	/* show flash video player in dialog window */
	function ShowVideoWindow() {
		$("#videowindow").dialog({
			resizable: false,
			height:450,
			width: 520,
			modal: false,
		});
	}

	/* keyboard pressed */
	$(document).keydown(function (e) {
		e.preventDefault(); /* prevent window scroll */
		if (prevKeyDown == e.keyCode) return;
		prevKeyDown = e.keyCode;
		prevKeyUp = null;

		switch (e.keyCode) {

			case 38: direction |= 1; /* UP */
			break;
			case 40: direction |= 2; /* DOWN */
			break;
			case 37: direction |= 4; /* LEFT */
			break;
			case 39: direction |= 8; /* RIGHT */
			break;
			case 17: ws.send('{"cmd":"light","v1":0}'); /* Ctrl - toggle light */
			break;
			case 65: /* A */
				if (!speed) speed = $("#speed").val();
				speed -= 10;
				if (speed < 0) speed = 1;
				$("#speedslider").slider("option", "value", speed);
				ParseSpeed();
			break;
			case 83: /* S */
				if (!speed) speed = $("#speed").val();
				speed += 10;
				if (speed > 127) speed = 127;
				$("#speedslider").slider("option", "value", speed);
				ParseSpeed();
			break;

			case 81:
				// camera move fixed step down
				ws.send('{"cmd":"cam","v1":0}');
			break;
			case 87:
				// camera move fixed step up
				ws.send('{"cmd":"cam","v1":1}');
			break;
			case 69:
				// camera move fixed step left
				ws.send('{"cmd":"cam","v1":2}');
			break;
			case 82:
				// camera move fixed step right
				ws.send('{"cmd":"cam","v1":3}');
			break;
		}

		/* make speed1 and speed2 for wheels from pressed arrows */
		ParseSpeed();
	});

	$(document).keyup(function (e) {
		e.preventDefault(); /* prevent window scroll */
		if (prevKeyUp == e.keyCode) return;
		prevKeyUp = e.keyCode;
		prevKeyDown = null;

		switch (e.keyCode) {
			case 38: direction &= 0xFE; /* UP */
			break;
			case 40: direction &= 0xFD; /* DOWN */
			break;
			case 37: direction &= 0xFB; /* LEFT */
			break;
			case 39: direction &= 0xF7; /* RIGHT */
			break;
		}

		/* make speed1 and speed2 for wheels from pressed arrows */
		ParseSpeed();
	});


	/* Mouse movement functions */

	/* mouse button pressed, left or right/middle */
	$("#jsstick").mousedown(function(e){
		if (e.which == 1)
			joystickactive = true;
		else
			pantiltactive = true;
	});

	/* mouse button unpressed */
	$("#jsstick").mouseup(function(e){		if (joystickactive) {
			joystickactive = false;
			analogX = NEUTRAL;
			analogY = NEUTRAL;
			ParseAnalog(analogX, analogY);
		}
		if (pantiltactive) {
			pantiltactive = false;
		}
	});

	/* mouse cursor leave a virtual joystick area */
	$("#jsstick").mouseout(function(e){
		if (joystickactive) {
			joystickactive = false;
			analogX = NEUTRAL;
			analogY = NEUTRAL;
			ParseAnalog(analogX, analogY);
		}
		if (pantiltactive) {
			pantiltactive = false;
		}
	});

	/* mouse move */
	$("#jsstick").mousemove(function(e){

		/* moves with left button pressed */
		if (joystickactive) {
			var x = parseInt(e.pageX - $(this).offset().left);
			var y = parseInt(e.pageY - $(this).offset().top);

			analogX = x;
			analogY = y;

			var speed_x = Math.abs(analogX - NEUTRAL);
			var speed_y = Math.abs(analogY - NEUTRAL);

			$("#speedslider").slider("option", "value", (speed_x > speed_y) ? speed_x : speed_y );
			speed = (speed_x > speed_y) ? speed_x : speed_y;

			$('#jsstickvalue').html("X : " + x + " Y : " + y);

		}
		if (pantiltactive)  {

			/* moves with right/middle button pressed */
			var x = parseInt(e.pageX - $(this).offset().left);
			var y = parseInt(e.pageY - $(this).offset().top);

			pantilt_x = x / 255 * 180;
			pantilt_y = y / 255 * 180;

			$("#cameravslider").slider("option", "value", 180 - pantilt_y);
			$("#camerahslider").slider("option", "value", pantilt_x);

			$('#jsstickvalue').html("pan&tilt X : " + x + " Y : " + y);
		}
	});


	/**************************************************************************
	timers
	**************************************************************************/

	/* run alive timer */
	if (aliveTimer) clearInterval(aliveTimer);
	aliveTimer = setInterval("updateUptime()", 1000);

	/* run send command timer */
	if (sendTimer) clearInterval(sendTimer);
	sendTimer = setInterval("updateCommand()", 50);

	/* send alive command to board */
	function updateUptime() {
		ws.send('{"cmd":"alive"}');
	}

	/* check current analog values for move or pan&tilt */
	function updateCommand () {
		if (joystickactive) {
			if ( (analogX != oldX) || (analogY != oldY) ) {
				ParseAnalog(analogX, analogY);
				oldX = analogX;
				oldY = analogY;
			}
		}
		if (pantiltactive) {
			if ( (pantilt_x != oldPanX) || (pantilt_y != oldPanY) ) {
				ParsePanTilt(pantilt_x, pantilt_y);
				oldPanX = pantilt_x;
				oldPanY = pantilt_y;
			}
		}
	}

</script>

<style>
#speedslider {
  width: 250px;
}
</style>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Telegue</a></h3>
	<div>

		<table width="100%">
		<tr valign="top">
		<td>

		<div><span class="bluetitle">Подключение:</span> <span id="connectionstatus"></span></div>
		<div><span class="bluetitle">Напряжение:</span> <span id="voltage"></span></div>
		<div><span class="bluetitle">Сигнал Wi-Fi:</span> <span id="wifi"></span></div>

		<div><span class="bluetitle">Скорость:</span> <input type="text" id="speed" value="" style="background: transparent; width: 20px; border: none; color: #ffffff;"></div>
		<div><div id="speedslider"></div></div>

		<p></p>

		<div><span class="bluetitle">Свет:</span> <span id="light"></span></div>
		<p><div id="lightstate">
			<input type="radio" id="light_on" name="radio"><label for="light_on">вкл</label>
			<input type="radio" id="light_off" name="radio" checked="checked"><label for="light_off">выкл</label>
		</div>
		</p>

		<p></p>

		<div><span class="bluetitle">Направление:</span> <span id="direction"></span></div>

		<p></p>

		<div class="bluetitle">Пропорциональное управление: <span id="jsstickvalue" class="graytext">&nbsp;</span></div>

		<p></p>

		<div>
			<div id="jsstick" style="width:255px;height:255px;background-color:#333333; clear: right; float: left;"></div>
			<div style="margin-left:40px; width:100px; clear: right; float: left; text-align:center;">
				<div id="cameravslider" style="height:180px; margin-bottom:20px;"></div>
				<div id="camerahslider" style="width:100px;"></div>
			</div>
		</div>

		<p style="clear:both;">&nbsp;</p>

		<div>
			<p><a href="#" onclick='$.post("modules/mjpeg/run.php?rnd=" + Math.random(), {port:8888, quality: 40}, null); return false;'>Запустить MJPEG сервер</a></p>
			<p><a href="#" onclick='ShowVideoWindow(); return false;'>Показать плеер MJPEG</a></p>
		</div>

		</td>
		<td class="graytext" width="300">
			<p class="bluetitle">Описание</p>
			<p>Дискретное управление производится с клавиатуры</p>
			<p>Клавиши:</p>
			<p>Ввер, вниз, влево, вправо - соотвественно</p>
			<p>"A" - уменьшить скорость</p>
			<p>"S" - увеличить скорость</p>
			<p>"Ctrl" - переключение состояния фар</p>
			<p>&nbsp;</p>
			<p>Пропорциональное управление производится с помощью мыши.</p>
			<p>Нажать левую кнопку мыши на сером квадрате и водить курсором.</p>
			<p>Пропорциональное управление приводами камеры производится тоже с помощью мыши, либо с помощью ползунков.</p>
			<p>Нажать правую кнопку мыши на сером квадрате и водить курсором.</p>

			<p>Середина квадрата - нейтраль. Ось X - вперёд/назад, ось Y - влево/вправо</p>
			<p>При выходе за пределы квадрата - останов моторов</p>
			<p>&nbsp;</p>
			<p>Плеер видео будет показывать MJPEG поток, но для этого сначала надо запустить MJPEG сервер на порту 8888.</p>
			<p>Сделать это можно в разделе <a href="?mjpeg">MJPEG сервер</a> или на этой странице, нажав ссылку "запустить MJPEG сервер"</p>
			<p>Поток MJPEG довольно плотный, так что практическое применение нежелательно.</p>
		</td>
		</tr>
		</table>

		<p>&nbsp;</p>

		<div id="videowindow" title="MJPEG stream" style="display:none;">
			<div id="flashContent"><div>
		</div>

		<p>&nbsp;</p>

	</div>

</div>
