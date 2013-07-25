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

foreach ($pins as $key => $value) {
	$pintable .= "<tr><td>$value[0]</td><td>$value[1]</td><td width=200>&nbsp;</td><td>$value[2]</td><td>$value[3]</td></tr>";
}

$module_content = str_replace("{pintable}", $pintable, $module_content);

echo $module_content;

?>