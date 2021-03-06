<?php

/*****************************************************
* modules/rtp/run.php
* rtp run command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('rtp');

$clients = preg_replace('/\s+/', '', $_POST['clients']); // strip spaces
$bitrate = $_POST['bitrate'];
$type = $_POST['type'];

$params = "CLIENTS=$clients\nBITRATE=$bitrate\nTYPE=$type\n";
file_put_contents("/etc/virt2real/rtp_server.conf", $params);

shell_exec("/etc/virt2real/rtp_server.sh start");

printf($language['M_RTP_STREAM_STARTED']);

?>
