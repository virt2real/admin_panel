<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		$("#pinghost").focus();
	}
</script>


<script>
	function PingHost(host){

		if (!host) {
			$("#pingStatus").html("%M_ERR_NO_ADDRESS%");
			return;
		}

		$("#pingStatus").html("%M_PING_IN_PROGRESS%");
		$("#pingStatus").load("modules/{module_name}/ping.php?rnd=" + Math.random() + "&host=" + encodeURIComponent(host), function(response, status, xhr) {
			if (status == "success") {
				$("#pingStatus").html(response);
			}
			if (status == "error") {
				$("#pingStatus").html("%L_FAIL%");
			}
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p class="bluetitle">%M_TARGET_HOST%</p>
		<form onSubmit="var host=$('#pinghost').val(); PingHost(host); return false;">
		<p>
			<input type="text" id="pinghost" style="width: 300px;">
			<a href="#" class="buttonlink" onclick="var host=$('#pinghost').val(); PingHost(host); return false;" style="padding-left:20px;">[ %M_PING% ]</a>
			<p></p>
			<span id="pingStatus"></span>
		</p>
		</form>
	</div>

</div>
