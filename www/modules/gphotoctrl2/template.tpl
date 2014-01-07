<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	var ws;

	function init{module_name}(){

		if(typeof(WebSocket)=="undefined") {
			alert("Your browser does not support WebSockets. Try to use Chrome or Safari.");
		} else {
			if (ws)  ws.close();
			ws = new WebSocket("ws://{deviceHost}:9999");
			ws.onmessage = function(event) {
				ParseEvent(event.data);
			}
			ws.onopen = function(event) {
				// connected to command server
				// get camera settings list
				$("#gphotoinfo").html("connected");
				ws.send('{"cmd": "list"}');
			}
		}

	}

	function ParseEvent(message){

		var json;

		try {
			json = JSON.parse(message);
		} catch (err) {
		}

		switch (json.cmd) {
			case "list":
				var text = JSON.stringify(json.result);
				for (var i in json.result) {
					$("#gphotoinfo").html("Найден " + json.result[i].model + " on " + json.result[i].port);
				}

				// if found at least one device - get params
				ws.send('{"cmd":"get-config","value":0}');
			break;
			case "config":
				var info = JSON.stringify(json.result.main);
				//for (var i in json.result.main.window)
					$("#gphotoinfo").append(info);
				
			break;
		}
		
	}


</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Информация о камере</a></h3>
	<div class="gphotoctrl">

		<div id="gphotoinfo"></div>

		<div id="gphotoscanresult"></div>

	</div>

</div>