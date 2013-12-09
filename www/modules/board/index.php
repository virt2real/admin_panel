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
				<td class='pintitle' id='title{key}_0' row='{key}' col='0'>{val0}</td>
				<td class='pintitle' id='title{key}_1' row='{key}' col='1'>{val1}</td>
				<td width=200 class='nobg'>&nbsp;</td>
				<td class='pintitle' id='title{key}_2' row='{key}' col='2'>{val2}</td>
				<td class='pintitle' id='title{key}_3' row='{key}' col='3'>{val3}</td>
			</tr>";
	$str = str_replace("{key}", $key, $str);
	$str = str_replace("{val0}", $value[0], $str);
	$str = str_replace("{val1}", $value[1], $str);
	$str = str_replace("{val2}", $value[2], $str);
	$str = str_replace("{val3}", $value[3], $str);
	$pintable .= $str;
}

$module_content = str_replace("{pintable}", $pintable, $module_content);

echo $module_content;

?>