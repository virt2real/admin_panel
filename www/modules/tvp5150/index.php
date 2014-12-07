<?php

/*****************************************************
* modules/tvp5150/index.php
* TVP5150 analog dual camera index file
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
exec("i2c_check -a 0x5d", $arr, $return_var);

if ($return_var) {
	$error_content = file_get_contents("../../templates/error.tpl");
	$error_content = str_replace("{text}", $language['M_NOTFOUND'], $error_content);
	$error_content = lang_translate($error_content);
	die ($error_content);
}

$content = shell_exec ("i2cget -f -y 1 0x5d 0x00");
$current_input = intval($content, 16) == 0 ? 0 : 1;

$input1 = $current_input ? "" : "checked";
$input2 = $current_input ? "checked" : "";

$module_content = str_replace("{input1}", $input1, $module_content);
$module_content = str_replace("{input2}", $input2, $module_content);

echo $module_content;

?>
