<?php

/*****************************************************
* modules/gphotoctrl/get.php
* gphotoctrl get options value
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

switch ($_POST["cmd"]) {
	case 1:
		$result['text'] = shell_exec("gphoto2 --set-config " . $_POST['id'] . "=" . $_POST['value']);
	break;
}


$result['status'] = $status;
$result['obj'] = $_POST["obj"];

echo json_encode($result);

?>