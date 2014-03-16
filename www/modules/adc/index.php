<?php

/*****************************************************
* modules/adc/index.php
* adc index file
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

$vref = 3.6;

include "common.php";
$adc_list = load_adc_list($vref);
$module_content = str_replace('{adc_status}', $adc_list, $module_content);

$module_content = str_replace('{adc_vref}', $vref, $module_content);

echo $module_content;

?>
