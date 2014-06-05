<?php

/*****************************************************
* modules/rcboard/save.php
* rcboard settings save file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

/* check autorun setting */
$autorun = intval($_POST['autorun']);

/* make move path */
if ($autorun) {
	$from = '/etc/init.d.sample/S98rcboard';
	$to = '/etc/init.d/S98rcboard';
} else {
	$from = '/etc/init.d/S98rcboard';
	$to = '/etc/init.d.sample/S98rcboard';
}

/* move autorun script */
@rename($from, $to);

/* parse other params */

$config = $_POST['config'];
$host = $_POST['host'];
$port = intval($_POST['port']);
$bitrate = intval($_POST['bitrate']);
$maxbitrate = intval($_POST['maxbitrate']);
$mtu = intval($_POST['mtu']);
$user = intval($_POST['user']);
$hash = $_POST['hash'];
$address = $_POST['address'];

$text = "CONFIG=$config\nHOST=$host\nPORT=$port\nBITRATE=$bitrate\nMAXBITRATE=$maxbitrate\nMTU=$mtu\nUSER=$user\nHASH=$hash\nADDRESS=$address\n";

$filename = '/opt/rcboard/config.sh';
$success = true;

if (is_writable($filename)) {
    if (!$handle = fopen($filename, 'w')) {
		$success &= false;
	}

   	if (fwrite($handle, $text) === FALSE) {
       	$success &= false;
    }
    fclose($handle);

} else {
	$success &= false;
}

if ($success)
	echo 'success';
else
	echo 'error';

?>