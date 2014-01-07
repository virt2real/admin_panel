<?php

/*****************************************************
* status.php
* uptime and other status info for main template
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

require_once("config.php");

$status["uptime"] = shell_exec ("/usr/bin/uptime");
$status["wifilink"] = "0";
$status["wifilevel"] = "0";

$wlanstatusfile = file("/proc/net/wireless");

$systemmessage = @file_get_contents("/tmp/systemmessage");
$ssid = @file_get_contents("/tmp/ssid");
$ssid = str_replace("\n", "", $ssid);

foreach ($wlanstatusfile as $key => $value){

	// remove many spaces
	$value =  preg_replace("/\s{2,}/",' ',trim($value));

	$statusstring = explode(" ", $value);
	$statusstring[0] = str_replace(":", "", $statusstring[0]);
	if ($statusstring[0] != $WLAN_IFACE_MONITOR) continue;

	// if here - wi-fi interface record found
	$status["wifilink"] = str_replace('.', '', $statusstring[2]);
	$status["wifilevel"] = str_replace('.', '', $statusstring[3]);
	$status["wifinoise"] = str_replace('.', '', $statusstring[4]);

	$status["message"] = "&nbsp;".$systemmessage;
	$status["ssid"] = $ssid;

}

$json = json_encode($status);
echo $json;

?>