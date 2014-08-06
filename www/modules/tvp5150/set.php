<?php

/*****************************************************
* modules/tvp5150/set.php
* tvp5150 set command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('tvp5150');

$input = $_POST['input'];
$value = $input == 0 ? 0x00 : 0x02;

shell_exec("i2cset -f -y 1 0x5d 0x00 $value");

// check is change correct
$current_input = shell_exec ("i2cget -f -y 1 0x5d 0x00");
$current_input = str_replace("\n", "", $current_input);

if ($current_input == "0x00")
	echo $language['M_USEINPUT1'];
else
if ($current_input == "0x02")
	echo $language['M_USEINPUT2'];
else
	echo $language['M_ERRORUSEINPUT'];

?>
