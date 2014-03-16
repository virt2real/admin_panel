<?php

/*****************************************************
* modules/gphotoctrl/description.php
* module description file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

$module_params['name'] = 'gphotoctrl2';
$module_params['title'] = '%M_DESC%';
$module_params['menu_part'] = 7;
$module_params['position'] = 0;
$module_params['depend'] = array("node", "gphoto2");
$module_params['depend_descr'] = array("NodeJS", "GPhoto2 for NodeJS", "libgphoto2", "libgphoto2_port");
?>
