<?php

/*****************************************************
* modules/motorshield/setaddr.php
* set i2c address divider for Motorshield
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_POST['addr'])) die();

$addr = intval($_POST['addr']);

/* save freq to module config */
file_put_contents("addr", $addr);

?>