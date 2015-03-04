<script type="text/javascript" src="js/ajaxupload.js"></script>

<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		LoadDir("", "/");
		//ActivateUpload();
	}

	var currentDir;
	var currentParent;

	function ActivateUpload() {
		$.ajax_upload($('#uploadButton'), {
			action : 'modules/{module_name}/upload.php',
			name : 'myfile',
			type: "POST",
			onSubmit : function(file, ext) {
				$("img#load").css("width", "126");
				$("img#load").attr("src", "imgs/loader.gif");
				this.settings.data = {"dir":currentDir, "parent":currentParent};
				this.disable();
			},
			onComplete : function(file, response) {
				$("img#load").css("width", "30");
				$("img#load").attr("src", "modules/{module_name}/imgs/upload.png");
				this.enable();
				LoadDir(currentDir, currentParent); // renew current dir
			}
		});
	}


	function LoadDir(dir, parent){
		currentDir = dir;
		currentParent = parent;
		$("#status").html('<img src="imgs/loader.gif">');
		$("#filelist").load("modules/{module_name}/load.php?rnd=" + Math.random() + "&dir=" + encodeURIComponent(dir) + "&parent=" + encodeURIComponent(parent), function(response, status, xhr) {
			if (status == "success") {
				$("#status").html("");
			}
			if (status == "error") {
				$("#status").html("%L_FAIL%");
			}
		});
	}

	function EditFile(dir, parent){
		$("#status").html('<img src="imgs/loader.gif">');
		$("#fileedit").load("modules/{module_name}/edit.php?rnd=" + Math.random() + "&dir=" + encodeURIComponent(dir) + "&parent=" + encodeURIComponent(parent), function(response, status, xhr) {
			if (status == "success") {
				$("#status").html("");
				$("#savebutton").prop("disabled", true);
				$("#filelist").css("display", "none");
				$("#editfileblock").css("display", "block");
				$("#savestatus").html("");
			}
			if (status == "error") {
				$("#status").html("%L_FAIL%");
			}
		});
	}

	function SaveFile(file, text){
		$("#savestatus").html('<img src="imgs/loader.gif">');

		$.post("modules/{module_name}/save.php?rnd=" + Math.random(), {file: file, text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#savestatus").html("%M_SAVE_SUCCESS%");
				$("#savebutton").prop("disabled", true);
			}
			if (savestatus == "error") {
				$("#status").html("%L_FAIL%");
			}
		});
	}

	function MakeSaveButtonActive(){
		$("#savebutton").prop("disabled", false);
		$("#savestatus").html("");
	}

	function RmDir(dir, parent) {
		var isAdmin = confirm("%M_REMOVE_ALERT% " + parent + dir + " ?");
		if (!isAdmin) return;

		$("#status").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/remove.php?rnd=" + Math.random(), {dir: encodeURIComponent(dir), parent: encodeURIComponent(parent)}, function(response, status, xhr) {
			if (status == "success") {
				$("#status").html("");
			}
			if (status == "error") {
				$("#status").html("%L_FAIL%");
			}
			LoadDir(currentDir, currentParent); // renew current dir
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_FILE_MANAGE_EDIT%</a></h3>
	<div>
		<div id="status" style="height: 26px; text-align: right; width: 100%;"></div>

        <div id="uploadButton" class="button" onclick="ActivateUpload(); return false;">
            <img id="load" src="modules/{module_name}/imgs/upload.png" width=30>
        </div>


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
