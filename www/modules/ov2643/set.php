<?php

/*****************************************************
* modules/ov2643/set.php
* ov2643 set command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$base = $_GET['base'];
$reg = $_GET['reg'];
$value = $_GET['value'];

$content = shell_exec ("i2cset -f -y 1 $base $reg $value");

?>
