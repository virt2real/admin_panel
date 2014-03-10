<?php

/*****************************************************
* modules/autorun/save.php
* save text to file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
include('../../parts/language.php');
lang_swapmod('autorun');

$filename = '/etc/virt2real/autostart.sh';
$somecontent = $_POST['text'];

if (is_writable($filename)) {
	if (!$handle = fopen($filename, 'w')) {
		die($language['M_ERR_NO_ACCESS']." $filename");
	}

	if (fwrite($handle, $somecontent) === FALSE) {
        die($language['M_ERR_NO_WRITE']." $filename");
	}

    echo $language['M_SAVE_SUCCESS'];

	fclose($handle);

} else {
	echo $language['M_ERR_NO_ACCESS']." $filename";
}

?>
