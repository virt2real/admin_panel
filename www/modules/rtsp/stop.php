<?php

/*****************************************************
* modules/rtsp/stop.php
* rtsp stop command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('rtsp');

shell_exec("/etc/virt2real/rtsp_server.sh stop");

echo $language['M_RTSP_STREAM_STOPPED'];

?>
