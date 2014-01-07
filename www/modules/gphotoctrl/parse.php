#!/usr/bin/php
<?php

$rawinput = shell_exec("gphoto2 --list-all-config");

// add fake string
$rawinput .= "/end";

$arr = explode("\n", $rawinput);

$result = null;

$element = null;

$choice_counter = 0;


foreach($arr as $key => $val) {

	if (!$val) continue;

	// if string starts with "/" - it's a setting name
	if (strpos($val, "/") === 0) {	

		if ($element)  {
			//echo "\n\n".json_encode($element) . "\n\n";
			//echo "element ".$current_setting_name." ended\n";
			//$element = null;
		}

		$current_setting_name = $val;
		$choice_counter = 0;

		$element[$current_setting_name]["name"] = $current_setting_name;
		//echo "setting name " . $element[$current_setting_name]["name"] . "\n";
	}

	if (strpos($val, "Label:") === 0) {	
		$element[$current_setting_name]["label"] = str_replace("Label: ", "", $val);
		//echo "setting name " . $current_setting_name ." label: " . $element[$current_setting_name]["label"] ."\n";
	}

	if (strpos($val, "Type:") === 0) {	
		$element[$current_setting_name]["type"] = str_replace("Type: ", "", $val);
		//echo "setting name " . $current_setting_name ." type: " . $element[$current_setting_name]["type"] ."\n";
	}

	if (strpos($val, "Current:") === 0) {	
		$element[$current_setting_name]["current"] = str_replace("Current: ", "", $val);
		//echo "setting name " . $current_setting_name ." current: " . $element[$current_setting_name]["current"] ."\n";
	}

	if (strpos($val, "Printable:") === 0) {	
		$element[$current_setting_name]["printable"] = str_replace("Printable: ", "", $val);
		//echo "setting name " . $current_setting_name ." printable: " . $element[$current_setting_name]["printable"] ."\n";
	}

	if (strpos($val, "Choice:") === 0) {	
		//$element[$current_setting_name]["choice"][$choice_counter] = str_replace("Choice: " . $choice_counter . " ", "", $val);
		$element[$current_setting_name]["choice"] .= str_replace("Choice: " . $choice_counter . " ", "", $val) . ';';
		//echo "setting name " . $current_setting_name ." choice ".$choice_counter.": " . $element[$current_setting_name]["choice"][$choice_counter] ."\n";
		$choice_counter++;
	}


}

echo json_encode($element);

?>
