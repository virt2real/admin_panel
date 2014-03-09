<?php

/*****************************************************
* index.php
* main index file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

error_reporting(E_ALL);
ini_set('display_errors', 1);

// turn off errors
//error_reporting(0);

// init translation
require_once('parts/language.php');

// common global include
require_once('parts/global.php');

// load main template
$template = file_get_contents('templates/index.tpl');

// global replaces
$template = GlobalReplace($template);

// check available modules
$mod_dirs = scandir("modules");

foreach ($mod_dirs as $key=>$value){
	if ($value == '.' || $value == '..') continue;

	// clear module params
	$module_params['name'] = false;

	if (file_exists("modules/$value/description.php")) {
		require("modules/$value/description.php");
	}

	// check module loading
	if (!$module_params['name']) continue;

	// check active module
	if (isset($_GET[$module_params['name']])) {
		$onload = $module_params['name'];
	}

	$module_list[] = $module_params;

}

// modules sorting
usort($module_list, "cmp");

// make menu modules list
$menu = "";

foreach ($module_list as $key=>$value) {
	$link = $value['name'];
	$menu[$value['menu_part']] .= '<p><a href="#" onclick=\'LoadContent("'.$link.'"); return false;\'>' . lang_getmoddesc($value['name']) . '</a></p>';
}

// load menu description
require("parts/menu.php");

foreach ($main_menu as $key => $value) {
	$menulist .= '<h3><a href="#">' . $value . '</a></h3><div>'.$menu[$key].'<br></div>';
}


// if we here, but modules not loaded - it mean that main module is active
if (!$onload) {
		$onload = 'main';
}

// make global replaces
$template = str_replace('{menu}', $menulist, $template);
$template = str_replace('{content}', $module_content, $template);
$template = str_replace('{onload}', $onload, $template);

// translate content
$template = lang_translate($template);

// show content
echo $template;

//unset($_SESSION["login"]);

// local sort function
function cmp($a, $b)  {
    if ($a['position'] == $b['position']) {
   	    return 0;
    }
   	return ($a['position'] < $b['position']) ? -1 : 1;
}

?>
