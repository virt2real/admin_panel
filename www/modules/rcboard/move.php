<?php

/*****************************************************
* modules/rcboard/move.php
* move files from /etc/init.d to /etc/init.d.sample and vice versa
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');


if (!isset($_POST['filename']) || !isset($_POST['action'])) die();

$ACTIVE_PATH = "/opt/rcboard/rc.d";
$INACTIVE_PATH = "/opt/rcboard/extensions";

switch ($_POST['action']) {

	case 1:
		rename($ACTIVE_PATH . '/' . $_POST['filename'], $INACTIVE_PATH . '/' . $_POST['filename']);
		exec("killall " . $_POST['filename'] . " >> /dev/null");
		break;

	case 2:
		rename($INACTIVE_PATH . '/' . $_POST['filename'], $ACTIVE_PATH . '/' . $_POST['filename']);
		exec("cd $ACTIVE_PATH ; ./" . $_POST['filename'] . " >> /dev/null &");
		break;

}

?>