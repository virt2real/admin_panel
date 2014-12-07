<?php

/*****************************************************
* modules/wlanscan/check.php
* check current wlan state
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$content = shell_exec ("wpa_cli status");

echo '<pre>' . $content . '</pre>';


?>