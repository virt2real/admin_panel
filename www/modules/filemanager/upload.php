<?php

/*****************************************************
* modules/filemanager/upload.php
* run export procedure
* (c)virt2real.ru 2015
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');

//echo $_POST["parent"];
//echo $_POST["dir"];

$uploaddir = $_POST["parent"].$_POST["dir"];
$uploadfile = $uploaddir.'/'.basename($_FILES['myfile']['name']);
move_uploaded_file($_FILES['myfile']['tmp_name'], $uploadfile);

?>
