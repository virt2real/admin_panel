<?php

/*****************************************************
* modules/adc/get.php
* ADC get command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$vref = 3.6;
$max_raw = 1 << 10;

if (isset($_GET["vref"])) $vref = $_GET["vref"];

$filename = "/dev/v2r_adc";
$handle = fopen($filename, "r");

$contents = fread($handle, 12);

for ($i = 0; $i < 6; $i++) {
        @$value = ord($contents[2 * $i]) + ord($contents[(2 * $i) + 1]) * 256;
        $volts = $value * $vref / $max_raw;
        $result[] = round($volts, 3);
}

fclose($handle);

$json = json_encode($result);
echo $json;

?>