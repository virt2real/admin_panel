<?php

/*****************************************************
* modules/ivideon/saveparams.php
* save common params for Ivideon start scripts
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('ivideon');

if (!isset($_POST['autorun']))
	die("empty autorun");


/* check autorun setting */
$autorun = intval($_POST['autorun']);

/* make move path */
if ($autorun) {
	$from = '/etc/init.d.sample';
	$to = '/etc/init.d';
} else {
	$from = '/etc/init.d';
	$to = '/etc/init.d.sample';
}

/* move autorun script */
@rename($from.'/S95ivideon', $to.'/S95ivideon');


?>