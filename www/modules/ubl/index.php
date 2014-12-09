<?php

/*****************************************************
* modules/ubl/index.php
* ubl module index file
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

/* check boot type */

if ($globalVars['intboottype'] == 2) {
	$error_content = file_get_contents("../../templates/error.tpl");
	$error_content = str_replace("{text}", $language['M_ONLYFORSDBOOT'], $error_content);
	$error_content = lang_translate($error_content);
	die ($error_content);
}


echo $module_content;

?>