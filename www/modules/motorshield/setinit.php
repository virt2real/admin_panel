<?php

/*****************************************************
* modules/motorshield/setinit.php
* send init command for Motorshield
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

/* get address */
$addr = @file_get_contents("addr");
if (!$addr) $addr = "40";

file_put_contents("/sys/bus/i2c/devices/1-00$addr/init", "1");

?>