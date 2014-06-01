<?php

/*****************************************************
* modules/mjpeg_udp/stop.php
* mjpeg_udp stop command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('mjpeg_udp');

shell_exec("killall gst-launch-0.10");
@file_put_contents("/tmp/onair", "");
echo $language['M_MJPEG_UDP_STOP'];

?>
