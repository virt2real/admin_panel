<?php

/*****************************************************
* modules/filemanager/save.php
* save changed files
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('filemanager');

$filename = $_POST['file'];
$text = $_POST['text'];

if (is_writable($filename)) {
    if (!$handle = fopen($filename, 'w')) {
		die($language['M_ERR_NO_ACCESS']." $filename");
	}

   	if (fwrite($handle, $text) === FALSE) {
       	die($language['M_ERR_NO_WRITE']." $filename");
    }

   	echo $language['M_SAVE_SUCCESS'];

    fclose($handle);

} else {
	echo $language['M_ERR_NO_ACCESS']." $filename";
}

?>
