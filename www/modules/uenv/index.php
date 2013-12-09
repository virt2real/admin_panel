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

// load module template
$module_content = file_get_contents("template.tpl");
$module_content = str_replace('{module_name}', $module_params['name'], $module_content);
$module_content = str_replace('{module_title}', $module_params['title'], $module_content);

// make global replaces
$module_content = GlobalReplace($module_content);

/***************** module specific part **************/

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

echo $module_content;

?>