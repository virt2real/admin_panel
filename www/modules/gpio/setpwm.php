<?php

/*****************************************************
* modules/gpio/setpwm.php
* set PWM on GPIO command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$num = intval($_GET['num']);
$pwm = $_GET['pwm'];
$value = $_GET['value'];
$period = $_GET['period'];

$command = 'echo "set con'.$num.' pwm'.$pwm.'" > /dev/v2rpins';
$content = shell_exec($command);
echo $command.'<br>';

$command = 'echo "set pwm'.$pwm.' duty:'.$value.' period:'.$period.'" > /dev/v2rpins';
$content = shell_exec($command);
echo $command.'<br>';

?>