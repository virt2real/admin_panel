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

$uploaddir = '/var/www/temp/';
$uploadfile = $uploaddir.basename($_FILES['myfile']['name']);
move_uploaded_file($_FILES['myfile']['tmp_name'], $uploadfile);

// extract archive
shell_exec("mkdir -p /opt");
shell_exec("rm -rf /opt/rcboard/*");
shell_exec("rmdir /opt/rcboard");
shell_exec("/usr/bin/tar --directory=/opt -zxvf " . $uploadfile);

?>
