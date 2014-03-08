<?php

/*****************************************************
* login.php
* auth login file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common global include
require_once('parts/global.php');

// init translation
require_once('parts/language.php');
if ($_GET['lang']) {
    lang_setlang($_GET['lang']);
}else{
    lang_setlang('ru');
}

// load main template
$template = file_get_contents('templates/login.tpl');

// global replaces
$template = GlobalReplace($template);

// make global replaces
$template = str_replace('{menu}', '', $template);
$template = str_replace('{content}', '', $template);
$template = str_replace('{onload}', '', $template);

// translate content
$template = lang_translate($template);

// show content
echo $template;

?>
