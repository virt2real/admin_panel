<?php

/*****************************************************
* modules/fs/doresize.php
* fs resize
* (c)virt2real.ru 2015
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('fs');

if (!isset($_POST['size']) || !isset($_POST['maxsize'])) die ();

$size = intval($_POST['size']) * 1024; // in kBytes
$maxsize = intval($_POST['maxsize'])  * 1024; // in kBytes

$partition = "/dev/mmcblk0";

if ($size == $maxsize) {
	// fill all card
	$cmd = 'echo -e "1,5,0xC,*\n6,,L" | sfdisk ' . $partition . ' -q -D -H255 -S63 --force';
} else {
	// fixed size
	$sectors = intval($size / 8520); // hren znaet chto tut dolzhno byt'
	$cmd = 'echo -e "1,5,0xC,*\n6,' . $sectors . ',L" | sfdisk ' . $partition . ' -q -D -H255 -S63 --force';
}

$result = shell_exec($cmd);
echo '<pre>' . $result . '</pre>';

// copy resize script to autorun dir
shell_exec("cp ./S00fsresize /etc/init.d/");
shell_exec("chmod +x /etc/init.d/S00fsresize");

?>
