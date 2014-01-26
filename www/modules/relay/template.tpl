<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<style>
.relayswitch {
  position: absolute;
  width: 68px;
  height: 26px;
}
</style>

<script>

	$(".relayswitch").click(function(){		var row = $(this).attr("row");
		var state = $(this).attr("state");
		SetRelay(row, state);
	});

	$(".relayswitch").mouseover(function(){
		var row = $(this).attr("row");
		var state = $(this).attr("state");
		$("#relaystatus").html(row + " " + state);
		$(this).css("background-color","#ff0000");
	});

	$(".relayswitch").mouseout(function(){		var row = $(this).attr("row");
		var state = $(this).attr("state");
		$("#relaystatus").html("&nbsp;");
		$(this).css("background-color","transparent");
	});


	function SetRelay(relay, state){
		$("#relaystatus").html("set relay " + relay + " as " + state);

		$.post("modules/{module_name}/set.php?rnd=" + Math.random(), {relay: relay, state: state}, function(response, status, xhr) {
			if (status == "success") {
				$("#relaystatus").html(response);
			}
			if (savestatus == "error") {
				$("#relaystatus").html(":-(");
			}
		});

	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Макет платы реле</a></h3>
	<div>
		<div style="position: relative;">
			<img src="modules/{module_name}/relay_shield.png" style="box-shadow:0px 0px 15px #555555;">

			<!-- J1 -->
			<div class="relayswitch" id="relay_j1_gr1" row="1" state="1" style="top:150px; left:58px;"></div>
			<div class="relayswitch" id="relay_j1_gr2" row="1" state="2" style="top:150px; left:103px;"></div>

			<!-- J2 -->
			<div class="relayswitch" id="relay_j2_gr1" row="2" state="1" style="top:210px; left:58px;"></div>
			<div class="relayswitch" id="relay_j2_gr2" row="2" state="2" style="top:210px; left:103px;"></div>

			<!-- J3 -->
			<div class="relayswitch" id="relay_j3_gr1" row="3" state="2" style="top:150px; left:438px;"></div>
			<div class="relayswitch" id="relay_j3_gr2" row="3" state="1" style="top:150px; left:483px;"></div>

			<!-- J4 -->
			<div class="relayswitch" id="relay_j4_gr1" row="4" state="2" style="top:210px; left:438px;"></div>
			<div class="relayswitch" id="relay_j4_gr2" row="4" state="1" style="top:210px; left:483px;"></div>

			<p></p>
			<div id="relaystatus" style="display: inline;"></div>
		</div>

		<p></p>
		
		<div>
			<p>J1</p>
			<p>J2</p>
			<p>J3</p>
			<p>J4</p>
		</div>

	</div>


</div>