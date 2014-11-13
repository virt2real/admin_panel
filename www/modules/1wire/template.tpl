<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});
</script>

<script>
	var w1_timer;

	function update_w1(){
		if (w1_timer)
			$("#w1loader").css("display","block");
		else
			$("#w1loader").css("display","none");

		load_w1();
		w1_timer = setTimeout("update_w1()", 1000);
	}

	function load_w1(num){
		$.get("modules/{module_name}/get.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#currentw1state").html(response);
			}
			if (status == "error") {
				$("#currentw1state").html("error");
			}
		});
	}

</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p>

			<a href="" class="buttonlink" onclick='if (!w1_timer) w1_timer = setTimeout("update_w1()", 1); return false;'>[ %L_START_QUERY% ]</a>
			<a href="" class="buttonlink" onclick='clearTimeout(w1_timer); w1_timer = false; $("#w1loader").css("display","none"); return false;'>[ %L_STOP_QUERY% ]</a>

			<p style="height:20px;"><img id="w1loader" src="imgs/loader.gif" style="display: none;"></p>

		</p>

		<p class="bluetitle">%M_FOUND_DEVICES%</p>
		<div id="currentw1state">
			{devicelist}
		</div>

	</div>

</div>
