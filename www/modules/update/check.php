<?php

/*****************************************************
* modules/update/check.php
* update check version
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$currentversion = file_get_contents("../../version");
$lastversion = file_get_contents("http://files.virt2real.ru/firmware/virt2real-board/adminkaversion");

$currentversion = preg_replace('%[^0-1.\d]%i', '', $currentversion);
$lastversion = preg_replace('%[^0-1.\d]%i', '', $lastversion);

$state = 0;
if ($lastversion) $state = 1;

$result['state'] = $state;
$result['current'] = $currentversion;
$result['last'] = $lastversion;

echo json_encode($result);

?>