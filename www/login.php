<?php

/*****************************************************
* login.php
* auth login file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common global include
require_once('parts/global.php');

// load main template
$template = file_get_contents('templates/login.tpl');

// global replaces
$template = GlobalReplace($template);

// make global replaces
$template = str_replace('{menu}', '', $template);
$template = str_replace('{content}', '', $template);
$template = str_replace('{onload}', '', $template);

// show content
echo $template;

?>