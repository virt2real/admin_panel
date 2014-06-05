<?php

/*****************************************************
* modules/quit/index.php
* quit index file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// check module name
require_once('description.php');

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
if ($_GET['lang']) {
    lang_setlang($_GET['lang']);
}else{
    lang_setlang('ru');
}

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

$localconfigfile = file_get_contents("/opt/rcboard/rcboard.conf");
$module_content = str_replace('{localconfigfile}', $localconfigfile, $module_content);


$configarr = array();
$runconfig = file("/opt/rcboard/config.sh");
foreach ($runconfig as $key=>$value) {
	$tmp = explode('=', $value);
	$tmp[0] = trim(str_replace("\n", "", $tmp[0]));
	$tmp[1] = trim(str_replace("\n", "", $tmp[1]));
	$configarr[strtolower($tmp[0])] = $tmp[1];
}

$module_content = str_replace('{user_id}', $configarr["user"], $module_content);
$module_content = str_replace('{hash}', $configarr["hash"], $module_content);
$module_content = str_replace('{address}', $configarr["address"], $module_content);
$module_content = str_replace('{host}', $configarr["host"], $module_content);
$module_content = str_replace('{port}', $configarr["port"], $module_content);
$module_content = str_replace('{bitrate}', $configarr["bitrate"], $module_content);
$module_content = str_replace('{maxbitrate}', $configarr["maxbitrate"], $module_content);
$module_content = str_replace('{mtu}', $configarr["mtu"], $module_content);

if ($configarr["config"] == "local") {
	$config_selected1 = "checked";
	$config_selected2 = "";
} else {
	$config_selected1 = "";
	$config_selected2 = "checked";
}

$module_content = str_replace('{config_selected1}', $config_selected1, $module_content);
$module_content = str_replace('{config_selected2}', $config_selected2, $module_content);


$path1 = '/etc/init.d/S98rcboard';
$path2 = '/etc/init.d.sample/S98rcboard';

if (file_exists($path1))
	$inautorun = "checked";
else
	$inautorun = "";

$module_content = str_replace('{inautorun}', $inautorun, $module_content);

echo $module_content;

?>
