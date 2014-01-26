<?php

/*****************************************************
* modules/motorshield/setservolimits.php
* set servo min and max timings for Motorshield
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_POST['action']) || !isset($_POST['value'])) die();

switch (intval($_POST['action'])) {
	case 1:         
		/* save servo min position to module config */
		file_put_contents("servomin", intval($_POST['value']));
		break;
	case 2:
		/* save servo max position to module config */
		file_put_contents("servomax", intval($_POST['value']));
		break;
}


?>