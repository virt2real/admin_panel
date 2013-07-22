<?php

/*****************************************************
* modules/imu/check.php
* check IMU sensors
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$command = "lsmod";
$content = exec($command, $array);

foreach($array as $key => $value) {
	if (!$key) continue;
	$str_parts = explode(" ", $value); // explode module string via spaces
	$result [] = $str_parts[0];
}

$json = json_encode($result);
echo $json;

?>