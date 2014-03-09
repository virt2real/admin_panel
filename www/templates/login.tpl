<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru" lang="ru">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="shortcut icon" href="imgs/favicon.png" />
	<script type="text/javascript" src="js/jquery.js"></script>
	<title>%L_ADMIN_INTERFACE% {deviceID} {boottype}</title>
</head>
<body onload='$("#username").focus();'>
	<script>
		function Enter(){
			if (!$("#username").val()) { ShowError("%L_ERR_EMPTY_LOGIN%"); return false; }
			if (!$("#password").val()) { ShowError("%L_ERR_EMPTY_PASS%"); return false; }
			CheckPassword($("#username").val(), $("#password").val());
		}
		function ShowError(text){
			$("#status").html(text);
		}

		function CheckPassword(){
			$("#enterimg").attr("src","/imgs/loader.gif");
			$("#status").html("");
			$.get("/parts/checklogin.php?" + Math.random() + "&username=" + $("#username").val() + "&password=" + $("#password").val(), function(response, status, xhr) {
				if (status == "success") {
					$("#enterimg").attr("src","/imgs/login.png");
					$("#enterimg").css("display","none");

					if (response == "ok") {
                        var chosenLang = GetUrlVars()["lang"];
                        if (typeof chosenLang === "undefined" )	{
                            location.replace("/?lang=ru");
                        } else {
                            location.replace("/?lang="+chosenLang);
                        }
					} else {
						$("#status").html("%L_FAIL%");
						$("#enterimg").css("display","inline");
					}
				}
				if (status == "error") {
					$("#enterimg").attr("src","/imgs/login.png");
					$("#status").html("%L_FAIL%");
				}
			});

		}

        function GetUrlVars() {
            var vars = {};
            var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
                vars[key] = value;
            });
            return vars;
        }

        function ChangeLang(lang){
                window.location = window.location.protocol+'//'+window.location.host+"/login.php?lang="+lang;
        }

    </script>

	<div style="position: absolute; top: 1px; left: 1px; z-index: 0;">
		<table width="100%">
			<tr valign=top>
				<td width=100>
					<a href="/"><img src="imgs/logo.png"></a>
				</td>
				<td align="left">
					<h1> <img src="imgs/logo2.png"></h1>
				</td>
				<td width="400" align="right">
					<div id="uptime"></div>
				</td>
			</tr>
		</table>
	</div>

	<table width="100%" height="100%" align="center">
		<tr valign=middle height="100%">
			<td width="100%" align="center">
				<table width="300" align="center">
					<tr>
						<td>
                            <form action="#">
                                <input type="radio" name="lang" id="langRu" onClick="ChangeLang('ru');" />ru</input>
                                <input type="radio" name="lang" id="langDe" onClick="ChangeLang('de');" />de</input>
                                <input type="radio" name="lang" id="langEn" onClick="ChangeLang('en');" />en</input>
                            </form>
							<form method="post" onSubmit="Enter(); return false;">
							<p>
								<input type="text" name="username" id="username" placeholder="%L_LOGIN_USER%" style="width: 300px; background-color:#ffffff; color:#000000;">
								<p></p>
								<input type="password" name="password" id="password" placeholder="%L_LOGIN_PASS%" style="width: 300px;  background-color:#ffffff; color:#000000;">
								<p style="text-align: right;"><input type="image" src="/imgs/login.png" alt="submit" id="enterimg"  style="border: none;" /></p>
								<div id="status" style="color: #ff0000; height: 50px;"></div>
							</p>
							</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
    <script>
        var checkButton = GetUrlVars()["lang"];
        if (typeof checkButton === "undefined" ) document.getElementById('langRu').checked = true;
        if (checkButton == "ru" ) document.getElementById('langRu').checked = true;
        if (checkButton == "de" ) document.getElementById('langDe').checked = true;
        if (checkButton == "en" ) document.getElementById('langEn').checked = true;
    </script>
</body>
