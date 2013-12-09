<?php

/*****************************************************
* modules/rtp/run.php
* rtp run command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$host = $_POST['host'];
$port = $_POST['port'];
$bitrate = $_POST['bitrate'];

shell_exec("./rtp.sh $host $port $bitrate");

echo 'RTP started stream to ' . $host . ':' . $port . ' at ' . $bitrate .' kbps';

?>