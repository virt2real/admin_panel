<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		GetInfo ();
		$("#nandtype").buttonset();
	}

	function GetInfo () {
		$.get("modules/{module_name}/check.php?rnd=" + Math.random(), function(response, status, xhr) {
			if (status == "success") {
				$("#nandstatus").html(response);
			}
			if (status == "error") {
				$("#nandstatus").html("%L_FAIL%");
			}
		});
	}

	function NandWrite () {
		if ("{intboottype}" == 2) {
			$("#nandwritestatus").html('%M_ERR_NO_NAND_BOOT%');
			return;
		}

		var fs;

		$("#nandwritestatus").html('<img src="imgs/loader.gif">');

		if ($("#nand_ubi").attr("checked") == "checked") fs = 0;
		if ($("#nand_jffs").attr("checked") == "checked") fs = 1;

		$.ajax({
			url: "modules/{module_name}/write.php?fs=" + fs + "&rnd=" + Math.random(),
			type: 'GET',
			timeout: 600000,
			success: function(data){
				$("#nandwritestatus").html(data);
			},
			error: function(data, err){
				$("#nandwritestatus").html('');
			}
		});
	}

	function CmdlineWrite () {
		var fs;
		var text = $("#newcmdline").val();
		$("#cmdlinewritestatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/cmdlinewrite.php?rnd=" + Math.random(), {text: text}, function(response, status, xhr) {
			if (status == "success") {
				$("#cmdlinewritestatus").html(response);
			}
			if (savestatus == "error") {
				$("#cmdlinewritestatus").html("%L_FAIL%");
			}
		});
	}

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_DESC%</a></h3>
	<div>
		<p class="bluetitle">%M_DEV_PART_INFO%</p>
		<span id="nandstatus"></span>

		<p>&nbsp;</p>

		<p class="bluetitle">%M_NAND_FLASH%</p>

		<div id="nandtype" style="display:inline;">
			<input type="radio" id="nand_ubi" name="radio" checked><label for="nand_ubi">%M_UBI%</label>
			<input type="radio" id="nand_jffs" name="radio"><label for="nand_jffs">%M_JFFS%</label>
		</div>

		<p style="display:inline;"><a href="#" class="buttonlink" onclick="NandWrite(); return false;" style="padding-left:20px;">[ %M_FLASH% ]</a></p>

		<p id="nandwritestatus"></p>

		<p class="graytext">%M_REC_FS_DEFAULT%</p>

		<p class="graytext">%M_DC_DURING_FLASHING%</p>


	</div>

	<h3><a href="#">%M_CMDLINE%</a></h3>
	<div>
		<p class="bluetitle">%M_CMDLINETITLE%</p>
		<p><textarea type="text" id="newcmdline" style="width:90%;height:200px;">{cmdlinevalue}</textarea></p>

		<p style="display:inline;"><a href="#" class="buttonlink" onclick="CmdlineWrite(); return false;" style="padding-left:20px;">[ %M_FLASH% ]</a></p>

		<p id="cmdlinewritestatus"></p>

	</div>
</div>
