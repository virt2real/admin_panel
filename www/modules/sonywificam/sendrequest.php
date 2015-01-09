<?php

/*****************************************************
* modules/sonywificam/sendrequest.php
* send JSON POST request to camera
* (c) virt2real 2015
* draft, by Gol
/*****************************************************/

// common include
include('../../parts/global.php');

$url = $_POST['url'];
$post_data = $_POST['request'];

$result = send_request($url, $post_data);

/* action for some methods */
$req = json_decode($post_data, true);
$res = json_decode($result, true);

switch ($req['method']) {
	case 'actTakePicture':
		$imgurl = $res['result'][0][0];
		$url_parts = parse_url($imgurl);
		$imgfile = strtolower($url_parts['path']);
		$imgfile = str_replace('/', '', $imgfile);
		shell_exec("wget " . $imgurl . ' -O ' . 'images/' . $imgfile);
		$newresult['result'] = $imgfile;
		echo json_encode($newresult);
	break;
	default:
		echo $result;
}


function send_request($url, $rec) {
	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_POST, true);
	curl_setopt($curl, CURLOPT_POSTFIELDS, $rec);
	$result = curl_exec($curl);
	curl_close($curl);
	return $result;
}


?>