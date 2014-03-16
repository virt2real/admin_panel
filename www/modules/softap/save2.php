<?php

/*****************************************************
* modules/softap/save2.php
* hostapd config save settings
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('softap');

if (!isset($_POST['text'])) die ();

$text = $_POST['text'];
$filename = "/etc/hostapd/hostapd.conf";
if (!$handle = fopen($filename, 'w+')) {
	die($language['M_ERR_NO_ACCESS'] . "$filename");
}
if (fwrite($handle, $text) === FALSE) {
	die($language['M_ERR_NO_WRITE'] . "$filename");
}

fclose($handle);

echo $language['M_SAVE_SUCCESS'];


?>
