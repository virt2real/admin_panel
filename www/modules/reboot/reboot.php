<?php

/*****************************************************
* modules/reboot/reboot.php
* reboot command file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

shell_exec("reboot -f &");

?>