<?php

/*****************************************************
* modules/speech/index.php
* speech index file
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

include '/etc/virt2real/speech/config.php';

$lang0_selected = '';
$lang1_selected = '';

switch ($LANG) {
	case "ru":
		$lang0_selected = ' checked="checked" ';
		break;
	default  :
		$lang1_selected = ' checked="checked" ';
		break;
}

$eng0_selected = '';
$eng1_selected = '';

switch ($SPEECH_ENGINE) {
	case "1":
		$eng1_selected = ' checked="checked" ';
		break;
	default :
		$eng0_selected = ' checked="checked" ';
		break;
}

$module_content = str_replace('{lang0_selected}', $lang0_selected, $module_content);
$module_content = str_replace('{lang1_selected}', $lang1_selected, $module_content);

$module_content = str_replace('{eng0_selected}', $eng0_selected, $module_content);
$module_content = str_replace('{eng1_selected}', $eng1_selected, $module_content);


echo $module_content;

?>
