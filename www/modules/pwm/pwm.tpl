<div class="col">
	<div class="bluetitle">%M_PWM%{num} <span id="freq{num}"></span></div>
	<p>
		<span class="inline">duty:</span>
		<input type="text" class="textpwm" id="pwm{num}duty" selectortype="duty" pwmid="{num}" value="">
		<div class="pwmsliders" id="sliderpwm{num}duty" type="duty" pwmid="{num}"></div>
	</p>
	<p>
		<span class="inline">period:</span>
		<input type="text" class="textpwm" id="pwm{num}period" value="" selectortype="period" pwmid="{num}">
		<div class="pwmsliders" id="sliderpwm{num}period" type="period" pwmid="{num}"></div>
	</p>
</div>
<div>{pins}</div>
<div style="clear: both;"></div>
<hr color="#3c3c3c" width=500 align=left>
