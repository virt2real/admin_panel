<?php

/*****************************************************
* modules/systemmessages/get.php
* systemmessages get command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (isset($_GET['num'])) {

	if ($_GET['num'] > 0)
		$cmd = "cat /var/log/messages | tail -n " . $_GET['num'];
	else 
		$cmd = @file_get_contents("/var/log/messages");

	echo '<pre>'.shell_exec($cmd).'</pre>';

}


?>