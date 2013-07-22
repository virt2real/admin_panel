<?php

/*****************************************************
* modules/ping/ping.php
* ping command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$host = $_GET['host'];

$content = shell_exec ("ping " . $host . " -c 3");

echo '<pre>' . $content . '</pre>';

?>