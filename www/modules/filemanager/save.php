<?php

/*****************************************************
* modules/filemanager/save.php
* save changed files
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$filename = $_POST['file'];
$text = $_POST['text'];

if (is_writable($filename)) {
    if (!$handle = fopen($filename, 'w')) {
		die("cannot access file $filename");
	}

   	if (fwrite($handle, $text) === FALSE) {
       	die("cannot write $filename");
    }

   	echo "successfully saved";

    fclose($handle);

} else {
	echo "no access to $filename";
}

?>
