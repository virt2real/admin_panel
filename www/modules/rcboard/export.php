<?php

/*****************************************************
* modules/rcboard/export.php
* run export procedure
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');

shell_exec("mkdir -p /var/www/temp");
shell_exec("rm -f /var/www/temp/*");
$res = shell_exec("/usr/bin/tar --directory=/opt -czvf /var/www/temp/rcboard.tar.gz ./rcboard");
echo '<pre>' . $res . '</pre>';

?>
