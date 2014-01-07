<?php

/*****************************************************
* modules/gphotoctrl/shoot.php
* gphotoctrl make shoot 
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

switch ($_POST["cmd"]) {
	case 1:
		shell_exec("gphoto2 --capture-preview");
	break;
}


$result['status'] = $status;
$result['obj'] = $_POST["obj"];

echo json_encode($result);

?>