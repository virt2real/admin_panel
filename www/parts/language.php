<?php

/*****************************************************
* language.php
* translation handling file
*(c)virt2real.de 2014
* draft, by keios
/*****************************************************/

lang_setlang(lang_readcookie());

function lang_getmoddesc($module){
    // get module description from translation file
    $set_language = lang_readcookie();
    $fname = dirname(dirname(__FILE__)) . "/modules/$module/loc/module.$set_language.php";
    //fallback to russian
    file_exists($fname) ? : $fname = dirname(dirname(__FILE__)) . "/modules/$module/loc/module.ru.php";
    if (file_exists($fname)){
        $fhandle = @fopen($fname, 'r');
        while (!feof($fhandle)){
            $line = fgets($fhandle);
            $items = explode("'",$line);
            if (isset($items[1]) && $items[1] == 'M_DESC'){
                // this won't work if the modules name contains an apostrophe
                fclose($fhandle);
                return $items[3];
            }
        }
    }else{
        // temporary fix for untranslated modules
        if (file_exists("modules/$module/description.php")){
            require("modules/$module/description.php");
            return $module_params['title'];
        }
        return 'no translation';
    }
}

function lang_swapmod($module){
    global $language;
    $set_language = lang_readcookie();
    // retain main translation keys
    $lpart = array();
    foreach ($language as $key => $value){
        if (strpos($key, 'L_') === 0){
            $lpart[$key] = $value;
        }
    }
    // but load new module keys
    $fname = dirname(dirname(__FILE__)) . "/modules/$module/loc/module.$set_language.php";
    if(file_exists($fname)){
        include $fname;
        $language = array_merge($lpart,$lang);
    }else{
        echo $fname;
    }
}

function lang_setlang($newlang){
    global $language;
    // load language files
    $fname = dirname(dirname(__FILE__)) . "/loc/common.$newlang.php";
    if(file_exists($fname)){
        include $fname;
        $language = array();
        $language = array_merge($language,$lang);
    }else{
        echo $fname;
    }
}

function lang_readcookie(){
    if ($_COOKIE['language']){
        $set_language = $_COOKIE['language'];
    }else{
        // fallback
        $set_language = "ru";
    }
    return $set_language;
}

function lang_translate($template){
    global $language;
    $set_language = lang_readcookie();
    foreach ($language as $key => $value){
		$template = str_replace('%'.$key.'%', $value, $template);
	}
	return $template;
}

?>
