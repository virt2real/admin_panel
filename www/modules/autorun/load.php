<?php

/*****************************************************
* modules/autorun/load.php
* load list from /etc/init.d
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$ACTIVE_PATH = "/etc/init.d";
$INACTIVE_PATH = "/etc/init.d.sample";

$active_list = array();
$inactive_list = array();

/* load current active scripts from /etc/init.d */

if (file_exists($ACTIVE_PATH)) {

if ($handle = opendir($ACTIVE_PATH)) {
	while (false !== ($file = readdir($handle))) { 
		if ($file != "." && $file != ".." && $file != "rcK" && $file != "rcS") { 
			if (is_dir($ACTIVE_PATH.'/'.$file)) continue;
			$active_list[] = $file;
		} 
	}
	closedir($handle); 
}

sort($active_list);

}


/* load inactive scripts from /etc/init.d.sample */

if (file_exists($INACTIVE_PATH)) {

if ($handle = opendir($INACTIVE_PATH)) {
	while (false !== ($file = readdir($handle))) { 
		if ($file != "." && $file != ".." && $file != "rcK" && $file != "rcS") { 
			if (is_dir($INACTIVE_PATH.'/'.$file)) continue;
			$inactive_list[] = $file;
		} 
	}
	closedir($handle); 
}

sort($inactive_list);
}


$result['active'] = $active_list;
$result['inactive'] = $inactive_list;

echo json_encode($result);

?>