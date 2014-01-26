<?php

/*****************************************************
* modules/motorshield/updatevoltage.php
* update motorshield voltage
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$max_raw = 1 << 10;

$filename = "/dev/v2r_adc";
$handle = fopen($filename, "r");

$contents = fread($handle, 2);
$value = ord($contents[0]) + ord($contents[1]) * 256;
$volts = $value * 58 / $max_raw;

$voltage = round($volts, 3);
echo $voltage;

?>
