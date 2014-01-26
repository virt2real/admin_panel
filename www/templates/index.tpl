<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru" lang="ru">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>

	<link rel="stylesheet" href="/js/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />
	<link type="text/css" href="css/vader/jquery-ui-1.8.21.custom.css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="css/style.css"/>
	<link rel="shortcut icon" href="imgs/favicon.png" />
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/jquery-ui.js"></script>
	<script type="text/javascript" src="js/jQueryRotate.js"></script>
	<script type="text/javascript" src="js/rocknroll.js"></script>

	<script type="text/javascript" src="/js/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
	<script type="text/javascript" src="/js/fancybox/jquery.easing-1.3.pack.js"></script>
	<script type="text/javascript" src="/js/fancybox/jquery.mousewheel-3.0.4.pack.js"></script>

	<title>{deviceID}</title>

</head>

<body onload="main_init();">


    <script>

	var timer;
	var update_function;

	function main_init() {

		LoadContent('{onload}');
		update_status();
	}


	function update_status(){

		if (update_function) update_function();

		$.ajax({
			url: "parts/status.php?" + Math.random(),
			type: 'GET',
			timeout: 5000,
			success: function(data){
				ShowStatus(data);
				if ($(".wifistatus").css("display") == "none") $(".wifistatus").css("display", "block");
				if ($("#systemmessages").css("display") == "none") $("#systemmessages").css("display", "block");
				timer = setTimeout("update_status()", 1000);
			},
			error: function(data, err){
				$("#date").html("соединение потеряно :-(");
				$(".wifistatus").css("display", "none");
				$("#systemmessages").css("display", "none");
				timer = setTimeout("update_status()", 5000);
			}
		});
	}

	function ShowStatus(response) {
		var status_json;
		try {
			status_json = JSON.parse(response);

			// show uptime
			$("#uptime").html(status_json["uptime"]);
			$("#date").html(status_json["date"]);

			// show system messages
			if (status_json["message"])
				$("#systemmessages").html('<a href="?systemmessages" title="системные сообщения">' + status_json["message"] + '</a>');
			else
				$("#systemmessages").html("&nbsp;");

			// show wi-fi status
			if (status_json["wifilink"]) {
				var ssid = "";
				if (status_json["ssid"]) ssid = status_json["ssid"] + " ";
				$("#linkstatus").html(ssid + status_json["wifilink"] + "/70 " + status_json["wifilevel"] + " dBm");
				$(".wifistatus").css("display", "block");
			} else {
				$(".wifistatus").css("display", "none");
			}

		} catch (e) {
		}
	}

	$(function() {
		$( "#menu" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});

	function LoadContent(link){
		$("#content").load("modules/" + link + "/index.php");
	}

	</script>

	<div style="margin-left: 40px; margin-right: 40px;">

		<table width="100%" cellspacing="0" cellpadding="0" border="0">
			<tr valign="top">
				<td width="100">
					<a href="/"><img id="logo" src="imgs/logo.png" width="100"></a>
				</td>
				<td align="left" width="300">
					<h1><img id="logo2" src="imgs/logo2.png" width="200"></h1>
				</td>
				<td width="auto">
					&nbsp;
				</td>
				<td width="300" align="right">
					<div id="date"></div><div id="uptime"></div>
					<p style="line-height:3px;">&nbsp;</p>
					<div class="wifistatus" style="display: none;">
						<div><img src="/imgs/wifi.png" style="padding-right: 30px; padding-bottom: 0px;"></div>
					</div>
				</td>
			</tr>
		</table>
		<div style="width:100%;">
			<div id="systemmessages" style="width: 48%; height: 15px; white-space: nowrap; clear: right; float: left; padding-bottom: 0px; overflow: hidden;"></div>
			<div class="wifistatus" id="linkstatus" style="clear: right; float: right; padding-bottom: 0px;">&nbsp;</div>
		</div>
		<table width=100% cellspacing="0" cellpadding="5" border="0">
			<tr valign="top">
				<td width=230>
					<div id="menu" style="margin:0; padding:0;">
							{menu}
					</div>

					<p style="text-align: center;"><a href="http://virt2real.ru" target="_blank" style="font-size: 14px; color:#000; text-decoration: none;">&copy; virt2real.ru 2014</a></p>

				</td>
				<td>
					<div id="content">
						{content}
					</div>
				</td>
			</tr>
		</table>

	</div>

</body>
