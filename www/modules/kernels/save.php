<?php

/*****************************************************
* modules/kernels/save.php
* kernel save select
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('kernels');

$kernelname = $_POST['text'];
$newkernellist = '';

shell_exec("mount /dev/mmcblk0p1 /mnt");

// копируем нужный файл ядра в uImage
if (!copy("/mnt/$kernelname", "/mnt/uImage")) {
	die($language['M_KERNELFILE'] . ' ' . $kernelname . ' ' . $language['M_NOTFOUND']);
}

// читаем список описаний ядер
$kerneldescrfile = file('/mnt/kernels.list');
foreach ($kerneldescrfile as $k => $v) {
	$tmp = explode("\t", $v); // split parts via tabs
	$tmp[2] = ($tmp[0] == $kernelname) ? $tmp[2] = "*" : "";
	$newkernellist .= $tmp[0] . "\t" . $tmp[1] . "\t" . $tmp[2] . "\n";
}

// write new kernels list
file_put_contents("/mnt/kernels.list", $newkernellist);

shell_exec("umount /mnt");

echo $language['M_KERNELCHANGED1'] . ' ' . $kernelname . '<br>' . $language['M_KERNELCHANGED2'];

?>
