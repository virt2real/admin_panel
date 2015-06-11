<?php

/*****************************************************
* modules/i2c/get.php
* i2c read registers file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$base = $_GET['base'];
$reg = intval($_GET['reg'], 16);

if ($reg > 0xff) {
	// two byte address
	#i2cset -f -y 1 0x3c 0x31 0x03 i
	#i2cget -f -y 1 0x3c
	$reg_low = $reg & 0xff;
	$reg_high = ($reg >> 8) & 0xff;
	shell_exec ("i2cset -f -y 1 $base $reg_high $reg_low i"); // set register address
	$content = shell_exec ("i2cget -f -y 1 $base"); // read register value
} else {
	// single byte address
	$content = shell_exec ("i2cget -f -y 1 $base $reg");
}

echo $content;

?>