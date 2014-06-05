<?php

/*****************************************************
* modules/rcboard/run.php
* run rcboard script
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');

if (!isset($_POST['action']))
	die();

$action = ($_POST['action'] == 1) ? "start" : "stop";

$path1 = '/etc/init.d/S98rcboard';
$path2 = '/etc/init.d.sample/S98rcboard';

$runpath = "";

if (file_exists($path1))
	$runpath = $path1;
else
if (file_exists($path2))
	$runpath = $path2;

shell_exec("$runpath $action > /dev/null &");

?>
