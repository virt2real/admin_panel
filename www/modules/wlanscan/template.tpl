<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		scan_wlan();
	}

	function scan_wlan(){
		$("#scan_result").html('<img src="/imgs/loader.gif">');
		$.get("modules/{module_name}/scan.php?" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#scan_result").html(response);
			}
			if (status == "error") {
				$("#scan_result").html(":-(");
			}
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Сканирование Wi-Fi сетей</a></h3>
	<div>

		<p><a href="#" class="buttonlink" onclick='scan_wlan(); return false;'>[ Сканировать сети ]</a> </p>
		
		<div id="scan_result" style="width: 90%;"></div>

	</div>


</div>

</div>