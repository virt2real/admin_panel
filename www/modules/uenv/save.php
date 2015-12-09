<?php

/*****************************************************
* modules/uenv/save.php
* uenv save settings
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('uenv');

$text = $_POST['text'];

shell_exec("mount /dev/mmcblk0p1 /mnt");

$filename = "/mnt/uEnv.txt";
if (is_writable($filename)) {
    if (!$handle = fopen($filename, 'w')) {
		die($language['M_ERR_NO_ACCESS'] . "$filename");
	}

   	if (fwrite($handle, $text) === FALSE) {
       	die($language['M_ERR_NO_WRITE'] . "$filename");
    }

   	echo $language['M_SAVE_SUCCESS'];

    fclose($handle);

} else {
	echo $language['M_ERR_NO_ACCESS'];
}

shell_exec("sync");
shell_exec("umount /mnt");

?>
