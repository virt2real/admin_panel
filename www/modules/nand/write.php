<?php

/*****************************************************
* modules/nand/write.php
* nand write command file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$fs = 0;

if (isset($_GET['fs'])) $fs = intval($_GET['fs']);

switch ($fs) {
	case 0 :
		$fstype = "ubi";
		break;
	case 1 :
		$fstype = "jffs";
		break;
	default:
		die ("wrong fs type");
		break;
}

echo '<pre>'.shell_exec("cd /etc/virt2real/nand_flasher && ./write_nand.sh $fstype").'</pre>';

?>