<?php

/*****************************************************
* modules/fs/load.php
* fs get partitions info
* (c)virt2real.ru 2015
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');
lang_swapmod('fs');

echo '<pre>' . shell_exec('df -h') . '</pre>';
echo '<br>';
echo '<pre>' . shell_exec('sfdisk -l -s -uM') . '</pre>';

?>
