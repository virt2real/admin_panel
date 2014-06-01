<?php

/*****************************************************
* modules/mjpeg_udp/run.php
* mjpeg_udp run command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('mjpeg_udp');

$host = $_POST['host'];
$port = $_POST['port'];
$quality = $_POST['quality'];
$fps = $_POST['fps'];

shell_exec("./mjpeg_udp.sh $host $port $quality $fps");
@file_put_contents("/tmp/onair", "MJPEG");
printf($language['M_JPEG_UDP_START'], $host, $port, $fps, $quality);

?>
