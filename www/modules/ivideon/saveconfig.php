<?php

/*****************************************************
* modules/ivideon/saveconfig.php
* save config for Ivideon
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('ivideon');

if (!isset($_POST['text']))
	die("empty text");

/* save config */
$config = @file_put_contents('/opt/ivideon/videoserverd/videoserverd.config', $_POST['text']);

?>