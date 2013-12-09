<?php

/*****************************************************
* modules/dmesg/get.php
* dmesg get command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (isset($_GET['num'])) {

	if ($_GET['num'] > 0)
		$cmd = "dmesg | tail -n " . $_GET['num'];
	else 
		$cmd = "dmesg";

	echo '<pre>'.shell_exec($cmd).'</pre>';

}


?>