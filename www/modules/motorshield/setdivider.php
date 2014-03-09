<?php

/*****************************************************
* modules/motorshield/setdivider.php
* set frequency divider for Motorshield
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_POST['divider'])) die();

$divider = intval($_POST['divider']);

/* get address */
$addr = @file_get_contents("addr");
if (!$addr) $addr = "70";

/* at first - stop all channels */
file_put_contents("/sys/bus/i2c/devices/1-00$addr/all", "0 0");

/* send freq to driver */
file_put_contents("/sys/bus/i2c/devices/1-00$addr/freq", $divider);

?>