<?php

/*****************************************************
* modules/samples_ru/run.php
* sample run command file
* (c)virt2real.ru 2013-2014
* draft, by Gol, Realizator
/*****************************************************/

// common include
include('../../parts/global.php');

$script_path = $_POST['path'];

echo "Script $script_path <br>";

echo "<pre>".shell_exec("$script_path")."</pre>";

?>
