<?php

/*****************************************************
* modules/1wire/get.php
* 1wire get command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

// load 1-wire devices list
$devices = @file("/sys/bus/w1/devices/w1_bus_master1/w1_master_slaves");
$devicelist = "";
for ($i = 0; $i < sizeof($devices); $i++) {

	if ($devices[$i]) {
		
		$valuefile = "/sys/bus/w1/devices/w1_bus_master1/".trim($devices[$i])."/w1_slave";
		$values = @file($valuefile);
		$vstr = "";
		for ($j = 0; $j < sizeof($values); $j++) {
			$vstr .= '<p style="padding-left:40px;">' . $values[$j] . '</p>';
		}

	}

	$devicelist .= "<p>$devices[$i]</p> <div>$vstr</div>";
}


echo $devicelist;

?>