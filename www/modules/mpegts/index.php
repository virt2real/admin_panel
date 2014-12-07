<?php

/*****************************************************
* modules/mpegts/index.php
* mpegts index file
* (c)virt2real.ru 2014
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

// parse config
$config = file("/etc/virt2real/mpegts_server.conf");
foreach ($config as $k => $v) {
	$tmp = explode('=', $v);
	switch ($tmp[0]) {
		case "CLIENTS":
			$clients = str_replace("\n", "", $tmp[1]);
		break;
		case "BITRATE":
			$bitrate = str_replace("\n", "", $tmp[1]);
		break;
	}
}

$mpegtstemplate = file_get_contents('/etc/virt2real/mpegts_server.sh');
$module_content = str_replace('{mpegtstemplate}', $mpegtstemplate, $module_content);

$module_content = str_replace('{clients}', $clients, $module_content);
$module_content = str_replace('{bitrate}', $bitrate, $module_content);

$path1 = '/etc/init.d/S92mpegtsserver';
if (file_exists($path1))
	$inautorun = "checked";
else
	$inautorun = "";

$module_content = str_replace('{inautorun}', $inautorun, $module_content);

echo $module_content;

?>
