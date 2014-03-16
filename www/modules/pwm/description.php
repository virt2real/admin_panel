<?php

/*****************************************************
* modules/pwm/description.php
* module description file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

$module_params['name'] = 'pwm';
$module_params['title'] = '%M_DESC%';
$module_params['menu_part'] = 3;
$module_params['position'] = 4;
$module_params['depend'] = array("/dev/v2r_pins", "/proc/v2r_pins/pwm0", "/proc/v2r_pins/pwm1", "/proc/v2r_pins/pwm2", "/proc/v2r_pins/pwm3");
$module_params['depend_descr'] = array("virt2real Pins driver");
?>
