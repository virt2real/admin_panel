<?php

/*****************************************************
* modules/wlans/index.php
* wlan settings index file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// check module name
require_once('description.php');

// common include
include('../../parts/global.php');

// load module template
$module_content = file_get_contents("template.tpl");
$module_content = str_replace('{module_name}', $module_params['name'], $module_content);
$module_content = str_replace('{module_title}', $module_params['title'], $module_content);

// make global replaces
$module_content = GlobalReplace($module_content);

/***************** module specific part **************/

$wpaconf_file = file_get_contents("/etc/wpa_supplicant.conf");

$module_content = str_replace('{wpa_config}', $wpaconf_file, $module_content);

echo $module_content;

?>