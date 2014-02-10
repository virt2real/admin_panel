<?php

/*****************************************************
* modules/nand/check.php
* check nand params
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$content = '<pre>'.shell_exec ("mtdinfo").'</pre>';
$content .= '<p></p>';
$content .= '<pre>'.shell_exec ("ubinfo").'</pre>';
$content .= '<p></p>';
$content .= '<pre>'.file_get_contents("/proc/mtd").'</pre>';

echo $content;

?>