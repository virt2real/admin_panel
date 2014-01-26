<?php


function read_gpios() {


	$file = fopen("/proc/v2r_gpio/all","r");

	if(!$file) {
		return;
	} else {

		$buff = fread ($file, 104);
		return $buff;
	}
}

function load_gpio_list() {

	$result = "";

	$file = fopen("/proc/v2r_gpio/all","r");

	if(!$file) {
		return ("error open /proc/v2r_gpio/all");
	} else {

		$buff = fread ($file, 104);

		for ($i = 0; $i <= 103; $i++) {
			if ( !($i % 10)) $result .= "<br>";
			$gpio_num = str_pad($i, 3, "0", STR_PAD_LEFT);
			if ($buff[$i] == 1) 
				$valueclass = "gpiohigh";
			else if ($buff[$i] == 0) 
				$valueclass = "gpiolow";
			$result .= '<div id="gpio'.$i.'" gpio="'.$i.'" class="gpiolist">'.$gpio_num.':<span class="'.$valueclass.'" id="gpio'.$i.'value">'.$buff[$i].'</span></div>';
		}

	}
	
	return $result;
}


function read_cons() {


	$file = fopen("/proc/v2r_pins/all","r");

	if(!$file) {
		return;
	} else {

		$buff = fread ($file, 87);
		return $buff;
	}
}


function load_con_list() {

	include '../../parts/connectors.php';

	$result = "";

	$file = fopen("/proc/v2r_pins/all","r");

	if(!$file) {
		return ("error open /proc/v2r_pins/all");
	} else {

		$buff = fread ($file, 87);

		$counter = 0;

		for ($i = 0; $i <= 86; $i++) {

			if ($PINS_ARRAY[$i]['gpio'] <= 0) continue;

			if ( !($counter % 10)) $result .= "<br>";
			$con_num = str_pad($i, 2, "0", STR_PAD_LEFT);
			if ($buff[$i] == 1) 
				$valueclass = "conhigh";
			else if ($buff[$i] == 0) 
				$valueclass = "conlow";
			$result .= '<div id="con'.$i.'" con="'.$i.'" class="conlist">'.$con_num.':<span class="'.$valueclass.'" id="con'.$i.'value">'.$buff[$i].'</span> </div>';

			$counter++;

		}

	}
	
	return $result;
}

?>