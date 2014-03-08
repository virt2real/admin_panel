<?php

/*****************************************************
* language.php
* translation handling file
*(c)virt2real.de 2014
* draft, by keios
/*****************************************************/

function lang_getmoddesc($module){
    global $set_language;
    $fname = dirname(dirname(__FILE__)) . "/modules/$module/loc/module.$set_language.php";
    if (file_exists($fname)){
        $fhandle = @fopen($fname, 'r');
        while (!feof($fhandle)){
            $line = fgets($fhandle);
            $items = explode("'",$line);
            if ($items[1] == 'M_DESC'){
                // this won't work if the modules name contains an apostrophe
                fclose($fhandle);
                return $items[3];
            }
        }
    }else{
        return 'no translation';
    }
}

function lang_swapmod($module){
    global $set_language;
    global $language;
    $lpart = array();
    foreach ($language as $key => $value){
        if (strpos($key, 'L_') === 0){
            $lpart[$key] = $value;
        }
    }
    $fname = dirname(dirname(__FILE__)) . "/modules/$module/loc/module.$set_language.php";
    if(file_exists($fname)){
        include $fname;
        $language = array_merge($lpart,$lang);
    }else{
        echo $fname;
    }
}

function lang_setlang($newlang){
    global $set_language;
    global $language;
    $set_language = $newlang;
    $fname = dirname(dirname(__FILE__)) . "/loc/common.$set_language.php";
    if(file_exists($fname)){
        include $fname;
        $language = array();
        $language = array_merge($language,$lang);
    }else{
        echo $fname;
    }
}

function lang_translate($template){
    global $language;
    foreach ($language as $key => $value){
		$template = str_replace('%'.$key.'%', $value, $template);
	}
	return $template;
}

?>
