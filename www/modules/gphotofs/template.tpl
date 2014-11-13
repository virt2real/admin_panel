<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });

	});


	function init{module_name}(){
		LoadDir("", "{document_root}/modules/{module_name}/camera");
	}

	function gphoto_mount(cmd){

		$("#gphotofsstatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/mount.php?rnd=" + Math.random(), {cmd: cmd}, function(response, status, xhr) {

			$("#gphotofsstatus").html("");
			if (status == "success") {
				var json = JSON.parse(response);
				if (json.status == 0) {
					LoadDir("", "{document_root}/modules/{module_name}/camera");
				}

			}
		});

	}


	function LoadDir(dir, parent){
		$("#gphotofsstatus").html('<img src="imgs/loader.gif">');
		$("#gphotofsfilelist").load("modules/{module_name}/load.php?rnd=" + Math.random() + "&dir=" + encodeURIComponent(dir) + "&parent=" + encodeURIComponent(parent), function(response, status, xhr) {
			if (status == "success") {
				$("#gphotofsstatus").html("");
			}
		});
	}


	function ShowPreview(obj, filename){
		$("#" + obj).attr("src", filename);
		$(".previewfiles").css("display", "none");
		$("#" + obj).css("display", "block");
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_VIEW_PHOTOS%</a></h3>
	<div>

		<div>
			<p>
				<a href="#" class="buttonlink" onclick="gphoto_mount(1); return false;">[ %M_MOUNT_DEV% ]</a>
				<a href="#" class="buttonlink" onclick="gphoto_mount(2); return false;">[ %M_UMOUNT_DEV% ]</a>
			</p>
			<div id="gphotofsstatus" style="height:20px;"></div>
			<div id="gphotofsfilelist"></div>
			<p></p>
		</div>

	</div>

</div>

</div>
