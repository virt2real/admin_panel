<?php

/*****************************************************
* modules/filemanager/edit.php
* edit file
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

$dirname = $_GET['dir'];
$parent = $_GET['parent'];

// Открываем требуемый файл
$file = file_get_contents($parent.$dirname);

// шаблон редактирования
$content = '
<div id="filename">'.$parent.$dirname.'</div>
<pre><textarea wrap="off" id="filecontent" onkeydown="MakeSaveButtonActive();">'.$file.'</textarea></pre>
';

echo $content;


?>