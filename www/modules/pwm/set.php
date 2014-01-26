<?php

/*****************************************************
* modules/pwm/set.php
* set PWM params file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_POST['id']) || !isset($_POST['duty']) || !isset($_POST['period'])) die();

$id = $_POST['id'];
$duty = $_POST['duty'];
$period = $_POST['period'];

$cmd = "set pwm $id $duty $period";

file_put_contents("/dev/v2r_pins", $cmd);

?>