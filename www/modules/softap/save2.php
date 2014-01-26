<?php

/*****************************************************
* modules/softap/save2.php
* hostapd config save settings
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_POST['text'])) die ();

$text = $_POST['text'];
$filename = "/etc/hostapd/hostapd.conf";
if (!$handle = fopen($filename, 'w+')) {
	die("can not access file $filename");
}
if (fwrite($handle, $text) === FALSE) {
	die("can not write $filename");
}

fclose($handle);

echo "settings saved";


?>