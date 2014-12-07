<?php

/*****************************************************
* modules/rtsp/saveparams.php
* save autostart params for RTSP server
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('rtsp');

if (!isset($_POST['autorun']))
	die("empty autorun");

/* check autorun setting */
$autorun = intval($_POST['autorun']);

/* make move path */
if ($autorun) {
	$from = '/etc/init.d.sample';
	$to = '/etc/init.d';

	// move all other video scripts to inactive dir
	exec("mv /etc/init.d/S92* /etc/init.d.sample/");

} else {
	$from = '/etc/init.d';
	$to = '/etc/init.d.sample';
}

/* move autorun script for RTSP server */
@rename($from.'/S92rtspserver', $to.'/S92rtspserver');

?>