<?php

/*****************************************************
* modules/fs/loaddisk.php
* fs get disk size
* (c)virt2real.ru 2015
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('fs');

$disksize['/dev/mmcblk0'] = shell_exec('blockdev --getsize64 /dev/mmcblk0');
$disksize['/dev/mmcblk0p1'] = shell_exec('blockdev --getsize64 /dev/mmcblk0p1');
$disksize['/dev/mmcblk0p2'] = shell_exec('blockdev --getsize64 /dev/mmcblk0p2');
echo json_encode($disksize, true);

?>
