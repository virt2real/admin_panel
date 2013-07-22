<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
	}
</script>

<script>
	var adc_timer;
	var adc_counter = 0;

	function updateTimer(){		var period = $("#adc_timer_period").val();
		clearInterval(adc_timer);
		adc_timer = false;
		if (!adc_timer) adc_timer = setInterval("update_adc()", period);
	}

	function update_adc(){		$.get("modules/{module_name}/get.php", function(response, status, xhr) {			if (status == "success") {

				var adc_json = JSON.parse(response);
				var value = "";
				for (var i in adc_json) {					value += adc_json[i] + "&nbsp;&nbsp;&nbsp;";
				}

				value += "<br>";

				if (adc_counter < (parseInt($("#adc_max_count").val()) - 1) ) {					adc_counter++;
					$("#adc_status").append(value);
				} else {					adc_counter = 0;
					$("#adc_status").html(value);
				}

			}
			if (status == "error") {
				$("#adc_status").html("error");
			}
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">ADC</a></h3>
	<div>
		<p>Мониторинг состояния аналоговых входов (ADC)</p>
		<div>
			<form onSubmit="updateTimer(); return false;">
			<table>
				<tr>
					<td>Сколько значений показывать:</td>
					<td><input type="text" id="adc_max_count" value="100" style="width: 40px;"></td>
				</tr>
				<tr>
					<td>Частота обновления (мс):</td>
					<td><input type="text" id="adc_timer_period" value="1000" style="width: 40px;"></td>
				</tr>
			</table>
			</form>

			<input type="button" value="Запустить таймер опроса" onclick='if (!adc_timer) adc_timer = setInterval("update_adc()", parseInt($("#adc_timer_period").val())); return false;'>
			<input type="button" value="Остановить таймер опроса" onclick='clearInterval(adc_timer); adc_timer = false; return false;'>

			</p>
		</div>
		<div id="adc_status"></div>
	</div>
</div>

</div>