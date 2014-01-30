<?php

/*****************************************************
* modules/samples/simplerun.php
* sample run command file
* (c)virt2real.ru 2013-2014
* draft, by Gol, Realizator
/*****************************************************/


// common include
include('../../parts/global.php');

echo "Script /var/www/modules/samples/test.sh started!";

echo "<pre>".shell_exec("/var/www/modules/samples/test.sh")."</pre>";

?>