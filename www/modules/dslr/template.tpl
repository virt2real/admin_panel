<style>
.hidden {display:none;}
.control {color:#0380ea; }
#controlblock {display:none;}
#gphotoscanresult { line-height:20px; height:20px; }
.selectbox { color:#7c7c7c;}
#cameranotfoundblock {display:none;}
</style>

<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	function init{module_name}(){
		gphoto_get_config();
	}

	function gphoto_get_cmd(obj, cmd, id, value){
		$("#gphotoscanresult").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/get.php?rnd=" + Math.random(), {obj: obj, cmd: cmd, id: id, value: value}, function(response, status, xhr) {

			$("#gphotoscanresult").html("");
			if (status == "success") {
				var json = JSON.parse(response);
				if (json.status == 0)
					$("#" + json.obj).html("<pre>" + json.text + "</pre>");
				else
					$("#" + json.obj).html("%L_FAIL%");
			} 
				
		});

	}

	function gphoto_shoot(obj, cmd){
		$("#gphotoscanresult").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/shoot.php?rnd=" + Math.random(), {obj:obj,cmd:cmd}, function(response, status, xhr) {
			$("#" + obj).html('');
			$("#gphotoscanresult").html("");
			if (status == "success") {
				var json = JSON.parse(response);
				if (json.status == 0) {
					$("#" + json.obj).html("<pre>" + json.text + "</pre>");
				}
				else
					$("#" + json.obj).html("%L_FAIL%");
				if (json.filename) {
					$("#shotresult").attr("width", "400");
					var rnd = Math.random();
					$("#shotresult").attr("src", "modules/{module_name}/" + json.filename + "?" + rnd);
					$("#bigshotresult").attr("href", "modules/{module_name}/" + json.filename + "?" + rnd);
				}
			}
		});

	}

	function camera_found () {
		$("#controlblock").css("display", "block");
	}

	function camera_not_found () {
		$("#cameranotfoundblock").css("display", "block");
	}

	function gphoto_get_config(){
		$("#gphotoscanresult").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/parse.php?rnd=" + Math.random(), {}, function(response, status, xhr) {
			if (response.length < 30) {
				$("#gphotoscanresult").html("");
				camera_not_found();
				return;
			}

			var json;
			try {
				json = JSON.parse(response);
				for (var index in json) {
					ParseControls(json[index]);
				}
				$("#gphotoscanresult").html(result);
			} catch (err) {
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
		camera_found();

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

	<h3><a href="#">%M_DESC%</a></h3>
	<div class="gphotoctrl">

		<div id="gphotoscanresult"></div>

		<div id="cameranotfoundblock">
			Убедитесь что DSLR камера включена и подключена к USB Виртурилки
		</div>

		<div id="controlblock">
		<table width="100%" align="left">
			<tr valign="top">
				<td width="450">
					<p><a href="modules/{module_name}/capture_preview.jpg" id="bigshotresult" target="_blank"><img src="modules/{module_name}/capture_preview.jpg" id="shotresult" width="400"></a></p>

					<p><a href="#" class="buttonlink" onclick="gphoto_shoot('gphotoresultconfig', 1); return false;">[ %M_PREVIEW% ]</a></p>
					<p><a href="#" class="buttonlink" onclick="gphoto_shoot('gphotoresultconfig', 2); return false;">[ %M_TAKE_PIC% ]</a></p>
					<p><a href="#" class="buttonlink" onclick="gphoto_shoot('gphotoresultconfig', 3); return false;">[ %M_TAKE_PIC2% ]</a></p>

				</td>
				<td>
					<span id="_main_capturesettings_shutterspeed_title" class="graytext hidden">%M_EXPOSURE%</span>
					<div id="_main_capturesettings_shutterspeed" style="width: 100px; height: 25px; font-size: 1.2em;"></div>
                    <p></p>
					<span id="_main_capturesettings_aperture_title" class="graytext hidden">%M_DIAPHRAGM%</span>
					<div id="_main_capturesettings_aperture" style="width: 100px; height: 25px; font-size: 1.2em;"></div>
                    <p></p>
					<span id="_main_imgsettings_iso_title" class="graytext hidden">%M_ISO%</span>
					<div id="_main_imgsettings_iso" style="width: 100px; height: 25px; font-size: 1.2em;"></div>
                    <p></p>
					<span id="_main_capturesettings_focusmode_title" class="graytext hidden">%M_FOCUS_MODE%</span>
					<div id="_main_capturesettings_focusmode" style="width: 170px; height: 25px; font-size: 1.2em;"></div>
                    <p></p>
					<span id="_main_imgsettings_whitebalance_title" class="graytext hidden">%M_WHITE_BALANCE%</span>
					<div id="_main_imgsettings_whitebalance" style="width: 170px; height: 25px; font-size: 1.2em;"></div>
                    <p></p>
					<span id="_main_capturesettings_picturestyle_title" class="graytext hidden">%M_PIC_STYLE%</span>
					<div id="_main_capturesettings_picturestyle" style="width: 170px; height: 25px; font-size: 1.2em;"></div>
                    <p></p>
					<span id="_main_capturesettings_meteringmode_title" class="graytext hidden">%M_METERING_MODE%</span>
					<div id="_main_capturesettings_meteringmode" style="width: 170px; height: 25px; font-size: 1.2em;"></div>
                    <p></p>
					<span id="_main_capturesettings_drivemode_title" class="graytext hidden">%M_DRIVE_MODE%</span>
					<div id="_main_capturesettings_drivemode" style="width: 170px; height: 25px; font-size: 1.2em;"></div>
                    <p></p>
					<span id="_main_capturesettings_autoexposuremode_title" class="graytext hidden">%M_AUTO_EXP_MODE%</span>
					<div id="_main_capturesettings_autoexposuremode" style="width: 150px; height: 25px; font-size: 1.2em;"></div>
                    <p></p>
					<span id="_main_capturesettings_aeb_title" class="graytext hidden">%M_EXP_BRACKETING%</span>
					<div id="_main_capturesettings_aeb" style="width: 150px; height: 25px; font-size: 1.2em;"></div>
                    <p></p>
					<span id="_main_capturesettings_autoexposuremode_title" class="bluetitle">%M_AUTO_EXP_MODE%</span>
					<div id="_main_capturesettings_autoexposuremode" style="width: 150px; height: 25px; font-size: 1.2em;"></div>
                    <p></p>
					<span id="_main_capturesettings_aeb_title" class="bluetitle">%M_EXP_BRACKETING%</span>
					<div id="_main_capturesettings_aeb" style="width: 150px; height: 25px; font-size: 1.2em;"></div>

				</td>
				<td width="250">
					<span id="_main_status_manufacturer_title" class="graytext hidden">%M_MANUFACTURER%</span>
					<div id="_main_status_manufacturer" class="control"></div>
                    <p></p>
					<span id="_main_status_cameramodel_title" class="graytext hidden">%M_MODEL%</span>
					<div id="_main_status_cameramodel" class="control"></div>
                    <p></p>
					<span id="_main_status_serialnumber_title" class="graytext hidden">%M_SERIAL_NUMBER%</span>
					<div id="_main_status_serialnumber" class="control"></div>
                    <p></p>
					<span id="_main_status_deviceversion_title" class="graytext hidden">%M_DEV_VERSION%</span>
					<div id="_main_status_deviceversion" class="control"></div>
                    <p></p>
					<span id="_main_status_shuttercounter_title" class="graytext hidden">%M_SHUTTER_COUNTER%</span>
					<div id="_main_status_shuttercounter" class="control"></div>
                    <p></p>
					<span id="_main_status_batterylevel_title" class="graytext hidden">%M_BATTERY_LEVEL%</span>
					<div id="_main_status_batterylevel" class="control"></div>
                    <p></p>
					<span id="_main_settings_datetime_title" class="graytext hidden">%M_DATE_TIME%</span>
					<div id="_main_settings_datetime" class="control"></div>
                    <p></p>
					<span id="_main_status_lensname_title" class="graytext hidden">%M_LENS_NAME%</span>
					<div id="_main_status_lensname" class="control"></div>
                    <p></p>
					<span id="_main_status_eosserialnumber_title" class="graytext hidden">%M_EOS_SERIAL_NUMBER%</span>
					<div id="_main_status_eosserialnumber" class="control"></div>
                    <p></p>
					<span id="_main_status_availableshots_title" class="graytext hidden">%M_SHOTS_AVAIL%</span>
					<div id="_main_status_availableshots" class="control"></div>
                    <p></p>
					<span id="_main_settings_ownername_title" class="graytext hidden">%M_OWNER%</span>
					<div id="_main_settings_ownername" class="control"></div>
                    <p></p>
					<span id="_main_settings_artist_title" class="graytext hidden">%M_AUTHOR%</span>
					<div id="_main_settings_artist" class="control"></div>
                    <p></p>
					<span id="_main_settings_copyright_title" class="graytext hidden">%M_COPYRIGHT%</span>
					<div id="_main_settings_copyright" class="control"></div>
				</td>
			</tr>
		</table>		
		</div>

		<div id="gphotoresult"></div>

	</div>

	<h3><a href="#">%M_OTHER_SETTINGS%</a></h3>
	<div class="gphotoctrl">

		<p class="bluetitle">%M_OTHER_CONTROLS%</p>
		<div id="othercontrols"></div>


		<p>
			<a href="#" class="buttonlink" onclick="gphoto_get_cmd('gphotoresultconfig', '--list-all-config'); return false;">[ %M_SHOW_FULL_CONFIG% ]</a>
		</p>

		<div id="gphotoresultconfig"></div>

	</div>

</div>

</div>
