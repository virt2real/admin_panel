<?php

/*****************************************************
* modules/gphotoview/preview.php
* gphotoview load preview files from camera
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$result['status'] = 1;

switch ($_POST["cmd"]) {
	case 1:
		shell_exec("mountptp.sh");
		$result['status'] = 0;

		break;
	case 2:
		shell_exec("umountptp.sh");
		$result['status'] = 0;
		break;
	default: 
}

echo json_encode($result);

?>