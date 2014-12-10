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
$bitrate = $_POST['bitrate'];
$enablesound = $_POST['enablesound'];

$params = "LOCATION=$location\nBITRATE=$bitrate\nSOUND=$enablesound\n";
file_put_contents("/etc/virt2real/rtmp_client.conf", $params);

shell_exec("/etc/virt2real/rtmp_client.sh start");

printf($language['M_RTMP_STREAM_STARTED'], $location, $playpath, $bitrate);

?>
