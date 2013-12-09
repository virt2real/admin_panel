<?php
/*****************************************************
* modules/deviceid/save.php
* deviceid save file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$id_filename = '/etc/virt2real/deviceid';
$descr_filename = '/etc/virt2real/devicedescription';

$device_id = $_GET['id'];
$device_descr = $_GET['descr'];

$success = true;

if (is_writable($id_filename)) {
	if (!$handle = fopen($id_filename, 'w')) {
		$success &= false;
	}
	if (fwrite($handle, $device_id) === FALSE) {
		$success &= false;
	}

	fclose($handle);

} else {
	$success &= false;
}

if (is_writable($descr_filename)) {
	if (!$handle = fopen($descr_filename, 'w')) {
		$success &= false;
	}

    	if (fwrite($handle, $device_descr) === FALSE) {
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