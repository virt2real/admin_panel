<?php

/*****************************************************
* modules/pwm/setpin.php
* set CON function params file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_POST['conid']) || !isset($_POST['pwmid']) || !isset($_POST['state'])) die();

$conid = $_POST['conid'];
$pwmid = $_POST['pwmid'];
$state = $_POST['state'];


if ($state)
	$cmd = "set con $conid pwm$pwmid";
else
	$cmd = "set con $conid output 0";

file_put_contents("/dev/v2r_pins", $cmd);

?>