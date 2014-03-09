<?php

/*****************************************************
* modules/mjpeg_udp/save.php
* mjpeg_udp settings save file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$text = $_POST['text'];
$filename = 'mjpeg_udp.sh';

if (file_put_contents($filename, $text)) echo "success"; else echo "error";


?>