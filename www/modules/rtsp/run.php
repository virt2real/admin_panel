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

$bitrate = $_POST['bitrate'];

shell_exec("./rtsp.sh $bitrate");

printf($language['M_RTSP_STREAM_STARTED']);

?>
