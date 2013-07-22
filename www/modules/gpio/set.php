<?php

/*****************************************************
* modules/gpio/set.php
* gpio set command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$num = intval($_GET['num']);
$state = $_GET['state'];

$command = 'echo "set con'.$num.' output:'.$state.'" > /dev/v2r_pins';

$content = shell_exec($command);
echo $command;

?>