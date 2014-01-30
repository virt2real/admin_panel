<?php

/*****************************************************
* modules/3g/connect.php
* run 3G connection script
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_POST['state'])) die ();

$state = $_POST['state'];

if ($state) {
	shell_exec("/etc/virt2real/pppd.sh connect &");
} else {
	shell_exec("/etc/virt2real/pppd.sh disconnect");
}

?>