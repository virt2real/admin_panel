<?php

/*****************************************************
* modules/sonywificam/checkbaseparams.php
* check device base params (ISO, etc)
* (c) virt2real 2015
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$url = $_POST['url'];

/* get events */
$result = send_request($url, '{ "method": "getEvent", "params": [false], "id": 1, "version": "1.0" }');
$res = json_decode($result, true);
$cameraParams['getEvent'] = $res['result'];

/* get supported ISO */
$result = send_request($url, '{ "method": "getSupportedIsoSpeedRate", "params": [], "id": 1, "version": "1.0" }');
$res = json_decode($result, true);
$cameraParams['getSupportedIsoSpeedRate'] = $res['result'][0];

/* get available ISO */
/*$result = send_request($url, '{ "method": "getAvailableIsoSpeedRate", "params": [], "id": 1, "version": "1.0" }');
$res = json_decode($result, true);
$cameraParams['getAvailableIsoSpeedRate'] = $res['result'][0];*/

/* get current ISO */
/*$result = send_request($url, '{ "method": "getIsoSpeedRate", "params": [], "id": 1, "version": "1.0" }');
$res = json_decode($result, true);
$cameraParams['getIsoSpeedRate'] = $res['result'];*/

echo json_encode($cameraParams);

function send_request($url, $rec) {
	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_POST, true);
	curl_setopt($curl, CURLOPT_POSTFIELDS, $rec);
	$result = curl_exec($curl);
	curl_close($curl);
	return $result;
}

?>
