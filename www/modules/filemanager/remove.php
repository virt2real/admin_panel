<?php

/*****************************************************
* modules/filemanager/remove.php
* remove file
* (c) virt2real.ru 2015
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');

$filename = urldecode($_POST["parent"].$_POST["dir"]);

shell_exec("rm -rf " . $filename);

?>
