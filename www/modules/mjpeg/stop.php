<?php

/*****************************************************
* modules/mjpeg/stop.php
* mjpeg stop command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('mjpeg');

shell_exec("killall gst-launch-0.10");
echo $language['M_MJPEG_STOPPED'];

?>
