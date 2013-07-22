<?php

/*****************************************************
* modules/imu/checkdevices.php
* check IMU sensors
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$command = "ls /sys/bus/i2c/devices";
$content = shell_exec($command, $array);

foreach($array as $key => $value) {
	$result [] = $value;
}

$json = json_encode($result);
echo $json;

?>