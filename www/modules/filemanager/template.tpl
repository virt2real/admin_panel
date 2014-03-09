<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		LoadDir("", "/");
	}

	function LoadDir(dir, parent){
		$("#status").html('<img src="/imgs/loader.gif">');
		$("#filelist").load("modules/{module_name}/load.php?rnd=" + Math.random() + "&dir=" + encodeURIComponent(dir) + "&parent=" + encodeURIComponent(parent), function(response, status, xhr) {
			if (status == "success") {
				$("#status").html("");
			}
			if (status == "error") {
				$("#status").html(":-(");
			}
		});
	}

	function EditFile(dir, parent){
		$("#status").html('<img src="/imgs/loader.gif">');
		$("#fileedit").load("modules/{module_name}/edit.php?rnd=" + Math.random() + "&dir=" + encodeURIComponent(dir) + "&parent=" + encodeURIComponent(parent), function(response, status, xhr) {
			if (status == "success") {
				$("#status").html("");
				$("#savebutton").prop("disabled", true);
				$("#filelist").css("display", "none");
				$("#editfileblock").css("display", "block");
				$("#savestatus").html("");
			}
			if (status == "error") {
				$("#status").html(":-(");
			}
		});
	}

	function SaveFile(file, text){
		$("#savestatus").html('<img src="/imgs/loader.gif">');

		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {file: file, text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#savestatus").html("%M_SAVE_SUCCESS%");
				$("#savebutton").prop("disabled", true);
			}
			if (savestatus == "error") {
				$("#status").html(":-(");
			}
		});
	}

	function MakeSaveButtonActive(){
		$("#savebutton").prop("disabled", false);
		$("#savestatus").html("");
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_FILE_MANAGE_EDIT%</a></h3>
	<div>
		<div id="status" style="height: 26px; text-align: right; width: 100%;"></div>

		<div id="editfileblock" style="display: none; height: auto;">
			<p><a href="#" onclick='$("#editfileblock").css("display", "none"); $("#filelist").css("display", "block"); return false;'>[ %M_BACK% ]</a></p>
			<div id="fileedit" style="height: auto;"></div>
			<p></p>
			<div>
				<input type="button" value="%L_SAVE%" id="savebutton" disabled="disabled" onclick='SaveFile($("#filename").html(), $("#filecontent").val()); return false;'>
				<input type="button" value="%M_RETURN%" onclick='$("#editfileblock").css("display", "none"); $("#filelist").css("display", "block"); return false;'>
				<span id="savestatus"></span>
			</div>
		</div>

		<div id="filelist"></div>

	</div>

</div>
