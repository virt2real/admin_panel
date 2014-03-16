<?php

/*****************************************************
* modules/samples_de/simplerun.php
* sample run command file
* (c)virt2real.ru 2013-2014
* draft, by Gol, Realizator, keios
/*****************************************************/


// common include
include('../../parts/global.php');

echo "Skript /var/www/modules/samples/test.sh gestartet!";

echo "<pre>".shell_exec("/var/www/modules/samples/test.sh")."</pre>";

?>
