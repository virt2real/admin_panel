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

/* check checkupdates */
$checkupdates = intval($_POST['checkupdates']);

/* check checkupdates */
$redirectoutput = intval($_POST['redirectoutput']);

/* parse other params */

$config = $_POST['config'];
$user = intval($_POST['user']);
$hash = $_POST['hash'];
$address = $_POST['address'];

$text = "CHECKUPDATES=$checkupdates\nREDIRECTOUTPUT=$redirectoutput\nCONFIG=$config\nUSER=$user\nHASH=$hash\nADDRESS=$address\n";

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