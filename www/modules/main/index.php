<?php

/*****************************************************
* modules/main/index.php
* main module index file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// check module name
require_once('description.php');

// common include
include('../../parts/global.php');

// load module template
$module_content = file_get_contents("template.tpl");
$module_content = str_replace('{module_title}', $module_params['title'], $module_content);

// make global replaces
$module_content = GlobalReplace($module_content);

/***************** module specific part **************/

$admin_version = file_get_contents("../../version");

$cpuinfo = '<pre>' . file_get_contents("/proc/cpuinfo") . '</pre>';
$meminfo = '<pre>' . file_get_contents("/proc/meminfo") . '</pre>';
$modules = '<pre>' . file_get_contents("/proc/modules") . '</pre>';
$cmdline = file_get_contents("/proc/cmdline");
$linuxversion = file_get_contents("/proc/version");


$module_content = str_replace('{admin_version}', $admin_version, $module_content);
$module_content = str_replace('{cpuinfo}', $cpuinfo, $module_content);
$module_content = str_replace('{meminfo}', $meminfo, $module_content);
$module_content = str_replace('{cmdline}', $cmdline, $module_content);
$module_content = str_replace('{modules}', $modules, $module_content);
$module_content = str_replace('{linuxversion}', $linuxversion, $module_content);

echo $module_content;

?>