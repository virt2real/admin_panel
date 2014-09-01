<?php

/*****************************************************
* modules/autorun/move.php
* move files from /etc/init.d to /etc/init.d.sample and vice versa
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');


if (!isset($_POST['filename']) || !isset($_POST['action'])) die();

$ACTIVE_PATH = "/etc/init.d";
$INACTIVE_PATH = "/etc/init.d.sample";

if (!file_exists($INACTIVE_PATH))
	mkdir($INACTIVE_PATH);

if (!file_exists($ACTIVE_PATH))
	mkdir($ACTIVE_PATH);


switch ($_POST['action']) {

	case 1:
		rename($ACTIVE_PATH . '/' . $_POST['filename'], $INACTIVE_PATH . '/' . $_POST['filename']);
		break;

	case 2:
		rename($INACTIVE_PATH . '/' . $_POST['filename'], $ACTIVE_PATH . '/' . $_POST['filename']);
		break;

}

?>