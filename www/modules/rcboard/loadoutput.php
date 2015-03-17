<?php

/*****************************************************
* modules/rcboard/loadoutput.php
* load rcboard output from /tmp/rcboard.out
* (c)virt2real.ru 2015
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$content = @file_get_contents("/tmp/rcboard.out");
echo $content

?>