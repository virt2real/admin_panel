<?php

/*****************************************************
* modules/gpio/setgpio.php
* set GPIO state
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_GET['dir']) || !isset($_GET['val']) || !isset($_GET['num'])) die;

$dir = intval($_GET['dir']);
$val = intval($_GET['val']);

if ($dir) $direction = "output"; else $direction = "input";

$num = $_GET['num'];
$list = explode(",", $num);

foreach ($list as $k=>$v) {

	if (!$v) continue;

	$cmd = "set gpio $v $direction $val";
	file_put_contents("/dev/v2r_gpio", $cmd);

}

?>