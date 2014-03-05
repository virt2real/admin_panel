<?php

/*****************************************************
* language.php
* main index file
*(c)virt2real.de 2014
* draft, by keios
/*****************************************************/
$filename = dirname(dirname(__FILE__)) . "/loc/common.$set_language.php";
if(file_exists($filename)){
    include $filename;
    $language = array();
    $language = array_merge($language,$lang);
}else{
    echo $filename;
}


function lang_insmod($module){
    // TODO: load module translations into $lang
}

function lang_rmmod($module){
    // TODO: remove module translations from $lang
}

function lang_translate($template){
    global $language;
    foreach ($language as $key => $value){
		$template = str_replace('%'.$key.'%', $value, $template);
	}
	return $template;
}

?>
