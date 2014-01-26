<?php

/*****************************************************
* modules/motorshield/set.php
* set channels for Motorshield
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_POST['action']) || !isset($_POST['num']) || !isset($_POST['pos'])) die();

$action = intval($_POST['action']);
$num = intval($_POST['num']);
$pos = intval($_POST['pos']);

/* get address */
$addr = @file_get_contents("addr");
if (!$addr) $addr = "40";


switch ($action) {

	case 1: /* servo */
		switch ($num) {
			case 1: $channel = 0; break;
			case 2: $channel = 1; break;
			case 3: $channel = 2; break;
			case 4: $channel = 3; break;
			case 5: $channel = 4; break;
			case 6: $channel = 5; break;
			case 7: $channel = 6; break;
			case 8: $channel = 7; break;
		}

		if ($num == -1 && $pos == -1) {
			file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch0", "0 0");
			file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch1", "0 0");
			file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch2", "0 0");
			file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch3", "0 0");
			file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch4", "0 0");
			file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch5", "0 0");
			file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch6", "0 0");
			file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch7", "0 0");
			die();
		}

		$divider = intval(@file_get_contents("/sys/bus/i2c/devices/1-00$addr/freq"));
		if (!$divider) die();
		$freq = intval(25000000 / ($divider + 1) / 4096);
		$tic =  1 / $freq / 4096;

		$minval = intval($_POST['minval']);
		if (!$minval) die();
		$maxval = intval($_POST['maxval']);
		if (!$maxval) die();

		$min = intval($minval / 1000000 / $tic);
		$max = intval($maxval / 1000000 / $tic);

		$scale = ($max - $min) / 180;
		$duty = intval($min + $scale * $pos);
		file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch$channel", "0 $duty");

	break;

	case 2: /* unipolar */
		switch ($num) {
			case 1: file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch8", "0 $pos"); break;
			case 2: $pos = $pos > (4095/2) ? 1 : 0; file_put_contents("/dev/v2r_gpio", "set gpio 31 output $pos"); break;
			case 3: file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch9", "0 $pos"); break;
			case 4: $pos = $pos > (4095/2) ? 1 : 0; file_put_contents("/dev/v2r_gpio", "set gpio 50 output $pos"); break;
			case 5: file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch10", "0 $pos"); break;
			case 6: $pos = $pos > (4095/2) ? 1 : 0; file_put_contents("/dev/v2r_gpio", "set gpio 79 output $pos"); break;
			case 7: file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch11", "0 $pos"); break;
			case 8: $pos = $pos > (4095/2) ? 1 : 0; file_put_contents("/dev/v2r_gpio", "set gpio 88 output $pos"); break;
		}

	break;

}


?>