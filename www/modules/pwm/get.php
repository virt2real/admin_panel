<?php

/*****************************************************
* modules/pwm/get.php
* PWM get command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$result = array();

for ($n = 0; $n < $TOTAL_PWM; $n++) {
	$pwm = @file_get_contents("/proc/v2r_pins/pwm$n");

	$tmp = explode(" ", $pwm);

	$cons = array();

	for ($i = 3; $i < sizeof($tmp); $i++) {
		if ($tmp[$i] && $tmp[$i] != "\n") $cons [] = $tmp[$i];
	}

	$element['id'] = $tmp[0]; // pwm id
	$element['duty'] = $tmp[1]; // pwm duty
	$element['period'] = $tmp[2]; // pwm period
	$element['cons'] = $cons; // cons on this pwm

	$result [] = $element;
	
}

echo json_encode($result);

?>
