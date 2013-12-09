<?php

/*****************************************************
* modules/softap/index.php
* softap index file
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

$softapparams = file("/etc/softap.conf");
foreach ($softapparams as $k => $v) {
	if (!$v) continue;
	$tmp = explode("=", $v);
	switch ($tmp[0]) {
		case "SSID":
			$ssid = $tmp[1];
		break;
		case "PASSPHRASE":
			$passphrase = $tmp[1];
		break;
	}
}
$module_content = str_replace('{ssid_value}', $ssid, $module_content);
$module_content = str_replace('{passphrase_value}', $passphrase, $module_content);


echo $module_content;

?>