<?php

/*****************************************************
* modules/3g/check.php
* check 3G connection status
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$pppd_state_string = @file_get_contents("/tmp/pppstate");
$pppd_state_string = str_replace("\n", "", $pppd_state_string);

$pppd_state_array = explode(" ", $pppd_state_string);

echo json_encode($pppd_state_array);

?>