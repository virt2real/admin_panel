<?php

/*****************************************************
* modules/sonywificam/check.php
* check device discovery state
* (c) virt2real 2015
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$filename = '/tmp/sonyssdpdiscovery';
$success = true;
$content = "";

if (file_exists($filename)) {
    if (!$handle = fopen($filename, "r")) {
		$success &= false;
	}
	$content = fread($handle, filesize($filename));
    fclose($handle);
} else {
	$success &= false;

	// check if discover already active
	$count = shell_exec ("ps | grep -c discover/discover.js");
	if (intval($count) < 3)
		shell_exec("node discover/discover.js 20 SonyImagingDevice /tmp/sonyssdpdiscovery > /dev/null &");
}

if ($success)
	echo $content;

?>
