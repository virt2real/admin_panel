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
			$("#pingStatus").html("не указан пингуемый адрес");
			return;
		}

		$("#pingStatus").html("пингуем...");
		$("#pingStatus").load("modules/{module_name}/ping.php?rnd=" + Math.random() + "&host=" + encodeURIComponent(host), function(response, status, xhr) {
			if (status == "success") {
				$("#pingStatus").html(response);
			}
			if (status == "error") {
				$("#pingStatus").html(":-(");
			}
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Ping</a></h3>
	<div>
		<p>Пингуемый хост</p>
		<form onSubmit="var host=$('#pinghost').val(); PingHost(host); return false;">
		<p>
			<input type="text" id="pinghost" style="width: 300px;">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="submit" value="Ping">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span id="pingStatus"></span>
		</p>
		</form>
	</div>

</div>