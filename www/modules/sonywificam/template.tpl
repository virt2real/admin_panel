<style>
#photomode { color:#7c7c7c; }
#videomode { color:#7c7c7c; }
#stillblock { display:none; }
#movieblock { display:none; }
#sendrequeststatus { line-height:20px; height:20px; }
</style>

<script>
	$(function() {
		$( "#accordion" ).accordion({ fillSpace: false, autoHeight: false, navigation: false, create: function( event, ui ) {init{module_name}();} });
	});

	var actionUrl = "";
	var shotMode;

	function init{module_name} () {
		check_device ();
		LoadDir("", "{document_root}/admin/modules/{module_name}/images");
	}

	function device_found (json) {
		var result = "";
		if (json.server) result += '<span class="graytext">Модель</span> <span class="bluetitle">' + json.modelName + ' ' + json.friendlyName + '</span><br>';
		$("#modelinfo").html(result);

		/* save action URL */
		actionUrl = json.actionUrl;

		setTimeout("check_base_params()", 100);

		$("#searchblock").css("display", "none");
		$("#controlblock").css("display", "block");
	}

	function check_device () {
		$("#discoverstate").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/check.php?rnd=" + Math.random(), {}, function(response, status, xhr) {
			if (status == "success") {
				var json;
				var result = "";
				try {
					json = JSON.parse(response);
					device_found(json);
				} catch (err) {
					result = "Камера не обнаружена, убедитесь что она включена, а Виртурилка подключена к ней по Wi-Fi";
					setTimeout("check_device()", 5000);
				}

				$("#discoverstate").html(result);
			}
			if (status == "error") {
				$("#discoverstate").html("%M_FAIL%");
			}

		});
	}

	function check_base_params () {
		$("#sendrequeststatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/checkbaseparams.php?rnd=" + Math.random(), {url: actionUrl}, function(response, status, xhr) {
			$("#sendrequeststatus").html("");
			if (status == "success") {
				var json = {};
				var result = "";
				$("#paramlist").html("");

				try {
					json = JSON.parse(response);
				} catch (err) {}

				try {
					if (json.getEvent[14].currentAspect) result += '<span class="graytext">Соотношение сторон</span> <span class="bluetitle">' + json.getEvent[14].currentAspect + '</span><br>';
				} catch (err) {}
				try {
					if (json.getEvent[14].currentSize) result += '<span class="graytext">Разрешение фото</span> <span class="bluetitle">' + json.getEvent[14].currentSize + '</span><br>';
				} catch (err) {}
				try {
					if (json.getEvent[19].currentPostviewImageSize) result += '<span class="graytext">Разрешение предпросмотра</span> <span class="bluetitle">' + json.getEvent[19].currentPostviewImageSize + '</span><br>';
				} catch (err) {}
				try {
					if (json.getEvent[18].currentExposureMode) result += '<span class="graytext">Экспозиция</span> <span class="bluetitle">' + json.getEvent[18].currentExposureMode + '</span><br>';
				} catch (err) {}
				try {
					if (json.getEvent[4].liveviewOrientation) result += '<span class="graytext">Ориентация</span> <span class="bluetitle">' + json.getEvent[4].liveviewOrientation + '&deg;</span><br>';
				} catch (err) {}
				try {
					if (json.getEvent[28].currentFocusMode) result += '<span class="graytext">Фокусировка</span> <span class="bluetitle">' + json.getEvent[28].currentFocusMode + '</span><br>';
				} catch (err) {}
				try {
					if (json.getEvent[21].currentShootMode) result += '<span class="graytext">Режим</span> <span class="bluetitle">' + json.getEvent[21].currentShootMode + '</span><br>';
					shotMode = json.getEvent[21].currentShootMode;
					if (shotMode == "still") {
						$("#photomode").css("color","#ffffff");
						$("#videomode").css("color","#7c7c7c");
						$("#movieblock").css("display", "none");
						$("#stillblock").css("display", "block");
					}
					if (shotMode == "movie") {
						$("#videomode").css("color","#ffffff");
						$("#photomode").css("color","#7c7c7c");
						$("#stillblock").css("display", "none");
						$("#movieblock").css("display", "block");
					}

				} catch (err) {}
				try {
					if (json.getEvent[2].zoomPosition) result += '<span class="graytext">Зум</span> <span class="bluetitle">' + json.getEvent[2].zoomPosition + ' %</span><br>';
				} catch (err) {}

				$("#paramlist").html(result);

			}
		});
	}


	function send_request (method, params, callback) {
		var request = { method: method, params: params, id: 1, version: "1.0"}
		var strrequest = JSON.stringify(request);
		$("#sendrequeststatus").html('<img src="imgs/loader.gif">');
		$.post("modules/{module_name}/sendrequest.php?rnd=" + Math.random(), {url: actionUrl, request: strrequest}, function(response, status, xhr) {
			if (status == "success") {
				//$("#sendrequeststatus").html(response);
				if (callback)
					callback(response);
				setTimeout("check_base_params()", 100);
			}
			if (status == "error") {
				$("#sendrequeststatus").html("%M_FAIL%");
			}
		});
	}


	function shot() {
		send_request("actTakePicture", [], callback_shoot);
	}

	function rec(state) {
		if (state)
			send_request("startMovieRec", [], null);
		else
			send_request("stopMovieRec", [], null);
	}

	function callback_shoot(message) {
		var result = "";
		try {
			json = JSON.parse(message);
			result = json.result;
			$("#shotresult").css("display", "none");
			$("#shotresult").attr("width", "400");
			$("#shotresult").attr("src", "modules/{module_name}/images/" + result);
			$("#bigshotresult").attr("href", "modules/{module_name}/images/" + result);
			$("#shotresult").css("display", "block");
			LoadDir("", "{document_root}/admin/modules/{module_name}/images");
		} catch (err) {
			result = "wrong answer";
		}
		$("#filenameinfo").html('<span class="graytext">Имя файла:</span> <span class="bluetitle">' + result + '</span>');
	}

   	function setShootModeCallback () {
		setTimeout("check_base_params()", 100);
	}

	function liveview(state) {
		if (state)
			send_request("startLiveview", [], callback_liveview_start);
		else
			send_request("stopLiveview", [], callback_liveview_stop);
	}

	function callback_liveview_start (message) {
		$("#sendrequeststatus").html(message);
	}

	function callback_liveview_stop (message) {
	}


	/////////////////////////////////// file manager part /////////////////////////////////////

	function LoadDir(dir, parent){
		$("#loadstatus").html('<img src="imgs/loader.gif">');
		$("#localimagesfilemanager").load("modules/{module_name}/load.php?rnd=" + Math.random() + "&dir=" + encodeURIComponent(dir) + "&parent=" + encodeURIComponent(parent), function(response, status, xhr) {
			if (status == "success") {
				$("#loadstatus").html("");
			}
		});
	}


