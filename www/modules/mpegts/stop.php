<?php

/*****************************************************
* modules/mpegts/stop.php
* mpegts stop command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('mpegts');

shell_exec("/etc/virt2real/mpegts_server.sh stop");

echo $language['M_MPEGTS_STREAM_STOPPED'];

?>
