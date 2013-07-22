<?php

/*****************************************************
* global.php
* main index file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

session_start();

if ($_SERVER["PHP_SELF"]!=="/login.php")
if (!isset($_SESSION["login"]) || $_SESSION["login"]!==1) {	header("Location: login.php");
	die;
}

$globalVars['deviceID'] = file_get_contents('/etc/virt2real/deviceid');
$globalVars['deviceDescription'] = file_get_contents('/etc/virt2real/devicedescription');
$globalVars['deviceHost'] = $_SERVER["HTTP_HOST"];

function GlobalReplace($template){
	// global replaces for templates
	global $globalVars;

	foreach ($globalVars as $key => $value) {
		$template = str_replace('{'.$key.'}', $value, $template);
	}

	return $template;}

?>