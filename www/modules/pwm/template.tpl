<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});


	function init{module_name}(){
		setTimeout("update_pwm()", 500);
		setTimeout("operate_pwm()", 1000);
	}


	var pwm_timer;
	var pwm_run;
	var operate = false;

	function update_pwm(){
		if (pwm_timer)
			$(".pwmloader").css("display","block");
		else
			$(".pwmloader").css("display","none");

		load_pwm_state();

	}

	function load_pwm_state(){

		$.get("modules/{module_name}/get.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {

				$(".pwmpins").removeClass("whitetext");

				try {
					var json = JSON.parse(response);
					for (var i in json) {
						for (var con in json[i].cons) {
							var con_id = json[i].cons[con];
							$(".con" + con_id).addClass("whitetext");
						}

						if (parseInt(json[i].period) > parseInt($("#sliderpwm" + json[i].id + "period").slider("option", "max"))) {

							$("#sliderpwm" + json[i].id + "period").slider("option", "max", json[i].period);
							$("#sliderpwm" + json[i].id + "duty").slider("option", "max", json[i].period);

						}

						$("#pwm" + json[i].id + "period").val(json[i].period);
						$("#pwm" + json[i].id + "duty").val(json[i].duty);

						$("#sliderpwm" + json[i].id + "period").slider("value", parseInt(json[i].period));
						$("#sliderpwm" + json[i].id + "duty").slider("value", parseInt(json[i].duty));

						getfreq(json[i].id, json[i].period);

						/* try count a position from duty if freq 50Hz (period 480000) */
						if (parseInt(json[i].period) == 480000) {
							duty_to_position(json[i].id, json[i].duty);
						}

					}
				} catch (err) {}

			}
			if (pwm_run) pwm_timer = setTimeout("update_pwm()", 1000);
		});
	}


	function operate_pwm() {
		operate = true;
	}

	function set_pwm(id, duty, period) {

		if (!operate) return;

		$.post("modules/{module_name}/set.php?" + Math.random(), {id: id, duty: duty, period: period}, function(response, status, xhr) {
			load_pwm_state();
		});
	}

	function set_pin_pwm(conid, pwmid, state) {

		if (!operate) return;

		$.post("modules/{module_name}/setpin.php?" + Math.random(), {conid: conid, pwmid: pwmid, state: state}, function(response, status, xhr) {
			load_pwm_state();
		});
	}


	/* text inputs */
	$(".textpwm").change(function () {
		var val = parseInt($(this).val());
		var type = $(this).attr("selectortype");
		var pwmid = parseInt($(this).attr("pwmid"));

		if (type == "duty")
			balance_sliders(pwmid, val, -1);
		if (type == "period") {

			var max_period = parseInt($("#sliderpwm" + pwmid + "period").slider("option", "max"));
			if (val > max_period) {
				$("#sliderpwm" + pwmid + "period").slider("option", "max", val);
				$("#sliderpwm" + pwmid + "duty").slider("option", "max", val);
			}

			balance_sliders(pwmid, -1, val);
		}

	});


	/* create PWM sliders */

	$(".pwmsliders" ).each(function() {

		$(this).empty().slider({
			value: 0,
			min: 0,
			max: 1200,
			animate: true,
			orientation: "horizontal"
		});

	});

	$(".pwmsliders").on("slidestop", function( event, ui ) {
		var pwmid = parseInt($(this).attr("pwmid"));
		var type = $(this).attr("type");
		if (!type) return;

		var period_value;
		var duty_value;

		// check duty and period dependences
		if (type == "period") {
			period_value = $(this).slider("option", "value");
			duty_value = $("#sliderpwm" + pwmid + "duty").slider("option", "value");
		} else
		if (type == "duty") {
			duty_value = $(this).slider("option", "value");
			period_value = $("#sliderpwm" + pwmid + "period").slider("option", "value");
		}

		balance_sliders(pwmid, duty_value, period_value);
	});


	function balance_sliders(pwmid, duty, period) {
		var new_duty;
		var new_period;

		new_duty = (duty >= 0) ? duty : parseInt($("#sliderpwm" + pwmid + "duty").slider("option", "value"));
		new_period = (period >= 0) ? period : parseInt($("#sliderpwm" + pwmid + "period").slider("option", "value"));

		if (new_duty > new_period) {
			new_duty = new_period;
			$("#sliderpwm" + pwmid + "duty").slider("option", "value", new_duty);
		}

		$("#sliderpwm" + pwmid + "period").slider("option", "value", new_period);

		$("#pwm" + pwmid + "duty").val(new_duty);
		$("#pwm" + pwmid + "period").val(new_period);

		set_pwm(pwmid, new_duty, new_period);

	}


	$(".pwmpins").click(function () {
		var state = 0;
		if ($(this).hasClass("whitetext"))
			state = 0 ;
		else
			state = 1;
		set_pin_pwm($(this).attr("conid"), $(this).attr("pwmid"), state)
		return false;
	});


	function getfreq(pwmid, period) {
		period = parseInt(period);
		if (!period) return;
		var freq = 1 / (period * 0.000000042);
		freqstr = parseInt(freq / 1000);
		var lit = "%M_PREFIX%";
		if (!freqstr) {
			freqstr = parseInt(freq);
			lit = "";
		}
		$("#freq" + pwmid).html(freqstr + lit + "%M_HZ%");
	}


	/* *************************************************** */

	function position_to_duty (pwmid, position) {
		var tic = 1000000 / 24000000;
		var minpos = 500 / tic;
		var maxpos = 2450 / tic;
		var scale = (maxpos - minpos) / 180;
		var period = 20000 / tic;

		set_pwm(pwmid, parseInt(minpos + scale * position), parseInt(period));
	}


	function duty_to_position (pwmid, duty) {
		var tic = 1000000 / 24000000;
		var minpos = 500 / tic;
		var maxpos = 2450 / tic;
		var scale = (maxpos - minpos) / 180;
		var position = parseInt((duty - minpos) / scale);
		$("#position" + pwmid).html(position);
		$("#sliderppm" + pwmid).slider("option", "value", position);
	}


	/* create PPM sliders */

	$(".ppmsliders" ).each(function() {

		$(this).empty().slider({
			value: 90,
			min: 0,
			max: 180,
			animate: true,
			orientation: "horizontal"
		});

	});


	$(".ppmsliders").on("slidestop", function( event, ui ) {
		var pwmid = parseInt($(this).attr("pwmid"));
		var position = $(this).slider("option", "value");
		position_to_duty (pwmid, position);
	});

