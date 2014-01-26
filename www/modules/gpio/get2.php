<?php

/*****************************************************
* modules/gpio/get2.php
* /dev/v2r_gpio get command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

include('common.php');

echo read_gpios();

?>