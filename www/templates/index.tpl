<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru" lang="ru">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>

	<link type="text/css" href="css/vader/jquery-ui-1.8.21.custom.css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="css/style.css"/>
	<link rel="shortcut icon" href="imgs/favicon.png" />
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/jquery-ui.js"></script>
	<script type="text/javascript" src="js/jQueryRotate.js"></script>
	<script type="text/javascript" src="js/rocknroll.js"></script>

	<title>{deviceID}</title>
</head>
<body onload="LoadContent('{onload}'); update_status();">
    <script>
	var timer;

	function update_status(){		$("#uptime").load("parts/status.php?" + Math.random(), function(response, status, xhr) {			if (status == "success") {
				var status_json;
				try {
					status_json = JSON.parse(response);

					// show uptime
					$("#uptime").html(status_json["uptime"]);

					// show wi-fi status
					if (parseInt(status_json["wifilink"])) {
						$("#linkstatus").html(status_json["wifilink"] + "/70 " + status_json["wifilevel"] + " dBm");
						$("#wifistatus").css("display", "block");
					} else {						$("#wifistatus").css("display", "none");					}

				} catch (e) {}
			}
			if (status == "error") {
				$("#uptime").html(":-(");
				$("#wifistatus").html("");
			}
			timer = setTimeout("update_status()", 1000);
		});
	}

	$(function() {
		$( "#menu" ).accordion({ fillSpace: false, autoHeight: false, navigation: false});
	});

	function LoadContent(link){		$("#content").load("modules/" + link + "/index.php");	}

	</script>

	<div style="margin-left: 40px; margin-right: 40px;">

		<table width="100%">
			<tr valign=top>
				<td width=150>
					<a href="/"><img id="logo" src="imgs/logo.png"></a>
				</td>
				<td align="left">
					<h1> <img id="logo2" src="imgs/logo2.png"></h1>
				</td>
				<td width="400" align="right">
					<div id="uptime"></div>
					<p></p>
					<p></p>
					<div id="wifistatus" style="display: none;">
						<div><img src="/imgs/wifi.png"></div>
						<div id="linkstatus"></div>
					</div>
				</td>
			</tr>
		</table>

		<table width=100% callspacing=5 cellpadding=5 border=0>
			<tr valign="top">
				<td width=230>
					<div id="menu" style="margin:0; padding:0;">
							{menu}
					</div>

					<p style="text-align: center;"><a href="http://virt2real.ru" target="_blank" style="font-size: 20px; color:#000; text-decoration: none;">&copy; virt2real.ru 2013</a></p>

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
