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

	<script type="text/javascript" src="/js/global.js"></script>

	<title>{deviceID} {boottype}</title>

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
				$("#wifistatus").css("display", "block");
				$("#mobile_status").css("display", "block");
				ShowStatus(data);
				timer = setTimeout("update_status()", 1000);
			},
			error: function(data, err){
				$("#wifistatus").css("display", "none");
				$("#mobile_status").css("display", "none");
				$("#date").html("соединение потеряно :-(");
				timer = setTimeout("update_status()", 5000);
			}
		});
	}

	function ShowStatus(response) {
		var status_json;
		try {
			status_json = JSON.parse(response);

			// show uptime
			$("#uptime").html(status_json.uptime);
			$("#date").html(status_json.date);

			// show system messages
			if (status_json.message)
				$("#systemmessages").html('<a href="?systemmessages" title="системные сообщения">' + status_json.message + '</a>');
			else
				$("#systemmessages").html("&nbsp;");

			// show wi-fi status
			if (parseInt(status_json.wificonnected)) {
				var ssid = "";
				if (status_json.ssid) ssid = status_json.ssid + " ";
				$("#linkstatus").html(ssid + '<br>' + status_json.wifilink + "/70 " + status_json.wifilevel + " dBm");
				$("#wifistatus").css("display", "block");
			} else {
				$("#wifistatus").css("display", "none");
			}

			// show 3G status
			if (status_json.mobile_status) {
				$("#mobile_params").html(status_json.mobile_status);
				$("#mobile_status").css("display", "block");
			} else {
				$("#mobile_status").css("display", "none");
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
				<td width="50%">
					<a href="/"><img id="logo" src="imgs/logo.png" width="100" style="float: left; clear: left;"></a>

					<h1><img id="logo2" src="imgs/logo2.png" width="200"></h1>
					<br>
					<br>

					<div id="systemmessages" style="width: 400px; height: 15px; white-space: nowrap; overflow: hidden; clear: right; float: left; padding-bottom: 0px; min-width:100px; max-width: 100%;"></div>
				
				</td>
				<td width="50%" align="right">
					<div id="date"></div><div id="uptime"></div>

					<table width="100%">
						<tr valign="top">	
							<td>&nbsp;</td>
							<td width="90" align="center">&nbsp;
								<div id="mobile_status">
									<a href="?3g"><img src="/imgs/3g.png"></a>
									<div id="mobile_params"></div>
								</div>
							</td>
							<td width="130" align="center">&nbsp;
								<div id="wifistatus">
									<a href="?wlan"><img src="/imgs/wifi.png"></a>
									<div id="linkstatus"></div>
								</div>
							</td>
						</tr>
					</table>

				</td>
			</tr>
		</table>
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
