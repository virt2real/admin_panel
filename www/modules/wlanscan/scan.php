<?php

/*****************************************************
* modules/wlanscan/scan.php
* scan wlan networks
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$content = shell_exec ("iwlist wlan0 scan");

echo '<pre>' . $content . '</pre>';


?>