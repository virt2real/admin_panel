<?php

/*****************************************************
* modules/i2c/get.php
* i2c read registers file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$base = $_GET['base'];
$reg = $_GET['reg'];

$content = shell_exec ("i2cget -f -y 1 $base $reg");

echo $content;

?>