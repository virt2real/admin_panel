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

// save kernel name
file_put_contents("/etc/virt2real/video.kernel", $kernelname);

// make video params for every kernel type
switch ($kernelname) {
	case "uImage.master":
		$width = "640"; // default value
		$height = "480"; // default value
		$fps = "30"; // default value
		$pitch = ""; // default value
	break;
	case "uImage.hd":
		$width = "1280"; // default value
		$height = "720"; // default value
		$fps = "30"; // default value
		$pitch = ""; // default value
	break;
	case "uImage.tvp5150":
		$width = "720"; // default value
		$height = "576"; // default value
		$fps = "25"; // default value
		$pitch = "736"; // default value
	break;
	case "uImage.hdmi":
		$width = "1280"; // default value
		$height = "720"; // default value
		$fps = "30"; // default value
		$pitch = ""; // default value
	break;
	case "uImage.hdmi1080p":
		$width = "1920"; // default value
		$height = "1088"; // default value
		$fps = "30"; // default value
		$pitch = ""; // default value
	break;
}

// write video params to config files
file_put_contents("/etc/virt2real/video.width", $width);
file_put_contents("/etc/virt2real/video.height", $height);
file_put_contents("/etc/virt2real/video.fps", $fps);
file_put_contents("/etc/virt2real/video.pitch", $pitch);

echo $language['M_KERNELCHANGED1'] . ' ' . $kernelname . '<br>' . $language['M_KERNELCHANGED2'];

?>
