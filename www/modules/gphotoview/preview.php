<?php

/*****************************************************
* modules/gphotoview/preview.php
* gphotoview load preview files from camera
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

switch ($_POST["cmd"]) {
	case 1:
		$result['text'] = shell_exec("cd ./thumbnails && yes | gphoto2 --get-all-thumbnails");
		$result['status'] = 0;

		break;
	case 2:
		shell_exec("rm -f ./thumbnails/*");
		$result['status'] = 0;
		break;
	default: 
}

echo json_encode($result);

?>