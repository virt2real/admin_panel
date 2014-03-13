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

	function update_interfaces(){
		$.getScript("modules/{module_name}/ifget.php?" + Math.random(), function(response, status, xhr) {
//$("#if_traf").html(response); return;
			if (status == "success") {
				var if_json = JSON.parse(response);
				var value = "";
				var rspeed = "", tspeed = "";
				if (!old) old = if_json;

				for (var i in if_json) {
					var rcv_speed = if_json[i].rcv_bytes - old[i].rcv_bytes;
					var trsm_speed = if_json[i].trsm_bytes - old[i].trsm_bytes;
					old[i].rcv_bytes = if_json[i].rcv_bytes;
					old[i].trsm_bytes = if_json[i].trsm_bytes;

					if (rcv_speed > 1024) {
						rspeed = (rcv_speed/1024).toFixed(3) + " %M_KBPS%";
					} else if (rcv_speed > 1048576) {
						rspeed = (rcv_speed/1048576).toFixed(3) + " %M_MBPS%";
					} else {
						rspeed = rcv_speed + " %M_BPS%";
					}

					if (trsm_speed > 1024) {
						tspeed = (trsm_speed/1024).toFixed(3) + " %M_KBPS%";
					} else if (trsm_speed > 1048576) {
						tspeed = (trsm_speed/1048576).toFixed(3) + " %M_MBPS%";
					} else {
						tspeed = trsm_speed + " %M_BPS%";
					}

					value += '<p class="bluetitle">' + if_json[i].if_name + " :</p>";
					value += "%M_TX%: " + tspeed + "</b><br>";
					value += "%M_RX%: " + rspeed + "<br><br><br>";

				}
				old = if_json;
				$("#if_traf").html(value);

			}
			if (status == "error") {
				$("#if_traf").html("%L_FAIL%");
			}

		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESCRIPTION%</a></h3>
	<div>
		<p class="bluetitle">%M_INACCURATE_INFO%</p>
		<div id="if_traf"></div>
	</div>

</div>
