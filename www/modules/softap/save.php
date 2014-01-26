<?php

/*****************************************************
* modules/softap/save.php
* softap save settings
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_POST['ssid']) || !isset($_POST['passphrase'])) die ();

$ssid = $_POST['ssid'];
$passphrase = $_POST['passphrase'];
$text = "SSID=$ssid\nPASSPHRASE=$passphrase\n";
$filename = "/etc/softap.conf";
if (!$handle = fopen($filename, 'w+')) {
	die("can not access file $filename");
}
if (fwrite($handle, $text) === FALSE) {
	die("can not write $filename");
}

fclose($handle);

echo "settings saved";


?>