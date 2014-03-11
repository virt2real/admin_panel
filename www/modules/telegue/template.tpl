<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>


<script>
	var alreadyloaded;

	var prevKeyUp;
	var prevKeyDown;

	var direction = 0;
	var olddirection = 0;

	var oldX, oldY;

	var speed = 63;
	NEUTRAL = 127;
	var speed1 = 0, speed2 = 0;

	var joystickactive = false;
	var analogX = NEUTRAL, analogY = NEUTRAL;
	var sendTimer;

	var aliveTimer;

	if(typeof(WebSocket)=="undefined") {
		alert("Your browser does not support WebSockets. Try to use Chrome or Safari.");
	} else {
		var ws = new WebSocket("ws://{deviceHost}:1083");

		ws.onmessage = function(event) {
			ParseCmd(event.data);
		}

		ws.onopen = function(event) {
			$("#connectionstatus").html("подключено");

			/* stop all */
			ParseSpeed();

		}

		ws.onerror = function(e) {
		};

		ws.onclose = function() { 
			$("#connectionstatus").html("отключено");
		};

	}

	$("#lightstate").buttonset();
	$("#light_on").click(function () {
		ws.send('{"cmd":"light","v":1}');
	});
	$("#light_off").click(function () {
		ws.send('{"cmd":"light","v":2}');
	});

	$("#speedslider").slider({
		value: 63,
		min: 0,
		max: 127,
		animate: true,
		orientation: "horizontal"
	});

	$("#speedslider").on("slidestop", function( event, ui ) {
		speed = $(this).slider("option", "value");
		$("#speed").val(speed);
		ParseSpeed();
	});

	$("#speedslider").on("slide", function( event, ui ) {
		speed = $(this).slider("option", "value");
		ParseSpeed();
	});              


	if (aliveTimer) clearInterval(aliveTimer);

	/* run alive timer */
	aliveTimer = setInterval("updateUptime()", 1000);

	if (sendTimer) clearInterval(sendTimer);

	/* run send command timer */
	sendTimer = setInterval("updateCommand()", 50);

	function updateUptime() {
		ws.send('{"cmd":"alive"}');
	}


	if (!alreadyloaded) {

	alreadyloaded = true;

		//if ((e.ctrlKey) && (e.keyCode == 82))

		$(document).keydown(function (e) {
			e.preventDefault();
			if (prevKeyDown == e.keyCode) return;
			prevKeyDown = e.keyCode;
			prevKeyUp = null;

			switch (e.keyCode) {
				case 38:
					/* UP */
					direction |= 1;
					break;
				case 40:
					/* DOWN */
					direction |= 2;
					break;
				case 37:
					/* LEFT */
					direction |= 4;
					break;
				case 39:
					/* RIGHT */
					direction |= 8;
					break;

				case 17:
					/* Ctrl */
					// toggle light
					ws.send('{"cmd":"light","v":0}');
					break;

				case 65:
					/* A */
					if (!speed) speed = $("#speed").val();
					speed -= 10;
					if (speed < 0) speed = 1;
					$("#speedslider").slider("option", "value", speed);
					ParseSpeed();
					break;
				case 83:
					/* S */
					if (!speed) speed = $("#speed").val();
					speed += 10;
					if (speed > 127) speed = 127;
					$("#speedslider").slider("option", "value", speed);
					ParseSpeed();
					break;
			}

			/* make speed1 and speed2 for wheels from pressed arrows */
			ParseSpeed();
		});

		$(document).keyup(function (e) {
			e.preventDefault();
			if (prevKeyUp == e.keyCode) return;
			prevKeyUp = e.keyCode;
			prevKeyDown = null;

			switch (e.keyCode) {
				case 38:
					/* UP */
					direction &= 0xFE;
					break;
				case 40:
					/* DOWN */
					direction &= 0xFD;
					break;
				case 37:
					/* LEFT */
					direction &= 0xFB;
					break;
				case 39:
					/* RIGHT */
					direction &= 0xF7;
					break;

			}

			/* make speed1 and speed2 for wheels from pressed arrows */
			ParseSpeed();
		});

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
				} else if (speed1 > NEUTRAL) speed1 = speed1 - speed; else speed1 = speed1 + speed;

				if (speed2 == NEUTRAL) {
					speed2 = speed2 + speed;
				} else if (speed2 > NEUTRAL) speed2 = speed2 - speed / 4; else speed2 = speed2 + speed / 4;
			}

			if (direction & 8) {
				if (speed1 == NEUTRAL) {
					speed1 = speed1 + speed;
				} else if (speed1 > NEUTRAL) speed1 = speed1 - speed / 4; else speed1 = speed1 + speed / 4;

				if (speed2 == NEUTRAL) {
					speed2 = speed2 - speed;
				} else if (speed2 > NEUTRAL) speed2 = speed2 - speed; else speed2 = speed2 + speed;
			}

			$("#direction").html(direction);
			ws.send('{"cmd":"drive","v1":' + parseInt(speed1) + ', "v2": ' + parseInt(speed2) + '}');

		}

		function ParseCmd(cmd) {
			var json = JSON.parse(cmd);
			$("#voltage").html(json.vol);
			$("#wifi").html(json.lnk + "/70 " + json.lev + " dBm");
		}


		function ParseAnalog (val1, val2) {

			ws.send('{"cmd":"adrive","v1":' + val1 + ', "v2": ' + val2 + '}');

		}


		$("#jsstick").mousedown(function(e){
			joystickactive = true;
		});

		$("#jsstick").mouseup(function(e){
			joystickactive = false;
			analogX = NEUTRAL;
			analogY = NEUTRAL;
			ParseAnalog(analogX, analogY);
		});

		$("#jsstick").mouseout(function(e){
			joystickactive = false;
			analogX = NEUTRAL;
			analogY = NEUTRAL;
			ParseAnalog(analogX, analogY);
		});

		$("#jsstick").mousemove(function(e){
			if (joystickactive) {
				var x = parseInt(e.pageX - $(this).offset().left);
				var y = parseInt(e.pageY - $(this).offset().top);

				if ( (x == oldX) && (y == oldY) ) return;

				oldX = x;
				oldY = y;

				analogX = x;
				analogY = y;

				$('#jsstickvalue').html("X : " + x + " Y : " + y);
			}
		});

		function updateCommand () {
			if (!joystickactive) return;
			$("#analogvalues").html("value: " + analogX + " " + analogY);
			ParseAnalog(analogX, analogY);
		}

	}
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
	swfobject.embedSWF("modules/mjpeg/camera.swf", "flashContent", "640", "480", swfVersionStr, "", flashvars, params, attributes);
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
			<div id="jsstick" style="width:255px;height:255px;background-color:#333333;"></div>
		</div>
		<p id="analogvalues"></p>

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
			<p>Пропорциональное управление производится с помощью мыши</p>
			<p>Нажать левую кнопку мыши на сером квадрате и водить курсором.</p>
			<p>Середина квадрата - нейтраль. Ось X - вперёд/назад, ось Y - влево/вправо</p>
			<p>При выходе за пределы квадрата - останов моторов</p>
			<p>&nbsp;</p>
			<p>Плеер видео (внизу страницы) будет показывать MJPEG поток, но для этого сначала надо запустить MJPEG сервер на порту 8888.</p>
			<p>Сделать это можно в разделе <a href="?mjpeg">MJPEG сервер</a></p>
			<p>Поток MJPEG довольно плотный, так что практическое применение нежелательно.</p>
		</td>
		</tr>
		</table>

		<p>&nbsp;</p>

		<div style="width:100%;text-align:center;">
			<div id="flashContent"><div>
		</div>

		<p>&nbsp;</p>

	</div>

</div>
