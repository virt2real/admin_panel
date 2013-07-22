<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	var if_timer;
	if (!if_timer) if_timer = setInterval("update_interfaces()", 1000);

	function init{module_name}(){
		update_interfaces();
	}

	var old;
	var ifaces;

	function update_interfaces(){		$.getScript("modules/{module_name}/ifget.php?" + Math.random(), function(response, status, xhr) {			if (status == "success") {
				var if_json = JSON.parse(response);
				var value = "";
				var rspeed = "", tspeed = "";
				if (!old) old = if_json;

				for (var i in if_json) {
					var rcv_speed = if_json[i].rcv_bytes - old[i].rcv_bytes;
					var trsm_speed = if_json[i].trsm_bytes - old[i].trsm_bytes;

					if (rcv_speed > 1024) {
						rspeed = (rcv_speed/1024).toFixed(3) + " KBytes/sec";
					} else if (rcv_speed > 1048576) {
						rspeed = (rcv_speed/1048576).toFixed(3) + " MBytes/sec";
					} else {
						rspeed = rcv_speed + " Bytes/sec";
					}

					if (trsm_speed > 1024) {
						tspeed = (trsm_speed/1024).toFixed(3) + " KBytes/sec";
					} else if (trsm_speed > 1048576) {
						tspeed = (trsm_speed/1048576).toFixed(3) + " MBytes/sec";
					} else {
						tspeed = trsm_speed + " Bytes/sec";
					}

					value += "<b>" + if_json[i].if_name + " :</b><br>";
					value += "приём: " + tspeed + "</b><br>";
					value += "передача: " + rspeed + "<p></p><p></p>";

				}
				old = if_json;
				$("#if_traf").html(value);

			}
			if (status == "error") {
				$("#if_traf").html("error");
			}

		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Мониторинг сетевых интерфейсов</a></h3>
	<div>
		<div id="if_traf"></div>
	</div>

</div>