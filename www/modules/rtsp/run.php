<?php

/*****************************************************
* modules/rtsp/run.php
* rtsp run command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('rtsp');

$bitrate = intval($_POST['bitrate']);
$port = intval($_POST['port']);
$type = intval($_POST['type']);
$path = $_POST['path'];

$params = "PORT=$port\nBITRATE=$bitrate\nPATH=$path\nVERSION=$type\n";
file_put_contents("/etc/virt2real/rtsp_server.conf", $params);

shell_exec("/etc/virt2real/rtsp_server.sh start");

printf($language['M_RTSP_STREAM_STARTED']);

?>
