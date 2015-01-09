<?php

/*****************************************************
* modules/usbmediadevices/load.php
* load directory listing
* (c)virt2real.ru 2015
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');

$dirname = $_GET['dir'];
$parent = $_GET['parent'];

date_default_timezone_set("Europe/Moscow");

// load thumbnails list
// megaizvrat but it works fine
global $thumb_list_realfilenames;
global $thumb_list_uppercasefilenames;

GetExistingThumbnailsList($_SERVER["DOCUMENT_ROOT"]."/admin/modules/gphotoview/thumbnails");

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
$content .= '<script>$("a.gallery").fancybox();</script><div id="fmcurrentdir">'.$parent.$dirname.'</div>';

// показываем ссылку "На уровень выше"
$content .= '<p id="moveup" onclick="LoadDir(\'\', \''.makeparent($parent).'\'); return false;"><a href="#" onclick="LoadDir(\'\', \''.makeparent($parent).'\'); return false;">[ '.$language['L_UP'].' ]</a></p>';

$content .= '<table cellspacing=1 cellpadding=2 border=0 id="filemanager">';

$lines = count($ARR);

$dir_list = '';
$file_list = '';
$media_list = '';


for ($i=0; $i<$lines; $i++) {
	$file_name = $ARR[$i]["name"][0];
	$date = date ('d.m.Y H:i', $ARR[$i]["name"][1]);
	$size = $ARR[$i]["name"][2];
	$dir_parent = $ARR[$i]["name"][3];
	if (substr($dir_parent, -1) != "/") $dir_parent .= "/";


	$uppercase_file_name = strtoupper($file_name);


	// search filename in uppercased filenames array
	$key = preg_grep("#".$uppercase_file_name."#", $thumb_list_uppercasefilenames);


	$arr_index = 0;
	if ($key) {

		// now we know array index for this filename
		foreach ($key as $k => $v) $arr_index = $k;

                //$previewtemplate = 'onclick="ShowPreview(\'file'.$i.'\',\'/modules/gphotoview/thumbnails/'.$thumb_list_realfilenames[$arr_index].'\'); return false;"';
                //$previewtemplate = '<a href="#" title="'.$dir_parent.$file_name.'" onclick="ShowPreview(\'file'.$i.'\',\'/modules/gphotoview/thumbnails/'.$thumb_list_realfilenames[$arr_index].'\'); return false;">'.$file_name.'</a>';

		$real_img_path = str_replace($_SERVER["DOCUMENT_ROOT"], "", $dir_parent.$file_name);
		$img_path = '/modules/gphotoview/thumbnails/'.$thumb_list_realfilenames[$arr_index];
		$filesize = round($size / 1048576, 3);
		$media_list .= '
			<div style="width:170px; height:200px; text-align: center; margin:10px; float: left;">
				<a href="'.$real_img_path.'" class="gallery" rel="fotos"><img src="'.$img_path.'" width="160"></a>
				<p style="text-align: left; color: #7c7c7c; margin: 0px;">'.$file_name.'</p>
				<p style="text-align: left; color: #7c7c7c; margin: 0px;">'.$filesize.' '.$language['M_MBYTE'].'</p>
			</div>
		';

	} else {
		//$previewtemplate = $file_name;
		$file_list .= '<tr><td class="col1"><a href="#" title="'.$dir_parent.$file_name.'" '.$previewtemplate.'>'.$file_name.'</a>&nbsp;<img src="" id="file'.$i.'" class="previewfiles"></td><td class="col2">'.$date.'&nbsp;</td><td class="col3">'.$size .'&nbsp;</td></tr>';
	}


}

$lines = count ($ARR2);

for ($i=0; $i<$lines; $i++) {
	$file_name = $ARR2[$i]["name"][0];
	$dir_parent = $ARR2[$i]["name"][1];
	if (substr($dir_parent, -1) != "/") $dir_parent .= "/";
	$dir_list .= '<tr><td class="col1"><a href="#" style="color:#0380ea;" title="'.$dir_parent.$file_name.'" onclick="LoadDir(\''.$file_name.'\', \''.$dir_parent.'\'); return false;">[ '.$file_name.' ]</a>&nbsp;</td><td class="col2">&nbsp;</td><td class="col3">&nbsp;</td></tr>';
}

$content .= $media_list . $dir_list . $file_list;

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

function GetExistingThumbnailsList($path){

	global $thumb_list_realfilenames;
	global $thumb_list_uppercasefilenames;

	$result = "";
	$dir = opendir($path);
	while (($file = readdir($dir)) !== false) {
		if ($file == "." || $file == "..") continue;
		$thumb_list_realfilenames [] = $file;
		$thumb_list_uppercasefilenames [] = strtoupper($file);
	}


}

?>
