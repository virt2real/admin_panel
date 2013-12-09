<?php
/*****************************************************
* modules/network/saveinterfaces.php
* network interfaces save file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/


// common include
include('../../parts/global.php');


$filename = '/etc/network/interfaces';
$somecontent = $_POST['text'];

if (is_writable($filename)) {
	if (!$handle = fopen($filename, 'w')) {
		die("can not access file $filename");
	}

	if (fwrite($handle, $somecontent) === FALSE) {
        	die("can not write $filename");
	}

    	echo "successfully saved";

	    fclose($handle);

} else {
	echo "no access to $filename";
}

?>