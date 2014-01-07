<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		gphoto_get_config();
	}

	function gphoto_get_cmd(obj, cmd, id, value){
		$("#" + obj).html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/get.php?rnd=" + Math.random(), {obj: obj, cmd: cmd, id: id, value: value}, function(response, status, xhr) {			$("#" + obj).html('');			if (status == "success") {
				var json = JSON.parse(response);
				if (json.status == 0)
					$("#" + json.obj).html("<pre>" + json.text + "</pre>");
				else
					$("#" + json.obj).html(":-(");
				
			}
		});

	}

	function gphoto_shoot(obj, cmd){
		$("#" + obj).html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/shoot.php?rnd=" + Math.random(), {obj: obj, cmd: cmd}, function(response, status, xhr) {

			$("#" + obj).html('');
			if (status == "success") {
				var json = JSON.parse(response);
				if (json.status == 0)
					$("#" + json.obj).html("<pre>" + json.text + "</pre>");
				else
					$("#" + json.obj).html(":-(");
				
			}
		});

	}



	function gphoto_get_config(){
		$("#gphotoscanresult").html('<img src="/imgs/loader.gif">');
		$.post("modules/{module_name}/parse.php?rnd=" + Math.random(), {}, function(response, status, xhr) {

			var json = JSON.parse(response);

			for (var index in json) {
				ParseControls(json[index]);
			}

		});

	}

	function ParseControls(element){
		
		$("#gphotoscanresult").html("");

		if (element['name'] == "/end") return;

		switch (element['type']) {

			case "TEXT":
			case "TOGGLE":
				// mask forbidden symbold ("/")
				var el_name = element['name'].replace(/\//g,"_");

				if (! $("div").is("#" + el_name)) {

					// create new element
					var newDiv = document.createElement('div');
					newDiv.id = el_name;
					$("#othercontrols").append(newDiv);
					
					$("#" + el_name).append(element['label'] + ": ");

				} else {
					// show element title
					$("#" + el_name + "_title").css("display", "block");
				}


				$("#" + el_name).append(element['current']);

			break;

			case "DATE":
				// mask forbidden symbold ("/")
				var el_name = element['name'].replace(/\//g,"_");

				if (! $("div").is("#" + el_name)) {

					// create new element
					var newDiv = document.createElement('div');
					newDiv.id = el_name;
					$("#othercontrols").append(newDiv);
					
					$("#" + el_name).append(element['label'] + ": ");

				} else {
					// show element title
					$("#" + el_name + "_title").css("display", "block");
				}


				$("#" + el_name).append(element['printable']);

			break;


			case "RADIO":
			case "MENU":
				// mask forbidden symbold ("/")
				var el_name = element['name'].replace(/\//g,"_");

				if (! $("div").is("#" + el_name)) {

					// create new element
					var newDiv = document.createElement('div');
					newDiv.id = el_name;
					$("#othercontrols").append(newDiv);
					
					$("#" + el_name).append("<p>" + element['label'] + ":</p>");

				} else {
					// show element title
					$("#" + el_name + "_title").css("display", "block");
				}


				$("#" + el_name).append('<select id="' + el_name + '_select" class="selectbox"></select>');

				// split choice string on parts
				var tmp = element['choice'].split(";");
				for (var i in tmp) {
					$("#" + el_name + "_select").append( $('<option value="' + i + '"> ' + tmp[i] + ' </option>'));
				}

				// make default selected, spaces VERY MAJORS
				$("#" + el_name + "_select :contains(' " + element['current'] + " ')").attr("selected", "selected");

				$("#" + el_name + "_select").bind('change', function () {
					// if changed - send new value to camera
					SaveOption(this.id, this.value);
				});

			break;
		

			default:
				$("#gphotoresult").append(res + "<br>");

		}


	}

	function SaveOption(id, value) {

		// make demasking replaces
		id = id.replace(/_select/g,"");
		id = id.replace(/_/g,"/");

		// send value to camera
		gphoto_get_cmd('gphotoresultconfig', 1, id, value);
		                                        
	}

</script>


<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">Информация о камере</a></h3>
	<div class="gphotoctrl">

		<div id="gphotoscanresult"></div>

		<table width=100% align=left>
			<tr valign=top>
				<td width=300>&nbsp;
					<p id="_main_status_manufacturer_title" class="bluetitle">Производитель</p>
					<div id="_main_status_manufacturer" class="control"></div>

					<p id="_main_status_cameramodel_title" class="bluetitle">Модель</p>
					<div id="_main_status_cameramodel" class="control"></div>

					<p id="_main_status_serialnumber_title" class="bluetitle">Серийный номер</p>
					<div id="_main_status_serialnumber" class="control"></div>

					<p id="_main_status_deviceversion_title" class="bluetitle">Версия устройства</p>
					<div id="_main_status_deviceversion" class="control"></div>

					<p id="_main_status_shuttercounter_title" class="bluetitle">Срабатываний затвора</p>
					<div id="_main_status_shuttercounter" class="control"></div>

					<p id="_main_status_batterylevel_title" class="bluetitle">Заряд батареи</p>
					<div id="_main_status_batterylevel" class="control"></div>

					<p id="_main_settings_datetime_title" class="bluetitle">Дата и время</p>
					<div id="_main_settings_datetime" class="control"></div>

					
				</td>
				<td width=300>&nbsp;

					<p id="_main_status_lensname_title" class="bluetitle">Оптика</p>
					<div id="_main_status_lensname" class="control"></div>

					<p id="_main_status_eosserialnumber_title" class="bluetitle">Серийный номер EOS</p>
					<div id="_main_status_eosserialnumber" class="control"></div>

					<p id="_main_status_availableshots_title" class="bluetitle">Ещё влезет снимков</p>
					<div id="_main_status_availableshots" class="control"></div>

				</td>
				<td width=300>&nbsp;
					<p id="_main_settings_ownername_title" class="bluetitle">Владелец</p>
					<div id="_main_settings_ownername" class="control"></div>
					<p id="_main_settings_artist_title" class="bluetitle">Автор</p>
					<div id="_main_settings_artist" class="control"></div>
					<p id="_main_settings_copyright_title" class="bluetitle">Копирайт</p>
					<div id="_main_settings_copyright" class="control"></div>
				</td>
				<td>&nbsp;
				</td>
				<td>&nbsp;
				</td>
			</tr>
		</table>



		<div id="gphotoresult"></div>


	</div>

	<h3><a href="#">Управление камерой</a></h3>
	<div class="gphotoctrl">

		<table width=100% align=left>
			<tr valign=top>
				<td width=200>&nbsp;
					<img src="/" width=160>
				</td>
				<td>
					<p><a href="#" class="buttonlink" onclick="gphoto_shoot('gphotoresultconfig', 1); return false;">[ предпросмотр ]</a></p>
					<p><a href="#" class="buttonlink" onclick="gphoto_shoot('gphotoresultconfig', 2); return false;">[ сфотать ]</a></p>
				</td>
			</tr>
		</table>


		<table width=100% align=left>
			<tr valign=top>
				<td width=200>&nbsp;

					<p id="_main_capturesettings_shutterspeed_title" class="bluetitle">Выдержка</p>
					<div id="_main_capturesettings_shutterspeed" style="width: 100px; height: 25px; font-size: 1.2em;"></div>

					<p id="_main_capturesettings_aperture_title" class="bluetitle">Диафрагма</p>
					<div id="_main_capturesettings_aperture" style="width: 100px; height: 25px; font-size: 1.2em;"></div>

					<p id="_main_imgsettings_iso_title" class="bluetitle">ISO</p>
					<div id="_main_imgsettings_iso" style="width: 100px; height: 25px; font-size: 1.2em;"></div>


				</td>
				<td width=250>&nbsp;

					<p id="_main_capturesettings_focusmode_title" class="bluetitle">Режим фокусировки</p>
					<div id="_main_capturesettings_focusmode" style="width: 170px; height: 25px; font-size: 1.2em;"></div>

					<p id="_main_imgsettings_whitebalance_title" class="bluetitle">Баланс белого</p>
					<div id="_main_imgsettings_whitebalance" style="width: 170px; height: 25px; font-size: 1.2em;"></div>

					<p id="_main_capturesettings_picturestyle_title" class="bluetitle">Стиль изображения</p>
					<div id="_main_capturesettings_picturestyle" style="width: 170px; height: 25px; font-size: 1.2em;"></div>

					<p id="_main_capturesettings_meteringmode_title" class="bluetitle">Тип замера</p>
					<div id="_main_capturesettings_meteringmode" style="width: 170px; height: 25px; font-size: 1.2em;"></div>

					<p id="_main_capturesettings_drivemode_title" class="bluetitle">Режим привода</p>
					<div id="_main_capturesettings_drivemode" style="width: 170px; height: 25px; font-size: 1.2em;"></div>


				</td>

				<td>&nbsp;

					<p id="_main_capturesettings_autoexposuremode_title" class="bluetitle">Текущий режим экспозиции</p>
					<div id="_main_capturesettings_autoexposuremode" style="width: 150px; height: 25px; font-size: 1.2em;"></div>

					<p id="_main_capturesettings_aeb_title" class="bluetitle">Брэкетинг экспозиции</p>
					<div id="_main_capturesettings_aeb" style="width: 150px; height: 25px; font-size: 1.2em;"></div>

				</td>
				<td>&nbsp;
				</td>
			</tr>
		</table>
	</div>

	<h3><a href="#">Остальные настройки</a></h3>
	<div class="gphotoctrl">

		<p class="bluetitle">Другие настройки</p>
		<div id="othercontrols"></div>


		<p>
			<a href="#" class="buttonlink" onclick="gphoto_get_cmd('gphotoresultconfig', '--list-all-config'); return false;">[ показать полный конфиг медиаустройства]</a>
		</p>

		<div id="gphotoresultconfig"></div>

	</div>

</div>

</div>