<?php

/*****************************************************
* modules/filemanager/load.php
* load directory listing
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');

$dirname = $_GET['dir'];
$parent = $_GET['parent'];

date_default_timezone_set("Europe/Moscow");

// Открываем требуемый каталог
$dir = opendir($parent.$dirname);

// Читаем в цикле директорию
while (($file = readdir($dir)) !== false) {

	// Если файл обрабатываем его содержимое
	if($file != "." && $file != "..") {

		// Это каталог
		if(is_dir($parent.$dirname.'/'.$file)) {

			$ARR2[] = array ("price" => $file, "name" => array ($file, $parent.$dirname));

		} else {

			if (is_link($parent.$dirname.'/'.$file)) {
				$linkchar = "@ ";
				$linkpath = ' &rarr; '.readlink($parent.$dirname.'/'.$file);
			} else {
				$linkchar = "";
				$linkpath = "";
			}

			$filectime = filemtime($parent.$dirname.'/'.$file);
			$filesize = filesize($parent.$dirname.'/'.$file);
			$ARR[] = array ("price" => $file, "name" => array ($linkchar.$file.$linkpath, $filectime, $filesize, $parent.$dirname));

		}
	}
}

// чистим кэш
clearstatcache ();

// Закрываем директорию
closedir($dir);

// Сортируем всё
@usort ($ARR, "_PriceCmp");
@usort ($ARR2, "_PriceCmp");


$content = '';

// показываем текущий каталог
$content .= '<div id="fmcurrentdir">'.$parent.$dirname.'</div>';

// показываем ссылку "На уровень выше"
$content .= '<p id="moveup" onclick="LoadDir(\'\', \''.makeparent($parent).'\'); return false;"><a href="#" onclick="LoadDir(\'\', \''.makeparent($parent).'\'); return false;">[ '.$language['L_UP'].' ]</a></p>';

$content .= '<table cellspacing=1 cellpadding=2 border=0 id="filemanager">';

$lines = count($ARR);

$dir_list = '';
$file_list = '';

for ($i=0; $i<$lines; $i++) {
	$file_name = $ARR[$i]["name"][0];
	$date = date ('d.m.Y H:i', $ARR[$i]["name"][1]);
	$size = $ARR[$i]["name"][2];
	$dir_parent = $ARR[$i]["name"][3];
	if (substr($dir_parent, -1) != "/") $dir_parent .= "/";
	$file_list .= '<tr><td class="col1"><a href="#" title="'.$dir_parent.$file_name.'" onclick="EditFile(\''.$file_name.'\', \''.$dir_parent.'\'); return false;">'.$file_name.'</a>&nbsp;</td><td class="col2">'.$date.'&nbsp;</td><td class="col3">'.$size .'&nbsp;</td><td class="col4"><a href="#" onclick="RmDir(\''.$file_name.'\', \''.$dir_parent.'\'); return false;">[x]</a></td></tr>';
}

$lines = count ($ARR2);

for ($i=0; $i<$lines; $i++) {
	$file_name = $ARR2[$i]["name"][0];
	$dir_parent = $ARR2[$i]["name"][1];
	if (substr($dir_parent, -1) != "/") $dir_parent .= "/";
	$dir_list .= '<tr><td class="col1" onclick="LoadDir(\''.$file_name.'\', \''.$dir_parent.'\'); return false;"><a href="#" style="color:#0380ea;" title="'.$dir_parent.$file_name.'" onclick="LoadDir(\''.$file_name.'\', \''.$dir_parent.'\'); return false;">[ '.$file_name.' ]</a>&nbsp;</td><td class="col2">&nbsp;</td><td class="col3">&nbsp;</td><td class="col4"><a href="#" onclick="RmDir(\''.$file_name.'\', \''.$dir_parent.'\'); return false;">[x]</a></td></tr>';
}

$content .= $dir_list . $file_list;

$content .= '</table>';

echo $content;


function _PriceCmp ( $a, $b ){

	if ( $a["price"] == $b["price"] ) return 0;
	if ( $a["price"] < $b["price"] ) return -1; return 1;

}

function makeparent($str){

	$res = '';
	$tmp = explode('/',$str);
 	$n = sizeof($tmp) - 1;
 	if ($n==1) return '/';
  	for ($i = 1; $i < $n; $i++) $res .= '/'.$tmp[$i];

  	return $res;

}

?>
