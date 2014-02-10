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
				$("#nandstatus").html(":-(");
			}
		});
	}

	function NandWrite () {

		if ("{intboottype}" == 2) {
			$("#nandwritestatus").html('Прошивка NAND недоступна в режиме загрузки с NAND');
			return;
		}

		var fs;

		$("#nandwritestatus").html('<img src="/imgs/loader.gif">');

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

</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">NAND</a></h3>
	<div>
		<p class="bluetitle">Информация о разделах и устройствах</p>
		<span id="nandstatus"></span>

		<p>&nbsp;</p>

		<p class="bluetitle">Прошивка NAND</p>

		<div id="nandtype" style="display:inline;">
			<input type="radio" id="nand_ubi" name="radio" checked><label for="nand_ubi">UBI</label>
			<input type="radio" id="nand_jffs" name="radio"><label for="nand_jffs">JFFS</label>
		</div>

		<p style="display:inline;"><a href="#" class="buttonlink" onclick="NandWrite(); return false;" style="padding-left:20px;">[ Прошить ]</a></p>
	
		<p id="nandwritestatus"></p>

		<p class="graytext">Рекомендуемый тип файловой системы - UBI (выбран по умолчанию)</p>

		<p class="graytext">После нажатия кнопки "Прошить" возможно пропадание связи, по окончании процесса прошивки коннект восстановится</p>


	</div>

</div>