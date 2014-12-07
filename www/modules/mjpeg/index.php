<?php

/*****************************************************
* modules/rtmp/index.php
* rtmp index file
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

$port = "";
$quality = "";

// parse config
$config = file("/etc/virt2real/mjpeg_server.conf");
foreach ($config as $k => $v) {
	$tmp = explode('=', $v);
	switch ($tmp[0]) {
		case "QUALITY":
			$quality = str_replace("\n", "", $tmp[1]);
		break;
		case "PORT":
			$port = str_replace("\n", "", $tmp[1]);
		break;
	}
}

$module_content = str_replace('{mjpeg_port}', $port, $module_content);
$module_content = str_replace('{mjpeg_quality}', $quality, $module_content);

$mjpegtemplate = file_get_contents('/etc/virt2real/mjpeg_server.sh');
$module_content = str_replace('{mjpegtemplate}', $mjpegtemplate, $module_content);

$path1 = '/etc/init.d/S92mjpegserver';
if (file_exists($path1))
	$inautorun = "checked";
else
	$inautorun = "";

$module_content = str_replace('{inautorun}', $inautorun, $module_content);

echo $module_content;

?>
