<?php

/*****************************************************
* modules/adc/get.php
* ADC get command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_GET["vref"]))  die("wrong vref");

$vref = $_GET["vref"];

include "common.php";
$adc_list = read_adc($vref);

echo $adc_list;

?>
