<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>

	$(".pinbox").click(function(){		var row = $(this).attr("row");
		var col = $(this).attr("col");
		var text = $("#title" + row + "_" + col).text();
		$("#pininfo").html(text);
		$("#title" + row + "_" + col).addClass("blueback");
	});

	$(".pinbox").mouseover(function(){
		var row = $(this).attr("row");
		var col = $(this).attr("col");
		var text = $("#title" + row + "_" + col).text();
		$("#pininfo").html(text);
		$("#title" + row + "_" + col).addClass("blueback");
		$("#title" + row + "_" + col).addClass("whitetext");
		$(this).css("background-image","url('/imgs/pinarea.png')");
	});

	$(".pinbox").mouseout(function(){		var row = $(this).attr("row");
		var col = $(this).attr("col");
		$("#pininfo").html("&nbsp;");
		$("#title" + row + "_" + col).removeClass("blueback");
		$("#title" + row + "_" + col).removeClass("whitetext");
		$(this).css("background-image","none");
	});

	$(".pintitle").click(function(){		var row = $(this).attr("row");
		var col = $(this).attr("col");
		$("#pin"+row+"_"+col).css("background-image","url('/imgs/pinarea.png')");
		$("#pininfo").html($(this).text());
	});

	$(".pintitle").mouseover(function(){
		var row = $(this).attr("row");
		var col = $(this).attr("col");
		$("#pin"+row+"_"+col).css("background-image","url('/imgs/pinarea.png')");
		$(this).addClass("whitetext");
		var text = "&nbsp;";
		if ($(this).text())  text = $(this).text();
		$("#pininfo").html(text);
	});

	$(".pintitle").mouseout(function(){
		var row = $(this).attr("row");
		var col = $(this).attr("col");
		$("#pin"+row+"_"+col).css("background-image","none");
		$(this).removeClass("whitetext");
		var text = "&nbsp;";
		if ($(this).text())  text = $(this).text();
		$("#pininfo").html(text);
	});

	$(".leds").mouseover(function(){
		var num = $(this).attr("num");
		var text = "LED " + num;
		$("#pininfo").html(text);
		//$(this).addClass("active")
	});

	$(".leds").mouseout(function(){
		var num = $(this).attr("num");
		$("#pininfo").html("&nbsp;");
		//$(this).removeClass("active")
	});


</script>

<style>

#pininfo {
  display: inline;
  line-height: 20px;
  height: 20px;
}

.pinbox {
  position: absolute;
  width:15px;
  height:15px;
}

.pintitle {
  color: #7c7c7c;
}

.whitetext {
  color: #ffffff;
}

.lighttext {
  color: #dddddd;
}

.leds {
  position: absolute;
  width:17px;
  height:8px;
}

#led0.leds.active {
  background: #2b85f5;
}

#led1.leds.active {
  background: #ff0000;
}

#led2.leds.active {
  background: #00ff00;
}

