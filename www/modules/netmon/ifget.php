<?php

/*****************************************************
* modules/netmon/ifget.php
* get interface info file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$ifaces = file_get_contents("/proc/net/dev");
$arr_ifaces = explode("\n", $ifaces);

// skip first three strings (it's a header and a loopback device)
for ($i = 2; $i < sizeof($arr_ifaces); $i++) {
	$arr_ifaces[$i] = str_replace(":", " ", $arr_ifaces[$i]);
	$arr_ifaces[$i] = preg_replace("/\s+/", " ", $arr_ifaces[$i]); // delete multiple spaces
	if (!$arr_ifaces[$i]) continue;
	$arr_parts = explode(" ", $arr_ifaces[$i]); // explode string by space
	if (!$arr_parts[1]) continue; // skipping strings with empty if_name
	$newif['if_name'] = $arr_parts[1];
	$newif['rcv_bytes'] = $arr_parts[2];
	$newif['trsm_bytes'] = $arr_parts[10];
	$interfaces[] = $newif;
}

$json = json_encode($interfaces); // make JSON encoding

echo $json; // show result JSON string

?>