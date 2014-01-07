<?php

/*****************************************************
* modules/gphotofs/description.php
* module description file
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

$module_params['name'] = 'gphotofs';
$module_params['title'] = 'Медиаустройства';
$module_params['menu_part'] = 6;
$module_params['position'] = 3;
$module_params['depend'] = array("gphoto2", "mountptp.sh", "umountptp.sh");
$module_params['depend_descr'] = array("GPhoto2", "GPhoto2fs");
?>