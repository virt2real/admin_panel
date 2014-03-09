<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){

		$("#3gconnectionswitch").buttonset();

		$("#3g_on").on("change", function () {
			Connect(1);
		});

		$("#3g_off").on("change", function () {
			Connect(0);
		});

		Check3G();

	}



	function Connect(state){

		$("#connection_status").html('<img src="/imgs/loader.gif">');

		$.post("modules/{module_name}/connect.php?rnd=" + Math.random(), {state: state}, function(response, status, xhr) {
			if (status == "success") {
				$("#connection_status").html(response);
			}
			if (savestatus == "error") {
				$("#connection_status").html("%L_FAIL%");
			}
		});
	}


	function Check3G(){

		$.post("modules/{module_name}/check.php?rnd=" + Math.random(), {}, function(response, status, xhr) {
			if (status == "success") {

				var json;
				var result = "";

				try {
					json = JSON.parse(response);
					if (json[0]) result += '<p><span class="bluecaption">%M_INTERFACE%:</span> ' + json[0] + '</p>';
					if (json[1]) result += '<p><span class="bluecaption">%M_DEVICE%:</span> ' + json[1] + '</p>';
					if (json[2]) result += '<p><span class="bluecaption">%M_SPEED%:</span> ' + json[2] + '</p>';
					if (json[3]) result += '<p><span class="bluecaption">%M_LOCAL_IP%:</span> ' + json[3] + '</p>';
					if (json[4]) result += '<p><span class="bluecaption">%M_REMOTE_IP%:</span> ' + json[4] + '</p>';
					if (json[5]) result += '<p><span class="bluecaption">%M_CARRIER%:</span> ' + json[5] + '</p>';
				} catch (err) {}

				$("#connection_status").html(result);

				if (result) {
					$("#3g_off").attr("checked", "checked");
					$("#3g_off").button("refresh");
					$("#3g_on").attr("checked", "");
					$("#3g_on").button("refresh");
				} else {
					$("#3g_on").attr("checked", "checked");
					$("#3g_on").button("refresh");
					$("#3g_off").attr("checked", "");
					$("#3g_off").button("refresh");
				}

			}
			if (status == "error") {
				$("#connection_status").html("%L_FAIL%");
			}

			setTimeout("Check3G()", 1000);
		});
	}


</script>

<style>
.bluecaption {
  color: #0380ea;
  clear: left;
  float: left;
  width: 100px;
}
</style>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p class="bluetitle">%M_TOGGLE_CONNECTION%</p>

		<p>%M_SETUP_MODEM_FIRST%</p>

		<p>&nbsp;</p>

		<div id="3gconnectionswitch">
			<input type="radio" id="3g_on" name="radio"><label for="3g_on">%L_ON%</label>
			<input type="radio" id="3g_off" name="radio" checked><label for="3g_off">%L_OFF%</label>
		</div>

		<p>&nbsp;</p>

		<p>%M_WAIT_20_SECONDS%</p>

		<p>&nbsp;</p>

		<div id="connection_status"></div>
	</div>


</div>

</div>
