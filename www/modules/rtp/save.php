<?php

/*****************************************************
* modules/rtp/save.php
* rtp settings save file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$text = $_POST['text'];
$filename = '/etc/virt2real/rtp_server.sh';

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