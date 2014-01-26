<?php

/*****************************************************
* global.php
* main index file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

$TOTAL_PWM = 4;
$TOTAL_GPIO = 104;
$TOTAL_PINS = 87;

session_start();

if ($_SERVER["PHP_SELF"]!=="/login.php")
if (!isset($_SESSION["login"]) || $_SESSION["login"]!==1) {	header("Location: login.php");
	die;
}

$globalVars['deviceID'] = file_get_contents('/etc/virt2real/deviceid');
$globalVars['deviceDescription'] = file_get_contents('/etc/virt2real/devicedescription');
$globalVars['deviceHost'] = $_SERVER["HTTP_HOST"];
$globalVars['document_root'] = $_SERVER["DOCUMENT_ROOT"];

// check dependences
$output = array();
$dep_ok = 0;
$need_files = "";
$need_packets = "";
if (isset($module_params['depend'])) {
	foreach ($module_params['depend'] as $k => $v) {
		$ret = 0;
		exec("which $v", $output, $ret);
		if ($ret)
			if (file_exists($v)) $ret = 0;
		$dep_ok |= $ret;
		if ($ret) $need_files .= $v.'<br>';
	}
}

if (isset($module_params['depend_descr'])) {
	foreach ($module_params['depend_descr'] as $k => $v) {
		$need_packets .= $v .'<br>';
	}
}

if ($need_files) {
	$error_content = file_get_contents("../../templates/error_dep.tpl");
	$error_content = str_replace("{dep_files}", $need_files, $error_content);
	if ($need_packets) $error_content = str_replace("{dep_descr}", $need_packets, $error_content);
	die ($error_content);
}


function GlobalReplace($template){
	// global replaces for templates
	global $globalVars;

	foreach ($globalVars as $key => $value) {
		$template = str_replace('{'.$key.'}', $value, $template);
	}

	return $template;}

?>