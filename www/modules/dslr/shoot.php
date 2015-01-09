<?php

/*****************************************************
* modules/dslr/shoot.php
* dslr make shoot 
* (c)virt2real.ru 2015
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$result_file = "";

switch (intval($_POST["cmd"])) {
	case 1:
		shell_exec("gphoto2 --capture-preview --force-overwrite");
		$result_file = "capture_preview.jpg";
	break;
	case 2:
		shell_exec("gphoto2 --capture-image --force-overwrite");
		$result_file = "";
	break;
	case 3:
		shell_exec("gphoto2 --capture-image-and-download --force-overwrite");
		$result_file = "capt0000.jpg";
	break;
}

$result['status'] = 0;
$result['filename'] = $result_file;
$result['obj'] = $_POST["obj"];

echo json_encode($result);

?>
