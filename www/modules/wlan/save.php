<?php

/*****************************************************
* modules/wlan/save.php
* wpa_supplicant config save settings
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('wlan');

if (!isset($_POST['text'])) die ();

$text = $_POST['text'];

if (strlen($text) < 1) die($language['M_ERR_NO_WRITE']);

$filename = "/etc/wpa_supplicant.conf";
if (!$handle = fopen($filename, 'w+')) {
	die($language['M_ERR_NO_ACCESS'] . "$filename");
}
if (fwrite($handle, $text) === FALSE) {
	die($language['M_ERR_NO_WRITE'] . "$filename");
}

fclose($handle);

echo $language['M_SAVE_SUCCESS'];


?>
