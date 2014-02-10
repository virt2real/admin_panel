<?php

/*****************************************************
* status.php
* uptime and other status info for main template
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

require_once("config.php");

$status["date"] = shell_exec ("date");
$status["uptime"] = "";

$status["wifilink"] = "0";
$status["wifilevel"] = "0";

$wlanstatusfile = @file("/proc/net/wireless");

/* 3G */
$tmp = @file_get_contents("/tmp/pppstate");
$mobile_status = "";
if ($tmp) {
	$mobilestatusfile = explode(" ", $tmp);
	$mobile_status = $mobilestatusfile[5];
}

$systemmessages = @file("/var/log/messages");
$systemmessage = $systemmessages[sizeof($systemmessages)-1];

$ssid = @file_get_contents("/tmp/ssid");
$ssid = str_replace("\n", "", $ssid);

foreach ($wlanstatusfile as $key => $value){

	// remove many spaces
	$value =  preg_replace("/\s{2,}/",' ',trim($value));

	$statusstring = explode(" ", $value);
	$statusstring[0] = str_replace(":", "", $statusstring[0]);
	if ($statusstring[0] != $WLAN_IFACE_MONITOR) continue;

	// if here - wi-fi interface record found

	// check field "status" and "misc" in file "/proc/net/wireless"
	if ($statusstring[1] > 0 || $statusstring[9] > 0)
		$status["wificonnected"] = 1;
	else
		$status["wificonnected"] = 0;

	$status["wifilink"] = str_replace('.', '', $statusstring[2]);
	$status["wifilevel"] = str_replace('.', '', $statusstring[3]);
	$status["wifinoise"] = str_replace('.', '', $statusstring[4]);

}

$status["message"] = "&nbsp;".$systemmessage;
$status["ssid"] = $ssid;
$status["mobile_status"] = $mobile_status;

$json = json_encode($status);
echo $json;

?>