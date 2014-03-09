<?php

/*****************************************************
* modules/1wire/index.php
* 1wire index file
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

// load 1-wire devices list
$devices = @file("/sys/bus/w1/devices/w1_bus_master1/w1_master_slaves");
$devicelist = "";
for ($i = 0; $i < sizeof($devices); $i++) {
	$devicelist .= "<p>" . $devices[$i] ."</p>";
}

$module_content = str_replace('{devicelist}', $devicelist, $module_content);

echo $module_content;

?>
