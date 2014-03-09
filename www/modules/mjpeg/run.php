<?php

/*****************************************************
* modules/mjpeg/run.php
* mjpeg run command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$port = $_POST['port'];
$quality = $_POST['quality'];

shell_exec("./mjpeg.sh $port $quality");
echo 'MJPEG server started';

?>