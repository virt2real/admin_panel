<?php

/*****************************************************
* modules/hls/get.php
* get hls streams list
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');


$HLS_DIR = "/var/media/hls/";

// load HLS streams list

if ($handle = opendir($HLS_DIR)) {
	while (false !== ($file = readdir($handle))) { 
		if ($file != "." && $file != "..") { 
			if (is_dir($HLS_DIR.$file)) {
				$entry['name'] = $file;
				/* check index.m3u8 file */
				if (file_exists($HLS_DIR.$file."/index.m3u8"))
					$entry['active'] = 1;
				else
					$entry['active'] = 0;

				$streamlist [] = $entry;
			}
		} 
	}
	closedir($handle); 
}

if (isset($streamlist)) echo json_encode($streamlist);

?>