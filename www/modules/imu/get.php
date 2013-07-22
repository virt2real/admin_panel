<?php

/*****************************************************
* modules/imu/get.php
* get IMU values
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$address = $_GET['addr'];
$command = "ls /sys/bus/i2c/devices/1-" . $address . "/";
$content = exec($command, $array);

foreach($array as $key => $value) {
	// skip regular driver files
	if ($value == "driver") continue;
	if ($value == "modalias") continue;
	if ($value == "subsystem") continue;
	if ($value == "uevent") continue;

	$element["addr"] = $address;
	$element["name"] = $value;
	$element["val"] = file_get_contents("/sys/bus/i2c/devices/1-".$address."/".$value);

	$result [] = $element;
}

$json = json_encode($result);
echo $json;

?>