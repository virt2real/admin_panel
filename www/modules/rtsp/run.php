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

shell_exec("/etc/virt2real/rtsp_server.sh start $port $path $bitrate $type > /dev/null &");
printf($language['M_RTSP_STREAM_STARTED']);

?>
