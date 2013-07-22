<?php

/*****************************************************
* modules/gpio/swtpwmspeed.php
* gpio set PWM command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$pwm = $_GET['pwm'];
$value = $_GET['value'];
$period = $_GET['period'];

$command = "set pwm$pwm duty:$value\n period:$period";

$handle = fopen('/dev/v2rpins', 'a');
flock($handle, LOCK_EX);
fwrite($handle, $command);
flock($fp, LOCK_UN);
fclose($handle);

?>