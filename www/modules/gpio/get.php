<?php

/*****************************************************
* modules/gpio/get.php
* gpio get command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$command = '<pre>' . shell_exec ("cat /sys/kernel/debug/gpio") . '</pre>';
echo $command;

?>