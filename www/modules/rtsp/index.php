<?php

/*****************************************************
* modules/rtsp/index.php
* rtsp index file
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

$rtsptemplate = file_get_contents('rtsp.sh');
$module_content = str_replace('{rtsptemplate}', $rtsptemplate, $module_content);

echo $module_content;

?>
