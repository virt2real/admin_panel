<?php

/*****************************************************
* modules/network/index.php
* network module index file
* (c)virt2real.ru 2015
* draft, by Gol
/*****************************************************/

// check module name
require_once('description.php');

// common include
include('../../parts/global.php');
require_once('../../parts/language.php');

// load module template
$module_content = file_get_contents("template.tpl");
$module_content = str_replace('{module_name}', $module_params['name'], $module_content);
$module_content = str_replace('{module_title}', $module_params['title'], $module_content);

// make global replaces
$module_content = GlobalReplace($module_content);

/***************** module specific part **************/

$content = '<pre>'.shell_exec ("ifconfig").'</pre>';
$interfaces = file_get_contents("/etc/network/interfaces");

$module_content = str_replace('{interfaces}', $interfaces, $module_content);
$module_content = str_replace('{currentstate}', $content, $module_content);



/* parse /etc/network/interfaces file */

$rawlist = @file("/etc/network/interfaces");

$ifacelist = "";
$ifaces = Array();
$current_iface = "";
$configured_ifaces = Array();
foreach ($rawlist as $k => $v) {
	$v = trim($v);
	$arr = explode(" ", $v);

	if ($arr[0] == "auto") {
		$ifaces[$arr[1]]['auto'] = "checked";
	}

	if ($arr[0] == "iface") {
		$configured_ifaces [] = $arr[1];
		$current_iface = $arr[1];
		$ifaces[$current_iface]['name'] = $arr[1];
		$ifaces[$current_iface]['type'] = $arr[2];
		$ifaces[$current_iface]['static'] = $arr[3];
	}

	if ($arr[0] == "address") {
		$ifaces[$current_iface]['address'] = $arr[1];
	}

	if ($arr[0] == "netmask") {
		$ifaces[$current_iface]['netmask'] = $arr[1];
	}

	if ($arr[0] == "gateway") {
		$ifaces[$current_iface]['gateway'] = $arr[1];
	}

	if ($arr[0] == "hwaddress") {
		$tmp = "";
		for ($i = 2; $i < sizeof($arr); $i++) {
			$tmp .= $arr[$i] . " ";
		}
		$ifaces[$current_iface]['hwaddress'] = $tmp;
	}

	if ($arr[0] == "pre-up") {
		$tmp = "";
		for ($i = 1; $i < sizeof($arr); $i++) {
			$tmp .= $arr[$i] . " ";
		}
		$ifaces[$current_iface]['pre-up'] = $tmp;
	}

	if ($arr[0] == "up") {
		$tmp = "";
		for ($i = 1; $i < sizeof($arr); $i++) {
			$tmp .= $arr[$i] . " ";
		}
		$ifaces[$current_iface]['up'] = $tmp;
	}

	if ($arr[0] == "post-up") {
		$tmp = "";
		for ($i = 1; $i < sizeof($arr); $i++) {
			$tmp .= $arr[$i] . " ";
		}
		$ifaces[$current_iface]['post-up'] = $tmp;
	}

	if ($arr[0] == "pre-down") {
		$tmp = "";
		for ($i = 1; $i < sizeof($arr); $i++) {
			$tmp .= $arr[$i] . " ";
		}
		$ifaces[$current_iface]['pre-down'] = $tmp;
	}

	if ($arr[0] == "down") {
		$tmp = "";
		for ($i = 1; $i < sizeof($arr); $i++) {
			$tmp .= $arr[$i] . " ";
		}
		$ifaces[$current_iface]['down'] = $tmp;
	}

	if ($arr[0] == "post-down") {
		$tmp = "";
		for ($i = 1; $i < sizeof($arr); $i++) {
			$tmp .= $arr[$i] . " ";
		}
		$ifaces[$current_iface]['post-down'] = $tmp;
	}

}

/* now get interfaces, that not in /etc/network/interfaces file, but present */

