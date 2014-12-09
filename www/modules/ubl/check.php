<?php

/*****************************************************
* modules/ubl/check.php
* check current cpu params
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$cpuinfo = file("/proc/cpuinfo");
foreach($cpuinfo as $k => $v) {
	$arr = explode(':', $v);
	if ('BogoMIPS' == preg_replace("|\s+|i", "", $arr[0])) {
		$bogomips = floatval($arr[1]);
	}
}

$res['bogomips'] = $bogomips;
$res['freq'] =  sprintf("%.02f", $bogomips * 2.047975727695079);

$json = json_encode($res, true);

echo $json;

?>