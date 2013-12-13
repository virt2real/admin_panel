<?php

/*****************************************************
* modules/update/update.php
* run update
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$type = $_GET["type"];

$retval = 0;
@system("./update.sh " . $_SERVER['DOCUMENT_ROOT'] . " " . $type, $retval);
echo $retval;

?>