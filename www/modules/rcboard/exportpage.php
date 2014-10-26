<?php

/*****************************************************
* modules/rcboard/exportpage.php
* download rcboard archive file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');

header("Content-Disposition: attachment; filename=rcboard.tar.gz");
header("Content-type: application/x-gzip");
readfile ("/var/www/temp/rcboard.tar.gz");

?>
