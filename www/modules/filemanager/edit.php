<?php

/*****************************************************
* modules/filemanager/edit.php
* edit file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$dirname = $_GET['dir'];
$parent = $_GET['parent'];

// Открываем требуемый файл
$file = file_get_contents($parent.$dirname);
$file = htmlspecialchars($file);

// шаблон редактирования
$content = '
<div id="filename">'.$parent.$dirname.'</div>
<pre><textarea id="filecontent" onkeydown="MakeSaveButtonActive();">'.$file.'</textarea></pre>
<p style="float:right;"><a href="#" onclick="noWrap($(\'#filecontent\')); return false;">переносы строк</a></p>
';

echo $content;


?>