<?php

/*****************************************************
* modules/gphoto/get.php
* gphoto get options value
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$result = "<pre>".shell_exec("gphoto2 " . $_POST["cmd"])."</pre>";

echo $result;

?>