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

// fill all card
$cmd = 'echo -e "1,48,0xC,*\n,,,-" | sfdisk --in-order --Linux --unit M ' . $partition . ' --force';

$result = shell_exec($cmd);
echo '<pre>' . $result . '</pre>';

// copy resize script to autorun dir
shell_exec("cp ./S00fsresize /etc/init.d/");
shell_exec("chmod +x /etc/init.d/S00fsresize");

?>
