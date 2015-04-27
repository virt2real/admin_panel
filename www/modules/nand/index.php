<?php

/*****************************************************
* modules/nand/index.php
* nand module index file
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

/* get current cmdline */
$cmdline = file_get_contents("/proc/cmdline");
$cmdline = str_replace("\n", "", $cmdline);
$cmdline = str_replace("\r", "", $cmdline);

/* make cmdline params array */
$arr = explode(" ", $cmdline);
$newarr = array();
$newarr1 = array();
foreach ($arr as $k => $v) {
	$tmp = explode("=", $v);
	if (strpos($v, "=") === FALSE) {
		$newarr1[$tmp[0]] = "";
	} else {
		if ($tmp[1] == "")
			$newarr[$tmp[0]] = " ";
		else
			$newarr[$tmp[0]] = $tmp[1];
	}
}

/* make new params for UBI fs */
$newarr["root"] = "ubi0:fs";
$newarr["rootfstype"] = "ubifs";
$newarr["ubi.mtd"] = "2,2048";
$newarr["rootwait"] = "";
$newarr["rw"] = "";

/* make new cmdline */
$newcmdline = "";
foreach ($newarr as $k => $v) {
	if ($v == "")
		$newcmdline .= $k . " ";
	else
		$newcmdline .= $k . "=" . $v . " ";
}

foreach ($newarr1 as $k => $v) {
	if ($k == "") continue;
	$newcmdline .= $k . " ";
}

$newcmdline = trim($newcmdline);
$module_content = str_replace("{cmdlinevalue}", $newcmdline, $module_content);

echo $module_content;

?>
