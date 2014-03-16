<?php

/*****************************************************
* modules/dmesg/index.php
* âüóûï index file
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
$dmesg_status = '<pre>'.shell_exec("dmesg | tail -n 20").'</pre>';
$module_content = str_replace('{dmesg_status}', $dmesg_status, $module_content);

echo $module_content;

?>
