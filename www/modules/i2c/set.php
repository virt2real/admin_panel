<?php

/*****************************************************
* modules/i2c/set.php
* i2c set command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$base = $_GET['base'];
//$reg = $_GET['reg'];
$reg = intval($_GET['reg'], 16);
$value = $_GET['value'];

if (isset($_GET['mask'])) {	$mask = intval($_GET['mask']);
	$value = str_replace('0x', '', $value);
	$value_dec = hexdec($value);
	$old_value_hex = shell_exec ("i2cget -f -y 1 $base $reg");
	$old_value_hex = str_replace('0x', '', $old_value_hex);
	$old_value_dec = hexdec($old_value_hex);
	$old_value = $mask & $old_value_dec;
	$value_dec_masked = $old_value | $value_dec;
	$value = '0x'.dechex($value_dec_masked);
}

if ($reg > 0xff) {
	// two byte address
	$reg_low = $reg & 0xff;
	$reg_high = ($reg >> 8) & 0xff;
	$content = shell_exec ("i2cset -f -y 1 $base $reg_high $reg_low $value i");
} else {
	// single byte address
	$content = shell_exec ("i2cset -f -y 1 $base $reg $value");
}


/*	echo 'mask='.$mask.'<br>';
echo 'old_value_hex='.$old_value_hex.'<br>';
echo 'old_value_dec='.$old_value_dec.'<br>';
echo 'old_value_masked='.$old_value.'<br>';
echo 'new_value='.$value.'<br>';
echo 'updated ' . $base . ':' . $reg . ' = ' . $value;
*/

?>