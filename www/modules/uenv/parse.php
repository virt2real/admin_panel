<?php

function ParseParams($cmdline, $template){

	$replaces = '';

	$cmdline = str_replace("\n","",$cmdline);
	$cmdline = str_replace("\r","",$cmdline);
	$arr = explode(' ', $cmdline);

	$params = '';

	foreach ($arr as $key => $value){

		if (!$value) continue;
		
		$element = explode("=",$value);
		$option1 = '';
		$option2 = '';
		$option3 = '';
		$option4 = '';
		$option5 = '';
		$option6 = '';
		switch ($element[0]) {

			case "wifi":
				if ($element[1] == "on") $option1 = "checked"; else $option2 = "checked"; 
				$template = str_replace('{wifiselected1}', $option1, $template);
				$template = str_replace('{wifiselected2}', $option2, $template);
			break;
			case "usbwifi":
				if ($element[1] == "on") $option1 = "checked"; else $option2 = "checked"; 
				$template = str_replace('{usbwifiselected1}', $option1, $template);
				$template = str_replace('{usbwifiselected2}', $option2, $template);
			break;
			case "ap":
				if ($element[1] == "on") $option1 = "checked"; else $option2 = "checked";
				$template = str_replace('{apselected1}', $option1, $template);
				$template = str_replace('{apselected2}', $option2, $template);
			break;
			case "wifi_ssid": 
				$element[1] = str_replace(" ", "", $element[1]);
				$template = str_replace('{wifi_ssid}', $element[1], $template);
			break;
			case "wifi_pass": 
				$element[1] = str_replace(" ", "", $element[1]);
				$template = str_replace('{wifi_pass}', $element[1], $template);
			break;
			case "lan0":
				if ($element[1] == "on") $option1 = "checked"; else $option2 = "checked";
				$template = str_replace('{lanselected1}', $option1, $template);
				$template = str_replace('{lanselected2}', $option2, $template);
			break;
			case "ks8851.hwaddr": 
				$tmp = explode(',',$element[1]);	
				$template = str_replace('{lan0mac}', $tmp[0], $template);
			break;
			case "lan1":
				if ($element[1] == "on") $option1 = "checked"; else $option2 = "checked";
				$template = str_replace('{lan1selected1}', $option1, $template);
				$template = str_replace('{lan1selected2}', $option2, $template);
			break;
			case "lan1hwaddr": 
				$tmp = explode(',',$element[1]);	
				$template = str_replace('{lan1mac}', $tmp[0], $template);
			break;

			case "pwrled":
				if ($element[1] == "on") $option1 = "checked"; else $option2 = "checked";
				$template = str_replace('{blueselected1}', $option1, $template);
				$template = str_replace('{blueselected2}', $option2, $template);
			break;
			case "greenled":
				switch ($element[1]){
					case "none" : 		$option1 = "checked"; break;
					case "heartbeat" : 	$option2 = "checked"; break;
					case "mmc0" : 		$option3 = "checked"; break;
					case "mmc1" : 		$option4 = "checked"; break;
					case "cpu0" : 		$option5 = "checked"; break;
				}
				$template = str_replace('{greenselected1}', $option1, $template);
				$template = str_replace('{greenselected2}', $option2, $template);
				$template = str_replace('{greenselected3}', $option3, $template);
				$template = str_replace('{greenselected4}', $option4, $template);
				$template = str_replace('{greenselected5}', $option5, $template);
			break;
			case "redled":
				switch ($element[1]){
					case "none" : 		$option1 = "checked"; break;
					case "heartbeat" : 	$option2 = "checked"; break;
					case "mmc0" : 		$option3 = "checked"; break;
					case "mmc1" : 		$option4 = "checked"; break;
					case "cpu0" : 		$option5 = "checked"; break;
				}
				$template = str_replace('{redselected1}', $option1, $template);
				$template = str_replace('{redselected2}', $option2, $template);
				$template = str_replace('{redselected3}', $option3, $template);
				$template = str_replace('{redselected4}', $option4, $template);
				$template = str_replace('{redselected5}', $option5, $template);
			break;
			case "camera": 
				if ($element[1] == "ov2643") $option2 = "checked"; 
				else
				if ($element[1] == "ov5642") $option3 = "checked"; 
				else
				if ($element[1] == "ov5640") $option4 = "checked"; 
				else $option1 = "checked";

				$template = str_replace('{cameraselected1}', $option1, $template);
				$template = str_replace('{cameraselected2}', $option2, $template);
				$template = str_replace('{cameraselected3}', $option3, $template);
				$template = str_replace('{cameraselected4}', $option4, $template);
			break;
			case "spi0": 
				if ($element[1] == "on") $option1 = "checked"; else $option2 = "checked";

				$template = str_replace('{spi0selected1}', $option1, $template);
				$template = str_replace('{spi0selected2}', $option2, $template);
			break;
			case "uart1": 
				if ($element[1] == "on") $option1 = "checked"; else $option2 = "checked";

				$template = str_replace('{uart1selected1}', $option1, $template);
				$template = str_replace('{uart1selected2}', $option2, $template);
			break;
			case "console": 
				$tmp = explode(',',$element[1]);	
				$template = str_replace('{conval1}', $tmp[0], $template);
				$template = str_replace('{conval2}', $tmp[1], $template);
			break;
			case "davinci_wdt.heartbeat": 
				$tmp = explode(',',$element[1]);	
				$template = str_replace('{wdtval1}', $tmp[0], $template);
			break;
			case "dm365_ccdc.top_offset": 
				$tmp = explode(',',$element[1]);	
				$template = str_replace('{hdmi_voffset}', $tmp[0], $template);
			break;
			case "ghid": 
				$tmp = explode(',',$element[1]);	
				$template = str_replace('{ghidval}', $tmp[0], $template);
			break;
			case "quiet":
				$option2 = "checked";

				$template = str_replace('{quietselected1}', $option1, $template);
				$template = str_replace('{quietselected2}', $option2, $template);
			break;
			case "1wire": 
				$template = str_replace('{w1val1}', $element[1], $template);
			break;
			case "1wirepullup": 
				$template = str_replace('{w1val2}', $element[1], $template);
			break;
			case "coherent_pool": 
				$template = str_replace('{coherent_pool}', $element[1], $template);
			break;
			case "davinci_enc_mngr.ch0_output": 
				if (strtoupper($element[1]) == "COMPOSITE") $option1 = "checked";
				if (strtoupper($element[1]) == "LCD") $option2 = "checked";

				$template = str_replace('{ch0val1}', $option1, $template);
				$template = str_replace('{ch0val2}', $option2, $template);
			break;
			case "davinci_enc_mngr.ch0_mode": 
				if (strtoupper($element[1]) == "PAL") $option1 = "checked";
				if (strtoupper($element[1]) == "NTSC") $option2 = "checked";

				$template = str_replace('{btn11val1}', $option1, $template);
				$template = str_replace('{btn11val2}', $option2, $template);
			break;
			case "video":
				$str = '';
				for ($i=1;$i < sizeof($element); $i++) {
					$str .= $element[$i];
					if ($i < sizeof($element)-1) $str .= '=';
				}
				$template = str_replace('{osdval}', $str, $template);
			break;
			case "vpfe_capture.interface": 
				$template = str_replace('{vpfeval}', $element[1], $template);
			break;
			case "dm365_imp.oper_mode": 
				$template = str_replace('{operval}', $element[1], $template);
			break;
			case "davinci_display.cont2_bufsize": 
				$template = str_replace('{bufval1}', $element[1], $template);
			break;
			case "vpfe_capture.cont_bufoffset": 
				$template = str_replace('{bufval2}', $element[1], $template);
			break;
			case "vpfe_capture.cont_bufsize": 
				$template = str_replace('{bufval3}', $element[1], $template);
			break;
			case "mem": 
				$template = str_replace('{memval}', $element[1], $template);
			break;
			case "root": 
				$template = str_replace('{rootval}', $element[1], $template);
			break;
			case "rootdelay": 
				$template = str_replace('{delayval}', $element[1], $template);
			break;
			case "rootfstype": 
				$template = str_replace('{fsval}', $element[1], $template);
			break;

		}

	}

	/* clear unsetted fields */
	$template = str_replace('{hdmi_voffset}', "", $template);
	$template = str_replace('{ghidval}', "", $template);
	$template = str_replace('{lan0mac}', "", $template);
	$template = str_replace('{lan1mac}', "", $template);
	$template = str_replace('{wifi_ssid}', "", $template);
	$template = str_replace('{wifi_pass}', "", $template);

	return $template.$params;

}

?>