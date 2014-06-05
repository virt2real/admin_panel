<?php

/*****************************************************
* modules/ivideon/attach.php
* attach camera to Ivideon
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('ivideon');

if (!isset($_POST["acc"]))
	die("empty account name");

if (!isset($_POST["cameraname"]))
	die("empty camera name");

$acc = $_POST["acc"];
$cameraname = $_POST["cameraname"];

$cmd =  '/opt/ivideon/videoserverd/videoserverd --attach --email "'. $acc . '" --server-name "' . $cameraname . '" --config-file -';

$code = 0;
$result = Array();
exec(escapeshellcmd($cmd), $result, $code);

$result_str = implode("", $result);

$return["code"] = $code;
if ($code == 0) {
	$return["content"] = $result_str;
}

echo json_encode($return);

?>