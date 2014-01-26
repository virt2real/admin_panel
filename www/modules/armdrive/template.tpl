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
	var part = 0;
	var speed = 50;

	var aliveTimer;

	if(typeof(WebSocket)=="undefined") {
		alert("Your browser does not support WebSockets. Try to use Chrome or Safari.");
	} else {
		var ws = new WebSocket("ws://{deviceHost}:8888");

		ws.onmessage = function(event) {
			try {
				var json = JSON.parse(event.data);
		
				$("#speed").val(json.s);
				speed = json.s;
				$("#speedslider").slider("option", "value", speed);
				$("#direction").html(json.d);
				$("#voltage").html(json.v);

				if (json.l == 1) {
					$("#light_off").attr("checked", " ");
					$("#light_on").attr("checked", "checked");
					$("#light_on").button("refresh");
					$("#light_off").button("refresh");
				} else { 
					$("#light_on").attr("checked", "");
					$("#light_off").attr("checked", "checked");
					$("#light_on").button("refresh");
					$("#light_off").button("refresh");
				}
				

				switch (json.p) {
					case 0:
						$(".allparts").css("display", "none");
						$("#part1").css("display", "block");
						break;
					case 1:
						$(".allparts").css("display", "none");
						$("#part2").css("display", "block");
						$("#part3").css("display", "block");
						break;
					case 2:
						$(".allparts").css("display", "none");
						$("#part4").css("display", "block");
						$("#part6").css("display", "block");
						break;
					case 3:
						$(".allparts").css("display", "none");
						$("#part5").css("display", "block");
						$("#part6").css("display", "block");
						break;
				}

			} catch (err) {}
		}

		ws.onopen = function(event) {
			$("#connectionstatus").html("подключено");

			/* stop all */
			ws.send('{"act":"d","v":0}');

		}

		ws.onerror = function(e) {
		};

		ws.onclose = function() { 
			$("#connectionstatus").html("отключено");
		};

	}

	$("#lightstate").buttonset();
	$("#light_on").click(function () {
		ws.send('{"act":"l","v":1}');
	});
	$("#light_off").click(function () {
		ws.send('{"act":"l","v":2}');
	});

	$("#speedslider").slider({
		value: 0,
		min: 0,
		max: 100,
		animate: true,
		orientation: "horizontal"
	});

	$("#speedslider").on("slidestop", function( event, ui ) {
		speed = $(this).slider("option", "value");
		$("#speed").val(speed);
		ws.send('{"act":"s","v":' + speed + '}');
	});

	$("#speedslider").on("slide", function( event, ui ) {
		speed = $(this).slider("option", "value");
	});



	if (aliveTimer) clearInterval(aliveTimer);

	/* run alive timer */
	aliveTimer = setInterval("updateUptime()", 1000);

	function updateUptime() {
		ws.send('{"act":"a"}');
	}


	if (!alreadyloaded) {

	alreadyloaded = true;

		//if ((e.ctrlKey) && (e.keyCode == 82))

		$(document).keydown(function (e) {
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

				case 81:
					/* Q */
					ws.send('{"act":"p","v":0}');
					break;
				case 87:
					/* W */
					ws.send('{"act":"p","v":1}');
					break;
				case 69:
					/* E */
					ws.send('{"act":"p","v":2}');
					break;

				case 82:
					/* R */
					ws.send('{"act":"p","v":3}');
					break;

				case 17:
					/* Ctrl */
					ws.send('{"act":"l"}');
					break;

				case 65:
					/* A */
					if (!speed) speed = $("#speed").val();
					speed -= 10;
					if (speed < 0) speed = 1;
					ws.send('{"act":"s","v":' + speed + '}');
					break;
				case 83:
					/* S */
					if (!speed) speed = $("#speed").val();
					speed += 10;
					if (speed > 100) speed = 100;
					ws.send('{"act":"s","v":' + speed + '}');
					break;
			}

			if (direction == olddirection) return;
			olddirection = direction;

			ws.send('{"act":"d","v":' + direction + '}');
		});

		$(document).keyup(function (e) {
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

			if (direction == olddirection) return;
			olddirection = direction;

			ws.send('{"act":"d","v":' + direction + '}');

		});


		function UpdatePart(part) {
			ws.send('{"act":"p","v":' + part + '}');
		}


	}
</script>

<style>
.allparts {
  position: absolute;
  display: none;
}

#speedslider {
  width: 250px;
}
</style>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Arm Drive</a></h3>
	<div>

		<div><span class="bluetitle">Подключение:</span> <span id="connectionstatus"></span></div>
		<div><span class="bluetitle">Напряжение:</span> <span id="voltage"></span></div>

		<div style="position: relative;">
			<img src="modules/{module_name}/arm.png" usemap="#imgmap">

			<img id="part1" class="allparts" style="bottom:3px; left:97px;" src="modules/{module_name}/part1.png">
			<img id="part2" class="allparts" style="top:211px; left:235px;" src="modules/{module_name}/part2.png">
			<img id="part3" class="allparts" style="top:131px; left:238px;" src="modules/{module_name}/part3.png">
			<img id="part4" class="allparts" style="top:11px; left:255px;" src="modules/{module_name}/part4.png">
			<img id="part5" class="allparts" style="top:1px; left:354px;" src="modules/{module_name}/part5.png">
			<img id="part6" class="allparts" style="top:4px; left:437px;" src="modules/{module_name}/part6.png">
		</div>

		<map name="imgmap">
			<area shape="rect" coords="90,270,370,370" href="#" onclick='UpdatePart(0); return false;'>
			<area shape="rect" coords="240,210,350,270" href="#" onclick='UpdatePart(1); return false;'>
			<area shape="rect" coords="240,140,350,310" href="#" onclick='UpdatePart(1); return false;'>
			<area shape="rect" coords="250,10,360,105" href="#" onclick='UpdatePart(2); return false;'>
			<area shape="rect" coords="350,2,450,95" href="#" onclick='UpdatePart(3); return false;'>
			<area shape="rect" coords="438,10,530,95" href="#" onclick='UpdatePart(3); return false;'>
		</map>


		<div><span class="bluetitle">Скорость:</span> <input type="text" id="speed" value="" style="background: transparent; width: 20px; border: none; color: #ffffff;"></div>
		<div><div id="speedslider"></div></div>

		<p></p>

		<div><span class="bluetitle">Свет:</span> <span id="light"></span></div>
		<p><div id="lightstate">
			<input type="radio" id="light_on" name="radio"><label for="light_on">вкл</label>
			<input type="radio" id="light_off" name="radio"><label for="light_off">выкл</label>
		</div>
		</p>
		<div><span class="bluetitle">Направление:</span> <span id="direction"></span></div>

	</div>

</div>
