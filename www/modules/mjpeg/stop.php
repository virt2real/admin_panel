<?php

/*****************************************************
* modules/mjpeg/stop.php
* mjpeg stop command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

shell_exec("killall gst-launch-0.10");
echo 'MJPEG server stopped';

?>