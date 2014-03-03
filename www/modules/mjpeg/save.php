<?php

/*****************************************************
* modules/mjpeg/save.php
* mjpeg settings save file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$text = $_POST['text'];
$filename = 'mjpeg.sh';

if (file_put_contents($filename, $text)) echo "success"; else echo "error";

 
?>