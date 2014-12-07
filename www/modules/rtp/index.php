<?php

/*****************************************************
* modules/rtp/index.php
* rtp index file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// check module name
require_once('description.php');

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');

// load module template
$module_content = file_get_contents("template.tpl");
$module_content = str_replace('{module_name}', $module_params['name'], $module_content);
$module_content = str_replace('{module_title}', $module_params['title'], $module_content);

// make global replaces
$module_content = GlobalReplace($module_content);

// translate content
lang_swapmod($module_params['name']);
$module_content = lang_translate($module_content);

/***************** module specific part **************/

$clients = "";
$bitrate = file_get_contents("/etc/virt2real/video.bitrate");
$type = "";

// parse config
$config = file("/etc/virt2real/rtp_server.conf");
foreach ($config as $k => $v) {
	$tmp = explode('=', $v);
	switch ($tmp[0]) {
		case "CLIENTS":
			$clients = str_replace("\n", "", $tmp[1]);
		break;
		case "BITRATE":
			$bitrate = str_replace("\n", "", $tmp[1]);
		break;
		case "TYPE":
			$type = str_replace("\n", "", $tmp[1]);
		break;
	}
}

$type1 = "";
$type2 = "";
$type3 = "";

switch ($type) {
	case "GST": 	$type1 = "checked"; break;
	case "ANDROID":	$type2 = "checked"; break;
	case "IOS": 	$type3 = "checked"; break;
}

$rtptemplate = file_get_contents('/etc/virt2real/rtp_server.sh');
$module_content = str_replace('{rtptemplate}', $rtptemplate, $module_content);

$module_content = str_replace('{clients}', $clients, $module_content);
$module_content = str_replace('{bitrate}', $bitrate, $module_content);
$module_content = str_replace('{type1}', $type1, $module_content);
$module_content = str_replace('{type2}', $type2, $module_content);
$module_content = str_replace('{type3}', $type3, $module_content);


$path1 = '/etc/init.d/S92rtpserver';
if (file_exists($path1))
	$inautorun = "checked";
else
	$inautorun = "";

$module_content = str_replace('{inautorun}', $inautorun, $module_content);

echo $module_content;

?>
