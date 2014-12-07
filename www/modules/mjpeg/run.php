<?php

/*****************************************************
* modules/mjpeg/run.php
* mjpeg run command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('mjpeg');

$quality = intval($_POST['quality']);
$port = intval($_POST['port']);

$params = "PORT=$port\nQUALITY=$quality\n";
file_put_contents("/etc/virt2real/mjpeg_server.conf", $params);

shell_exec("/etc/virt2real/mjpeg_server.sh start");

echo $language['M_MJPEG_STARTED'];

?>
