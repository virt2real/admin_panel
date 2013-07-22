<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		check_imu_modules();
	}

	function check_imu_modules(){		$("#imu_searchstatus").html("Проверка наличия загруженных модулей устройств...  ");
		$.get("modules/{module_name}/check.php", function(response, status, xhr) {			if (status == "success") {				var json = "";				try {					json = JSON.parse(response);
				} catch (e) {
					$("#imu_searchstatus").html(":-(");
					return;
				}

				for (var i in json) {					if (json[i] == sensors[0].name) sensors[0].found = true;
					if (json[i] == sensors[1].name) sensors[1].found = true;
					if (json[i] == sensors[2].name) sensors[2].found = true;
					if (json[i] == sensors[3].name) sensors[3].found = true;
				}

				var result = "";
				if (sensors[0].found) result += sensors[0].name + " загружен<br>";
				if (sensors[1].found) result += sensors[1].name + " загружен<br>";
				if (sensors[2].found) result += sensors[2].name + " загружен<br>";
				if (sensors[3].found) result += sensors[3].name + " загружен<br>";

				if (!result) result = ":-(";

				$("#imu_searchstatus").append(result + "<br>");

				// now check /sys/bus/i2c/devices

				check_imu_devices();
			}
			if (status == "error") {
				$("#imu_searchstatus").html(":-(");
			}
		});
	}


	function check_imu_devices(){		$("#imu_searchstatus").append("Проверка смонтированности устройств...  ");
		$.get("modules/{module_name}/checkdevices.php", function(response, status, xhr) {
			if (status == "success") {
				var json = JSON.parse(response);

				for (var i in json) {					if (json[i] == "1-"+sensors[0].address) sensors[0].mounted = true;
					if (json[i] == "1-"+sensors[1].address) sensors[1].mounted = true;
					if (json[i] == "1-"+sensors[2].address) sensors[2].mounted = true;
					if (json[i] == "1-"+sensors[3].address) sensors[3].mounted = true;
				}

				var result = "";
				if (sensors[0].mounted) result += sensors[0].name + " смонтирован<br>";
				if (sensors[1].mounted) result += sensors[1].name + " смонтирован<br>";
				if (sensors[2].mounted) result += sensors[2].name + " смонтирован<br>";
				if (sensors[3].mounted) result += sensors[3].name + " смонтирован<br>";

				if (!result) result = ":-(";

				$("#imu_searchstatus").append(result);

			}
			if (status == "error") {
				$("#imu_searchstatus").html(":-(");
			}
		});
	}


	var imu_timer;

	function updateTimer(){
		if (sensors[0].mounted) get_imu(sensors[0].address);
		if (sensors[1].mounted) get_imu(sensors[1].address);
		if (sensors[2].mounted) get_imu(sensors[2].address);
		if (sensors[3].mounted) get_imu(sensors[3].address);
		imu_timer = setTimeout("updateTimer()", 10);
	}


	function get_imu(address){
		$.get("modules/{module_name}/get.php?addr=" + address, function(response, status, xhr) {
			if (status == "success") {
				var json = JSON.parse(response);

				for (var i in json) {					//if (json[i].addr !=="0077") continue;
					$("#"+json[i].addr+json[i].name).html(json[i].val);				}

			}
			if (status == "error") {
			}
		});
	}


	var sensors =  [
		{id: 0, name: "itg3200", address: "0068", found: false, mounted: false},
		{id: 1, name: "bma180", address: "0040", found: false, mounted: false},
		{id: 2, name: "hmc5843", address: "001e", found: false, mounted: false},
		{id: 3, name: "bmp085", address: "0077", found: false, mounted: false},
	];

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">IMU</a></h3>
	<div>
		<table width=100%>
			<tr valign=top>
				<td width=400>

					<p>{i2c_name}</p>
					<div>
						<p id="imu_searchstatus"></p>
					</div>

					<input type="button" value="Запустить таймер опроса" onclick='if (!imu_timer) imu_timer = setTimeout("updateTimer()", 10); return false;'>
					<input type="button" value="Остановить таймер опроса" onclick='clearInterval(imu_timer); imu_timer = false; return false;'>

				</td>
				<td width=400>

					<div id="0040" style="padding:10px;">
						<div id="0040name" style="font-size:1.4em;">name</div>
						<div><span>coord:</span> <span id="0040coord">coord</span></div>
					</div>

					<div id="0077" style="padding:10px;">
						<div id="0077name" style="font-size:1.4em;">name</div>
						<div><span>temp0_input:</span> <span id="0077temp0_input">temp0_input</span></div>
						<div><span>pressure0_input:</span> <span id="0077pressure0_input">pressure0_input</span></div>
						<div><span>oversampling:</span> <span id="0077oversampling">oversampling</span></div>
					</div>

					<div id="001e" style="padding:10px;">
						<div id="001ename" style="font-size:1.4em;">name</div>
						<div><span>value: </span> <span id="001evalue">value</span></div>
						<div><span>rate: </span> <span id="001erate">rate</span></div>
						<div><span>mode: </span> <span id="001emode">mode</span></div>
						<div><span>conversion: </span> <span id="001econversion">conversion</span></div>
						<div><span>range: </span> <span id="001erange">range</span></div>
						<div><span>status: </span> <span id="001estatus">status</span></div>
						<div><span>counts_per_mgauss: </span> <span id="001ecounts_per_mgauss">counts_per_mgauss</span></div>
					</div>

					<div id="0068" style="padding:10px;">
						<div id="0068name" style="font-size:1.4em;">name</div>
						<div><span>values: </span> <span id="0068values">values</span></div>
						<div><span>low_pass: </span> <span id="0068low_pass">low_pass</span></div>
						<div><span>samplerate: </span> <span id="0068samplerate">samplerate</span></div>
						<div><span>clocksource: </span> <span id="0068clocksource">clocksource</span></div>
						<div><span>disable_axis: </span> <span id="0068disable_axis">disable_axis</span></div>
						<div><span>enable_axis: </span> <span id="0068enable_axis">enable_axis</span></div>
						<div><span>suspend: </span> <span id="0068suspend">suspend</span></div>
					</div>

				</td>
				<td>
					&nbsp;
				</td>
			</tr>
		</table>

	</div>

</div>

</div>