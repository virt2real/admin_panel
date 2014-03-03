<?php

/*****************************************************
* modules/mjpeg_udp/run.php
* mjpeg_udp run command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$host = $_POST['host'];
$port = $_POST['port'];
$quality = $_POST['quality'];
$fps = $_POST['fps'];

shell_exec("./mjpeg_udp.sh $host $port $quality $fps");

echo 'MJPEG udp started stream to ' . $host . ':' . $port . ' at ' . $fps . ' fps ' . $quality .' % quality';

?>