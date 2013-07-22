<?php

/*****************************************************
* modules/i2c/scan.php
* i2c scan command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$content = shell_exec ("i2cdetect -y 1");

echo '<pre>' . $content . '</pre>';

?>