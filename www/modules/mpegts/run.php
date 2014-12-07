<?php

/*****************************************************
* modules/mpegts/run.php
* mpegts run command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('mpegts');

$clients = preg_replace('/\s+/', '', $_POST['clients']); // strip spaces
$bitrate = $_POST['bitrate'];

$params = "CLIENTS=$clients\nBITRATE=$bitrate\n\n";
file_put_contents("/etc/virt2real/mpegts_server.conf", $params);

shell_exec("/etc/virt2real/mpegts_server.sh start");

printf($language['M_MPEGTS_STREAM_STARTED']);

?>
