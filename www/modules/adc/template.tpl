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

	function update_adc(){
		if (adc_timer) 
			$("#adcloader").css("display","block");
		else
			$("#adcloader").css("display","none");
		
		load_adc();

		var period = $("#adc_timer_period").val();
		adc_timer = setTimeout("update_adc()", period);

	}

	function load_adc(){		$.get("modules/{module_name}/get.php", function(response, status, xhr) {			if (status == "success") {

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
		<p class="bluetitle">Мониторинг состояния аналоговых входов (ADC)</p>
		<div>

			<form onSubmit="updateTimer(); return false;">

			<div style="display:inline-block; padding-left:40px; min-width:150px;">показывать значений</div>
			<div style="display:inline;">
				<input type="text" id="adc_max_count" value="100" style="width:50px; background-color:#b0b0b0; border: none;">
			</div>
			<p></p>
			<div style="display:inline-block; padding-left:40px; min-width:150px;">Частота обновления </div>
			<div style="display:inline;">
				<input type="text" id="adc_timer_period" value="1000"  style="width:50px; background-color:#b0b0b0; border: none;">
			</div>
			<div style="display:inline;">(мс)</div>
			</form>

			<p>
				<a href="" class="buttonlink" onclick='if (!adc_timer) adc_timer = setTimeout("update_adc()", 1); return false;'>[ Запустить опрос ]</a>
				<a href="" class="buttonlink" onclick='clearTimeout(adc_timer); adc_timer = false; $("#adcloader").css("display","none"); return false;'>[ Остановить опрос ]</a>
				<p style="height:20px;"><img id="adcloader" src="/imgs/loader.gif" style="display: none;"></p>
			</p>

			</p>
		</div>
		<div id="adc_status"></div>
	</div>
</div>

</div>