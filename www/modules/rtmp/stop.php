<?php

/*****************************************************
* modules/rtmp/stop.php
* rtmp stop command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
include('../../parts/language.php');
lang_swapmod('rtmp');

shell_exec("killall gst-launch-0.10");
echo $language['M_RTMP_STREAM_STOPPED'];

?>
