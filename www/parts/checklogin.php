<?php

/*****************************************************
* checklogin.php
* check login and password for admin panel
*(c)virt2real.ru 2013
* draft, by Gol
/*****************************************************/

session_start();

// load passwords from /etc/shadow
$shadow = file("/etc/shadow");

foreach($shadow as $key => $value) {

	$string = explode(":", $value);

	$login = $string[0];
	$shad = $string[1];

	if ($_GET["username"] === $login) {

		if(authenticate($_GET["password"], $shad)){

			// logged in
			echo "ok";
			$_SESSION["login"] = 1;

		} else {

			// not valid user
			echo "not valid user";
			unset($_SESSION["login"]);

		}

	}

}

function authenticate($pass, $shad){
  $mkps = crypt($pass, $shad);
  return ($shad == $mkps);
}

?>