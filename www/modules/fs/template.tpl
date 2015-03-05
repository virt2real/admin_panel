<style>
#fs_info pre {
  font-family: "Lucida Console", Monaco, monospace;
}
</style>
<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		LoadDiscInfo();
		LoadFsInfo();
	}

	var globalPartitionsSize = null;

	function LoadDiscInfo() {
		$("#disc_info").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/loaddisc.php?rnd=" + Math.random(), {}, function(response, status, xhr) {
			if (status == "success") {
				try {
					var json;
					json = JSON.parse(response);

					globalPartitionsSize = json; // save values

					var discsize = parseInt(json['/dev/mmcblk0']);
					discsize = parseInt(discsize / 1000000);
					var partition1size = parseInt(json['/dev/mmcblk0p1']);
					var partition2size = parseInt(json['/dev/mmcblk0p2']);
					var partitionsSize = parseInt((partition1size + partition2size) / 1000000);
					$("#disc_info").html("%L_DISCSIZE% " + discsize + " Mb" + "<br>" + "%L_PARTITIONSSIZE%" + partitionsSize + " Mb");

				} catch (err) {
					$("#disc_info").html(":-(");
				}
			}
			if (savestatus == "error") {
				$("#disc_info").html("%L_FAIL%");
			}
		});
	}

	function LoadFsInfo() {
		$("#fs_info").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/load.php?rnd=" + Math.random(), {}, function(response, status, xhr) {
			if (status == "success") {
				$("#fs_info").html(response);
			}
			if (savestatus == "error") {
				$("#fs_info").html("%L_FAIL%");
			}
		});
	}

	function ShowResizePartition() {
		if (!globalPartitionsSize) return;
		var discsize = parseInt(globalPartitionsSize['/dev/mmcblk0']);
		var partition1size = parseInt(globalPartitionsSize['/dev/mmcblk0p1']);
		var partition2size = parseInt(globalPartitionsSize['/dev/mmcblk0p2']);
		var availableSize = parseInt((discsize - partition1size) / 1000000);
		$("#fulldiscsize").html(parseInt(discsize / 1000000) + " Mb");
		$("#currentaprtitionsize").html(parseInt(partition2size / 1000000) + " Mb");
		$("#availablesize").html(availableSize + " Mb");

		$("#newfssize").val(availableSize);

	}

	function DoResize(newsize) {
		var discsize = parseInt(globalPartitionsSize['/dev/mmcblk0']);
		var partition1size = parseInt(globalPartitionsSize['/dev/mmcblk0p1']);
		var partition2size = parseInt(globalPartitionsSize['/dev/mmcblk0p2']);
		var availableSize = parseFloat( parseInt((discsize - partition1size) / 1000000) );

		if (newsize > availableSize) {
			$("#fs_resize_status").html("Новый размер превышает максимальный");
			return;
		}

		if (newsize < (partition2size / 1000000)) {
			$("#fs_resize_status").html("Новый размер не должен быть меньше текущего");
			return;
		}

		$("#fs_resize_status").html('<img src="imgs/loader.gif">');

		$.post("modules/{module_name}/doresize.php?rnd=" + Math.random(), {size: newsize, maxsize: availableSize}, function(response, status, xhr) {
			if (status == "success") {
				$("#fs_resize_message").html("%L_RESIZEMESSAGE%");
				$("#fs_resize_status").html(response);
			}
			if (savestatus == "error") {
				$("#fs_resize_status").html("%L_FAIL%");
			}
		});

	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_TITLE%</a></h3>
	<div>
		<p class="bluetitle">%M_CURRENTDISC%</p>
		<div id="disc_info"></div>

		<p>&nbsp;</p>

		<p class="bluetitle">%M_CURRENTPARTITIONS%</p>
		<div id="fs_info"></div>

	</div>

	<h3><a href="#" onclick="ShowResizePartition(); return false;">%M_TITLE2%</a></h3>
	<div>

		<p class="bluetitle">%M_RESIZETITLE%</p>

		<p><span class="graytext">Полный объём накопителя</span> <span id="fulldiscsize"></span></p>
		<p><span class="graytext">Текущий размер файловой системы</span> <span id="currentaprtitionsize"></span></p>
		<p><span class="graytext">Максимально возможный размер файловой системы</span> <span id="availablesize"></span></p>

		<p>Новый размер файловой системы <input type="text" id="newfssize" style="width:60px; text-align:right;"> Mb</p>

		<p><a href="#" class="buttonlink" onclick="var newsize=$('#newfssize').val(); DoResize(newsize); return false;" style="padding-left:20px;">[ %M_DORESIZE% ]</a></p>

		<div id="fs_resize_message"></div>

		<div id="fs_resize_status" class="graytext"></div>

	</div>


</div>

</div>
