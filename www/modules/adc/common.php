<?php


function read_adc($vref) {

	$max_raw = 1 << 10;

	$filename = "/dev/v2r_adc";
	$handle = fopen($filename, "r");

	$contents = fread($handle, 12);

	for ($i = 0; $i < 6; $i++) {
        	$value = ord($contents[2 * $i]) + ord($contents[(2 * $i) + 1]) * 256;
	        $volts = $value * $vref / $max_raw;
		$voltage = round($volts, 3);
		$int = floor($volts);
		$mil = (round($volts, 3) - $int) * 1000;
		$result[$i]['volt'] = str_pad($int, 2, "0", STR_PAD_LEFT) . '.' . str_pad($mil, 3, "0", STR_PAD_LEFT) . ' V';
		$result[$i]['val'] = $value;
	}

	fclose($handle);

	return json_encode($result);
}


function load_adc_list($vref) {

	$result = "";
	$max_raw = 1 << 10;

	$filename = "/dev/v2r_adc";
	$handle = fopen($filename, "r");

	$contents = fread($handle, 12);

	for ($i = 0; $i < 6; $i++) {
        	$value = ord($contents[2 * $i]) + ord($contents[(2 * $i) + 1]) * 256;
	        $volts = $value * $vref / $max_raw;
		$voltage = round($volts, 3);
		$int = floor($volts);
		$mil = (round($volts, 3) - $int) * 1000;
		$voltage_str = str_pad($int, 2, "0", STR_PAD_LEFT) . '.' . str_pad($mil, 3, "0", STR_PAD_LEFT) . ' V';
		$result .= '<div id="adc'.$i.'" class="adclist">ADC'.$i.': <span id="adc'.$i.'voltage" class="adcvoltages">'.$voltage_str.'</span> <span id="adc'.$i.'value" class="adcvalues">'.$value.'</span></div>';
	}

	fclose($handle);
	
	return $result;
}

?>