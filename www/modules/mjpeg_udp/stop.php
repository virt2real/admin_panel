<?php

/*****************************************************
* modules/mjpeg_udp/stop.php
* mjpeg_udp stop command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

shell_exec("killall gst-launch-0.10");
echo 'MJPEG udp stream stopped';

?>