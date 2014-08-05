<?php

/*****************************************************
* modules/kernels/index.php
* kernel list index file
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// check module name
require_once('description.php');

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');

// load module template
$module_content = file_get_contents("template.tpl");
$module_content = str_replace('{module_name}', $module_params['name'], $module_content);
$module_content = str_replace('{module_title}', $module_params['title'], $module_content);

// make global replaces
$module_content = GlobalReplace($module_content);

// translate content
lang_swapmod($module_params['name']);
$module_content = lang_translate($module_content);

/***************** module specific part **************/

/* check boot type */

if ($globalVars['intboottype'] == 2) {
	$error_content = file_get_contents("../../templates/error.tpl");
	$error_content = str_replace("{text}", $language['M_ERR_NO_EDIT_UENV'], $error_content);
	die ($error_content);
}

shell_exec("mount /dev/mmcblk0p1 /mnt"); // mount /boot partition into /mnt

// читаем список описаний ядер
$kerneldescrfile = file('/mnt/kernels.list');
foreach ($kerneldescrfile as $k => $v) {
	$tmp = explode("\t", $v); // split parts via tabs
	$kerneldescr[$tmp[0]]['descr'] = $tmp[1]; // kernel file description
	if (strpos($tmp[2], "*") !== FALSE) $kerneldescr[$tmp[0]]['active'] = true; // active kernel or not
}

// Открываем каталог с ядрами
$dir = opendir('/mnt');

$kernelslist = '';

// Читаем содержимое каталога с ядрами
while (($file = readdir($dir)) !== false) {

	// Если файл обрабатываем его содержимое
	if (strpos($file, 'uImage.') === FALSE) continue;

	$active = $kerneldescr[$file]['active'] ? 'checked' : '';

	$kernelslist .= '<input type="radio" name="kernel" id="'.$file.'" '.$active.'>' . '<label for="'.$file.'">' . $file . '</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' . '<span class="graytext">'. $kerneldescr[$file]['descr'] . '</span><br>';
}

closedir($dir);

shell_exec("umount /mnt"); // umount /boot partition from /mnt

$module_content = str_replace('{kernelslist}', $kernelslist, $module_content);

// translate content
$module_content = lang_translate($module_content);

echo $module_content;

?>
