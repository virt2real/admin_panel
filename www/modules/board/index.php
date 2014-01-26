<?php

/*****************************************************
* modules/board/index.php
* board module index file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// check module name
require_once('description.php');

// common include
include('../../parts/global.php');

// load module template
$module_content = file_get_contents("template.tpl");
$module_content = str_replace('{module_name}', $module_params['name'], $module_content);
$module_content = str_replace('{module_title}', $module_params['title'], $module_content);

// make global replaces
$module_content = GlobalReplace($module_content);

/***************** module specific part **************/

require_once('pins.php');

$pins = GetPinArray();

$pintable = "";

foreach ($pins as $key => $value) {
	$str = "<tr>
				<td class='pintitle {textclass0}' id='title{key}_0' row='{key}' col='0' con='{num0}'>{con_descr0}</td>
				<td class='pintitle {textclass1}' id='title{key}_1' row='{key}' col='1' con='{num1}'>{con_descr1}</td>
				<td width=100 class='nobg'>&nbsp;</td>
				<td class='pintitle {textclass2}' id='title{key}_2' row='{key}' col='2' con='{num2}'>{con_descr2}</td>
				<td class='pintitle {textclass3}' id='title{key}_3' row='{key}' col='3' con='{num3}'>{con_descr3}</td>
			</tr>";

	$str = str_replace("{key}", $key, $str);

	$str = str_replace("{num0}", $value[0]['id'], $str);
	$str = str_replace("{num1}", $value[1]['id'], $str);
	$str = str_replace("{num2}", $value[2]['id'], $str);
	$str = str_replace("{num3}", $value[3]['id'], $str);

	if ($value[0]['gpio'] > 0) $str = str_replace("{textclass0}", 'lighttext', $str);
	if ($value[1]['gpio'] > 0) $str = str_replace("{textclass1}", 'lighttext', $str);
	if ($value[2]['gpio'] > 0) $str = str_replace("{textclass2}", 'lighttext', $str);
	if ($value[3]['gpio'] > 0) $str = str_replace("{textclass3}", 'lighttext', $str);

	if ($value[0]['alt']) $alt0 = ' / '.$value[0]['alt'].$value[0]['alt_ch']; else $alt0 = '';
	if ($value[1]['alt']) $alt1 = ' / '.$value[1]['alt'].$value[1]['alt_ch']; else $alt1 = '';
	if ($value[2]['alt']) $alt2 = ' / '.$value[2]['alt'].$value[2]['alt_ch']; else $alt2 = '';
	if ($value[3]['alt']) $alt3 = ' / '.$value[3]['alt'].$value[3]['alt_ch']; else $alt3 = '';

	if ($value[0]['alt2']) $alt02 = ' / '.$value[0]['alt2'].$value[0]['alt2_ch']; else $alt02 = '';
	if ($value[1]['alt2']) $alt12 = ' / '.$value[1]['alt2'].$value[1]['alt2_ch']; else $alt12 = '';
	if ($value[2]['alt2']) $alt22 = ' / '.$value[2]['alt2'].$value[2]['alt2_ch']; else $alt22 = '';
	if ($value[3]['alt2']) $alt32 = ' / '.$value[3]['alt2'].$value[3]['alt2_ch']; else $alt32 = '';

	if ($value[0]['name']) $con_descr0 = $value[0]['id'] . '. ' . $value[0]['name'] . $alt0 . $alt02; else $con_descr0 = "";
	if ($value[1]['name']) $con_descr1 = $value[1]['id'] . '. ' . $value[1]['name'] . $alt1 . $alt12; else $con_descr1 = "";
	if ($value[2]['name']) $con_descr2 = $value[2]['id'] . '. ' . $value[2]['name'] . $alt2 . $alt22; else $con_descr2 = "";
	if ($value[3]['name']) $con_descr3 = $value[3]['id'] . '. ' . $value[3]['name'] . $alt3 . $alt32; else $con_descr3 = "";

	$str = str_replace("{con_descr0}", $con_descr0, $str);
	$str = str_replace("{con_descr1}", $con_descr1, $str);
	$str = str_replace("{con_descr2}", $con_descr2, $str);
	$str = str_replace("{con_descr3}", $con_descr3, $str);

	$pintable .= $str;
}

$module_content = str_replace("{pintable}", $pintable, $module_content);


/* read leds state */
$blueled = @file_get_contents("/proc/v2r_gpio/pwctr3");
if ($blueled[0] == "1") $blue_active = "active"; else $blue_active = "";
$module_content = str_replace("{led0active}", $blue_active, $module_content);

$redled = @file_get_contents("/proc/v2r_gpio/74");
if ($redled[0] == "1") $red_active = "active"; else $red_active = "";
$module_content = str_replace("{led1active}", $red_active, $module_content);

$greenled = @file_get_contents("/proc/v2r_gpio/73");
if ($greenled[0] == "1") $green_active = "active"; else $green_active = "";
$module_content = str_replace("{led2active}", $green_active, $module_content);

echo $module_content;

?>