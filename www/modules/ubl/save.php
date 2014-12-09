<?php

/*****************************************************
* modules/ubl/save.php
* ubl write command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$freq = 0;
$ubl_image = "";

if (isset($_POST['freq'])) $freq = intval($_POST['freq']);

switch ($freq) {
	case 1 :
		$ubl_image = "UBL_DM36x_SDMMC.bin";
		break;
	case 2 :
		$ubl_image = "UBL_DM36x_SDMMC_ARM432_DDR340_OSC24.bin";
		break;
	default:
		die ("wrong ubl image name");
		break;
}

$cmd = "/usr/bin/uflash -d /dev/mmcblk0 -u /etc/virt2real/ubl/$ubl_image -b /etc/virt2real/ubl/u-boot.bin -e 0x82000000 -l 0x82000000";
$code = 0;
$res = Array();
$result = Array();
exec(escapeshellcmd($cmd), $res, $code);

$result['retcode'] = $code;
$result['output'] = '';
foreach ($res as $k => $v) {
	$result['output'] .= "<p>$v</p>";
}

echo json_encode($result, true);

?>