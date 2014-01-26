<?php

/*****************************************************
* modules/pwm/index.php
* pwm index file
*(c)virt2real.ru 2014
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

/* load pwm pins list */
include '../../parts/connectors.php';

/* make lists of pins */

$pinlist = array();

for ($i = 1; $i < $TOTAL_PINS; $i++) {
	if ($PINS_ARRAY[$i]['alt'] == "pwm") $pinlist[$PINS_ARRAY[$i]['alt_ch']] .= '<p class="pwmcon"><a href="#" class="pwmpins con'.$i.'" conid="'.$i.'" pwmid="'.$PINS_ARRAY[$i]['alt_ch'].'">CON' . $i .'</a></p>';
}


/* make list of pwms */

$pwmlist = "";
$pwm_tpl = file_get_contents("pwm.tpl");
for ($i = 0; $i < sizeof($pinlist); $i++) {

	$pwm = $pwm_tpl;
	$pwm = str_replace('{num}', $i, $pwm);
	$pwm = str_replace('{pins}', $pinlist[$i], $pwm);
	$pwmlist .= $pwm;

}

/* make list of ppms */

$ppmlist = "";
$ppm_tpl = file_get_contents("ppm.tpl");
for ($i = 0; $i < $TOTAL_PWM; $i++) {

	$ppm = $ppm_tpl;
	$ppm = str_replace('{num}', $i, $ppm);
	$ppm = str_replace('{pins}', $pinlist[$i], $ppm);
	$ppmlist .= $ppm;

}



$module_content = str_replace('{pwmlist}', $pwmlist, $module_content);
$module_content = str_replace('{ppmlist}', $ppmlist, $module_content);

echo $module_content;

?>