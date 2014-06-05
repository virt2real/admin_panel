<?php

/*****************************************************
* modules/ivideon/index.php
* ivideon index file
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

$path1 = '/etc/init.d/S95ivideon';
$path2 = '/etc/init.d.sample/S95ivideon';

if (file_exists($path1))
	$inautorun = "checked";
else
	$inautorun = "";

$module_content = str_replace('{inautorun}', $inautorun, $module_content);

echo $module_content;

?>
