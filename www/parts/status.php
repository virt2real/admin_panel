<?php

/*****************************************************
* status.php
* uptime and other status info for main template
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

require_once("config.php");

$status["uptime"] = substr(shell_exec ("/usr/bin/uptime"), 1, 8);
$status["wifilink"] = "0";
$status["wifilevel"] = "0";

$wlanstatusfile = file("/proc/net/wireless");
foreach ($wlanstatusfile as $key => $value){

	// remove many spaces
	$value =  preg_replace("/\s{2,}/",' ',trim($value));

	$statusstring = explode(" ", $value);
	$statusstring[0] = str_replace(":", "", $statusstring[0]);
	if ($statusstring[0] != $WLAN_IFACE_MONITOR) continue;

	// if here - wi-fi interface record found
	$status["wifilink"] = str_replace('.', '', $statusstring[2]);
	$status["wifilevel"] = str_replace('.', '', $statusstring[3]);
	//$status["wifinoise"] = str_replace('.', '', $statusstring[4]);

}

$json = json_encode($status);
echo $json;

?>