/*	$(".ppmsliders").on("slide", function( event, ui ) {
		var pwmid = parseInt($(this).attr("pwmid"));
		var position = $(this).slider("option", "value");
		position_to_duty (pwmid, position);
	});
*/

</script>


<style>
.col {
  clear:right;
  float:left;
  width:450px;
  color: #7c7c7c;
  font-family: "Lucida Console", Monaco, monospace;
  font-size:1.2em;
}

.pwmcon a {
  color: #7c7c7c;
  text-decoration: none;
  font-family: "Lucida Console", Monaco, monospace;
  font-size:1.2em;
  padding: 3px;
}

.pwmcon a:hover {
  border: 1px solid #7f7f7f;
  color: #ffffff;
}

.pwmcon a.whitetext {
  color: #ffffff;
}

.pwmsliders, .ppmsliders {
  width: 400px;
}

.textpwm {
  color: #0380ea;
  background-color: transparent;
  border: none;
  width: 70px;
}

.ppmlist {
  color: #7c7c7c;
  text-decoration: none;
  font-family: "Lucida Console", Monaco, monospace;
  font-size:1.2em;
  padding: 3px;
}

</style>



<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p class="bluetitle">%M_PWM_PPM_CONTROL%</p>
		<p>%M_WHAT_PWM%</p>
		<p>%M_WHAT_PPM%</p>
		<p></p>
		<p>
			%M_FIRST_BIND_PIN%<br>
			%M_COLOUR_CODING%
		</p>
	</div>


	<h3><a href="#">%M_PWM%</a></h3>
	<div>

		<p>
			<a href="" class="buttonlink" style="color:#ffffff;" onclick='pwm_run = 1; if (!pwm_timer) pwm_timer = setTimeout("update_pwm()", 1); return false;'>[ %L_START_QUERY% ]</a>
			<a href="" class="buttonlink" onclick='pwm_run = 0; clearTimeout(pwm_timer); pwm_timer = false; $(".pwmloader").css("display","none"); return false;'>[ %L_STOP_QUERY% ]</a>
			<p style="height:20px;"><img class="pwmloader" src="/imgs/loader.gif" style="display: none;"></p>
		</p>

		<div>
			{pwmlist}
		</div>


	</div>

	<h3><a href="#">%M_PPM%</a></h3>
	<div>

		<p>
			<a href="" class="buttonlink" onclick='pwm_run = 1; if (!pwm_timer) pwm_timer = setTimeout("update_pwm()", 1); return false;'>[ %L_START_QUERY% ]</a>
			<a href="" class="buttonlink" onclick='pwm_run = 0; clearTimeout(pwm_timer); pwm_timer = false; $(".pwmloader").css("display","none"); return false;'>[ %L_STOP_QUERY% ]</a>
			<p style="height:20px;"><img class="pwmloader" src="/imgs/loader.gif" style="display: none;"></p>
		</p>

		<div>
			{ppmlist}
		</div>

	</div>

</div>

</div>
