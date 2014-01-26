<?php

/*****************************************************
* modules/motorshield/setbipolar.php
* set bipolar motors params for Motorshield
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_POST['action']) || !isset($_POST['num']) || !isset($_POST['value'])) die();

$action = intval($_POST['action']);
$num = intval($_POST['num']);
$value = intval($_POST['value']);

switch ($action) {

	case 1: /* set direction */

		if (!isset($_POST['pin'])) die;
		$pin = intval($_POST['pin']);
		if (!$pin) die;

		switch ($num) {
			case 1:
				if ($pin == 1) $gpio = 22;
				if ($pin == 2) $gpio = 23;
				break;
			case 2:
				if ($pin == 1) $gpio = 24;
				if ($pin == 2) $gpio = 26;
				break;
			case 3:
				if ($pin == 1) $gpio = 32;
				if ($pin == 2) $gpio = 33;
				break;
			case 4:
				if ($pin == 1) $gpio = 36;
				if ($pin == 2) $gpio = 37;
				break;
			case 5:
				if ($pin == 1) $gpio = 27;
				if ($pin == 2) $gpio = 28;
				break;
			case 6:
				if ($pin == 1) $gpio = 29;
				if ($pin == 2) $gpio = 30;
				break;
			case 7:
				if ($pin == 1) $gpio = 81;
				if ($pin == 2) $gpio = 82;
				break;
			case 8: 
				if ($pin == 1) $gpio = 85;
				if ($pin == 2) $gpio = 86;
				break;

			default: die;
		}

		file_put_contents("/dev/v2r_gpio", "set gpio $gpio output $value");

	break;

	case 2: /* set speed */

		if (!isset($_POST['period'])) die;
		$period = intval($_POST['period']);
		if (!$period) die;

		/* get i2c address */
		$addr = @file_get_contents("addr");
		if (!$addr) $addr = "40";

		switch ($num) {
			case 1: $channel = 0; $type = 1; $con = 43;
				break;
			case 2: $channel = 1; $type = 1; $con = 44;
				break;
			case 3: $channel = 12; $type = 2; 
				break;
			case 4: $channel = 13; $type = 2; 
				break;
			case 5: $channel = 2; $type = 1; $con = 19;
				break;
			case 6: $channel = 3; $type = 1; $con = 42;
				break;
			case 7: $channel = 14; $type = 2; 
				break;
			case 8: $channel = 15; $type = 2; 
				break;
			default: die;
		}

		if ($type == 1) {
			$percentage = $value / 4095;
			$duty = round($period * $percentage);
			
			file_put_contents("/dev/v2r_pins", "set con $con pwm$channel");
			file_put_contents("/dev/v2r_pins", "set pwm $channel $duty $period");
		} else 
		if ($type == 2) {
			file_put_contents("/sys/bus/i2c/devices/1-00$addr/ch$channel", "0 $value");
		}


	break;

}


?>