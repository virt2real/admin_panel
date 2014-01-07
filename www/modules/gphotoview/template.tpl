<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		LoadDir("", "{document_root}/modules/{module_name}/thumbnails");
	}

	function gphoto_preview(cmd){

		$("#gphotoviewstatus").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/preview.php?rnd=" + Math.random(), {cmd: cmd}, function(response, status, xhr) {
			if (status == "success") {

			$("#gphotoviewstatus").html(response); 
				var json = JSON.parse(response);
				if (json.status == 0) {
					LoadDir("", "{document_root}/modules/{module_name}/thumbnails");
					$("#gphotoviewstatus").html();
				}
				else
					$("#gphotoviewstatus").html(":-(");
				
			}
		});

	}


	function LoadDir(dir, parent){
		$("#gphotoviewstatus").html('<img src="/imgs/loader.gif">');
		$("#gphotoviewfilelist").load("modules/{module_name}/load.php?rnd=" + Math.random() + "&dir=" + encodeURIComponent(dir) + "&parent=" + encodeURIComponent(parent), function(response, status, xhr) {
			if (status == "success") {
				$("#gphotoviewstatus").html("");
			}
		});
	}


</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Просмотр фотографий на камере</a></h3>
	<div>

		<div>
			<p>
				<a href="#" class="buttonlink" onclick="gphoto_preview(1); return false;">[ загрузить превью ]</a>
				<a href="#" class="buttonlink" onclick="gphoto_preview(2); return false;">[ удалить все превью ]</a>
			</p>
			<div id="gphotoviewstatus" style="height:20px;"></div>
			<div id="gphotoviewfilelist"></div>
			<p></p>
		</div>

	</div>

</div>

</div>