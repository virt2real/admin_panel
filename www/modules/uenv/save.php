<?php

/*****************************************************
* modules/uenv/save.php
* uenv save settings
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$text = $_POST['text'];

shell_exec("mount /dev/mmcblk0p1 /mnt");

$filename = "/mnt/uEnv.txt";
if (is_writable($filename)) {
    if (!$handle = fopen($filename, 'w')) {
		die("can not access file $filename");
	}

   	if (fwrite($handle, $text) === FALSE) {
       	die("can not write $filename");
    }

   	echo "successfully saved";

    fclose($handle);

} else {
	echo "no access to $filename";
}

shell_exec("umount /mnt");

?>