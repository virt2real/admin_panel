<?php

/*****************************************************
* modules/filemanager/save.php
* save changed files
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// check session
session_start();
if ($_SERVER["PHP_SELF"]!=="/login.php")
if (!isset($_SESSION["login"]) || $_SESSION["login"]!==1) {
	header("Location: login.php");
	die;
}

$filename = $_POST['file'];
$text = $_POST['text'];

if (is_writable($filename)) {
    if (!$handle = fopen($filename, 'w')) {
		die("can not access file $filename");
	}

   	if (fwrite($handle, $text) === FALSE) {
       	die("can not write $filename");
    }

   	echo "successfully saved";

    fclose($handle);

} else {
	echo "no access to $filename";
}

?>