$newifaces = shell_exec ('ifconfig -a | grep "Link encap"');
$newifaces = explode("\n", $newifaces);
foreach ($newifaces as $k=>$v) {
	$tmp = explode(" ", $v);
	if (!$tmp[0]) continue;
	if (in_array($tmp[0], $configured_ifaces)) continue;

	/* add it into list */
	$ifaces[$tmp[0]]['name'] = $tmp[0];
}


/* create list */

$ifacetpl = file_get_contents("iface.tpl");

foreach ($ifaces as $k=>$v) {

	if ($v['name'] == "lo") continue; // skip loopback

	$tpl = $ifacetpl;

	// dirty hack to hide autostart for wlan0
	if ($v['name'] == "wlan0") {
		$tpl = str_replace('{is_hidden}', 'display:none;', $tpl);
		$tpl = str_replace('{additional_message}', '%L_MESSAGE_AUTOWLAN0%', $tpl);
	}
	else {
		$tpl = str_replace('{is_hidden}', '', $tpl);
		$tpl = str_replace('{additional_message}', '', $tpl);
	}

	$tpl = str_replace('{autochecked}', isset($v['auto'])?$v['auto']:"", $tpl);
	$tpl = str_replace('{name}', isset($v['name'])?$v['name']:"", $tpl);
	$tpl = str_replace('{address}', isset($v['address'])?$v['address']:"", $tpl);
	$tpl = str_replace('{netmask}', isset($v['netmask'])?$v['netmask']:"", $tpl);
	$tpl = str_replace('{gateway}', isset($v['gateway'])?$v['gateway']:"", $tpl);
	$tpl = str_replace('{hwaddress}', isset($v['hwaddress'])?$v['hwaddress']:"", $tpl);
	$tpl = str_replace('{pre-up}', isset($v['pre-up'])?$v['pre-up']:"", $tpl);
	$tpl = str_replace('{up}', isset($v['up'])?$v['up']:"", $tpl);
	$tpl = str_replace('{post-up}', isset($v['post-up'])?$v['post-up']:"", $tpl);
	$tpl = str_replace('{pre-down}', isset($v['pre-down'])?$v['pre-down']:"", $tpl);
	$tpl = str_replace('{down}', isset($v['down'])?$v['down']:"", $tpl);
	$tpl = str_replace('{post-down}', isset($v['post-down'])?$v['post-down']:"", $tpl);

	$static = "";
	$dhcp = "";
	if ($v["static"] == "static") {
		$static = "selected";
		$hidden = "";
	}
	else
	if ($v["static"] == "dhcp") {
		$dhcp = "selected";
		$hidden = 'hidden';
	}

	$tpl = str_replace('{static_selected}', $static, $tpl);
	$tpl = str_replace('{dhcp_selected}', $dhcp, $tpl);
	$tpl = str_replace('{hidden}', $hidden, $tpl);

	$ifacelist .= '<h1 style="line-height:24px; margin-top: 4px;"><span style="margin-left: 30px;"> '. $v['name'] . '</span></h1><div>' . $tpl . '</div>';
}


$module_content = str_replace('{ifacelist}', $ifacelist, $module_content);


/* parse nameservers */

$nameservertpl = file_get_contents("nameserver.tpl");
$nslist = @file("/etc/resolv.conf");
$nameserverlist = "";
$num = 1;
foreach ($nslist as $k=>$v) {
	$v = trim($v);
	$tmp = explode(" ", $v);
	if ($tmp[0] != "nameserver") continue;

	$tpl = $nameservertpl;
	$tpl = str_replace('{nameserver}', $tmp[1], $tpl);
	$tpl = str_replace('{num}', $num, $tpl);

	$nameserverlist .= $tpl;
	$num++;
}

/* if only one nameserver - add second with empty value */
if ($num < 3) {
	$tpl = $nameservertpl;
	$tpl = str_replace('{nameserver}', "", $tpl);
	$tpl = str_replace('{num}', $num, $tpl);
	$nameserverlist .= $tpl;
}

$module_content = str_replace('{nameserverlist}', $nameserverlist, $module_content);

// translate content
lang_swapmod($module_params['name']);
$module_content = lang_translate($module_content);

echo $module_content;

?>
