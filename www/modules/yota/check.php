<?php

/*****************************************************
* modules/yota/check.php
* check Yota connection status
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$raw = explode("\n", curl_get_result("http://10.0.0.1/status"));

$result = '';
foreach ($raw as $k => $v) {
	$tmp = explode("=", $v);
	$result [$tmp[0]] = $tmp[1];
}

echo json_encode($result);


function curl_get_result($url) {
	$ch = curl_init();
	$timeout = 5;

	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_POST, 0);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
	$data = curl_exec($ch);
	curl_close($ch);
	return $data;
}


?>