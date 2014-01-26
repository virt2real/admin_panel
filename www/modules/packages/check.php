<?php

/*****************************************************
* modules/packages/check.php
* package list load
* (c)virt2real.ru 2014
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$packagelist = shell_exec ('opkg-cl list');
$lines = explode("\n", $packagelist);

$packages = Array();

foreach ($lines as $k=>$v) {

	$element = explode(" - ", $v);

	$one_package['name'] = $element[0];
	$one_package['ver'] = $element[1];
	$one_package['desc'] = $element[2];
	$one_package['dec_ver'] = str_replace(".", "", preg_replace('%[^0-1.\d]%i', '', $element[1])); // make undotted "version"
	$one_package['flag'] = 0; // defaul - install flag

	$packages [] = $one_package;
}


$installedlist = shell_exec ('opkg-cl list-installed');
$lines = explode("\n", $installedlist);

foreach ($lines as $k=>$v) {

	if (!$v) continue;

	$installed_element = explode(" - ", $v);

	for ($i = 0; $i < sizeof($packages); $i++) {

		if ($packages[$i]['name'] == $installed_element[0]) {

			$packages[$i]['flag'] = 1; // uninstall flag
			$packages[$i]['inst_ver'] = $installed_element[1]; // installed package version

			$version = str_replace(".", "", preg_replace('%[^0-1.\d]%i', '', $installed_element[1])); // make undotted current "version"

			$packages[$i]['inst_dec_ver'] = $version; // installed decicimal version

			if ($packages[$i]['dec_ver'] > $version) {

				$packages[$i]['flag'] = 2; // update flag

			}

		}

	}
}

echo json_encode($packages);

?>