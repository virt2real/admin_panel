<?php

/*****************************************************
* modules/mjpeg_udp/index.php
* mjpeg_udp index file
* (c)virt2real.ru 2013
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

$mjpeg_udptemplate = file_get_contents('mjpeg_udp.sh');
$module_content = str_replace('{mjpeg_udptemplate}', $mjpeg_udptemplate, $module_content);

$module_content = str_replace('{host}', $_SERVER["REMOTE_ADDR"], $module_content);

echo $module_content;

?>