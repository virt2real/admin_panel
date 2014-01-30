<?php

/*****************************************************
* modules/usbmon/scan.php
* scan USB devices
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$content = shell_exec ("lsusb");

echo '<pre>' . $content . '</pre>';


?>