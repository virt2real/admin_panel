<?php

/*****************************************************
* modules/kernels/get.php
* video params get command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$res['width'] 	= str_replace("\n", "", file_get_contents("/etc/virt2real/video.width"	));
$res['height'] 	= str_replace("\n", "", file_get_contents("/etc/virt2real/video.height"	));
$res['fps'] 	= str_replace("\n", "", file_get_contents("/etc/virt2real/video.fps"	));
$res['pitch'] 	= str_replace("\n", "", file_get_contents("/etc/virt2real/video.pitch"	));

if (($res['width'] == 720) && ($res['height'] == 576))
	$res['buf'] = $res['width'] * $res['height'] * 3 * 2 * 2 * 2;
else
	$res['buf'] = $res['width'] * $res['height'] * 3 * 2 * 2;
$res['mem'] = intval(102 - ($res['buf'] / 1048576));

$json = json_encode($res, false);
echo $json;

?>
