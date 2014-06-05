<?php

/*****************************************************
* modules/ivideon/loadconfig.php
* load config for Ivideon
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('ivideon');

/* load config */
$config = @file_get_contents('/opt/ivideon/videoserverd/videoserverd.config');
echo $config;

?>