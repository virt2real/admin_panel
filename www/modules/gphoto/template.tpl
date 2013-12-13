<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		$("#gphotoscanresult").html('<img src="/imgs/loader.gif">');
		gphoto_get_cmd("--auto-detect");
		gphoto_get_cmd("--summary");
	}

	function gphoto_get_cmd(cmd){
		$.post("modules/{module_name}/get.php?rnd=" + Math.random(), {cmd: cmd}, function(response, status, xhr) {			$("#gphotoscanresult").html('');			if (status == "success") {
				$("#gphotoresult").append(response);
			}
			if (savestatus == "error") {				$("#gphotoresult").html(":-(");
			}
		});

	}

	function LoadDir(dir, parent){
		$("#gphotostatus").html('<img src="/imgs/loader.gif">');
		$("#gphotofilelist").load("modules/{module_name}/load.php?rnd=" + Math.random() + "&dir=" + encodeURIComponent(dir) + "&parent=" + encodeURIComponent(parent), function(response, status, xhr) {
			if (status == "success") {
				$("#gphotostatus").html("");
			}
			if (status == "error") {
				$("#gphotostatus").html(":-(");
			}
		});
	}


</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">GPhoto</a></h3>
	<div>

		<p class="bluetitle">Найденные устройства</p>
		<div id="gphotoscanresult"></div>
		<div id="gphotoresult"></div>

	</div>

	<h3><a href="#">Содержимое накопителя устройства</a></h3>
	<div>

		<a href="#" onclick='LoadDir("", "/media/camera"); return false;'>Загрузить список файлов</a>

		<div id="gphotofilelist"></div>
		<p></p>
		<div id="gphotostatus"></div>

	</div>

</div>

</div>