</style>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Макет платы</a></h3>
	<div>
		<div style="position: relative;">
			<img src="modules/{module_name}/board_scheme.png" style="box-shadow:0px 0px 15px #555555;">

			<!-- LEDS -->
			<div class="leds {led0active}" id="led0" num="0" style="top:55px; left:5px;"></div>
			<div class="leds {led1active}" id="led1" num="1" style="top:67px; left:5px;"></div>
			<div class="leds {led2active}" id="led2" num="2" style="top:79px; left:5px;"></div>

			<!-- PINS -->
			<div class="pinbox" id="pin21_0" row="21" col="0" style="top:4px; left:66px;"></div>
			<div class="pinbox" id="pin20_0" row="20" col="0" style="top:4px; left:87px;"></div>
			<div class="pinbox" id="pin19_0" row="19" col="0" style="top:4px; left:108px;"></div>
			<div class="pinbox" id="pin18_0" row="18" col="0" style="top:4px; left:130px;"></div>
			<div class="pinbox" id="pin17_0" row="17" col="0" style="top:4px; left:150px;"></div>
			<div class="pinbox" id="pin16_0" row="16" col="0" style="top:4px; left:170px;"></div>
			<div class="pinbox" id="pin15_0" row="15" col="0" style="top:4px; left:192px;"></div>
			<div class="pinbox" id="pin14_0" row="14" col="0" style="top:4px; left:213px;"></div>
			<div class="pinbox" id="pin13_0" row="13" col="0" style="top:4px; left:234px;"></div>
			<div class="pinbox" id="pin12_0" row="12" col="0" style="top:4px; left:255px;"></div>
			<div class="pinbox" id="pin11_0" row="11" col="0" style="top:4px; left:276px;"></div>
			<div class="pinbox" id="pin10_0" row="10" col="0" style="top:4px; left:297px;"></div>
			<div class="pinbox" id="pin9_0" row="9" col="0" style="top:4px; left:318px;"></div>
			<div class="pinbox" id="pin8_0" row="8" col="0" style="top:4px; left:339px;"></div>
			<div class="pinbox" id="pin7_0" row="7" col="0" style="top:4px; left:360px;"></div>
			<div class="pinbox" id="pin6_0" row="6" col="0" style="top:4px; left:381px;"></div>
			<div class="pinbox" id="pin5_0" row="5" col="0" style="top:4px; left:402px;"></div>
			<div class="pinbox" id="pin4_0" row="4" col="0" style="top:4px; left:423px;"></div>
			<div class="pinbox" id="pin3_0" row="3" col="0" style="top:4px; left:444px;"></div>
			<div class="pinbox" id="pin2_0" row="2" col="0" style="top:4px; left:465px;"></div>
			<div class="pinbox" id="pin1_0" row="1" col="0" style="top:4px; left:485px;"></div>
			<div class="pinbox" id="pin0_0" row="0" col="0" style="top:4px; left:506px;"></div>

			<div class="pinbox" id="pin21_1" row="21" col="1" style="top:25px; left:66px;"></div>
			<div class="pinbox" id="pin20_1" row="20" col="1" style="top:25px; left:87px;"></div>
			<div class="pinbox" id="pin19_1" row="19" col="1" style="top:25px; left:108px;"></div>
			<div class="pinbox" id="pin18_1" row="18" col="1" style="top:25px; left:130px;"></div>
			<div class="pinbox" id="pin17_1" row="17" col="1" style="top:25px; left:150px;"></div>
			<div class="pinbox" id="pin16_1" row="16" col="1" style="top:25px; left:170px;"></div>
			<div class="pinbox" id="pin15_1" row="15" col="1" style="top:25px; left:192px;"></div>
			<div class="pinbox" id="pin14_1" row="14" col="1" style="top:25px; left:213px;"></div>
			<div class="pinbox" id="pin13_1" row="13" col="1" style="top:25px; left:234px;"></div>
			<div class="pinbox" id="pin12_1" row="12" col="1" style="top:25px; left:255px;"></div>
			<div class="pinbox" id="pin11_1" row="11" col="1" style="top:25px; left:276px;"></div>
			<div class="pinbox" id="pin10_1" row="10" col="1" style="top:25px; left:297px;"></div>
			<div class="pinbox" id="pin9_1" row="9" col="1" style="top:25px; left:318px;"></div>
			<div class="pinbox" id="pin8_1" row="8" col="1" style="top:25px; left:339px;"></div>
			<div class="pinbox" id="pin7_1" row="7" col="1" style="top:25px; left:360px;"></div>
			<div class="pinbox" id="pin6_1" row="6" col="1" style="top:25px; left:381px;"></div>
			<div class="pinbox" id="pin5_1" row="5" col="1" style="top:25px; left:402px;"></div>
			<div class="pinbox" id="pin4_1" row="4" col="1" style="top:25px; left:423px;"></div>
			<div class="pinbox" id="pin3_1" row="3" col="1" style="top:25px; left:444px;"></div>
			<div class="pinbox" id="pin2_1" row="2" col="1" style="top:25px; left:465px;"></div>
			<div class="pinbox" id="pin1_1" row="1" col="1" style="top:25px; left:485px;"></div>
			<div class="pinbox" id="pin0_1" row="0" col="1" style="top:25px; left:506px;"></div>

			<div class="pinbox" id="pin20_2" row="20" col="2" style="top:340px; left:72px;"></div>
			<div class="pinbox" id="pin19_2" row="19" col="2" style="top:340px; left:93px;"></div>
			<div class="pinbox" id="pin18_2" row="18" col="2" style="top:340px; left:114px;"></div>
			<div class="pinbox" id="pin17_2" row="17" col="2" style="top:340px; left:135px;"></div>
			<div class="pinbox" id="pin16_2" row="16" col="2" style="top:340px; left:156px;"></div>
			<div class="pinbox" id="pin15_2" row="15" col="2" style="top:340px; left:182px;"></div>
			<div class="pinbox" id="pin14_2" row="14" col="2" style="top:340px; left:203px;"></div>
			<div class="pinbox" id="pin13_2" row="13" col="2" style="top:340px; left:224px;"></div>
			<div class="pinbox" id="pin12_2" row="12" col="2" style="top:340px; left:245px;"></div>
			<div class="pinbox" id="pin11_2" row="11" col="2" style="top:340px; left:266px;"></div>
			<div class="pinbox" id="pin10_2" row="10" col="2" style="top:340px; left:287px;"></div>
			<div class="pinbox" id="pin9_2" row="9" col="2" style="top:340px; left:308px;"></div>
			<div class="pinbox" id="pin8_2" row="8" col="2" style="top:340px; left:329px;"></div>
			<div class="pinbox" id="pin7_2" row="7" col="2" style="top:340px; left:350px;"></div>
			<div class="pinbox" id="pin6_2" row="6" col="2" style="top:340px; left:371px;"></div>
			<div class="pinbox" id="pin5_2" row="5" col="2" style="top:340px; left:392px;"></div>
			<div class="pinbox" id="pin4_2" row="4" col="2" style="top:340px; left:413px;"></div>
			<div class="pinbox" id="pin3_2" row="3" col="2" style="top:340px; left:434px;"></div>
			<div class="pinbox" id="pin2_2" row="2" col="2" style="top:340px; left:455px;"></div>
			<div class="pinbox" id="pin1_2" row="1" col="2" style="top:340px; left:475px;"></div>
			<div class="pinbox" id="pin0_2" row="0" col="2" style="top:340px; left:496px;"></div>

			<div class="pinbox" id="pin20_3" row="20" col="3" style="top:360px; left:72px;"></div>
			<div class="pinbox" id="pin19_3" row="19" col="3" style="top:360px; left:93px;"></div>
			<div class="pinbox" id="pin18_3" row="18" col="3" style="top:360px; left:114px;"></div>
			<div class="pinbox" id="pin17_3" row="17" col="3" style="top:360px; left:135px;"></div>
			<div class="pinbox" id="pin16_3" row="16" col="3" style="top:360px; left:156px;"></div>
			<div class="pinbox" id="pin15_3" row="15" col="3" style="top:360px; left:182px;"></div>
			<div class="pinbox" id="pin14_3" row="14" col="3" style="top:360px; left:203px;"></div>
			<div class="pinbox" id="pin13_3" row="13" col="3" style="top:360px; left:224px;"></div>
			<div class="pinbox" id="pin12_3" row="12" col="3" style="top:360px; left:245px;"></div>
			<div class="pinbox" id="pin11_3" row="11" col="3" style="top:360px; left:266px;"></div>
			<div class="pinbox" id="pin10_3" row="10" col="3" style="top:360px; left:287px;"></div>
			<div class="pinbox" id="pin9_3" row="9" col="3" style="top:360px; left:308px;"></div>
			<div class="pinbox" id="pin8_3" row="8" col="3" style="top:360px; left:329px;"></div>
			<div class="pinbox" id="pin7_3" row="7" col="3" style="top:360px; left:350px;"></div>
			<div class="pinbox" id="pin6_3" row="6" col="3" style="top:360px; left:371px;"></div>
			<div class="pinbox" id="pin5_3" row="5" col="3" style="top:360px; left:392px;"></div>
			<div class="pinbox" id="pin4_3" row="4" col="3" style="top:360px; left:413px;"></div>
			<div class="pinbox" id="pin3_3" row="3" col="3" style="top:360px; left:434px;"></div>
			<div class="pinbox" id="pin2_3" row="2" col="3" style="top:360px; left:455px;"></div>
			<div class="pinbox" id="pin1_3" row="1" col="3" style="top:360px; left:475px;"></div>
			<div class="pinbox" id="pin0_3" row="0" col="3" style="top:360px; left:496px;"></div>

			<p></p>
			<div id="pininfo">&nbsp;</div>
		</div>

		<p></p>

		<div>
			<table width="600" id="pinstable">
				{pintable}
			</table>
		</div>

	</div>


</div>