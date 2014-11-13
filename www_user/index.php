<?php
// check boot type
$cmdline = file_get_contents("/proc/cmdline");

// find a "rootfstype=" param
$fstype = "";
preg_match_all('/rootfstype=(.{0,}?) /', $cmdline, $params, PREG_SET_ORDER);
if ($params) $fstype=$params[sizeof($params)-1][1];

switch ($fstype) {
	case "ext3":
		$bootmode = "(SD boot)";
	break;
	case "jffs2":
	case "ubifs":
		$bootmode = "(NAND boot)";
	break;
}

?>

<html>
	<head>
		<style>
			html {width:100%; height:100%; padding:0px; font-family: Arial; color:#7c7c7c;}
			body {width:90%; height:90%; padding:0px; background-image:url('imgs/virt2real-board.jpg'); background-position:  left bottom; background-repeat: no-repeat;}
			img  {border:none;}
			a    {color:#7c7c7c;}
			.window {background-color:#9a9a9a; padding:20px; box-shadow: 0px 0px 160px rgba(0,0,0,0.9); color:#ffffff; }
			.window a {color:#0380ea;}
		</style>
	</head>
	<title><?php echo file_get_contents("/etc/virt2real/deviceid") . " " . $bootmode; ?></title>
<body>
	<table width="100%">
		<tr valign=top>
			<td width=100>
				<a href=""><img src="imgs/logo.png"></a>
			</td>
			<td align="left" valign="middle">
				<h1> <img src="imgs/logo2.png"></h1>
			</td>
			<td width="400" align="right">
				<p> <a href="/admin">перейти в админку</a> </p>
			</td>
		</tr>
	</table>

	<p style="height:20px;">&nbsp;</p>

	<center>
	<table width="50%" cellspacing="0" cellpadding="0" border="0" class="window">
		<tr valign="top">
			<td width="100%" align="center">
				<h1>Добро пожаловать!</h1>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" align="left">
				<p>Вы находитесь на дефолтной странице веб-сервера Виртурилки. Страница располагается в файловой системе по адресу /var/www_user и предназначена для любого пользовательского контента.</p>
				<p>Можете смело заливать сюда свои файлы, не боясь повредить панель управления (админку).</p>
				<p>Админка находится по адресу <a href="/admin">/admin</a></p>
			</td>
		</tr>
	</table>

</body>
</html>