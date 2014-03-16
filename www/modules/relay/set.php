<?php

/*****************************************************
* modules/relay/set.php
* set relay state
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
include('../../parts/language.php');
lang_swapmod('relay');

$relay = intval($_POST["relay"]);
$state = intval($_POST["state"]);

// make state value

if ($state == 1)
	$real_state = 0;
else
if ($state == 2)
	$real_state = 1;
else
	die($language['M_WRONG_STATE']);


switch ($relay) {
	case 1:	$con = 34; break;
	case 2:	$con = 35; break;
	case 3:	$con = 33; break;
	case 4:	$con = 32; break;
	default: die($language['M_WRONG_RELAY']);
}

$cmd = "set con $con output $real_state";
echo $cmd;
file_put_contents("/dev/v2r_pins", $cmd);


?>
