<?php

/*****************************************************
* modules/uenv/index.php
* uenv index file
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

/* check boot type */

if ($globalVars['intboottype'] == 2) {
	$error_content = file_get_contents("../../templates/error.tpl");
	$error_content = str_replace("{text}", $language['M_ERR_NO_EDIT_UENV'], $error_content);
	$error_content = lang_translate($error_content);
	die ($error_content);
}

shell_exec("mount /dev/mmcblk0p1 /mnt");
$uenvcontent = file("/mnt/uEnv.txt");
shell_exec("umount /mnt");

$cmdline = str_replace('bootargs=','',$uenvcontent[0]);

// load params template
$template = file_get_contents("params.tpl");

// parse cmdline string
include("parse.php");
$params = ParseParams($cmdline, $template);

$module_content = str_replace('{uenvcontent}', $params, $module_content);

// translate content
$module_content = lang_translate($module_content);

echo $module_content;

?>
