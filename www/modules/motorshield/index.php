<?php

/*****************************************************
* modules/motorshield/index.php
* motorshield module index file
* (c)virt2real.ru 2014
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

/* get settings */

$addr = intval(@file_get_contents("addr"));
if (!$addr) $addr = "70";

$divider = intval(@file_get_contents("/sys/bus/i2c/devices/1-00$addr/freq"));


/* init servos */

$servo_min = intval(@file_get_contents("servomin"));
if (!$servo_min) $servo_min = 600;
$servo_max = intval(@file_get_contents("servomax"));
if (!$servo_max) $servo_max = 3000;

$freq = intval(25000000 / ($divider + 1) / 4096);

$module_content = str_replace('{divider}', $divider, $module_content);
$module_content = str_replace('{freq}', $freq, $module_content);
$module_content = str_replace('{servomin}', $servo_min, $module_content);
$module_content = str_replace('{servomax}', $servo_max, $module_content);
$module_content = str_replace('{addr}', $addr, $module_content);

echo $module_content;

?>