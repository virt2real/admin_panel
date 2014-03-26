<?php

/*****************************************************
* modules/rtmp/run.php
* rtmp run command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
include('../../parts/language.php');
lang_swapmod('rtmp');

$location = $_POST['location'];
$playpath = $_POST['playpath'];
$bitrate = $_POST['bitrate'];

shell_exec("./rtmp.sh $location $playpath $bitrate");

printf($language['M_RTMP_STREAM_STARTED'], $location, $playpath, $bitrate);

?>