</script>

<div id="accordion" style="margin:0; padding:0;">

	<h3><a href="#">%M_CAMERA_CONTROL%</a></h3>
	<div>
		<div id="searchblock">
			<div class="graytext">
				Данный раздел предназначен для управления камерами SONY, подключаемыми по беспроводной связи<br>
				(проверено на модели DSC-QX100)
			</div>
			<p></p>
			<p>Убедитесь что Виртурилка настроена на точку доступа камеры. Точка доступа настраивается в разделе <a href="?wlan">Настройки-> Wi-Fi-> Настройка Wi-Fi</a></p>
			<div id="discoverstate"></div>
		</div>

		<div id="controlblock" style="display:none;">
			<div id="modelinfo"></div>
			<div id="sendrequeststatus"></div>
			<table width="100%">
				<tr valign="top">
					<td width="450">
						<p><a href="#" id="bigshotresult" target="_blank"><img src="modules/{module_name}/imgs/defaultframe.png" id="shotresult"></a></p>
						<div id="filenameinfo"></div>

						<p>
							<span class="graytext">Режим: </span>
							<a href="#" id="photomode" onclick='send_request("setShootMode", ["still"], setShootModeCallback); return false;'>фото</a>
							<a href="#" id="videomode" onclick='send_request("setShootMode", ["movie"], setShootModeCallback); return false;'>видео</a>
						</p>

						<div id="paramlist"></div>

					</td>
					<td>
						<p>
							<span class="graytext">Приблизить</span><br>
							<a href="#" onclick='send_request("actZoom", ["in","start"], null); return false;'>до упора</a>
							<a href="#" onclick='send_request("actZoom", ["in","1shot"], null); return false;'>на шаг</a>
						</p>
						<p>
							<span class="graytext">Удалить</span><br>
							<a href="#" onclick='send_request("actZoom", ["out","start"], null); return false;'>до упора</a>
							<a href="#" onclick='send_request("actZoom", ["out","1shot"], null); return false;'>на шаг</a>
						</p>

						<p>&nbsp;</p>

						<div id="stillblock">
							<p class="graytext">Сделать снимок</p>
							<a href="#" onclick='shot(); return false;'><img src="modules/{module_name}/imgs/shot2.png" width="50" title="сделать снимок"></a>

							<p>
								<span class="graytext">Размер фоток для просмотра</span><br>
								<a href="#" onclick='send_request("setPostviewImageSize", ["2M"], null); return false;'>2M</a>
								<a href="#" onclick='send_request("setPostviewImageSize", ["Original"], null); return false;'>Original</a>
							</p>

							<p>
								<span class="graytext">Режим экспозиции</span><br>
								<a href="#" onclick='send_request("setExposureMode", ["Intelligent Auto"], null); return false;'>Intelligent Auto</a>
								<a href="#" onclick='send_request("setExposureMode", ["Superior Auto"], null); return false;'>Superior Auto</a>
								<a href="#" onclick='send_request("setExposureMode", ["Program Auto"], null); return false;'>Program Auto</a>
								<a href="#" onclick='send_request("setExposureMode", ["Aperture"], null); return false;'>Aperture</a>
								<a href="#" onclick='send_request("setExposureMode", ["Shutter"], null); return false;'>Shutter</a>
							</p>
						</div>

						<div id="movieblock">
							<p class="graytext">Запись видео</p>
							<a href="#" onclick='rec(true); return false;'>старт</a>
							<a href="#" onclick='rec(false); return false;'>стоп</a>
						</div>

					</td>
				</tr>
			</table>
		</div>
	</div>

	<h3><a href="#">%M_CAMERA_IMAGES%</a></h3>
	<div>

		<div id="loadstatus"></div>
		<div id="localimagesfilemanager"></div>

	</div>

</div>

