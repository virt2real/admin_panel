<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script src="modules/{module_name}/lib/three.min.js"></script>
<script src="modules/{module_name}/lib/leap.js"></script>


<script>
var leapInit =  function (){

	Leap.loop(function(frame) {

		$("#leapstatus").html(frame.pointables.length);

		if(frame.pointables[0]){
			$("#point0").html(frame.pointables[0].tipPosition[0] + " " + frame.pointables[0].tipPosition[1] + " " + frame.pointables[0].tipPosition[2]);
		} else $("#point0").html("");

		if(frame.pointables[1]){
			$("#point1").html(frame.pointables[1].tipPosition[0] + " " + frame.pointables[1].tipPosition[1] + " " + frame.pointables[1].tipPosition[2]);
		} else $("#point1").html("");

		if(frame.pointables[2]){
			$("#point2").html(frame.pointables[2].tipPosition[0] + " " + frame.pointables[2].tipPosition[1] + " " + frame.pointables[2].tipPosition[2]);
		} else $("#point2").html("");

		if(frame.pointables[3]){
			$("#point3").html(frame.pointables[3].tipPosition[0] + " " + frame.pointables[3].tipPosition[1] + " " + frame.pointables[3].tipPosition[2]);
		} else $("#point3").html("");

		if(frame.pointables[4]){
			$("#point4").html(frame.pointables[4].tipPosition[0] + " " + frame.pointables[4].tipPosition[1] + " " + frame.pointables[4].tipPosition[2]);
		} else $("#point4").html("");

		if(frame.pointables[5]){
			$("#point5").html(frame.pointables[5].tipPosition[0] + " " + frame.pointables[5].tipPosition[1] + " " + frame.pointables[5].tipPosition[2]);
		} else $("#point5").html("");

		if(frame.pointables[6]){
			$("#point6").html(frame.pointables[6].tipPosition[0] + " " + frame.pointables[6].tipPosition[1] + " " + frame.pointables[6].tipPosition[2]);
		} else $("#point6").html("");

		if(frame.pointables[7]){
			$("#point7").html(frame.pointables[7].tipPosition[0] + " " + frame.pointables[7].tipPosition[1] + " " + frame.pointables[7].tipPosition[2]);
		} else $("#point7").html("");

		if(frame.pointables[8]){
			$("#point8").html(frame.pointables[8].tipPosition[0] + " " + frame.pointables[8].tipPosition[1] + " " + frame.pointables[8].tipPosition[2]);
		} else $("#point8").html("");

		if(frame.pointables[9]){
			$("#point9").html(frame.pointables[9].tipPosition[0] + " " + frame.pointables[9].tipPosition[1] + " " + frame.pointables[9].tipPosition[2]);
		} else $("#point9").html("");

	})

}

leapInit();

</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div style='height: 400px;'>
		<p>
			<p class="bluetitle" style="display: inline;">%M_DETECTED% </p>
			<div id="leapstatus" style="display: inline; padding-left: 10px;"></div>
			<p></p>

			<div style='font-family: "Lucida Console", Monaco, monospace; font-size:1.2em;'>
			<div id="point0"></div>
			<div id="point1"></div>
			<div id="point2"></div>
			<div id="point3"></div>
			<div id="point4"></div>
			<p></p>
			<div id="point5"></div>
			<div id="point6"></div>
			<div id="point7"></div>
			<div id="point8"></div>
			<div id="point9"></div>
			</div>

		</p>

	</div>

</div>
