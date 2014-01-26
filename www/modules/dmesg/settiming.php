<?php

/*****************************************************
* modules/dmesg/settiming.php
* set dmesg timestamps
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (isset($_GET['state'])) {

	$state = intval($_GET['state']);

	if ($state == 0)
		file_put_contents("/sys/module/printk/parameters/time", "n");
	else 
	if ($state == 1)
		file_put_contents("/sys/module/printk/parameters/time", "y");

}


?>