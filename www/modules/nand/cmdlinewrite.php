<?php

/*****************************************************
* modules/nand/cmdwrite.php
* cmdline write to nand
* (c)virt2real.ru 2015
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

if (!isset($_POST['text'])) die;
$text = $_POST['text'];
if ($text == "") die;

echo '<pre>'.shell_exec('fw_setenv bootargs ' . $text).'</pre>';

?>