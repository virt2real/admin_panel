<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});


	function init{module_name}(){
	}

</script>

<script>

	var adc_timer;
	var adc_run;

	function update_adc(){

		if (adc_timer)
			$("#adcloader").css("display","block");
		else
			$("#adcloader").css("display","none");

		load_adc();

	}

	function load_adc(){
		var max_voltage = $("#max_voltage").val();
		$.get("modules/{module_name}/get.php?" + Math.random() + "&vref=" + max_voltage, function(response, status, xhr) {
			if (status == "success") {
				var adc_json = JSON.parse(response);
				for (var i in adc_json) {
					$("#adc" + i + "voltage").html(adc_json[i].volt);
					$("#adc" + i + "value").html(adc_json[i].val);
				}

			}
			if (status == "error") {
				$("#adc_status").html("error");
			}
			if (adc_run) adc_timer = setTimeout("update_adc()", $("#adc_timer_period").val());
		});
	}

</script>

<style>

.adclist {
  margin-right: 15px;
  font-family: "Lucida Console", Monaco, monospace;
  font-size:1.2em;
  color: #7c7c7c;
  padding: 2px;
  line-height: 20px;
}

.adcvalues {
  font-family: "Lucida Console", Monaco, monospace;
  font-size:1.2em;
  color: #7c7c7c;
  padding: 10px;
  line-height: 20px;
}

.adcvoltages {
  font-family: "Lucida Console", Monaco, monospace;
  font-size:1.2em;
  color: #ffffff;
  padding: 10px;
  line-height: 20px;
}


</style>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p class="bluetitle">%M_ADC_MONITORING%</p>
		<div>

			<form onSubmit="updateTimer(); return false;">

			<div style="display:inline-block; padding-left:40px; min-width:200px;">%M_SHOW_VALUES%</div>
			<div style="display:inline;">
				<input type="text" id="adc_max_count" value="100" style="width:30px; text-align: right;">
			</div>
			<p></p>
			<div style="display:inline-block; padding-left:40px; min-width:200px;">%M_UPDATE_FREQUENCY%</div>
			<div style="display:inline;">
				<input type="text" id="adc_timer_period" value="1000"  style="width:30px; text-align: right;">
			</div>
			<div style="display:inline;">%M_MILLISECONDS%</div>
			<p></p>
			<div style="display:inline-block; padding-left:40px; min-width:200px;">%M_MAX_VOLTAGE%</div>
			<div style="display:inline;">
				<input type="text" id="max_voltage" value="{adc_vref}"  style="width:30px; text-align: right;">
			</div>
			<div style="display:inline;">%M_VOLT%</div>
			</form>

			<p>
				<a href="" class="buttonlink" onclick='adc_run = 1; if (!adc_timer) adc_timer = setTimeout("update_adc()", 1); return false;'>[ %L_START_QUERY% ]</a>
				<a href="" class="buttonlink" onclick='adc_run = 0; clearTimeout(adc_timer); adc_timer = false; $("#adcloader").css("display","none"); return false;'>[ %L_STOP_QUERY% ]</a>
				<p style="height:20px;"><img id="adcloader" src="imgs/loader.gif" style="display: none;"></p>
			</p>

			</p>
		</div>
		<div id="adc_status">{adc_status}</div>

	</div>
</div>

</div>
